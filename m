Return-Path: <stable+bounces-241914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBy8Dk0u8mlvogEAu9opvQ
	(envelope-from <stable+bounces-241914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:14:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDEB4978E8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1243039880
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB023F6616;
	Wed, 29 Apr 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHJu9reQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38653F6611
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478867; cv=none; b=m8kVPw0VC3MC9dvYXrY3qVepm5WYNV0y+75Hzg+jma+NIg4cu90onrdkw7WPZmXeNpC+wAN8gcsWs3blnS+jDs+porFBrRLNsiJLzYiv+JEE+b2BJs/2A0zOPrafYFnwmrgj3jxwkLwIVUkWmRztnIo6hLClvC6Vne86QULOcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478867; c=relaxed/simple;
	bh=DytySb4ZvigQDwLMhmo/xI438Ra2nb2hFZ+vtkYS4bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZJro9jPZ5HpY+sEobybI9WxkRQABwP9NTg3/0wcmOW3Xyg1qaSR3PxcTXiCBYiPYkhTOqjaE7/oRnAVAp+urIerQk5+h1/kInG8leFgVLDBWYWoO7a2sHrpVd3Q0xBeFwSZhoDSObahimr/5cCKQi3JlLImR7D70lNNooHlQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHJu9reQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso2675325e9.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777478853; x=1778083653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+77RgoEJ0AmITQg6v+6hZLh8ZTCmvX7iqaggTxjks=;
        b=HHJu9reQhE7FT6dez4rapU0YIGXczoDbP8tnVNv5bJ46PQVxO9lkKaWw3OKAhsF6QL
         TzS0En/DpxkJNL2l6B34J78/KftdlIPHt5IqigWiobDrFoVRv2xSa286YCCRlPVPRfMi
         s4DvKXtVeO9Ve5rUkiJepU1VFQj37rt5lyX1yL9qIrUeAMCzD0Sw1qOcqvdi4U9s+mXn
         dKBCuQZ6W3vzeXGISCq9zNOhq1WvuCEdsnxFICesjJQRxC1ZhauxWTLskt3vAwYFmFYa
         kUsFHV0huKCwffW0/x0xr8cYyvr7g47lInEENdfDyO9gpzSbrGra8TFLdWUph2U9xwGW
         Burg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777478853; x=1778083653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR+77RgoEJ0AmITQg6v+6hZLh8ZTCmvX7iqaggTxjks=;
        b=i/EsuSnKvJv8HcSvDrrTP2CbkT8ZivL223iqwWwWS/qoIb8RliJhCMsFU+loD4RW45
         d6oMf7LnZqDrgcHd7BQRIMD7zvn9S8A91ybzzXaX2hwa1jDzjrDBvMBs40l108lhao94
         xxewSMgP8HScAH7oIDWKVorHRP/aYrHJxRI63fJCP4Z35IhpghZwI84eldnpSjsu+W9x
         Bq+LGkH22YzQ/wuiCnRuVChMMIKCUGgC+GaJf1FbB8R1zVUHBoq8vK24wYJ9+l6jwr6d
         fTyFuvYBfNMQ/lifxFkmx7mq5ZqaOdEPAQySVqCIVGmRyHdGuJcLMDFuHFXBpOyuWEZ4
         ggtA==
X-Gm-Message-State: AOJu0YwkGQOyspwD1CB7mGq6W0gJIWbLR3hW5T+2MFPV8A5M9U6SNFv6
	pm5gPLMYNgKe2xDKxfs90jALGFleXWWSYNIZkcOc3S4WKmBgqjfe80qtMJT+ACYf
X-Gm-Gg: AeBDietlzCmr7Kppy6yzibLmxhbS2hcsQ2bvff1jfonyU/dxI1ffU2eO98TXNEiot7J
	zZlktyXMbP+h0vcu1xbUduqIfnl7lEbVAc2+osvj0NPS0u84s9SHAmkYAvMK8wD9e8F7nbqo7FG
	jiD/pV+3xrl0vnspxnK1aYlP3LiiKSYp0TxI9fIm6qyeGn3cWGvV+NRRMmPUZ0cx+0FuLJMkOiR
	OwimE/un8heN5lAVeoYor6Pp8G1rLxzdvjVrjypBRRPXwb7jdHJIeqE1mdGyRtWxwEdRq15X+mf
	s6+ROnHStOMhZ5z7O72OU0+prnhOeWMKJSHl5T/tUkQ8F9+xLP2XylJOiFkx45oVv3UnFKwRtQC
	4boU6iqn3QQG5h6togLOYal3Frldxf8dfjsebSZwkN39U2VpEbnC5Q6YvI7PHgnQyUBTxYCYFY8
	+is07i2x5w9jlCtqpEbTyieE4L39NaVP2G0xWWbUPjmSq6tRBOdowq
X-Received: by 2002:a05:600c:4593:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48a7b5479dcmr86884165e9.27.1777478852777;
        Wed, 29 Apr 2026 09:07:32 -0700 (PDT)
Received: from poldo.fritz.box ([151.71.61.80])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a7b935af1sm33452535e9.4.2026.04.29.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:07:31 -0700 (PDT)
From: Tommaso Soncin <soncintommaso@gmail.com>
To: soncintommaso@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table
Date: Wed, 29 Apr 2026 18:07:21 +0200
Message-ID: <20260429160721.537658-1-soncintommaso@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EDEB4978E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-241914-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[soncintommaso@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add a DMI quirk for the HP OMEN Gaming Laptop 16-ap0xxx line fixing the
issue where the internal microphone was not detected.

Cc: stable@vger.kernel.org
Signed-off-by: Tommaso Soncin <soncintommaso@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index c5cf45881416..a2d744b75f52 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -59,6 +59,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15-fc0xxx"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN Gaming Laptop 16-ap0xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -668,6 +675,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8EE4"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8E35"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.54.0


