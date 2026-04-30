Return-Path: <stable+bounces-242154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFAQGxqA82mr4gEAu9opvQ
	(envelope-from <stable+bounces-242154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:15:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0124A582A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486B63080EA8
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058BD45BD4E;
	Thu, 30 Apr 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMU5I5Kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D244B679
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565250; cv=none; b=WOJIhcU5oKSi5BbzaMu2ygYFHBU8qEXJnZ6NwgZrgDt5tKuGbnqHFpDQUyS0kf5zMPDpl1npFGgTqYRhABrXrD1zGrvwRBCHTQyP5mQ3ttwziAkU+0mIo8vUIiX3u0oG4bHwS6A4RdKFSmlUoK7+2HjZASk3SqSWMa8u4oS2TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565250; c=relaxed/simple;
	bh=AGQHqIPMG8RaVt2qPm7qUrBKQAEL0Zol+D1S6HKPDKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQJ0s2isfr2E2rzc6mNxcCXZCxAWonok+DqdV6zKA/fx0kd0QO08kV2G8EfpSsEjSh3Y12cUL7pNIcy9PPIzCjuhR+HELNFx+qJFELAj6knBqsSiRBxZ5nkRshKm6RDj+SYtiFMmWolpFhPJVwZE5KQeJqP3CsLgVFOkfMoFBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMU5I5Kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D3DC2BCB3;
	Thu, 30 Apr 2026 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565250;
	bh=AGQHqIPMG8RaVt2qPm7qUrBKQAEL0Zol+D1S6HKPDKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMU5I5KbsfJmHv0cDdaZtA3qI1UJc2x7mGqWkD2ul3D5tf3KOABq0zOZ8WNm3AsUT
	 HuEYCGS2bmpbG+JVlSMlPBizVbQAs/bJOAG6SXH1efYJcVX+pQrU+3avfk808A6+aF
	 vCVVk/2qCYAgMbqu1Dwo7ItaRi187+dODU4TmrdxLQsY/Dmrn6Kov4zwk1QHHjttKj
	 to6ulvCCDeR4ymWfOH33c9oi+Fph/dBoTv+podjD5NlObfL2VqWzoZ7Xh8xqqdJKQO
	 3OZ+LW0LT/QjWLy9I6WNfdVPNYZc1Tdg9vg6ELe58qKzcJucI3eVVGYygcl83gKOxW
	 iW/d5abXLkjiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
Date: Thu, 30 Apr 2026 12:07:21 -0400
Message-ID: <20260430160722.1784926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043040-tissue-nuptials-8136@gregkh>
References: <2026043040-tissue-nuptials-8136@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE0124A582A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242154-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:email,mediatek.com:email,msgid.link:url]

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit e6f48512c1ceebcd1ce6bb83df3b3d56a261507d ]

Prepare mt792xu_wfsys_reset() for chips that share the same USB WFSYS
reset flow but use different register definitions.

This is a pure refactor of the current mt7921u path and keeps the reset
sequence unchanged.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260311002825.15502-1-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 56154fef47d1 ("wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 552808458138a..a92e872226cfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -206,6 +206,24 @@ static void mt792xu_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 	mt792xu_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
+struct mt792xu_wfsys_desc {
+	u32 rst_reg;
+	u32 done_reg;
+	u32 done_mask;
+	u32 done_val;
+	u32 delay_ms;
+	bool need_status_sel;
+};
+
+static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
+	.rst_reg = MT_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT_UDMA_CONN_INFRA_STATUS,
+	.done_mask = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.done_val = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.delay_ms = 0,
+	.need_status_sel = true,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -236,25 +254,31 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
+	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
 	mt792xu_epctl_rst_opt(dev, false);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val |= MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
 
-	usleep_range(10, 20);
+	if (desc->delay_ms)
+		msleep(desc->delay_ms);
+	else
+		usleep_range(10, 20);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val &= ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
+
+	if (desc->need_status_sel)
+		mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 
-	mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 	for (i = 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
-		val = mt792xu_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
-		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
+		val = mt792xu_uhw_rr(&dev->mt76, desc->done_reg);
+		if ((val & desc->done_mask) == desc->done_val)
 			break;
 
 		msleep(100);
-- 
2.53.0


