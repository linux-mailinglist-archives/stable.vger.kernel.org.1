Return-Path: <stable+bounces-93543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888A9CDEBF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C832E1F220B7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159B1BDA97;
	Fri, 15 Nov 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK6MerwE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346D1BC073
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675330; cv=none; b=Uv/Q9Ww0LTJ5DJJLkglJ/5NT40ixBbi7Gez7KojOipR9FDIfH3WDn//aBNvBFq+ep4F0jTZzzJAwdYjBpUK6Iww7Qt98+LP/97FUjxZUUl6t10XEo5zbvLt7RR2u7h4ai3LI9DYHkLrEEF9CWvVGIFF4tTG1GCYwaABN4qQgNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675330; c=relaxed/simple;
	bh=CCI27rlvVRosezWzuY/2E3AP29V/IuLh6N24eCBmC9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mPmTTE5hb4vjRLidCeYpOVR0XgIlQOwJWNdCPPP0tp1eB/0oG8Pq5G7M0u75n3UT60yrszX6UAKHc2BWgh2QOkEkFd17brKx+zrGNPsciZ+VTu//tEjA0IP44pV943yrWHPFoEeHxTMg0Ypxenvx6Neya+0jBbT/+sfOCEKxm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gK6MerwE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso14887565e9.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 04:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731675324; x=1732280124; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZze3yn24TXviwcT7N4kjvraoXCM6pscw+3oqLD8HvY=;
        b=gK6MerwEa/Cg/PTunyjr5GbAvw7A4y2cLBGlWTaykMNTpwYkDLbdMytxaf2sR9YRKh
         d8IPKQtZT6WgAIvAZb+LAbFdWmm6WKWWqR8UvDJYvmpzBfVNubsMpf10shFQSQG/7VOj
         BAyC99VVGMW6S7Fc1dPD8sJTrcmAGyXgMzd6UBJpLkra4A4TjInU8AZeM3f2DOwkuc1w
         Q/fTaoNuvdz2GkSm7LmPtyu6U4RmBBot4T9n99I9hRkYtSQk0gQgYkb7Y41T8m2caulj
         Vf0W+LJUsbbFyqrnJwz5QCVJrV/IpfjCiaX3kYBtxBXIMQ5dyFI3b30Gs478yQGXyjMI
         SiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675324; x=1732280124;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZze3yn24TXviwcT7N4kjvraoXCM6pscw+3oqLD8HvY=;
        b=J/eG3gEa+IXRapEipjILOWLjieezm0J1CntyN+cPXSgNmZeOiLEJKO81LeaqXaJTrU
         5ACklh0UCmfLFrmpvBiAQ7l+OBXSK647ng2NeW9ba40mJcu1wAZbegbnaQytp5zHRrPY
         ouBEYU9HdLzzQb+Tm+N88UKgjjGY0FG/8MV5pvu3mBdu4zBsCNBp2ToBEK5O0y80QuQl
         qKg/oXND1RMXZUf9Ja1DbF98wC625ejcIt04eT8rXdW6/fsnV0pI7PxTJiJqYKlSA8b+
         PNhYxsLuLlUDP4kqx7ThoD1mKUT+3bH1PawTEYc9N5mk+a+6bueYfDxmsGMWNj+td9Pm
         /IvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzwlvM9JBmIt7yG/hu3uY8hJTxvGqpjUam4iKU11lP3sSnkW6/x6xlnJqvvTF8Lim50BI4wLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQuhEzdIKBf1WpH/dz7LCgQ88gZ8Z4hBdwHQOL70dtg0Nz0No
	TuVGJw4TVhu/3rvLAcY+zSkV1JpQsPMNt+4JpSdQ47qZS0/YsDiQN99TYpWDNdw=
X-Google-Smtp-Source: AGHT+IFCxeXdFwVvRfx+K9CW5GOw9LM/hVZhe41k/tOelfCV9iTkGBsMWti9JMRBfFAiS/C37CDtfA==
X-Received: by 2002:a05:6000:70e:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-3822590b9aemr1876457f8f.3.1731675324056;
        Fri, 15 Nov 2024 04:55:24 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:f4fb:dc44:5c32:eaef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae31083sm4285582f8f.103.2024.11.15.04.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 04:55:23 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 15 Nov 2024 13:55:13 +0100
Subject: [PATCH] drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-x1e80100-dp2-fix-v1-1-727b9fe6f390@linaro.org>
X-B4-Tracking: v=1; b=H4sIALBEN2cC/x2MQQqAIBAAvyJ7bsGViuor0cF0q71YKIQg/j3pO
 AMzBRJH4QSLKhD5lSR3aECdAnfZcDKKbwxGm56IBszEkyat0T8GD8m4807Gjd5ZN0PLnshN/8t
 1q/UD7WkMTGIAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

The IRQ indexes for the intf_6 underrun/vsync interrupts are swapped.
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16) is the actual underrun interrupt and
DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17) is the vsync interrupt.

This causes timeout errors when using the DP2 controller, e.g.
  [dpu error]enc37 frame done timeout
  *ERROR* irq timeout id=37, intf_mode=INTF_MODE_VIDEO intf=6 wb=-1, pp=2, intr=0
  *ERROR* wait disable failed: id:37 intf:6 ret:-110

Correct them to fix these errors and make DP2 work properly.

Cc: stable@vger.kernel.org
Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index a3e60ac70689..d61895bb396f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -389,8 +389,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
 		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_2,
 		.prog_fetch_lines_worst_case = 24,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
 	}, {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,

---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241115-x1e80100-dp2-fix-beb12c6dcac9

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


