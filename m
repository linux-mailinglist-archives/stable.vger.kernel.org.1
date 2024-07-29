Return-Path: <stable+bounces-62555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C393F5B6
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24C31F23054
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5FA150981;
	Mon, 29 Jul 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdIdYL+5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3E1494DC
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256941; cv=none; b=iMh5jjOziEDhp9WfzO0qvWab4Hp0SThsjN+5/cqwETWSHg5Xw/2OaxmDHNbJrbxdgLV/UK2KWoFDDQZfTVCq0cUEgdzrHgc8EFum0kkp1iL020sd1Nx7CIez37J6vxTR9mykXQ4f1Ii+7OEEAjzNFxP87FUjUmQcnW5HU9EkY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256941; c=relaxed/simple;
	bh=XMtSAnQLUPLTjEcZ9/jJuTztPkljj4KBCEwVdIRm9FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wj65gPCfAMSsS9tUE8+7NGZlcTVA22s5vQBnnCTm57qec+nhWPRtbFowlQ0Mgzg01MubwA16juU0a7Uoke/ANeEuezbEqBI+q6mNnb7+6jsUK/nT/Ozyt43ATafcZjXoK5ydWwpFh0yTSfi5LVWvVjYGAw5fPqT7+L69rtYPMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdIdYL+5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso16574645e9.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722256937; x=1722861737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N37H6kLbkNAIPuExxunsB7bhPLTHsDDj/8KnxxdH8yw=;
        b=zdIdYL+5faQpUDJZwI9HxYaAMurA7BiYm+TksSWvmQGV+37eD/VWOMxc71Z/GNIJY7
         6T808NtQfItXKarLR2yWJg63UioqK9129dtyXa2TKxQflgtmr1k66YSpdKhkrpwBdzk6
         /nA4cGBVgwe3DDGTTHD51/whL66ZH4wXzuB0OsuGVlulJGO1A7TbcIjxiCqm9uy86O4c
         d+TRsVLkhIvauVLiGi19uEI4FDWl0vDR4S0nAOf4dmSh3qu/7C9tHZF1/8xk2eItr5dX
         Xx8SmFfGQHCKrW667KKG76uYtFtU3KjgI/TnE/VzYKoQCduOjarIbPh+PZGCmViZezrM
         4+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256937; x=1722861737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N37H6kLbkNAIPuExxunsB7bhPLTHsDDj/8KnxxdH8yw=;
        b=RIG8SaFevPfPBHsKUo718+4N+/bXHIxx+GtXathgC/a4p6C3AAF13CozdPID1fhsRF
         b853SjCqeGfklN/MOnoaeHrMlfm6yq+NKDkga7yjSO3NFGXrRWRqbdE8MpUP61Oe+MXm
         vkkpWXLh6H/AXXvGpSp7qP/I5SbZTmLdu1ye1g45RXwkg58xLZoN0+50WfRCcPmR8hVt
         W6vCxStB2mf1BfMW8uBpO1+9yeMn/GBf9EG/pjAFL8VoemQLQ7qxRmStMsTfHh44lQLB
         BZX1COcY0TWTKE2qAX6cKu1eyE+lMa/WuUMVilkqUhxmc/k4pLWGXw9YAkhYV2j2GRYF
         z9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOq+LBgq17xNsmPfWr/79IYuOshrWpxJncsJy0TTMqztot7QLHau0AtISVj6kOvL7u/NtXHPw4Pldg+fpUOD2MNFZhkmWf
X-Gm-Message-State: AOJu0YyNgk7e+xboB0BAcvH8EoDoOR0aoqfVxex0rGg+DyGKB99FO9B2
	osV/bKiOdHhCudr+HtyADYpxw5gUoJDkYdZsqwYhTdqXMoBO4aRIvcqb43mFkA8=
X-Google-Smtp-Source: AGHT+IFd9o55Nf2Yjsmn3MKtdq05hMAb79DL3MCHg9LTvgi6dSD5URw35jk1cVD61sFRmsWeY6X4Hw==
X-Received: by 2002:a05:6000:1a53:b0:367:9851:4f22 with SMTP id ffacd0b85a97d-36b5d0cc08cmr4558101f8f.58.1722256936868;
        Mon, 29 Jul 2024 05:42:16 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c092esm12106275f8f.13.2024.07.29.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:42:16 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 29 Jul 2024 13:42:03 +0100
Subject: [PATCH v3 2/2] media: qcom: camss: Fix ordering of
 pm_runtime_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-linux-next-24-07-13-camss-fixes-v3-2-38235dc782c7@linaro.org>
References: <20240729-linux-next-24-07-13-camss-fixes-v3-0-38235dc782c7@linaro.org>
In-Reply-To: <20240729-linux-next-24-07-13-camss-fixes-v3-0-38235dc782c7@linaro.org>
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


