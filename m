Return-Path: <stable+bounces-58753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B029C92BBC0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CACD283FF6
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB0181B81;
	Tue,  9 Jul 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSAQ4u4I"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A617E901
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532914; cv=none; b=NVwrplZ05z6F2cdcE1mlP9vgZZn1vA37LfKdcC0VzpsUzp32GL3mv+5QR8+/6qohQo/rHQjBzswJgBbBYeNQswE9u06N9IQvc3Beb9NfDxY5uEALb+2YT2CALXAqt3igz/oro38lU9d7nSdxvgM+mcwr3MwHoVmzKXhRlxmjDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532914; c=relaxed/simple;
	bh=bL6t+kZFucDajd7H3MVoLbxP4QMw5AdDFCkBISCWBK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hw2seAZkLbETx+83jcCYSwMzlbUwEl8rnpYNgI1C1zJSG3Rht2TtzpaNOwWjto5jWCHrNi0cSDSWcCTLEDIp6knp4dwT+Xls9dqGIIcYUg4q9ogGXwmgWnVw7n1cHS02/4+thek9+f6j58UIURFcgoT+TeRF/tDfxBBlF+t0NLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSAQ4u4I; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so4982093e87.3
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720532907; x=1721137707; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhHYU7UmK4dnD7/sjmuMOOwDgcdEgKtZKNrTen8zuww=;
        b=kSAQ4u4I1hdFNSV2+rDfN1CbuZVj+kBI4C2mPJajE2RDvnUVScSTSkws//dQN147q+
         BLKTpJCd1MBIeQtaT0G2IK8LPnWknAGhdHcWKJEhq669p0XiF++t3zQZrS4Ijr73+hYf
         Zp45v5Vn+NSyR9p/ww3Qp/uPCkq9368qlpky9AH1VyDNC+GFuahSyiRjZE0LIGLCDM75
         DsuxxCl1TAiu10AU51nGR0s4d2l642I6f3S85IlQW+S3Ipctkp7YsSnc5/Aypjz1pd7u
         cJBoZ1vvOQ77tzfjPoElojVmLDLRnH8/lSa5+ad8kUosE15uWEdKrab+OX7zK9QNIX3e
         /pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532907; x=1721137707;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhHYU7UmK4dnD7/sjmuMOOwDgcdEgKtZKNrTen8zuww=;
        b=WHgXhYQdyGcXhtUxwc0MEPzVwfbtogvhOflth8smDhmaNk75yhiJnNEx7HEK3Pv/8A
         wwqJRMDsrDCtw/SLnzbgXmuVvA2DjLU++fnF8Kw+EH0FGn+7jX/aKhrqWtw9o52OA0cF
         KmZXPGKKMqW78uYlxMm0L7XpsichbxPFpTSwQTi5eEMPbQ8aaX55wWPQQiBijpJ7TXZG
         /l2bgolb4IcrmpSRs/JNNyivscy8qDTdMVV/WuUO//PbjMk0MSQ3SLr/J1+VYAdHBDci
         lzk5EIqhajYefpJpLh6KQNFlx756Rq7X1sMhUkZJ3FnkCtywA/RG7u71q9TmnH1s7d6/
         vCCw==
X-Forwarded-Encrypted: i=1; AJvYcCUA3QRFqDlV0J8jHQ3dpYXslkYvxsFAer8k/drV86OXFcKFTmwDqwR3KGBF2FnfIE/gwKXVro8l4BaZ6sRPWCVAGKhcHpw+
X-Gm-Message-State: AOJu0Yz37Ih9NsckQqstLFfpAQOIYfw38lq4c/w+njP2k0xdR1spL/BE
	aW8ach57e9KrC8Zef8lItkZxRINs5dl/AAYEeF04OJFuFnC5goN+hoqZf4IjA2M=
X-Google-Smtp-Source: AGHT+IH+4DaePyXmIoNWLgjS79EsnJAzPqo0nKjSdovFNAcILKuskj9yBxxbOKOqicxdvrhvMII+KQ==
X-Received: by 2002:a05:6512:2349:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-52eb99d20f1mr1872812e87.53.1720532905946;
        Tue, 09 Jul 2024 06:48:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e4959csm250297e87.82.2024.07.09.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/msm/dpu: two fixes targeting 6.11
Date: Tue, 09 Jul 2024 16:48:21 +0300
Message-Id: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKU/jWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNL3ZSCUt20zArd8iRds+QUU/NU49QkQwsjJaCGgqJUoAzYsOjY2lo
 A++nUC1wAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 Chandan Uddaraju <chandanu@codeaurora.org>, 
 Rajesh Yadav <ryadav@codeaurora.org>, 
 Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
 Archit Taneja <architt@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org, 
 Leonard Lausen <leonard@lausen.nl>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bL6t+kZFucDajd7H3MVoLbxP4QMw5AdDFCkBISCWBK4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmjT+o18HQEGU/sh2XXVi9PeuAXwCOvz/3KnFsm
 9WZwmhMseaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZo0/qAAKCRCLPIo+Aiko
 1ZpGCACE6gn9tmgMaVRmpBa4xTQljPegAbZFYn+ABYfIs31WEBWo/P9UqeL5ARG15SGCRyVcseT
 RxgOeDmBPXxGP9LOov67wJGBAUEvKJB0Pq8IOyegyKoLn4b+7H4TWdlpa2UOGSphHy1ZvoyX712
 MmV3f8r3HcL+p2HV6ZPJGfJW34MCMF7qVCDf3kcpWqSTPJZKW+kImOdbV90u7JaoKFX39eg8BbV
 G2rDiW3BCyta8sfiSHe4kMlk3AGfOPvh+L598PeQlQ0SJ9FkULJin5ywg8bPqpEr3REZg0Fs7PB
 Mz3sfn2D35c0aZgurVDkT2dQCqH2DaxaplNesO9HYYjA8y5t
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue. Also make sure
that DPU debugging logs are always directed to the drm_debug / DRIVER so
that usual drm.debug masks work in an expected way.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/msm/dpu1: don't choke on disabling the writeback connector
      drm/msm/dpu: don't play tricks with debug macros

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       | 14 ++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 19 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-dpu-fix-wb-6cd57e3eb182

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


