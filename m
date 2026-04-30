Return-Path: <stable+bounces-242159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPP9JU+F82lQ4wEAu9opvQ
	(envelope-from <stable+bounces-242159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:37:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55E04A5D35
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FABE305117B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C946AF33;
	Thu, 30 Apr 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkOgu1zW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C53FF889
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566698; cv=none; b=X7zOWQzCGKzGSPoF+1pDjsvbU7IbOVMyv0DdjlOQdvvuqQCgrCftCwJlLTJ6/1yR6IZDa1RB4ahNKjrImTuj9mgzf107SKT1z5oCcDrsRIl+FW3QRNCnpDhqOm4ql0SeF76o8qMRBnd0w8BP3lF/FfWZ4q6qCUqrQcsCLWh5/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566698; c=relaxed/simple;
	bh=9JpMdAdDRn6kvxLco1JvLGEbJWlPFF1cy2mxUIaev/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLx32JBv+pnNc+hyW9OqC9y5ATYOdHgoPtDUfmbv2F6wiBQMXXACzGvIUDDpPvCD0YMo2sTaua/edovQPgt5Omy0nzgPFI3kSfikBJoL5u6S2tKnhz4wNCVP5Oy9n+/8xxxl/NfSfLcDiyoTkLiPIHQNDCMZQoiFPccOE2lW6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkOgu1zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93300C2BCB3;
	Thu, 30 Apr 2026 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566698;
	bh=9JpMdAdDRn6kvxLco1JvLGEbJWlPFF1cy2mxUIaev/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkOgu1zWgohwWu+Ox/BIuT1g3sE4bZnw/Nz6ulE0LtuX0QYdmvMYX9ekhuleczgym
	 mdXbyvSKQVxycy9exfgfMLNo76t8ClDHfjmHhhjY/OTrKl1xjgQbNVKTGJAjKt63EF
	 3BV/r0RKjOKT7b2BHvhKgZDUJppNncuj/32Wy7FPpzW5R56Y6toS7RkAVMtpujgl1A
	 JYTNj9oKdLNxe0d7lpdmHm7LBtP7RgOLzDzImNbzaMnrqYJAZ50BTYjbbEzHgj7Wps
	 EybSVJRMeENmkTb046nAd/KGum30JySb/YFblMvL0JkSmX2Imnh113SYwjaXhl9N8E
	 7/f3tvptkUjIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
Date: Thu, 30 Apr 2026 12:31:34 -0400
Message-ID: <20260430163135.1837241-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043041-eastcoast-antiques-377a@gregkh>
References: <2026043041-eastcoast-antiques-377a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E55E04A5D35
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
	TAGGED_FROM(0.00)[bounces-242159-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nbd.name:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]

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
index 76272a03b22e5..7b1bee3c6605d 100644
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


