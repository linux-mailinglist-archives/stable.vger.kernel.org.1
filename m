Return-Path: <stable+bounces-200885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B68CB8604
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6413064547
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED57311941;
	Fri, 12 Dec 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRJ7mLnh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B863101DB
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530318; cv=none; b=VsYbsYHpsNv9yEsZVNAPZQDRPp6/2y/xxl7F3G+ea77n1FmZd0MKmsyesH9gJh3OVWyxnUsUU5Xhfpgw3yTqXWatLtkwrot6wA+5EYA96gRUAxLFaPr5qvpGzsCYiG5YppQQiWxTc6l96fbbUmwTr95LRmawCW68Eep8bG07lqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530318; c=relaxed/simple;
	bh=eLUe4QkIaRcncwktrwIJwZlqkOyBRdYBem6CwcNuZIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cf5jVjx/+LtVljyamV1mzRwPVIZkcvTqhZy6+VbwYPrnKO9CTWCJ4W7MBT4SgCXAzXX18A26kElmNf8Qwb+0KH2QL/luHDFJ2c4a1t/2mhLAk/KisV4NfHTyYlg1h3JK6M/OEcqxyPAmXTH5SIPiUEqNGqMjLUDjw0uPMhg+04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRJ7mLnh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso1036032b3a.1
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765530316; x=1766135116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18rjT9pgaNvB9Qf9LpM1y6kM3HyLMcgHWq36AJ/Vv+M=;
        b=TRJ7mLnhIMA373MfQb4xLWBaQi3aTg3BdFiDnOrq9FgZjpyq03wkibW9B87hq8lV3W
         v4wfSMQ2o+abH2rWfTX1Cvz54E8V0AzYVpAO/QeO45mXGJW1btoWJwv/RzDmSewsDmrv
         c36fYu3GPhhb2jARqJGLF3H4+xEFJkVor2xXWN/3NGgo8HwJrjjmitUV8VRs9UXhhhW/
         M+AWvBZhFXzU3fY1FFxHAo1IEu6L6dtZNLKabiR8bmnGuxTY2+UfZfcRNCGimGQnVkZX
         3Zi6QWHRYrmneTleQScL8+5CHMAbYinOzzr/HpFG2ksAlXnqn/Y+1l4MrtkO6L3ml+7a
         CsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530316; x=1766135116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18rjT9pgaNvB9Qf9LpM1y6kM3HyLMcgHWq36AJ/Vv+M=;
        b=E5/RBfy/HWUnElplneTnqBnSjVVstsyfJDSK6mqRTm14DDU4WyfMnnInmNyodzmqQx
         bAYZ8naoRd7bh7dS66JUN+56PepuRNFhR/H0kZ8mCLJ2WXoADqzgLcV4IQKnZ0nnLucG
         M2CxmnTJH2uOja+oMHmyXaJtmGlaEHQNtOQoks3JoyfB17ixOvu7qNjcPQZWt6jYEIOT
         /xgbUl35xW3FAXbZ4xYcNOopOISCLs+P3xKxJGzoGWG2iwAhNkxB24iHhKnED8xUGBdL
         p8lqAslvMAg7f2kxsEK4MrPGmmsu6UW2bYqwvNift3TrVo2/mjUjPsdpSJUx37Iut1TA
         3psA==
X-Gm-Message-State: AOJu0Yw7Y6FWy8VRux+G5uP9yq1dgFv5vnAN7m0swdlaJTciwIVXu+Sv
	nHMND+wBT9SqSygqXW+1jACMHms6faDo5tlvu7rh+VU2qj5DzBjnzYzr
X-Gm-Gg: AY/fxX70cXRJ/gwBBLFdAreURLqP7En1WF0gpsW+Bpg/fkNCcYgqoQT27xx8iwtpXbA
	fxzaG4B55X87ASHbbDFh6L5plo3dqo7KOOdhG3a4h870Vv7gNCFDnMpdRvUfuPE5wLcv3S4dKfv
	siPD9dWNABVvwa8a6a1XRjhJGoGEsMqfeBxG3KGVNP1UlUhPSIZ8cdjWkACt/SwLkpvOsqpIjJI
	+CHJ+gavLQsjaRYyfwzFxkOlO6oHXJaPIusvIt6rw3l3PEeuk412YpwSk0WshiQXNK7hgomqYt+
	1ZYOAzwT9A1aUqMKL7OfgFRySkeZ1dEjfVnexQlcfUTHSUOyobQlz0xavsnl3ZvlqyXPCGozJZg
	u1d301g0ezQRq66s9awqx4XpHYFwAD3wIQmbSfXq6zg5UYDiI/xsHa8N51JkYKfRHwyOLPmwWJ9
	+NDAYyzpHh0OgR
X-Google-Smtp-Source: AGHT+IEDygPV7ef+AunvCxcliNZzMaymBcHsi+xWx0um/y/3lc9mq5i2cxK/n6h0T+vGIbbV/Ff6Dg==
X-Received: by 2002:a05:6a00:bc81:b0:7f6:2b06:7129 with SMTP id d2e1a72fcca58-7f6691b1681mr1561358b3a.43.1765530316226;
        Fri, 12 Dec 2025 01:05:16 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7f4c2d4c2eesm4691139b3a.29.2025.12.12.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:05:15 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Olof Johansson <olof@lixom.net>,
	Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/pasemi: Fix error handling in pasemi_dma_init
Date: Fri, 12 Dec 2025 13:05:01 +0400
Message-Id: <20251212090503.2447465-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pci_dev_put(iob_pdev) to drop the reference count
obtained by pci_get_device() in case of error.

Found via static analysis and code review.

Fixes: 8ee9d8577935 ("pasemi: DMA engine management library")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/pasemi/dma_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..b824bfe97ce8 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -530,6 +530,7 @@ int pasemi_dma_init(void)
 		BUG();
 		pr_warn("Can't find DMA controller\n");
 		err = -ENODEV;
+		pci_dev_put(iob_pdev);
 		goto out;
 	}
 	dma_regs = map_onedev(dma_pdev, 0);
-- 
2.25.1


