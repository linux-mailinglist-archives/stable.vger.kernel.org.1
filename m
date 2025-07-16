Return-Path: <stable+bounces-163070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68756B06EB5
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD61A64CF1
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8E28A727;
	Wed, 16 Jul 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hBxU0FI6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAD381AF
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650149; cv=none; b=LoajgccOqKQLSCmr4YDi+5U2alxYty1JNdgFly4pa9vqWI0/X0Dd3QeX3Mtxuk4S6izKlgpHzWillC+qc+kmzGkPQi8zEhlL/JNx1Z5QHPwYFdDmHa7ywccHvHXeGBZYgLGgt6PMHTGF3EHCbmdrm4MJGPKqa0Pm3LKd9FBmg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650149; c=relaxed/simple;
	bh=24Tb/LcZcpuEpFKIVKeMZB7NBtNKQTvEKsUhXdnCMXk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UVJpiWlP+byTDOik7Bgj5v+LWJI7WACqvJVW61ZFZ/ZbgfWqhxvgPTWu+UNnBbUVpvtZG+s8Td6rvS8/7yLGaSU/he/1nQXdMUUok0Cov3uGn1L+TCNYcD7/zwzJ1adpnO5QWvK9RdTT0Oxsnm9FO/bX6xXyHDvreDD6cq1bYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=hBxU0FI6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso9861995a12.0
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752650146; x=1753254946; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfsjryOJJcheH9NBkSyCY8ER+5hEKLpu3+/ZdvPKIxw=;
        b=hBxU0FI6N4QyvB9ewq8YRKB58MORaqNgkMrhXYVmffHaIufzTUqBkT5pO9I8Vk7sVE
         72DJEvKxWuMuruygEKXhPttCZprFXvvhq/onoRMHK+fYnYSdR6nPotsCmeUcjpu33+bd
         SW28QC5rr8OhHWCFj3WjkAJEGVQuEzcaVWEhBawOZVZlR+TlMUybSl/eA9k/dkb7sQRp
         vyD6PszlSyymICoMdafqoXUgi8embFU2wiMtp/1pOQPcBf2u9Tk23JVIss5JvzxQV6mt
         KJUfr4UHgNhJfILhy5Y8HbMlMt+GiPBTPhOc2IfkdHjiCHrZcmqSCCKB6RzVlswHxfOU
         Elyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650146; x=1753254946;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YfsjryOJJcheH9NBkSyCY8ER+5hEKLpu3+/ZdvPKIxw=;
        b=qaiqh0CqY4j+VLwIVdNbdr68K+yi0IZMKyq3GxOgntWoIM0KhgFZZ3UU494HL8UNvK
         99wz2IIH8lnXF8aAvzHbXSzf7CgvcN/gaZdQ+jd3rQnziAeD+C7jPrBTHVt+ab5N9A+7
         oz3YM5fFzvuZyUhzDWjdIC1DcpuARw5BlagFmxa7jMQjL7DJ3qwZ5d3wMJwmvQqX2jJt
         Nm0ULpAF5sqxgG7P6vul8f3z84dczGT/fUgBI50siLs2SqwiaPuxC24DqhWcvXlz20Hq
         FupCNEY8WWg6B/Z34T/jhGyfx0t8IWQug3poeF2CSN5qJsguHKLMZHzXuHALXlDzhPHJ
         xGpA==
X-Forwarded-Encrypted: i=1; AJvYcCWj9JhtVTF09Akz1vcHtUTpg/pOSCkshBGcx4nA7F9CXy0c3jyTXmdvvIRlHV+mhWY+7FHNU3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lGpOHCXlAE1JtCNgJ4EyYyTuyx+yAk678Caa5CMMHl5ZyzCU
	X4Hc6lCxp5C+/MdupjISE47TOo7hftbiGyXjAvVL17sNX7PDqJ/1fVrspuVkmi5KRrc=
X-Gm-Gg: ASbGnctu+ThIKjuNdUsS3Eon6QZhFGLwv7V2pUn1yn5ZLjJVbmxdVcVKhK6oN2ACAbF
	b57CvQGB41UQmh7Amw2gskd3hHBoMr8nqjO0SJesM9Au+YcmSBkqJADKIq9u+3zIWVnVmz9BDVf
	w1OIbFMsq7sx/tbufpnSjEdKb/8Jw6IVyftS4tby/0gWHD7XmQBb8yhgzFoXorU7M0WLn0KXTtS
	Akevpc+ZrSEC4avIwSMuF0YSl0iGVgRu+kr/X99X6xztlQ4VcRs1lDM0fBwPlbhNqdBVpLtc9mg
	PXEeBXdng8yfAhG0JG5iKhIMoCS8Nw9QPkTb2qup2dy8xIK+qgsUFpg7wNcpyPohaACPa88UUgN
	3qQb8fpCBPmEms9l1FnHD54D8m5oTx5Kw4S9YOIhGrYdl2TyI79ddo94=
X-Google-Smtp-Source: AGHT+IHh6O0xWZNdSmDIs+XRRgBqO1v1bLel1oaIRd2A4zdKO7Ksr9kC4ZbOvvs8AVHwGMBGLMFLbg==
X-Received: by 2002:a05:6402:2343:b0:606:9211:e293 with SMTP id 4fb4d7f45d1cf-61281ebe084mr1668193a12.9.1752650145562;
        Wed, 16 Jul 2025 00:15:45 -0700 (PDT)
Received: from localhost (212095005088.public.telering.at. [212.95.5.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ec04sm8197036a12.60.2025.07.16.00.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 00:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 09:15:43 +0200
Message-Id: <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fixes/improvements for SM6350 UFS
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>

Hi Bjorn,

On Fri Mar 14, 2025 at 10:17 AM CET, Luca Weiss wrote:
> Fix the order of the freq-table-hz property, then convert to OPP tables
> and add interconnect support for UFS for the SM6350 SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (3):
>       arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
>       arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
>       arm64: dts: qcom: sm6350: Add interconnect support to UFS

Could you please pick up this series? Konrad already gave his R-b a
while ago.

Regards
Luca

>
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++--=
------
>  1 file changed, 39 insertions(+), 10 deletions(-)
> ---
> base-commit: eea255893718268e1ab852fb52f70c613d109b99
> change-id: 20250314-sm6350-ufs-things-53c5de9fec5e
>
> Best regards,


