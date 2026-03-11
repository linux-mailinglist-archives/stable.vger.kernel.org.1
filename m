Return-Path: <stable+bounces-224611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ID+BE63sGlvmQIAu9opvQ
	(envelope-from <stable+bounces-224611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:29:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F1259CB6
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1E313028C3E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8E35AC24;
	Wed, 11 Mar 2026 00:28:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25F35A937
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188918; cv=none; b=EjG7eAeC/QASOYnSUd116X4TJfIOhkygICmYFaCiMN/15vko9DH0fxSc3RwUSB7lWC3Ygvg2uF90wIcxLoJ51HklRRTQ+BuWLNarQ7HfUWk4nN3sG5tBolPFEDirWBfqezAVd7lk3Lk/tkrGDhewCfrQTyYD9+1Mon6JK8Ne/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188918; c=relaxed/simple;
	bh=OkEIBxc3yBY6QPzdTqn2maD1OuzaedMvIydfn3q/lLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMOU03rSxCVwJElZPCPLdfeNnY6pWBCC8E7APpH3war9mb0y9LlVoqjdhnzr+1iuy9XuDdFJBcph+IPSdXIXEyYaoLyJtDTNjTBHJOdA89y/ltF1DWP0Mdsrmfl++Xj8TqbUcg3hs5PfPqsV4+IZ9PxPOEpjI6HtMw1e9MIo5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4638e238094so6920804b6e.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 17:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188916; x=1773793716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uV7lH3FIJA3CkRWr9ZibC3b+y2jhZmrH7643sTDjV0c=;
        b=n+BoseZUKD6As4/hyVHCHVlqmZII4Bxg17K1FRe1w/Qx6GmyUO5qJC/P4r6Cj2Ts38
         ZM9e1mkFoxRmO4eRq6sT6qFj53aTJbceXywBhSC85adeFstRljdeSqLRiXZ8k2blsTx9
         KfDv0XODhRzp8TB0lP9h2c0zP1Yojjn/MnhR6S7y/OGf0K74y1UoWaBf7QJ43AssMiSL
         wCLmFEdqT3yg2+o9PiNhg5ryYAI6rd8Yps7403PU/61R0MSSoHcsjj2b0MNPlQ9aNm/T
         jwbmh0nqTiBoj6E07S1uvXCtbRJlCmVecG8Vl7vyUYok0g+XfQHjBJ0JaVATVh+gqVWT
         J/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV9AuxyG0XeEtkpvBhAT/j30V7sjE4xKy/OivT5Sduw2KrcZxrRJx/AH7BGupHfJTsn2/rE9b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0tRNOS0FMOJJjQBYqezvguusHwW9KswBxngyOGvp2Npsrt98
	CwxUvG2FAJe9kdBtMZANDiKm1uu37HCHHC2UBbXcTGhbL9XaC98bjE3p
X-Gm-Gg: ATEYQzxUGbfZZ0PSXK55AQMa7xHTC14PFmmVPIGFHD9fAe+p+HDanrOUENHsW5huZ/e
	LrA3pTGy1wQXF5xx5KkLPDl7VUQtvlnhDSzM6721Bv9eMowhYytOMECowCl2HnTASRtjlrJFW1g
	V9I6GYZHSX5nCga/xXF5jXoqIUfA7/VsvjB7P3BUi3jzlY8hYFlxaUM+kxUiOkwBdlZyqunAlX7
	DOco8RI4uI7XT8f5ESqIFgwdfPfl4uTrC9tl2sg+Nfo+OqtTbVtxPnh9uLnFZAQuP2ap77ssghK
	3SIA1c3gWp6CHB0sjPMqHTAAINo/wzoH0u7pd69ykAvCOIOgcbduaVOdHUwT+yOr4UbEyteNFzX
	oQk1fmfok2OnqMlmbKtoVXM0oIxLHp0bRsmFyaHj7IzqinBxm42+JNeR6w+UyJWzGaBYxIPs6gN
	f6SnHKdDTEchwqE+T4vCehUAsiEvEnc4iniitNwpABV1sNAFs=
X-Received: by 2002:a05:6808:178d:b0:45a:9068:642a with SMTP id 5614622812f47-46733506ea9mr429126b6e.35.1773188915884;
        Tue, 10 Mar 2026 17:28:35 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e72b40asm516497fac.20.2026.03.10.17.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:28:35 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
Date: Tue, 10 Mar 2026 19:28:25 -0500
Message-ID: <20260311002825.15502-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311002825.15502-1-sean.wang@kernel.org>
References: <20260311002825.15502-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F5F1259CB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224611-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

mt7925u uses different reset/status registers from mt7921u. Reusing the
mt7921u register set causes the WFSYS reset to fail.

Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
correct registers and fix mt7925u failing to initialize after a warm
reboot.

Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 7ddde9286861..d2a8b2b0df32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -392,6 +392,10 @@
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
index a92e872226cf..47827d1c5ccb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
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
@@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
-	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
+	const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
+						&mt7925_wfsys_desc :
+						&mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
-- 
2.43.0


