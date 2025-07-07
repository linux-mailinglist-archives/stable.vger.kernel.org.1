Return-Path: <stable+bounces-160385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE16AFB994
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BB43A8CDB
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3F2E88B9;
	Mon,  7 Jul 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfQ3D63d"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEF2E8DE2
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907934; cv=none; b=RU7iUDv+7ghBQRWN2ckMpD9S4a0Qb6W6PytoZLM0U7kjAY9mNIoj0Lx29GxLeIIRBue+vybV4jbXWNUHqBpFyi5y2RxxJDi5UBAATZEP/x/TeRGT+lHKMeia3VRs9zht9lFx1g9DwWcP3ekXTs+vGv+t+Du121SndVxiX78jcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907934; c=relaxed/simple;
	bh=V7GVXPeniRjfSBXgyWCdSqUUNadL/PC4wB6+w+kmXrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bINt8NTxULBsY5muHoZ7cq8SI6VZwi/yqowfddtw/Djj6HqUzrXJRf2wbAHPXN2xvwQCwNvKz5pEwoAUeWBRipv4iO4IZPmEpBgTGfdwXvpX/pUvRGpFoGHKnf+jGEpKLaguaD86IZoGiwNWtP/V6rBJ+UvenLu6Q0pn2thatLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GfQ3D63d; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so726878866b.1
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751907929; x=1752512729; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57rYJvDLr2D8w3kMcZW5Qve8k2sDHgGAExSpeGzzFo4=;
        b=GfQ3D63d+nGazbk7+lWB93ffVNPgxydPzyZXj3KGUyz/vIms4FksdDaxrU0xQ429vw
         rx+TtugBgSOEJDFoHPbvG9HYkXmSU6leJ+pqVLcTfaj8G7FcqCEW5S89ZoAWI+SEDzgV
         R+dCV2bGR+srkCuQrAUqx9k5W6qnKDVtbbsZ+xPEpCd5+oZ28ot9cUeQi1R9kpBT5WUv
         AFaWPypwbM1YUFnO4YHJFENdKPAxbUQgkL1KI5BWHacbYjjWvfmR+/Z2A+/Fd8vZCHTa
         byUzedF4qHVgnhNVvmiIeNvVMGqmkWFKwxDl207Q6MGm5nGKidGmgu8kCcce9jdkyxQ9
         Zt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751907929; x=1752512729;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57rYJvDLr2D8w3kMcZW5Qve8k2sDHgGAExSpeGzzFo4=;
        b=TP3SzLWUD4V2kakdJimZ3owzCOjpOgnkGq9b1Ve23yA9gcT81xeuJ2S6ETieTs+uX5
         z8KyWQa78c+p+9QnLfSbLPrZuCbps/AJVk3W0uh7sS91wMFU0+WiCeBF4dtDRNq6/Zl4
         t1Q1EcGrqMYHvHDN8d0ga9E97qF9TCr9gQWzszJrCXVA0YDgbMadQXolTpR2z6GOv84y
         v/lO3Em5HyZGt3m7i9aafCA7tzffkjsJmbbMGPAO0gz8/uuOZZqWo6R4A7nc2p+rtpHZ
         LZj+iaXaIqMMmjfxHj17bDtSnMw7YXpPUmyiXCF2d+n0w1OpslU6zCVV9GSWMu3mcOdF
         vo0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9Pmdp0uH8mr65HQzitt9h6llBP03e9MOtUwJMoy9flxQ/tPJQHSUdOfuMLZbPffQFI9+a9OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmOfwiYaRi+6EQr1lHJymuk22SqHipspny9CAWmzqtEJ/1PP9
	bXkvhMDvuinVl7cTzMIdTOLHcBNbJa64FL3rZakA0peFceP0SiLX8YWgmr44lcM07lWkFJLsXdh
	tJfKiCBs=
X-Gm-Gg: ASbGncu6QpLCmrC9MEeBgITDaT18eEkXwTSFSM9MYi8rzxbh4T2BPtQVOLztpmLSV8l
	QZCzISSXYlU5NqLEPL20RfepE4xAPLsCzYQSpJvsxQLYQYH2JJ4qEr6LsMgvKyoayaojJZdMwP1
	J8ngpKXdBdd8u9Lwju6VOVYaY7S2JjmaRnLlqRlW6fnoDFAEw3MzZjNxcG6BOGd1AW0Xgqy3dV9
	VbL/skTi20w6p7JtTxUHeDC7kMa2nmGQaHZqJJBGpugVcO8HKRaMg/TYVZeFMcZo43hI0Me5fea
	E43Hq9k+5+iXcEyiIqRqp09+CpSXURsJl2UfV4KJrIEQ5XyW/wOvE+L19rPRSi7HzX0pPbhwxQG
	998hx/PG/FfzC98W08zdbTjhHlmppGfK414fngZ3fi3l7yA==
X-Google-Smtp-Source: AGHT+IH39ie4cMyXIg4z35kSN5NcopH3AiyCIAZ7/0N31t7b87LaPnUMjOhDIkjPEUdI9Xt4zZAZOg==
X-Received: by 2002:a17:907:3c91:b0:ae3:70cb:45d5 with SMTP id a640c23a62f3a-ae3fe741335mr1295648966b.48.1751907928992;
        Mon, 07 Jul 2025 10:05:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac54a0sm745507266b.109.2025.07.07.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:05:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 07 Jul 2025 18:05:27 +0100
Subject: [PATCH] scsi: ufs: exynos: fix programming of HCI_UTRL_NEXUS_TYPE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-ufs-exynos-shift-v1-1-1418e161ae40@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFb+a2gC/x3MPQqAMAxA4auUzAZqqT94FXHQmmqWKo1KRby7x
 fEb3ntAKDIJdOqBSBcLbyGjLBS4dQwLIc/ZYLSpdKMbPL0gpTtsgrKyP3Cq51K3lkzrLORsj+Q
 5/ct+eN8PxFjj5GIAAAA=
X-Change-ID: 20250707-ufs-exynos-shift-b6d1084e28c4
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Seungwon Jeon <essuuj@gmail.com>, 
 Avri Altman <avri.altman@wdc.com>, Kiwoong Kim <kwmad.kim@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

On Google gs101, the number of UTP transfer request slots (nutrs) is
32, and in this case the driver ends up programming the UTRL_NEXUS_TYPE
incorrectly as 0.

This is because the left hand side of the shift is 1, which is of type
int, i.e. 31 bits wide. Shifting by more than that width results in
undefined behaviour.

Fix this by switching to the BIT() macro, which applies correct type
casting as required. This ensures the correct value is written to
UTRL_NEXUS_TYPE (0xffffffff on gs101), and it also fixes a UBSAN shift
warning:
    UBSAN: shift-out-of-bounds in drivers/ufs/host/ufs-exynos.c:1113:21
    shift exponent 32 is too large for 32-bit type 'int'

For consistency, apply the same change to the nutmrs / UTMRL_NEXUS_TYPE
write.

Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 3e545af536e53e06b66c624ed0dc6dc7de13549f..f0adcd9dd553d2e630c75e8c3220e21bc5f7c8d8 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1110,8 +1110,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, val, HCI_TXPRDT_ENTRY_SIZE);
 
 	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)

---
base-commit: 50c8770a42faf8b1c7abe93e7c114337f580a97d
change-id: 20250707-ufs-exynos-shift-b6d1084e28c4

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


