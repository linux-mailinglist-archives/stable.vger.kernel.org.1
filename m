Return-Path: <stable+bounces-241915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FMjJA0v8mlvogEAu9opvQ
	(envelope-from <stable+bounces-241915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364949797E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E340B3028818
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067883FE345;
	Wed, 29 Apr 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRtPb0iw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF43F7880
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479042; cv=none; b=o7hU5k7aMi/12JEnsKg99vVa0pMubT88o74XEEsSLGuC6+7n5/E6ix8/myN9EhzALeMIfdWdHqbryjhuZ2WroBcxwBHnuHpP9mw+hA5rqkq/PkItqcvKVZrusHtc9wXcqXqBMm1k5z6x4iqX+FxJn280MQaaOs/ncRIC9BLAggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479042; c=relaxed/simple;
	bh=DytySb4ZvigQDwLMhmo/xI438Ra2nb2hFZ+vtkYS4bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dw6TC25cOqBOUkf3myyKe+JWhx5DXey0ow3YI+3dPolfYVi1ycQYT36DHYROjoMx+ir9j5pjn9PBs362SGQm0LMceqVbM3TXSBN+CqEBlAWHY9G8kkHNWIpkjRF3mg6c2oLlsgv0BKB2I7PcxtFTAXOc0YvIIWW6vgAWNxlbUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRtPb0iw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so115548385e9.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479036; x=1778083836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+77RgoEJ0AmITQg6v+6hZLh8ZTCmvX7iqaggTxjks=;
        b=PRtPb0iwjA+Jc+6fL9H4GViYLyG5XvoWymFnQzLZgLjVNt/ejRxNB9iHLyrENapH+j
         2N/uFPeuD64FAPM8xYFbfYH46LlWS6Mk3up8pAgyxNtvWZmLwZx7KH2oUfFYyrs1tvdI
         GoVoOfKe/tgxAnKtlIM4ZR1h/i67FKtW6BtukBetnrvhLT6Z6vVODUGTFcZqnUjCkAA8
         p5IStWanxOd7SUIt75+QUAXVGwtlN6UPDrSSkDFDiwUHt0SfPolGjMxPqvMW5lRt78k3
         mT+tqs1YqA0Lj2pbZZ2DeTw6ZZRm61Z5TI544AfobZr+hDnwL++n9QzdUeUeENJQP7DW
         eTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479036; x=1778083836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR+77RgoEJ0AmITQg6v+6hZLh8ZTCmvX7iqaggTxjks=;
        b=jD8G2+FLWVXdvwuYs+jTGHFdOiw8RFY2BRZYFahGANQh8xagnDgbhQC+gJMrCdmZPX
         aqz0gavxH2mjbawvOzZnjws4P41RNVRG/GtNiCqsgyld5XAL4PjwVj1wQzDK13pIaj2u
         aYXqhjihcspDQATIdwIsn0wPohbJVzlp8Y8SPwn/NRUptEv4xgHoMRr/hjROUGR6xt4t
         Uw2wWTQ8X2wD7+0wDSoEDDyxqHDZ1rndZ/1AL88DCgGmnsYnAaAs9frcetrtOEjSk8BU
         UnTDf81sGZGAtqEUorXPtYz348iQ0Pg+Rm8GVhWocyg+jFSWfYS0PCdj/vXD92FJPPUp
         zNGA==
X-Forwarded-Encrypted: i=1; AFNElJ9SlZ/SVaipZ+f7Yq+qAWtv2hTDbXM1vPAP3Q/35kxSc+7OpBlfqu1u3e1Y7psp7HbYQC6zNU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx79Q4xWr4Q0kZ6nwOQN1oaAxBY4fxoIdVYsDRnwGvj9+6MeaP
	f30HnHY00KAdrdUlK4rd6RFs/OTqqUefZpmE5OZt+T/AmaCtKoTRkPlC
X-Gm-Gg: AeBDievWSL5PdDwmoA4qK1qfwD2XeGUBfEoGwhnSjVuMcTpciznWndU4LhzxVlDZw8A
	d2NbkoiB0hF4CSRRDc4/n1jT0H9+Iu/yHfsSa1aPzUwhB1hSCSe5UldKxIMs4nTIWQ/rVBtgcIW
	ENS37p82I3+86lmgTBrVvsa9q0+shBPNsQbEeyJzIS5h0I5FCT0ixImYM9+OnMjS6ZxFVEy704l
	3seacO60QdehZa/Gm8UXUkgiGMGvmT+UjlYspo4iaLo+eFOugvhY5nVBbe8Y1p4gnI0gJPhRkHE
	8aVFqJLLD8oyDthz3g+q8ShxMPrpmegeB2xOEPwNSh3ho9kQJyy0kpmsJizoTmycsNQBxwMYGq3
	txYqgzF4zUxJovJ/D1pJGpF0D0zFzfYHsEPMH/fJ+8+LLUlBxwvs5NsNSQWkXUiHi3GnimmbXmC
	89NSYkuUGnnkMZs8dBNj+VeeHBgMLuvUXATnHw6RQxNP6LAw1Ec2hR
X-Received: by 2002:a05:600c:530f:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-48a77b298b3mr125207095e9.26.1777479035979;
        Wed, 29 Apr 2026 09:10:35 -0700 (PDT)
Received: from poldo.fritz.box ([151.71.61.80])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a7c2f2eb8sm36761295e9.6.2026.04.29.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:10:35 -0700 (PDT)
From: Tommaso Soncin <soncintommaso@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Tommaso Soncin <soncintommaso@gmail.com>,
	stable@vger.kernel.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add HP OMEN Gaming Laptop 16-ap0xxx product line in quirk table
Date: Wed, 29 Apr 2026 18:08:57 +0200
Message-ID: <20260429160858.538986-1-soncintommaso@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1364949797E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,amd.com,kernel.org,perex.cz,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241915-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[soncintommaso@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

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


