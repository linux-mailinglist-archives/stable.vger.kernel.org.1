Return-Path: <stable+bounces-70369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF0F960CB7
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B68282044
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2341C32E5;
	Tue, 27 Aug 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlIhxQ3e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA231A0721;
	Tue, 27 Aug 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767029; cv=none; b=UKHd+eqfltrH7vfvWDecwPZDX7/G7s9fcvfe3jOc/qtNLe9pLlnx+URNWkiISSv3mH8saPB8Qmfxs2kS9bbw0RBSDvhZ6ixhCxW6RaQ5jXMdXbsRud8qiW6fRvNRoD/L5ZjGdy7XZ2GiSuFBOzLhjy56PRMjp2X0ROCMRH6qWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767029; c=relaxed/simple;
	bh=reO3QG+v1itNZN54c+wyIa0kyddzc2cUrltFlAiFcDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axgTXl9Sg7QHBIVFMoqv6sEruIn7+PPxu/EcqqCi2tWg7lce6X0InpyFBMR7n7osTEdG81Y/XhT7ChOKs9HcPr3q2rSgB/dbRi6aNG/Bdu0B8uLReKSd8MPvTrsR7DMEhSAgfmzvyyXImGZ0wPQdHXKkUHnoSaBU9ODEV309WWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlIhxQ3e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428101fa30aso48022095e9.3;
        Tue, 27 Aug 2024 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724767026; x=1725371826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZEqvc6zEHEfwAN7IHcwm2DC5T9Ho962g1TGUZnthTU=;
        b=DlIhxQ3edTCpWkZ+mbayL7Q0GzZPc78qRIDO3hC0LWwjNGBrccdPtjHMVzjQhaeVc6
         wQHJLGyOIAvdF40kYe2PEtebp+UfEHhu/Hoycymtqm7N43OBptczbJW0viP70Py6RR3N
         UiBEoTtdjlPTR4hI8/VZbfO3FgPELpf7xNqdxM1g26S78NKa6O4qTq7SFOwHxy4Z40yw
         XbyHSlep/6iwjwEmPgYX2cuoElI3o1Ah5DZAhWGuCHq6ykMJDRpMS7b+3cHx+gcHmd1x
         or6BR17wS2P2uvt5y3Nz72vGGSz8+9fOLeNbEDe4h9k2XLk9e7lNSqPGZDd+0uBvJr88
         9RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767026; x=1725371826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZEqvc6zEHEfwAN7IHcwm2DC5T9Ho962g1TGUZnthTU=;
        b=YH/d8bviB1EErflor87fRoH3l5S0ibU6DvdoJNRTNuwaAaFyh5wQY6l1UIcfDp9NOK
         m7RuHbnzqKH9xzAHiL1luhKx7i05lYxcjv4PsaWwAYO1Qqae/F93b62SXc/RST3mKxFy
         9UIhmxkVwe/Ti1ouGi77QNj4JNVlt2EYb7765cYIk38QGIjgKbeYUGWmZFpUv77otTtZ
         Pa5ipdTBV+UTK0w8x8J85ENRcvHiZFQvox50Zk/MOeb/80Uux+3NY3tuHwX6Lx9vegFU
         BlFssj5+TA0W8u/twz5pX75Y0l+yTXvQsAYBanou5cgz3cZM1y8oZKk471Llq0077r1D
         j0jw==
X-Forwarded-Encrypted: i=1; AJvYcCVz90iX54khsaxc+MAMtBBsFvLlV0FL2pMAeSpXbLrolixLKUEFdJrRElyS2AGGjwZM+eP95m0Hl65fdV4=@vger.kernel.org, AJvYcCX7EDsX4UHO0JSD9pns+yJkbw6pnU8MjowM5LLf1I9KfGvYQ4qmKvK/1bw1d+/TN7SMRAChqMAYT3McjFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/eHV47tUEs7xOMWE9LhkALPE3LBupBuPED5hMa4ZiT9AryuE
	e+Gm+S2kIFxTtuQRtZzPQXa4RNT3uW6W7RqM61xDWxSRb0fWFYmR
X-Google-Smtp-Source: AGHT+IEjaBiDkWtaA95khky22P6PC5R3VYIlTNatnUSbe9dgj0TFqbAkCCvOcvJ7G8YL9qcSzKRZMQ==
X-Received: by 2002:a05:600c:1d03:b0:42a:a6aa:4135 with SMTP id 5b1f17b1804b1-42b9adf0b5fmr23266855e9.20.1724767025987;
        Tue, 27 Aug 2024 06:57:05 -0700 (PDT)
Received: from localhost (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm185664985e9.24.2024.08.27.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:57:05 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Timo Alho <talho@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: tegra: bpmp: drop unused mbox_client_to_bpmp()
Date: Tue, 27 Aug 2024 15:57:01 +0200
Message-ID: <172476700282.1247158.4472584146310216649.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
References: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Fri, 16 Aug 2024 15:57:21 +0200, Krzysztof Kozlowski wrote:
> mbox_client_to_bpmp() is not used, W=1 builds:
> 
>   drivers/firmware/tegra/bpmp.c:28:1: error: unused function 'mbox_client_to_bpmp' [-Werror,-Wunused-function]
> 
> 

Applied, thanks!

[1/2] firmware: tegra: bpmp: drop unused mbox_client_to_bpmp()
      commit: 6aa3ed11978d55f6d0377fdc58f1ef19dbd03af7
[2/2] firmware: tegra: bpmp: use scoped device node handling to simplify error paths
      commit: d281ecc22a0da7f2f067f61f563c3475d9d90059

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

