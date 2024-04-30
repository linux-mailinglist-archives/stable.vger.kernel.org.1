Return-Path: <stable+bounces-42743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433DA8B746B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007AD287271
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDF12D761;
	Tue, 30 Apr 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BBLUHQL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519F12D215;
	Tue, 30 Apr 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476642; cv=none; b=i4BcNWl/Cxx+HjJp3ZNNB5tbegFomcbvEs7OF7ZgUfcFMmw8tELqGj4zZc5F8toVazr5Is8Ruknk1GR+gOGKDijkLrjnOt7t4eFFuNLkCidGhdXaOGq8jcwx6Tbzntm0t5rXUbm7QnTCqVQYMzh7ch3QcClcba/7tBRIktIfTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476642; c=relaxed/simple;
	bh=OmtcX3E9cnXVwdAvIXeSK5Ys5PUISyYvo4ISNEHbrlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKpIiIloF0SvZkkpxYVD9b7sRskMNVNG0aWZ1Tg3J21i6joTZEyvtd1djGLY8eu9nWOlpVIP3+eTsILeAKij7JFm67SzdbRjPCitx8n/JXh+LqGyUewim+ieVSPBKfrg2X9+6P1YTU4z8K9moWOIq8CBgxU9lzIj5dYPv5aVMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BBLUHQL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D92AC4AF19;
	Tue, 30 Apr 2024 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476641;
	bh=OmtcX3E9cnXVwdAvIXeSK5Ys5PUISyYvo4ISNEHbrlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBLUHQL4iXJD84EXmMiyS8r8naYLBcIuVBiaJ6SvQAjEGGng5RpJHSmOJapSdImhg
	 yg1jZEg5PktwfEJnufn/dYJfiSvlpw9WJz8B0npaAAGlKeOHPnTRIJxPxB4qIJV1P5
	 5GsstJHk6YeiEVZSEc7t5HkbJeOy/XHSqW1gOgxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Reeder <jreeder@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Ed Trexel <ed.trexel@hp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/110] net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets
Date: Tue, 30 Apr 2024 12:40:26 +0200
Message-ID: <20240430103049.249985653@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Reeder <jreeder@ti.com>

[ Upstream commit 1b9e743e923b256e353a9a644195372285e5a6c0 ]

The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
field from the second nibble of the PTP header which is defined in the
PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
the first two bytes of the PTP header are defined as the versionType
which is always 0x0001. This means that any PTPv1 packets that are
tagged for TX timestamping by the CPTS will have their messageType set
to 0x0 which corresponds to a Sync message type. This causes issues
when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
timestamp that never appears.

Fix this by checking if the ptp_class of the timestamped TX packet is
PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
sequence ID in the skb->cb data structure. If the sequence IDs match
and the packet is of type PTPv1 then there is a chance that the
messageType has been incorrectly stored by the CPTS so overwrite the
messageType stored by the CPTS with the messageType from the skb->cb
data structure. This allows the PTPv1 stack to receive TX timestamps
for Delay_Req packets which are necessary to lock onto a PTP Leader.

Signed-off-by: Jason Reeder <jreeder@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Tested-by: Ed Trexel <ed.trexel@hp.com>
Fixes: f6bd59526ca5 ("net: ethernet: ti: introduce am654 common platform time sync driver")
Link: https://lore.kernel.org/r/20240424071626.32558-1-r-gunasekaran@ti.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 9948ac14e68db..c1bdf045e9815 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -649,6 +649,11 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 		struct am65_cpts_skb_cb_data *skb_cb =
 					(struct am65_cpts_skb_cb_data *)skb->cb;
 
+		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
+		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
+		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
+			mtype_seqid = skb_cb->skb_mtype_seqid;
+
 		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
 			u64 ns = event->timestamp;
 
-- 
2.43.0




