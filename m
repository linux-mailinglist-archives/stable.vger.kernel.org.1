Return-Path: <stable+bounces-109454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7AA15E1B
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863D31886ACD
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E85199E8B;
	Sat, 18 Jan 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN0wx/io"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF215CD78;
	Sat, 18 Jan 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737218181; cv=none; b=IAPhuhEG50BuyYvk2UqtHtpUEGpGW3bRnYEAexxzrvFP1DHZaSvm19ZChpkN2omYEuxXxnTCUwUJ7UHJasXX4umo9ndG9NlsCmIE/rbVmz2+O7bpRjFIzBAfWmPz75k4TCR890WG3R4VkKZrEHViHqWycRWnsP8R30nYjlcqWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737218181; c=relaxed/simple;
	bh=eh1SfXx9U8ZBjcOmI+c31uIuIYkcVWt69AWwx4rbptc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrqCUZEtiep+Su/K4mMUUoxMWm0EEVUa0QlC1FisHfCLVRGzgYTBge6jVmX8zGyjPI3o+96FhjFcdx+soU5YCe6DpmkQ1dAent80jXSHCLh6cms780hdhaOieWikF7mKu5vKmoSFwlaYYjAN4CHYvnBaG9AQOpKJVgZCq1jW0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN0wx/io; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4154684a91.1;
        Sat, 18 Jan 2025 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737218179; x=1737822979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBcCkYZGqUKu3cSA3W2Zh/4n8iTPp48ifQZWMJrBSVA=;
        b=hN0wx/ioW22sNvoxIq/NN0HJmP9fU/yToeh9+e+OdTAkXUtIeM5rABjTh+UV5djpQw
         g1Xp9w5/OfD6DAJ+dnbDIJah7EbkvCwZqpxc107jcfE4YtzkAyh/X/BJ50JfUUhAbgfc
         v2zfdrNUMYFzvH6HEoPhW6zJolk+J3gpOMwMRNz5rVTsChfYYWttcfap7TdmQAiQCDKo
         /MxrlzBfujqw4ns4M2lQn86io7FoS8W1UOEhWs/y85IyDBTlKF1pXDgsmnWcRVcFPfmp
         7wpKwH+UaajRDDlmivMnK6icpXS8CN/OkEubir0Cc0sEAe9UJwVhw3UCpK+G5BU7sofR
         Rz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737218179; x=1737822979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBcCkYZGqUKu3cSA3W2Zh/4n8iTPp48ifQZWMJrBSVA=;
        b=be3T6zHXKzi54kTwZCf8SqWEuemRYkVd/1ctRoTwfioPE5ouLhZ6yq8arRMWT1MInB
         7YYacsIKpmlmCn6Xxik1RApBKFj1LTtvRN0VxWSTMP1gxE9qJ+QTlFDtEJQnlMcewVys
         JnD/SCjNA7SJsDYuISjuZ+yROQ7Rd5J66GuPCi751bvLiTKFW3OqVJtu+rrD+AYyGJvS
         1ULo9AFxmFSmtoeHd4QGJU51RkxTVJHF+sJDWZH/H0Wmhl1tge0VcindEuOxg14n30JP
         iURqZ0QHz4bKWkTpmUJI7d2IOX+8a5EzXub4+ZKnTgeffnp911JE/tjpCAr7nd/xQAds
         MaAg==
X-Forwarded-Encrypted: i=1; AJvYcCVS5/Jt8UYWAsztY3VEnyoZHZloYS3+iQd545fTI5GeMNrwYHQ0K37t4u9w/825QecI83FjxBFK@vger.kernel.org, AJvYcCX4EMroZG6XbjiZbPk1hE1LA0dq9xMfemgXe+JSzgN2pOdNz2Ey5f5t7cJe1FHL9k7G2s27qRw9phBdd8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+24z+Yx9tLL1YV/4kLkLW/JaLqPi4Ga12rsWRbMWxJLkEHzgE
	xjhgEGdARnX8Xbgb/1TXVb5IY1JTZcdyIkqSB1ylOt8j3LrJXFLQY4QK4EQx
X-Gm-Gg: ASbGnculGn4KUGcT9Ruth/uYqOn1FPFWy87FufGcc01Y5nNGHL+gRFXWPSgqLJxbuRA
	W33WQ2OP1hrZWJrIlKhcvXWlSjiKKx21Gx1iTcEAPRS3qR6PPoYYQPQlLVPsShbZGqbO8ab43Rl
	508ajPe6g2iKFHcsFfILdB9Gu8aGI/zy1VdZ8MfbMlTTh5YCKxjZLGbroxotxSgqIf+oe5BhW8z
	w+snyUsw/vZsgPQhHOBJMQRYh++snmlmOVkhtmyjA2EEp+BBF00AY6rayyCbC2rvDpPkKk=
X-Google-Smtp-Source: AGHT+IFIC6xQyN0czHlq14fUPCGSYmLyGoA8mjgv2tG6wO4ESEzTfyUD4RwRKSlW4dbm9htceT7Hgw==
X-Received: by 2002:a17:90b:270c:b0:2ee:8031:cdbc with SMTP id 98e67ed59e1d1-2f782d2c9a1mr8501141a91.23.1737218179378;
        Sat, 18 Jan 2025 08:36:19 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f72c2bae59sm8156962a91.30.2025.01.18.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 08:36:18 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured to fire FIQ
Date: Sun, 19 Jan 2025 00:31:42 +0800
Message-ID: <20250118163554.16733-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU PMU in Apple SoCs can be configured to fire its interrupt in one
of several ways, and since Apple A11 one of the method is FIQ. Only handle
the PMC interrupt as a FIQ when the CPU PMU has been configured to fire
FIQs.

Cc: stable@vger.kernel.org
Fixes: c7708816c944 ("irqchip/apple-aic: Wire PMU interrupts")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---

Changes in v2:
Fix the conditional to have the intented behavior of evaluating to true
only when both PMCR0_IMODE is PMCR0_IMODE_FIQ and PMCR0_IACT is set by
reverting the conditional to how it is before c7708816c944.

Link to v1: https://lore.kernel.org/asahi/20250117170227.45243-1-towinchenmi@gmail.com/T

- Nick Chan


 drivers/irqchip/irq-apple-aic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index da5250f0155c..2b1684c60e3c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -577,7 +577,8 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
-	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
+			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
 		int irq;
 		if (cpumask_test_cpu(smp_processor_id(),
 				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.48.1


