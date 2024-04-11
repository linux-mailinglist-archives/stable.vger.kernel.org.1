Return-Path: <stable+bounces-38077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76A8A0CDC
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D210DB21702
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B04145B05;
	Thu, 11 Apr 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yA8U6O4G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDE145330
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829325; cv=none; b=nwkkJ6GlIpt+U2yP94gYACYKVvLVMtCT+Vv3jumIAwOV/myDxThFRB9Me9ItwitUiGYC52RolQsnUrYrQkD0Y/c1YkUr6+WKQUBSBfM4lYUqsPjcEcbjJ6THwe1Ef5hJTYYo43hywXkGbZk58cQLfWk1iKMXCgux5NHEac93fNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829325; c=relaxed/simple;
	bh=x58WqDrW54mbSDZg6DVW0SdiBq5P4n8LYvlGtzYZ5Fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g/My6iNZRJbDeX9Tl+02bi2fGb40I8t3//XIZgFsMExgR2ctb7M9MS90bHyAIR43vYt7BA43sRioez5hcfqhI6eyEmmCV9wReGPfCF1UUl89hLEOIIW9l5agCUgrYR1CM1Derbren6JRo/vhnP+tmsvy3fwvsMuc/ntkudxkMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yA8U6O4G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417d08135b6so4959095e9.1
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712829322; x=1713434122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlGP44dphA3R+UbqzP2my5uJQJOQh7ETKlgiCn1Z/F4=;
        b=yA8U6O4G/m0vgMpIU0vNFdBGkOMB+yn79fMcWT2ebwn16jTuzHVQR/IRyGHnmT5SeV
         kxmvIKlfkyDHoumxXZOCWcJHGAGBLhM3LlTkJAjX1i0ghJ4JgN2QHzkYU9WZM0M30IvD
         Bry+le8TM4t5ja3vif3ndhVqGGAuR+MoVRv0MT6/6+tooQ/boIAV7U8vc2yCt5ydEgGp
         Badz1/blPoY0SVfqKwM/XMI8rJ8amHMq1jQc29/sL/t9f8fBH6WYVpFS3MdZ9lCMVfdc
         cMF/eET3uP/Ncd0GmLmEjxVzOI0Tb8cdfpvD2heOvJWgEorRE4vCU5qQSNDHYzv3KEfT
         wuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829322; x=1713434122;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlGP44dphA3R+UbqzP2my5uJQJOQh7ETKlgiCn1Z/F4=;
        b=HYLYexmEYEHmpy9v1XH1I6N10uZuK0X2nDFVy1WK6S5r98TxxnNfcDezPmzipxRBLO
         DqGrtitIzNamYqc5eRzUNzlVO0AqQZi1LAAS5TNwaKXuO7DIOFn4+x1Awj1XqcqsLjyY
         AeHFjwUkZaA5ckWo3lEDDHzheoQXkkY8MboqKtgEv6iEJp+aopEgwvwoZW77aiduG1J/
         453iN9XNbfh9KvlzFUWAkOadT8lFafNoVUKeoYQEFeMYDm8K8lHyF6m2L54XpGclOddf
         3d5YHj4LdbU6CGUUfpPUQ2Q8qSPIjBpIwoN+r04ImnLFn+tnJq2pDbjT4QSPAvy9vkGe
         8cww==
X-Forwarded-Encrypted: i=1; AJvYcCUtPm80CCTttFgMLoIwsZ9bPQWTV3aF1oCcViZUtBEVIvQizs+HQvD/WNKxs90c6cSrt0kDrmX0KxpNGVhf7QtfK9nsWkSX
X-Gm-Message-State: AOJu0YwRcmwwAftq9KnEz1SMegdC4bIsyA2yCCSASK+jqCiha7UO8ZCv
	sXnvwdfcwvEWi44x2Q7rcvxCTsrXzfcplYrVGlbtplE/dbJPA29qzya4JsVFT7c=
X-Google-Smtp-Source: AGHT+IH+8tjSkXLDnfEBY8Nl1q3OV/1O/GEG0fXg6mYcVntFO0qT8luy7ERWu78WyTA0HYHQdNoBwg==
X-Received: by 2002:a05:600c:1388:b0:415:46be:622f with SMTP id u8-20020a05600c138800b0041546be622fmr4697912wmf.14.1712829321839;
        Thu, 11 Apr 2024 02:55:21 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c1c0300b0041690a1c9desm1792206wms.30.2024.04.11.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:55:21 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, 
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, 
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com, 
 stable@vger.kernel.org
In-Reply-To: <20240306091642.9123-1-quic_vdadhani@quicinc.com>
References: <20240306091642.9123-1-quic_vdadhani@quicinc.com>
Subject: Re: [PATCH v2] slimbus: qcom-ngd-ctrl: Add timeout for wait
 operation
Message-Id: <171282932055.158508.13864797939880326855.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 10:55:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 06 Mar 2024 14:46:42 +0530, Viken Dadhaniya wrote:
> In current driver qcom_slim_ngd_up_worker() indefinitely
> waiting for ctrl->qmi_up completion object. This is
> resulting in workqueue lockup on Kthread.
> 
> Added wait_for_completion_interruptible_timeout to
> allow the thread to wait for specific timeout period and
> bail out instead waiting infinitely.
> 
> [...]

Applied, thanks!

[1/1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
      commit: b12bd525ca6e06c5ba93a49904f580f7f0021cbd

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


