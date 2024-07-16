Return-Path: <stable+bounces-60371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C36933427
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 00:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C779B2834E0
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703B144D07;
	Tue, 16 Jul 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjmQLgMj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43453143C40
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167991; cv=none; b=evZLrrs1i2Fx2CaRmLdtW5DkiPAkGI0EUYjArP+BkDe53kyMWHBKyaPHepSzTPP/iO7wzmfPRfuTbcdDpTbsw12k2q2daB5K6TpfFUkjIy/RH/qquuS6UYTrpTY2wBkCg8dQnnPZeCC8oc1jXDEpiyGAQAGGQghuoU24US+LXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167991; c=relaxed/simple;
	bh=XMtSAnQLUPLTjEcZ9/jJuTztPkljj4KBCEwVdIRm9FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l38JAuAUQtSDUtHTeBnkHCh6vINDp30N6i6tkzNI+7f8w3OtAdHmpk//anzsnv4Mgy7k+DPlymOBWyRHuDV2r3Qua7c4PriQ4h4RJ8Bh2qOXHfTnzO1TvKh1cYjVwTV2RDgpNkVoRoxBrDAXPlXSojlwh7aA2yttjBHvaXa6GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjmQLgMj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so7412618a12.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721167987; x=1721772787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N37H6kLbkNAIPuExxunsB7bhPLTHsDDj/8KnxxdH8yw=;
        b=FjmQLgMjigIdM1J3dcOZykVf0m/v3rTlS5b8bZ/rbCa1+m6MqBp91Ybu/YUBW8fR6I
         wUgnXFEJeMW1qSXGMCyCZ6XxFykfQe/7Bhxn0VihsmXD1aENdk/JqBocGb2xtsSEP04L
         0ppImgesB9rCJv2Xu6elhVNxOAOPEY2B3vd3H9DZiUIH8wf30LOFQywn5pDGFgTr1bgs
         NB3PrQuuIqu8OCykSm8mfckpi/QtWy40QincLyLT4Q80v8/OkrDeWj7MsPtfPNCnG07S
         6Ka53AhIpqvv1a18CulBy3nRV4GBtIB/2vX1hkaYzflc4C7HobqrP5jvKAcYMg2WAApN
         oM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167987; x=1721772787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N37H6kLbkNAIPuExxunsB7bhPLTHsDDj/8KnxxdH8yw=;
        b=GPdv8EXUMbX8IsXQluolvfTklzo8xMtUcSTteVL/XgIjYn08F7tokZI99LU5xg+F0m
         oMvC7t5B4Iy1qZxKVz4Mq6Uj2ltR9wveEk68Dk9s252dsZUCmo8I2JrvYzVf/KcBU/0S
         wPONFHCQ18jlOdce4XxiS3deUUwBgyT2hV/upBC4JarluXlh8GDy3eqYjAzlGW2dIokn
         r162STce2VQ34pWeWRmRtSpPDrpm9+Kfrn4ava4GoY6TZb8rYjTK+qx1lR+olpsGJOj6
         irx+TVLhXqFIE9BrylTNjl7+HVSYdCvTWAgdhRTLApkpgyEOQSEfSu88OtbOef/k5BWW
         g/zg==
X-Forwarded-Encrypted: i=1; AJvYcCWZBOtOlAZJktzdVkm4tO49dHN+tvno+n3j24Lr5oeD+QP+A8/PSbXRERGUi42N3harJVyt246s9OWnTC7vvqNYiD2QCdLo
X-Gm-Message-State: AOJu0YwaEjyNqcqeh8Ms8hTc9N/P1AgTUye4v6sghyX07eoslRD+Pdjw
	ZSlTygJUf6WupVbfwoaedslEuKhq5fmgEXYpFU7atDRA/Qd80K6zL0h5q9jOD24BrhOhqN1ArEO
	AEVc=
X-Google-Smtp-Source: AGHT+IG+MADQTpWKslhKvuJZKyGIHvh1adrMraY/f13ntQtqMtGVpyG6NOKMVQVgZZdl1PITC4I3bw==
X-Received: by 2002:a50:a6d7:0:b0:58c:74ae:24ee with SMTP id 4fb4d7f45d1cf-59ef06b97fcmr1807973a12.38.1721167987397;
        Tue, 16 Jul 2024 15:13:07 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a28ddsm5582997a12.71.2024.07.16.15.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 15:13:07 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 16 Jul 2024 23:13:25 +0100
Subject: [PATCH v2 2/2] media: qcom: camss: Fix ordering of
 pm_runtime_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-linux-next-24-07-13-camss-fixes-v2-2-e60c9f6742f2@linaro.org>
References: <20240716-linux-next-24-07-13-camss-fixes-v2-0-e60c9f6742f2@linaro.org>
In-Reply-To: <20240716-linux-next-24-07-13-camss-fixes-v2-0-e60c9f6742f2@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-13183

pm_runtime_enable() should happen prior to vfe_get() since vfe_get() calls
pm_runtime_resume_and_get().

This is a basic race condition that doesn't show up for most users so is
not widely reported. If you blacklist qcom-camss in modules.d and then
subsequently modprobe the module post-boot it is possible to reliably show
this error up.

The kernel log for this error looks like this:

qcom-camss ac5a000.camss: Failed to power up pipeline: -13

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoVNHOTI0PKMNt4_@hovoldconsulting.com/
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 51b1d3550421..d64985ca6e88 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2283,6 +2283,8 @@ static int camss_probe(struct platform_device *pdev)
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
 
+	pm_runtime_enable(dev);
+
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
@@ -2323,8 +2325,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	return 0;
 
 err_register_subdevs:
@@ -2332,6 +2332,7 @@ static int camss_probe(struct platform_device *pdev)
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+	pm_runtime_disable(dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 

-- 
2.45.2


