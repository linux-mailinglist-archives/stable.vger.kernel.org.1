Return-Path: <stable+bounces-75381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498F973445
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02BA28DDB3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2019066C;
	Tue, 10 Sep 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiVDNJjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BA14B06C;
	Tue, 10 Sep 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964564; cv=none; b=FY6rz72T+FBFFAy4koJFB9n9ohR+VG9vbnZ3ItLV/GJacZJDTje9YI4DPjL0KbVKXLp1byDnTpjt+s7QmloUREIk2UyO5UiDYoANaeBrEjmsSoUbH/g8ndevibksTS9+2TZGI7gF1hi6jkkLLejCRMoYwlvHXzsibfMiEdnj+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964564; c=relaxed/simple;
	bh=cBvhDIQxMRxVqCm8Lsrw3GsKA9QKK9x3QZYIOfhk2lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2tID4dtiwg6MGWn7NSoA52kD60zx0JFAE3HP/EtceCkiQk8nh6USthgRmARvMTUaWeTqTuE+ZfcTjtyUwXqPdOpXILoQejOFRqlNbF3paEwhKlx6ia4vYN6p4fAJ5fAregVWboQQekrQdpUqFz9iJrJSYYRHMAy0dVRgzhhoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiVDNJjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAB1C4CEC3;
	Tue, 10 Sep 2024 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964564;
	bh=cBvhDIQxMRxVqCm8Lsrw3GsKA9QKK9x3QZYIOfhk2lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiVDNJjWN3pxT/ahptbbLlXlZAHW16MJMuFcMKCjz9Vab5B5Bh9FXV2xOughuIOOX
	 LX8gsdryBNx14Sz6YuaTZ93MQTaoQ2WKtwiaWuImUF1VQOysH9egadC3OctLiDGalZ
	 MxwmIEAlkPzN/6gSWpzhIc4bWl25Hjei/40AT0dM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vern Hao <vernhao@tencent.com>,
	David Hildenbrand <david@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 225/269] mm/vmscan: use folio_migratetype() instead of get_pageblock_migratetype()
Date: Tue, 10 Sep 2024 11:33:32 +0200
Message-ID: <20240910092615.969587034@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vern Hao <vernhao@tencent.com>

[ Upstream commit 97144ce008f918249fa7275ee1d29f6f27665c34 ]

In skip_cma(), we can use folio_migratetype() to replace
get_pageblock_migratetype().

Link: https://lkml.kernel.org/r/20230825075735.52436-1-user@VERNHAO-MC1
Signed-off-by: Vern Hao <vernhao@tencent.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: bfe0857c20c6 ("Revert "mm: skip CMA pages when they are not available"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 83fa8e924f8a..7175ff9b97d9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2271,7 +2271,7 @@ static bool skip_cma(struct folio *folio, struct scan_control *sc)
 {
 	return !current_is_kswapd() &&
 			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			get_pageblock_migratetype(&folio->page) == MIGRATE_CMA;
+			folio_migratetype(folio) == MIGRATE_CMA;
 }
 #else
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
-- 
2.43.0




