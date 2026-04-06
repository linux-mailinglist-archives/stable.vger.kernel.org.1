Return-Path: <stable+bounces-233351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAlbBIBb02mQhgcAu9opvQ
	(envelope-from <stable+bounces-233351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:06:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B223A1ED6
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605F33005646
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42435A387;
	Mon,  6 Apr 2026 07:06:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65D332610
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459195; cv=none; b=TLi/dU+lcSWGR8gcPI9e6DyOTaugmETzPv3q4hBkD7QfqYHuS8DYkfW5dmgNozGQQtEKaOKReZzvBEAJ3aGJ/6CVgOVIp1S/3403ngFNtJprYQ8jeHlAbhTsjMIEKydzPWXMxOYEpt41YlX0eg24Rw3btLCvu3k9lnjcheu1pLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459195; c=relaxed/simple;
	bh=IzwUOOk07arVzGnI3bxwELcmQCPD2zVHN2+sLLaQQaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QxG8QrWit+WrFmh/JOecGCN4SOzMsb7ExXpFPKENF+ojJuVipz08meIi6jqEEwdiQ2UDUlqqq/6Z6fTOOxEeh53Qokj7ROCTStClA6N5/ruff6NECpulaybQrNrgvtWUd0mua+WjT2ZSmL3FfKKYRZtOShnGRirhQRZ0+2xdSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lvkasz.us; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lvkasz.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so629573866b.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 00:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775459192; x=1776063992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmI+hzyBqRr28Y++VrQXgi0DtpH9W0BGd3T//ob2zds=;
        b=AsVLiQ8IJdeWB4HUknciPHBg/zaxd3Qgez0Nr84HwcB/t4Z+13ZmaZFQBJj6tPtmBP
         wuXIQGJ4OBqgW2FN5nMExKlgSbHFyIjMzbMt6IzFSsK3ml2wtwlx/weo4GE9VvZh/uA/
         /i4bvJ0PX8FuuTnwU8aZcRS/XgexaMzjE5boMZSccRFs8nBUcfPo6ldpxaz+mumXWH0y
         NSkkEH4h0jw+vHNtdIAQWcQEjymaemunQx6G5RBMWUyzkz4FZLmFQyFUXpMt+sKHV83B
         287EVPmF5Yo0IgjwZIGduWTNAMs+Z+csQodK8pH+VAtdmx1Lwhx8GX3X7bmz9rEEAYiq
         nocQ==
X-Forwarded-Encrypted: i=1; AJvYcCX13yjxyDthNHwBW+Ym52uQwZV0X/z/cbCYRoM50BxmNntpKkRDx8EN0YXFZhab9jqLF6jVqE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunxplEyyMVZTLTgAr/YsGxsK8LUWvsrrWoaJx6Pgv5GRGiJBm
	fH2Pe1iMqGakHXOHSelP+eTl1i68LQubtrUpNw6MnXaSqxm6XaVBwNay
X-Gm-Gg: AeBDiesNPhCX32Bq9L/zpUkqRqGLk8cKJoDEOese9cpl7a0sTIEgIxB4W2OxdfwwB8i
	mrzF3qJlOhxO1OUXr+edQXoQg1oO2llIQPNenuoQVMShN5tKPO8EiT7YpuC12bK7IAk+Z2yxvZC
	IjfijzjQG33/XKnDA0/FtveNS+yfALrteBfs/xHYzo1LssTzoUnwlAKy/6p2V1pPjS5MTQhi1HO
	lEpl1XY/bqGD8/LZ/oF020ZkPr+oGcFnN4tVdm2f5xQ8I35RBznSETl1jET69iqh2m1ckhuteZl
	Y3Hi3cylS0h8jYZgqcKo9oE7OKnUYw9q9Si8PZk84YPcmHhiY57eiPovoVOWPBePkBMsSBFt0ew
	tjJq+RSznirgksXh4rwzunmD9/QDOcCBrw6PuAZyf8Ku2DIsN7YQoIsJ3e/UYFLWiFQ57+IjzQO
	qR9unb4/cbUY2QeLbPH7mfS0IXIAQfq5tdJ+7NG/eYBHRiRgwsuDc1kFn1rSkp0w==
X-Received: by 2002:a17:906:4fd4:b0:b96:e11e:97c4 with SMTP id a640c23a62f3a-b9c676ad8bfmr559766366b.20.1775459192157;
        Mon, 06 Apr 2026 00:06:32 -0700 (PDT)
Received: from aorus.localdomain (5.185.72.109.ipv4.public.orange.pl. [5.185.72.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff131csm450129466b.52.2026.04.06.00.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 00:06:31 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values for Exynos7870
Date: Mon,  6 Apr 2026 09:05:48 +0200
Message-ID: <20260406070548.132491-1-kernel@lvkasz.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,samsung.com,disroot.org,gmail.com,lists.infradead.org,vger.kernel.org,lvkasz.us];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233351-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@lvkasz.us,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.775];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B223A1ED6
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
Tested-by: Łukasz Lebiedziński <kernel@lvkasz.us>
Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org>
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

base-commit: caf08514bbee0736c31d8d4f406e3415cdf726bb
-- 
2.53.0


