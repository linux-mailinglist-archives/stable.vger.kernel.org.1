Return-Path: <stable+bounces-233379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCRAOau702mslAcAu9opvQ
	(envelope-from <stable+bounces-233379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 15:56:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E88953A3BD8
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C94273006030
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF5372671;
	Mon,  6 Apr 2026 13:56:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3D33C532
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483814; cv=none; b=kLzuXFgAX2Hc6n3EyXbdFFQ6h4ZjnFJ+xWSqNl7P9zEf2gnYuPJV5scyyD7dJZMScUVskCSf+iOXLC2WRsUn0ZYlJ0SaoZhuMqiBz7VUa30VkgLXj0MR7ugSEBuk+Y3eRyA0aUBoFKKNW1dRQR9oWYiHvR/lCdVMyeBuQVd4/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483814; c=relaxed/simple;
	bh=hSrL++7BFKBB2qjBSL6tIqon+XilxF4IH2+bdS1/RC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WjEBcmyjm9ciObaQ/5CkMnoEBDQJxxRPcAg7gh4GTtN/Ppzlh1CrSXk+nOlBkBcD8cH3F2FJ1qKx6kUIVmsHG92KF9b4jG+xzJnr3iR45uyr+YLKZ2KWpuGbx5YXQg3WQ/SDCUHnwa29iowO55LfiOmEtRqLyDzBUQF5dxTIwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lvkasz.us; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lvkasz.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b941762394aso509961566b.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 06:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483811; x=1776088611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQtUgZBlTwv+xDoaiKb2N7gT+/y7cOGsVK3GMzZHFqc=;
        b=Gj/FTSMWOOMYB+uJhb+HXUHwo4z0VYBNfg9T9Ui5/uujF58c+wFO+tw+bDtMNAF0ax
         XgAcOuOT/hoYrsHQiwQ/omwSAd26vG/ARXb4Oziqx/PW7QR4FVulJtu5OVYp+x9RBbe/
         Cp/a7taduYqju/7TPTqEtHiFvRwi8sn/acGTIaR601R9xD/potH5ozA3ExsA3Wn9eMFx
         b6W9pLgak1soh6uNtVXvTsuX8iaoGr5B7E3lmRe0E90xhp3JdOCK/2Hy5XxNW/z1VAwS
         tf7llaVQuKIi92O3lupZigiFDcQSQQv1492r19s3F+gPgfCCs8kh2krsZfKPjW25xF43
         Ti6w==
X-Forwarded-Encrypted: i=1; AJvYcCVvNYTi31jxPqG435r+8wcwrRlaRiJk3BVxbVtke47nmOxnLiY9V6EK0KtC+LnCExuUWSCD8zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRbRVeNoMHjxf/IthyRoo3GdRW9ncrtbK14UMVMObs4aHEv80
	yKPUuJTJPI01pW79VofPIHKQc4RGBHwmrT2ANiyKso9RRJwjycb+PErf
X-Gm-Gg: AeBDievX0VIbZuqW7cMf6U8LM6wb15LS2Sca9Ct1jeTV25OP/LKAnMWEXnO5sWWd79s
	FPQvtXFsZq4/mmFgspH7cgmTNArwXiinC4SXuIPiDZ/3gyGtFVAlXmsDqJqbxj2gs1I4VlwJ66Y
	Kpwu1fW3bw3R+u5zyJyGPyWd1BpAfSJUaX+Y5s+hXTRsMDxk/D9g/kBNpc6CEVujQb2byQPDDer
	5nsyAVKBEQUhZlORzdICFIcFY2h2Dw1DO26T9cdMu88EPoSu62zl/lDk6ugxC3qdZiAVrh5klWP
	06U/gsfrjpA4SfKIok0VZkyNATrA4k6dudzxax/tFJl/K4xXtqR+Pz7x+fuZHc8B1gwZbcOc0br
	q5zPTwoscdno3OLaDA5/Ygp/u2un5fHM/1GB+G/DYaoey6FWVawL548V8C0ywqor6ElU7Q6/MEZ
	NGRNSOxwRyFPEQwk4NegG7kyJ5BvFDWiz93c2BbpnvCjXHdjJOMkHHXrVy39TuXA==
X-Received: by 2002:a17:907:2d9f:b0:b9c:b3b5:bbf0 with SMTP id a640c23a62f3a-b9cb3b5bc8fmr276106266b.6.1775483810728;
        Mon, 06 Apr 2026 06:56:50 -0700 (PDT)
Received: from aorus.localdomain (5.185.72.109.ipv4.public.orange.pl. [5.185.72.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cac0e1asm472921266b.27.2026.04.06.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:56:50 -0700 (PDT)
From: =?UTF-8?q?=C5=81ukasz=20Lebiedzi=C5=84ski?= <kernel@lvkasz.us>
To: vkoul@kernel.org
Cc: neil.armstrong@linaro.org,
	krzk@kernel.org,
	alim.akhtar@samsung.com,
	andre.draszik@linaro.org,
	pritam.sutar@samsung.com,
	kauschluss@disroot.org,
	johan@kernel.org,
	ivo.ivanov.ivanov1@gmail.com,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?q?=C5=81ukasz=20Lebiedzi=C5=84ski?= <kernel@lvkasz.us>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values for Exynos7870
Date: Mon,  6 Apr 2026 15:56:27 +0200
Message-ID: <20260406135627.234835-1-kernel@lvkasz.us>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[lvkasz.us : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,samsung.com,disroot.org,gmail.com,lists.infradead.org,vger.kernel.org,lvkasz.us,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233379-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@lvkasz.us,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.813];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lvkasz.us:email,lvkasz.us:mid]
X-Rspamd-Queue-Id: E88953A3BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing PHYPARAM0 tuning values for Exynos7870 are incorrect,
causing the USB 2.0 PHY to fail high-speed negotiation and fall back
to full-speed (12Mbps) operation.

Fix TXVREFTUNE (transmitter voltage reference) from 14 to 3,
TXRESTUNE (transmitter impedance) from 3 to 2, and SQRXTUNE
(squelch threshold) from 6 to 5. Also explicitly set
TXPREEMPPULSETUNE to 0, which was previously missing from the
tuning table despite being included in the register mask.

All values are derived from the vendor kernel for the Samsung
Galaxy A6 (SM-A600FN), as no public hardware documentation is
available for the Exynos7870 USB DRD PHY. With these corrections,
the PHY successfully negotiates high-speed (480Mbps) operation.

Fixes: 588d5d20ca8d ("phy: exynos5-usbdrd: add exynos7870 USBDRD support")
Cc: stable@vger.kernel.org
Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Łukasz Lebiedziński <kernel@lvkasz.us>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 5a181cb4597e..8711a3b62c8e 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1958,13 +1958,14 @@ const struct exynos5_usbdrd_phy_tuning exynos7870_tunes_utmi_postinit[] = {
 			      PHYPARAM0_TXPREEMPAMPTUNE | PHYPARAM0_TXHSXVTUNE |
 			      PHYPARAM0_TXFSLSTUNE | PHYPARAM0_SQRXTUNE |
 			      PHYPARAM0_OTGTUNE | PHYPARAM0_COMPDISTUNE),
-			     (FIELD_PREP_CONST(PHYPARAM0_TXVREFTUNE, 14) |
+			     (FIELD_PREP_CONST(PHYPARAM0_TXVREFTUNE, 3) |
 			      FIELD_PREP_CONST(PHYPARAM0_TXRISETUNE, 1) |
-			      FIELD_PREP_CONST(PHYPARAM0_TXRESTUNE, 3) |
+			      FIELD_PREP_CONST(PHYPARAM0_TXRESTUNE, 2) |
+			      FIELD_PREP_CONST(PHYPARAM0_TXPREEMPPULSETUNE, 0) |
 			      FIELD_PREP_CONST(PHYPARAM0_TXPREEMPAMPTUNE, 0) |
 			      FIELD_PREP_CONST(PHYPARAM0_TXHSXVTUNE, 0) |
 			      FIELD_PREP_CONST(PHYPARAM0_TXFSLSTUNE, 3) |
-			      FIELD_PREP_CONST(PHYPARAM0_SQRXTUNE, 6) |
+			      FIELD_PREP_CONST(PHYPARAM0_SQRXTUNE, 5) |
 			      FIELD_PREP_CONST(PHYPARAM0_OTGTUNE, 2) |
 			      FIELD_PREP_CONST(PHYPARAM0_COMPDISTUNE, 3))),
 	PHY_TUNING_ENTRY_LAST
-- 
2.53.0


