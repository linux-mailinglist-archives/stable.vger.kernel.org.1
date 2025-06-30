Return-Path: <stable+bounces-158872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1289AED504
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBBC1896235
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B020F07C;
	Mon, 30 Jun 2025 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vC+CiMtZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66B2036ED
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751266605; cv=none; b=GxYrpvVpMC0ojJ81kcBbgOhfWGnlBJY/7Qs1t1/Qkazw2An7Dn7Wl0H5Ao1Uj7gta+aMvs8gKqRDnaW7eCobK77z5X3gzwavPP+MTIJTnRwW6bYrBCijKsC/jlvhq363CMFW9uoBMZG/C5wu+oIwxhS2iW8vcRsCswCsnOIYUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751266605; c=relaxed/simple;
	bh=V8lMI/ycTv3tqtCuknt2wqYhGtqZO6N//510l4dI67w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qeaHAMcRhhAOuI/y+kGPh4UO3kkordiFkiCc8C90MzQOX24T/a4087QDZ2yAl17K/YzYu8O1zPt7p+6m7sBEaRb37Nigs5iTdLmQ/C/ZXVoN2tgtLrl9AqDpz+eFqpUWZ3JpiY/uj9FnhQQYjV4g6kGwr8ufRd0ZtIEh5ToZd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vC+CiMtZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6089c0d376eso844645a12.2
        for <stable@vger.kernel.org>; Sun, 29 Jun 2025 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751266601; x=1751871401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+ucKXlTGds2s7GThwxlN7FGLXCQFZmOc6TZ3BNHKTU=;
        b=vC+CiMtZHVNmByHQKluhGBTBh7ivXLQDBwwKfgdWYb35QBN1k+xoCMMwwLKhbZ7mra
         dp0GmZwpBrXnQmyXuvBGGwv+KALZbA2TWc/hWmB3C3dvTaKJ1cYDsBnjawV2y1GIfIbt
         jRwGYZKLc/zo+lSPz9s0Y7ZSeBQheQiWHLxIQH/6sEORZ9Voul1iHiZWN69k1wCXQge4
         LR1o/GcAXANpjaosNR6sBuxXDPp8piCo3/5HcZ8TKbI29bV4OGZbQwZ0g+yCvWcvwZIi
         QgGVFIyQCPYmb+vRqX+xTQ0R7cOZKsm8B14L0DVugE9mS7TWsSBUDxWWAcogikomYfdq
         Wk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751266601; x=1751871401;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+ucKXlTGds2s7GThwxlN7FGLXCQFZmOc6TZ3BNHKTU=;
        b=GHTF7J8bQw7kxe02oj8g1sjH98PF0hL9VlX+DzidllR1p3qVTBh8V4xR+T15Snt8BU
         7PTKGhg1S7wJJ9/lxiYLYdYdMV8zXLDmGcBcII1xDIhnJ5UScz5CoFdncQK02ndP4Y4e
         3C4xWJBClMAftLVvHxAwWAkdRpBdQRJev8cyChjAZ9tJEoPX+2vZSnlCZxl5WMt1x1KK
         PfmtiUYKev5cVg+4ML9thiC1QvBoe5ju/dhHRLJxpZWV8n9+utY4L8htMl1xpM7ev8AK
         EDimc5wsrswX10TAxmzswP1ev6/1xnvWhwtAoUFphjAhztFhmHjpxoRvZ1TnnkFQb8h3
         EkAw==
X-Forwarded-Encrypted: i=1; AJvYcCX9d2K6oWWBY/DmnWTSdDMGMIKAsR8kS+m0J2AjNAO2eSQNLjKgbEFWo/QUkhOLr2+ET0VFlhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZGct30E+gTVE6CG8oHM6FQIuGYRuwaSCjwteXVFBZD7hhuDz
	N2bY8TXKyVIyOSROOenvbXSRbWxZPnV1C6FBH15cR34SuF25AmplhJmfV8O+X5nqfMT/I4qypaz
	FTmXUQnc=
X-Gm-Gg: ASbGncvGDYZgEwOHG77zoLJou6+Udn1zF3bpx2799RPyBqUzbts669cTtQBx1YAA2vl
	0I5+lsObR5MnMVpJuBf7ldpf7HpqFsFSqf+Fwm4oGiQhlhsKImjtCP1A5iWJeVXSDTeDJpeW5L7
	+cumZxeCwX+Od8RODsl2xh5o+HlXscaHiANhYUelZz8LDCH08wBsXWOw3hZLu6+SYGZe//6YnBk
	c7xrZgEasJZvSOqyP8/wd2QTgGA8TvHJqP+Ux+d7bKrSKg/SRC6pnqIEnyA+V7qvaUkrFKXXv5G
	QbAbF+0T2VGF5+J2VjYL6rw8zs447P3OL/I85miHaSaGkPIUbw2SV7c2pcrgF/5YAkRAIAgZGKE
	3
X-Google-Smtp-Source: AGHT+IGU9xP+Go/413QUXOq1KbVbfMFxzQ8IwfNr4sg069oTmFb0gdttj33NjsLt9OC8dhZXTxaTLg==
X-Received: by 2002:a05:6402:1e94:b0:5ff:9994:92d3 with SMTP id 4fb4d7f45d1cf-60ca35c05b9mr2021686a12.2.1751266601314;
        Sun, 29 Jun 2025 23:56:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bb118sm5368960a12.2.2025.06.29.23.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 23:56:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, kernel-team@android.com, 
 willmcvicker@google.com, stable@vger.kernel.org
In-Reply-To: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
 <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add
 dma-coherent property
Message-Id: <175126659939.23797.4726512180709761065.b4-ty@linaro.org>
Date: Mon, 30 Jun 2025 08:56:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 14 Mar 2025 15:38:02 +0000, Peter Griffin wrote:
> ufs-exynos driver configures the sysreg shareability as
> cacheable for gs101 so we need to set the dma-coherent
> property so the descriptors are also allocated cacheable.
> 
> This fixes the UFS stability issues we have seen with
> the upstream UFS driver on gs101.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent property
      https://git.kernel.org/krzk/linux/c/4292564c71cffd8094abcc52dd4840870d05cd30

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


