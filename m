Return-Path: <stable+bounces-127312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7774A7789E
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E096D3AB9F7
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB91F03C0;
	Tue,  1 Apr 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2IbJeQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C4566A;
	Tue,  1 Apr 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502577; cv=none; b=Hsvs+5fCi3s2oAN1zdd6663SJ/Rw+X4QCX67N3lVrWsVIOCU/izVum27pYU0alDHvdpjUVnWLbiUZHAQ0MJn3v/BwiMVLZpQIsbg09Qf4emRXYMCza+DGqNK9PSVhe4fHB11TEHY7qMIA7AM29Mzr1N4YWVecEdOKDVV6kizM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502577; c=relaxed/simple;
	bh=fJuf7QgRrpE8EyTCAfmjINjJF3WAYEMREpuSiSeY6ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TtmMXolRgMKQfT5CvpS2td1q5pTLboUDFuwUnvd8EZiBEcaTJ9T83+W8tL4xGww0bWOOMd/RikjD6avcoI1a0j+pQ6kTS9ywMLBJOAQS4M+Hj2yBmTEo0ytaKAT2QsS679d108mrKMuskKx30HxNV0fNYAaRRJlV9Q8IQbMOkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2IbJeQW; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-227d6b530d8so96776105ad.3;
        Tue, 01 Apr 2025 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743502574; x=1744107374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFvH9ZV2m/VeIM9RuPxIlvaO7l7aY0mjmS9sI8UIPsY=;
        b=J2IbJeQWTJRBVUt0M/YJOoqgaN7nAXHIVPTn7ojD+wX5RQklSVZZ/SvTd3wb51Ig2U
         oyG4lu+vmRK/D6MNVvFUGaX5VbHLe+rCqYXAKx341TFZGvXRAprmPBhlf4UkyBlW3ivO
         wESaWjEjnzQ61Yhr9jTMeI10ZoTj12XW2gHMFxavaXwOoRvbHuFpOS4iHL+P7ETiA5Ua
         l9evbPXSmKlApTSuBTdXkVmKUOiI7pQYi+PVei9WraP80Spidzb2pjpi0HkTbt47r8HA
         gB4eMY84d/UE+5KAsVXsfFqlUM7Ordt3+gr+pEi/BhX6DqTEbb8dVeUEkVhDMgxJATr3
         fzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502574; x=1744107374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFvH9ZV2m/VeIM9RuPxIlvaO7l7aY0mjmS9sI8UIPsY=;
        b=Ga3iAdR13/BHTgdsJeP6X4XsSzhfgEYv/Cy5wMGW4rrx8T+zLX03npZ6l2ykp1zSo9
         LQRVKyYpVuG7A17XRu38mpfaPOwcmv6Zvh/tY5Wjt0ejzc3waYVRGoa+jmtQ9YqwKPMu
         R3ebLBKv0Btq32bx7oOvu9ukOkKFmjCJee+1nYUnCAUHqW8hVtEYKRo0XHkaNnt4JJin
         g4PSpXQpC9iaS/otv2qxYS+qn54bjlx9CG1hnpV9FJruMzTSrP41X39GI0wcSww3w5+e
         ldroptX0k2lQ9YV9bFWQnLWal3fY9+dNw68SvRFAkqWaD75Z9dbZajGUSho1KH0TT+kN
         2TtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM3TjLBL1Yz3omwXDjXnuQmNPBagf4f9Dp+OUQwGlmG1mQXwxIKRAxVaFXSTohcUBeO7Y9OnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvWHw6cPQg/Zd6lZ0ZAai2YENIYsU6mj3YLWUPi/TCTF/0zve
	QvAEoaZt0esVCuvNxoyzJvKUGlh/uGBvCv+vuvGmimAr6UP3BOIZIlX9gDkoIHg=
X-Gm-Gg: ASbGncvNGb4v2yAQoK0V3s9lYNuACdSvQSqu2e21q0o8jNhdphrKMsILfvQu8tOyx+e
	Qai14FL0/QARA6WSJ7EpBJFpmG7LGLGCBK3wqhDhqAa0dqFp6yfSp9l9NVcfdSKiCHrQzs2jGNw
	OU9Yl68ghQpnEAKj7Jp5jKCFm98s0EMpv1/NQqoxAkID4CGGmn09lzxMyaKKMuDvsavNFb22eFu
	t6R0CbbxEHYqtfs7gW9UBCbS6TdtwTR6bYJB6vH3PdKXxCX3lfJWHc2kq6TigtIZfEyaOhX7OgV
	iwb4btj4wsS//x8BFEHC+V8ZGSqoQqfqXJqlm1BrcOCTagxjkUaT23jvPBAZMy7K6/swjJ8eg4V
	WQtke2Q==
X-Google-Smtp-Source: AGHT+IH+Jt41E+RuNoDZtRe1HL4HH62/IT/HUpvgTdYzXmdyQIV0K70TeXuM86H0gfwDJo1pKK6jIg==
X-Received: by 2002:a05:6a21:33a3:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-200d140c289mr3516875637.19.1743502574214;
        Tue, 01 Apr 2025 03:16:14 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba10871sm6514812a12.73.2025.04.01.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:16:13 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] uio: uio_fsl_elbc_gpcm: Add NULL check in the uio_fsl_elbc_gpcm_probe()
Date: Tue,  1 Apr 2025 18:16:02 +0800
Message-Id: <20250401101602.24589-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
uio_fsl_elbc_gpcm_probe() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue and ensuring
no resources are left allocated.

Cc: stable@vger.kernel.org
Fixes: d57801c45f53 ("uio: uio_fsl_elbc_gpcm: use device-managed allocators")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: Add Cc: stable@vger.kernel.org
V1 -> V2: Remove printk after memory failure and add proper resource
cleanup.

 drivers/uio/uio_fsl_elbc_gpcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 81454c3e2484..26be556d956c 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -384,6 +384,10 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 
 	/* set all UIO data */
 	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
+	if (!info->mem[0].name) {
+		ret = -ENOMEM;
+		goto out_err3;
+	}
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
@@ -423,6 +427,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 out_err2:
 	if (priv->shutdown)
 		priv->shutdown(info, true);
+out_err3:
 	iounmap(info->mem[0].internal_addr);
 	return ret;
 }
-- 
2.34.1


