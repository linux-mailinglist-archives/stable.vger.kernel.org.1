Return-Path: <stable+bounces-195164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C62C6E34D
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4184EE3F1
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F15350A31;
	Wed, 19 Nov 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA77XtmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572534D93E
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551012; cv=none; b=DL6P8fkUfCIiNCci6M3/UhTDuehMpL1jTls0Y7aeLu7QyfFYfFmW12SjlbmIcxd8jfxEIAls+uNZFuUAjVwAMewAf4JZLQCeUT3LkvmxEWPCN0dUQUsKp+JRgxzOpkqcef19PUcOtQMC/JRXPum8iyetFwVppSVwXV4Q7ObAvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551012; c=relaxed/simple;
	bh=Jfm1+IV0dmKR6UvATXbNPaNXa4YJ4/UDhZCRc24a46A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bjpj5LQI5azblEgTdRxjjyOL7XzWyNdcFOeJco8PQ9EV2AbSjpyKVoLsvAd75LG4ksqQZbETqY3JPTkgJio9uZWPlkMSA5lOrfV5yAgtC9TY9/8xgsdwyi8fLxc37OSlF9CXG2DZdhKMCMF+98HcWxIqd9ZO3mYt2TB6eNdMufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZA77XtmL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47755de027eso44842985e9.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763551008; x=1764155808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jfm1+IV0dmKR6UvATXbNPaNXa4YJ4/UDhZCRc24a46A=;
        b=ZA77XtmLwwkJObTivXPBfyDyqMyutSIkl8y3xw6NyX0zWizyH8GREDJ8Xy9KQ1VUAc
         v5aB2YnBhltBiL/ocqMmMZ0V7/PojY60D8WCO95lJBzqcdeq2kjXf232ERL4UhrFV8Fi
         8RNkFjsXsPlWa8u0VNf6DaGo8BS5DQffGZRDhz42ii51Kh9cu9eHLM1bShF5OSkvmdp9
         RMUpOr+vQq8XanN+5hh+h8ZFvd6e64ByWTb8TJakk6t74FH9ptwJYwPcFfmUYGluba6+
         bGDtqYexC3beYqQ+hfBHFRoQkvzcSJOMyV0HzoAma3X1OK5HmN9tQ+Ln4AfDes8E+6xu
         zR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763551008; x=1764155808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfm1+IV0dmKR6UvATXbNPaNXa4YJ4/UDhZCRc24a46A=;
        b=L3yyNfwiZpkGcssskK2S8O6j1rKgIPHmS6oOeCOffDkiEVeOiyyLQPJlcRTxJiy+yN
         o8MfC3hw94X1XbLFh0nUM8e3bs+DqCvuX7K4ccjy9HbPIirGZu3urFm3/n7bWFv/AWiQ
         6TRDbtKFYPFuEKhkIaKwsTbnXE2llLwOwc/wz1faz0JlUFtvStNwtG46jcXK+sYZJvWc
         W8JUDTKg1ZwlAuWV2Sn5ULMKO49cqBs5Zn9DtX3CpZ3odh4KdlRmDkFHOi3dXnHpBE6h
         WeBTR5jwHSZz9IOUy24J6KMmjMsztDTe31z7zc0sgHYChce58hppz2xaWIWnJZAYVxQ5
         dr9w==
X-Forwarded-Encrypted: i=1; AJvYcCXKNzvrkMyhR4E3zePSYwSmAR0GTcRHP4ewLa4/5JylxRCh5SOu3Xusle0ubVyAvOkfly46Kek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPmRccKBmnHQJDMVCoc7VJ4WiS2XSkVV2eoSFRjfdImKoj0a2
	7zzF5zK8xnPMjx9p3NgmSl7r1rFFiarsTXc1GmpIDAaH2keH7jsvQo5UoC4D7iBQlnQ=
X-Gm-Gg: ASbGncvBiuJozq6fsO6v8JIqcu3L7Qwiiz0ZUI60SeVs4vBLHgY80VrxIKSVNksmGNN
	VnRWcoonOXeHC53viVqra3KYLyf5jUtuLiaffGgRarBxvSddQCDpyC1cQOcuV7ONci/UTT6FV7L
	Tal3gVxpfhzdjnDtNn3u7lVsqw/UPJNEoRdLbMjKvNKm7mfOTpbQsNx7a41tPXY3b2uLvhcv0tS
	rc1bxWCN5c1zZUc+xk5BlUF5hW4CJwmAI5ZaEJx+QLUmc2rX2pbQJ92BXrEqbkCkKFJmWMd1NSh
	5wyilNLhcHQv/JesfC471rWEU5nAudSX2vXcpJwSFn+N/ycRpRALdLHlWkcTV7LCFDwXly/4cOv
	U8s49sZq4uSqUuIEQprkEQ0H4jon3wBVPjdHT82Xtt76WIoQ8CU0fFU7CJriFrdyd2ffhMI1L7s
	QXZVXPHzoAWDbpxVVwdQ==
X-Google-Smtp-Source: AGHT+IHxUjgdNCXTiwpOfnXS2oC4TBNMEII+w8M+hOGIH0Djg1ZSLLta8lC5CXkAR753ngvyVq70XA==
X-Received: by 2002:a05:600c:3542:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4778fe7d0ecmr189079235e9.26.1763551007791;
        Wed, 19 Nov 2025 03:16:47 -0800 (PST)
Received: from [10.1.1.13] ([212.129.77.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1013edcsm42553585e9.4.2025.11.19.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:16:47 -0800 (PST)
Message-ID: <643a5776c383a501b129cd0f867395c0ccf80566.camel@linaro.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kishon Vijay Abraham
 I	 <kishon@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar	
 <alim.akhtar@samsung.com>
Date: Wed, 19 Nov 2025 11:16:46 +0000
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
References: 
	<20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 09:07 +0100, Andr=C3=A9 Draszik wrote:
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
>=20
> Update the code accordingly.
>=20
> Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend wit=
h UDC bound (E850+)")
> CC: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Friendly ping.

