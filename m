Return-Path: <stable+bounces-44198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A964F8C51AE
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146D1B2215D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944713AD25;
	Tue, 14 May 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCA4vbOo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596066B5E;
	Tue, 14 May 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684894; cv=none; b=fgUYr4hvUj0M6UyEJ68LR+2DBse53H7kZggjDmzaBBNb092x5ntv3JIN2urOas6+G11nVK/JA30QPv+fewaNitfhhLeffwz+g4ztSn0y/YLWyERek3G2XbUUe9/9d9TVpvZzUbnDa5VFahellHCrKTn8LjUP/Ny/BBRCw6jFvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684894; c=relaxed/simple;
	bh=e/b1TQwGCj06uVpoiye6/km+NPuIyIXw6ui1IEr4sH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQyCHfExy1SRxUubRje4aLAYvFD2dMbY6NV7Ptdm7hYl9DxUJP250+ySldfVNwWYBDyL5xdEdpza/dihE+jlw0hNFBrb2aDfs3KNt7nhWe6blVu92n2kvQtySndvQRkFMvbjRibqp9BOvrMIe/Anhp2KVnWwke0gQRmxx8tj3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCA4vbOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27EAC2BD10;
	Tue, 14 May 2024 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684894;
	bh=e/b1TQwGCj06uVpoiye6/km+NPuIyIXw6ui1IEr4sH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCA4vbOoUdKbErMT10P/auMkTCEZiSRlwrAfI73sVbDwGLlsRwh5Zf/hTbvgtv8fx
	 6xr38/0PGDT3+4vn/b/Qz73hKKisnkMTUAvJh76TnyHslMrqv4Pr8hpe2aJvm5Ogdj
	 DzpTOBAKjpmxBwEjBSBXMnhVxDL4lHvdf+2W9570=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/301] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Tue, 14 May 2024 12:16:16 +0200
Message-ID: <20240514101036.214671311@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit ec50f3114e55406a1aad24b7dfaa1c3f4336d8eb ]

Fix the order of arguments in the TP_ARGS macro
for the rdev_dump_mpp tracepoint event.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240311164519.118398-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 617c0d0dfa963..e89443173c7b4 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1015,7 +1015,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-- 
2.43.0




