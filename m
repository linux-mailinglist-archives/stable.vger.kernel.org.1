Return-Path: <stable+bounces-126681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A293A710F7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 08:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DBE188AE25
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212D191F6D;
	Wed, 26 Mar 2025 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLdgg/0l"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2719047C
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972608; cv=none; b=rc1EshiZltYD0Q5L01ERWnj3eZaUzr0Jk3RpsNT979CJABZR4xnOrjWS77IUy3Y16PCCDQyhFyAXENolwTk8jj0+E6mEhVnQMWXK5Tv9B424u/ZPnpd9M+N+L4j6SqCkTfZseYIgimv6L/cAoGBKlx0sY2iOxXPJmXP8Kod9Uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972608; c=relaxed/simple;
	bh=qTpgNy6zEDsUZhOgWml+A7fADV/itqrWvIqhBWECVzc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eBTv0tid3XlIw5VW6pwAXu7qju5uimlvqv2aGnSxrQJXqsoY4OldB+CMh+j+Hsps4R+4ngbakK8lIh+HpHgakM7D7D7EX5zxeVAzGYnpNOWtWeymb6k4aIe1I382Y1kF73SiNbCatqrPBCMLVObviU/MGsKEMnnkfqO2k/dXJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLdgg/0l; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keirf.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so28882145e9.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742972605; x=1743577405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjdDMxOJ8ypIsJr26T0ef7SswO7nHrS4JeKFOEHommw=;
        b=OLdgg/0lcUlFYDTUfmCHOW4+p6ZmeD+XTpQeAknHEolk8qBst5l4m+AxlxzJ6NNz6x
         CdTwrID5S3BIjG+SbCSIj7oNswm3DQpfyj01+4ol+SirAL5gKSetVzID+lcphx06n6ef
         SVew1+ekJfidbeWcm3It5+BXVOIqNnsewtjBJRR3HWaX9QPET5pX0V/YY1ZslrntnKjl
         tKGDJ4tfhhbotu25K3gntRPX7P+MKalv0VZrMouqDqV5kHpGrmbx8o/elplwHZV/k3QI
         r1y7n+Ssg/wqAomNabRi9mTsMj2gzHXVR9plyvJlmHSvTcfKUL0NuZIPoVOgZkn9MtQl
         Qp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972605; x=1743577405;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjdDMxOJ8ypIsJr26T0ef7SswO7nHrS4JeKFOEHommw=;
        b=qTFecF2FBrHsj8ZZRR8aJN1ZJA/GpitZPdwFGNwPwmsHO+O787io+zGSf4gGOGUAVh
         X+6McSwmyc2m4MqJgsqqY1/NhOBTetyuDn1sr9IPDZfPKe19l3skvic+HxJi74UXpo6a
         DV3z2iv/py9vS0c39TV9q/K2SnxWbQc6NJcK5mdWlXGW6sGTJmMCtugPTJkK1Y7UFx1s
         QMKMpQsCSnlBlINWWUNI1nlZVsDrV7XaOa+zhheEEsjzliPxcGWus6MsMscy9M4CWHfV
         aWFCS2bufbP0qXf4D1/0N+JX2S1Az9iwmvQp3mi0y06l7sfRuPbMDzn5+VbKR4zQONRK
         YkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdPpjarZmILiPUSSPVzZhd1N6/5MDjXYjqGXBB2SsN3ohBX936Wz35eSy90HWmgyMAEGMxrfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+ZGiOpdfFYeSlnUbDZhwV+RQPMtCmx77eBJtMcxSLefE5AJO
	emSCVH2mV20vkl0HTXRMYxNiPqBrZw6/sp96/nM/NbzcewtdH+BMLiaVWEnUxhbikMLRALqGjQ=
	=
X-Google-Smtp-Source: AGHT+IH/xYSgXGEpnU/366BtleKSATBGgV7i3H8fDcMjsdSTbRVbQbDtBIxppx2fAgMCYggfEAQrcuBHoQ==
X-Received: from wmbgx13.prod.google.com ([2002:a05:600c:858d:b0:43d:8f:dd29])
 (user=keirf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:186d:b0:390:ed04:a676
 with SMTP id ffacd0b85a97d-3997f8ff44fmr18138026f8f.22.1742972605097; Wed, 26
 Mar 2025 00:03:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:02:55 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326070255.2567981-1-keirf@google.com>
Subject: [PATCH] arm64: mops: Do not dereference src reg for a set operation
From: Keir Fraser <keirf@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Keir Fraser <keirf@google.com>, Kristina Martsenko <kristina.martsenko@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The register is not defined and reading it can result in a UBSAN
out-of-bounds array access error, specifically when the srcreg field
value is 31.

Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Keir Fraser <keirf@google.com>
---
 arch/arm64/include/asm/traps.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d780d1bd2eac..82cf1f879c61 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -109,10 +109,9 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
 	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
 	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
-	unsigned long dst, src, size;
+	unsigned long dst, size;
 
 	dst = regs->regs[dstreg];
-	src = regs->regs[srcreg];
 	size = regs->regs[sizereg];
 
 	/*
@@ -129,6 +128,7 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
 		}
 	} else {
 		/* CPY* instruction */
+		unsigned long src = regs->regs[srcreg];
 		if (!(option_a ^ wrong_option)) {
 			/* Format is from Option B */
 			if (regs->pstate & PSR_N_BIT) {
-- 
2.49.0.395.g12beb8f557-goog


