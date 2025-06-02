Return-Path: <stable+bounces-148988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2775ACAF92
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A5188D5FB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3A1A3A80;
	Mon,  2 Jun 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YP1AteVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D4218AC8;
	Mon,  2 Jun 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872175; cv=none; b=jwxAJI44i6aqDI7sYgzq89//CHycNZF/L3G9HDb8gF19ucFM3v7bYcWvn0Vl3K1z1/5XwyNkO/YnoVbJHeoHbrmckw+SkMUfnLEdi6c5+IczDMlvp1FwpqagSfDKjhuDtm36YojN70lXb7wr/Ke99Mox15NELT6Di4lHYxEkdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872175; c=relaxed/simple;
	bh=gpfZuWgriEcuHHh2QQa57DoeiTU8rWrQfkfLPJvO+38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efMHh5v7TjmTC4efN0ue6RldNyU9bgE/K/uA4ibAkNoYt5GrzNnndLuW/8pgAegYpK05s2MPcyJ0tIEc8x6iHeENzFnPTtKAlULhbzTm6vKHyASP+JPCg5OSOhrCIXPo3nUVCptUtVeop96JEV6FyO0lgzpu9iXfRbZG8uQpRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YP1AteVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5742EC4CEEB;
	Mon,  2 Jun 2025 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872174;
	bh=gpfZuWgriEcuHHh2QQa57DoeiTU8rWrQfkfLPJvO+38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP1AteVTDM9gaL5dVPtmX5qtfoKlWKGRqkcNvOGvui8DdQqBSTm1H1TA1IwtQqFAR
	 4uT7yykG2xpK0M+CjOAL3/Y2urc/P+bx1ouUNqHATrLdTTKxDPAaLV3vUmXM/Of5+F
	 JYSIg/3F/pQZRuHnimWO3RmvX8GVXimpYs9IO0ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.15 42/49] perf/arm-cmn: Fix REQ2/SNP2 mixup
Date: Mon,  2 Jun 2025 15:47:34 +0200
Message-ID: <20250602134239.594149322@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
References: <20250602134237.940995114@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 11b0f576e0cbde6a12258f2af6753b17b8df342b upstream.

Somehow the encodings for REQ2/SNP2 channels in XP events
got mixed up... Unmix them.

CC: stable@vger.kernel.org
Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/087023e9737ac93d7ec7a841da904758c254cb01.1746717400.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm-cmn.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -727,8 +727,8 @@ static umode_t arm_cmn_event_attr_is_vis
 
 		if ((chan == 5 && cmn->rsp_vc_num < 2) ||
 		    (chan == 6 && cmn->dat_vc_num < 2) ||
-		    (chan == 7 && cmn->snp_vc_num < 2) ||
-		    (chan == 8 && cmn->req_vc_num < 2))
+		    (chan == 7 && cmn->req_vc_num < 2) ||
+		    (chan == 8 && cmn->snp_vc_num < 2))
 			return 0;
 	}
 
@@ -882,8 +882,8 @@ static umode_t arm_cmn_event_attr_is_vis
 	_CMN_EVENT_XP(pub_##_name, (_event) | (4 << 5)),	\
 	_CMN_EVENT_XP(rsp2_##_name, (_event) | (5 << 5)),	\
 	_CMN_EVENT_XP(dat2_##_name, (_event) | (6 << 5)),	\
-	_CMN_EVENT_XP(snp2_##_name, (_event) | (7 << 5)),	\
-	_CMN_EVENT_XP(req2_##_name, (_event) | (8 << 5))
+	_CMN_EVENT_XP(req2_##_name, (_event) | (7 << 5)),	\
+	_CMN_EVENT_XP(snp2_##_name, (_event) | (8 << 5))
 
 #define CMN_EVENT_XP_DAT(_name, _event)				\
 	_CMN_EVENT_XP_PORT(dat_##_name, (_event) | (3 << 5)),	\



