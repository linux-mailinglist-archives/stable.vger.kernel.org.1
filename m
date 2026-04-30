Return-Path: <stable+bounces-242176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN2EFXiQ82ky5AEAu9opvQ
	(envelope-from <stable+bounces-242176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0A4A657F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D60C304482C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995847278A;
	Thu, 30 Apr 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeiPztmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A45364045
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569808; cv=none; b=XPpgopOqbg0U9boSW2mUx8MK95zGO2nhA7iiunhi8bGiF8WWDuiNr94u6zhy1b5wBL52/crdE3+X71I4ncEtV9dievx2Jkh2cK7I7t4YRjU9zCVx/OaHaBkVKwMcFypEti0mXr9YeQks4AbEfO7jVconk0LotplaoCF8tZYEg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569808; c=relaxed/simple;
	bh=LA0X9xR8/v7iEvNdDUTMeOp0g38F5a0meXOMaAEwxzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNLH8uzI3+jugA4nkjm+9G9unwwzhT8wCOeKPjE1cy/mirfNgVJjlTap6rQ7saAnZkmn8zn5VIBZfsunZVY0CBTY1axJYEqwlYwBTVQciN6XsIxx3mnpnw1eRENhWNtHXPAKImnRLcK8tKu8jAXqkRjknOgl8oGIqhGQDa+uneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeiPztmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A49C2BCB9;
	Thu, 30 Apr 2026 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777569808;
	bh=LA0X9xR8/v7iEvNdDUTMeOp0g38F5a0meXOMaAEwxzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XeiPztmicM56w3U5we3h5/whyPckHwcp7TrZ3HPVZJ7vye25r1aX3T2FUzBibBcjG
	 K6bUWVfksIQQGAm77CD+eeiU+wDhm++Fgx7jkLJFsrmkdh/8vNFCknTgiCMpfjzzQr
	 IcgK5FZMO24XlLJdpwUiCr5SuWzHdrIhzu98iA4+U3FaR5yPJJ6VjW3ahc8NAoNQDs
	 bi7Tg0wng5ThvM9xfXzdfYs87PvQwN5b77A271lTmvKalnERs3w5ry8Lk4n0mvMGeF
	 SM23hMLGsmDdUYqG9OZHfJ35Ya6rGRhbUG4M3f5mv63K65kR1p3oLkSXN8Lo3X7Nlx
	 rw4hYIKysS/pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
Date: Thu, 30 Apr 2026 13:23:24 -0400
Message-ID: <20260430172324.1875442-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430172324.1875442-1-sashal@kernel.org>
References: <2026043042-octopus-sagging-4db9@gregkh>
 <20260430172324.1875442-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5E0A4A657F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242176-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email,nbd.name:email,msgid.link:url]

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 56154fef47d104effa9f29ed3db4f805cbc0d640 ]

mt7925u uses different reset/status registers from mt7921u. Reusing the
mt7921u register set causes the WFSYS reset to fail.

Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
correct registers and fix mt7925u failing to initialize after a warm
reboot.

Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20260311002825.15502-2-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index a99af23e4b564..ae33ac34e3cc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -385,6 +385,10 @@
 #define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
 #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
 
+#define MT7925_CBTOP_RGU_WF_SUBSYS_RST	0x70028600
+#define MT7925_WFSYS_INIT_DONE_ADDR	0x184c1604
+#define MT7925_WFSYS_INIT_DONE		0x00001d1e
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 666be8ee6092d..5d10d981b33f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -226,6 +226,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
 	.need_status_sel = true,
 };
 
+static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
+	.rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
+	.done_mask = U32_MAX,
+	.done_val = MT7925_WFSYS_INIT_DONE,
+	.delay_ms = 20,
+	.need_status_sel = false,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -256,7 +265,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
-	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
+	const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
+						&mt7925_wfsys_desc :
+						&mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
-- 
2.53.0


