Return-Path: <stable+bounces-121219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5A6A5492D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94BD3A4BAA
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334C20896C;
	Thu,  6 Mar 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i10MCi+E"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CD204583
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260252; cv=none; b=mhrt9g+O8g1Vn0OVWmD3qlvUU2qSwAttvXdwrKsG/k7ViBolCWYQMCGcnim5oSEUssaA3AYI3hnfhA11si8oMdL74fwnxujZARsDgwGndQovc+qg221C+u49g6mw97m3mEGI446KXojAj6b0J/RHQt0YZjcvkr/7ZLNa/fG0wj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260252; c=relaxed/simple;
	bh=TlrvRCPySdQOxtujofeQxJmxEKL7GhiXvuM9GTzF67E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpLGunCQsORFX479LyD0ZGEKzbAh41ZGqAK/CRUvlcTLAQ8cij+2l2uJKfX0J843m9cbq8esHM2sV1c/pymrpgEaHfTE9n1jlvBwHz8uDuwUU99GVj/4PbPPY0J9CrlJq/+FA8KArfVtBcGRDuYy7B9WjmzoDuCkXapnXNqdlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i10MCi+E; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso612488a12.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 03:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260249; x=1741865049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlrvRCPySdQOxtujofeQxJmxEKL7GhiXvuM9GTzF67E=;
        b=i10MCi+EgS5KTWmcXCV/WkJC60/Md7pToZmf19bqbFfI7m4VBt1MjVrshSXrxRd0dz
         zCEigUnse5E+iP2SmisaqsjVV2iQ3x+Dj5vJ5McCTKFvHY/2gVJWYEMZk0BgCJlCbVBZ
         6u1jztiqZRnyU+EIBiOq3XlgONZ18PvwoGRMY6+UZCUKg5BYuloS8agVYSRtm24v4EAg
         58O/GPXRShMKF0uByALJpNRmoeEkmCdrqrEQeZI9VOjxsGtr1yM++GWGyWV3dglyIrMd
         wnAJWWtvETybHHUKN4896f2rEAaR4yDX8cPdLjZWNIiWH7usGpZPjgTYtzXqHf21E3s3
         iChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260249; x=1741865049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlrvRCPySdQOxtujofeQxJmxEKL7GhiXvuM9GTzF67E=;
        b=hysFmVkPMHXGZdw/c0s4Mh1IifpLep5w8LgiVbH9Zm6goyN+tNmUaHAanK3L51ZdpM
         Cm8k0PUyudtxxLUYLQA5teNkKyPWxulZ+jyR4msnBsV/Dw7OmwHJAsU1ccC5TncqJ0/w
         cvcZSIQyPmteb/kPV0DPjddLen7v75qd+fsl8VffVQkl2eRlnxRpx4KMwcDu5wgKAsL4
         N/nRM/ZJcS0C2lzVgDPR3RYGPg+807jtLL6jsQH+GbbAyYVrP1c3i11kl+a1qgy/D+xL
         rj9Q54Lq3q7qq43WRuYstu6Mp+I+BmUJ9cO165bMMQ50geYboAmPVpKMFuRkr0Iz6ZtA
         7E9w==
X-Forwarded-Encrypted: i=1; AJvYcCUso0XFsdwmIYoVD+zTOwC7qhMXxKGF/1mDLFXRPhGwi2xtjzE60tmGkVNPhdlE/9yiVsn8NQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQok+jGZkHYx9I4pzlSc5ijUANY47utRNKuw6rcTuHXa/U/MQT
	btcmqjnTPNxxOq/GzALVNhPpVJmrHYHMNKimxBj7yqcU7v5wZQUr0hQ/mquXiDo=
X-Gm-Gg: ASbGncvQ5epH5Fvj243l8fSkRw4+wPUaI/rsNBDIRG/Uowm1OoEoKtIspMNR6P+Q9Vm
	08HzhMSiiVYVJE+64X8BbW0PZVgXmGIp4Gv2hBvqNkZy/cXEA8obINauXPfNPMOV+b1TxbqHGuZ
	3duqpRUoku5VCSFEj4mzOZm9II8SoNvYqMep9/RjfQynkIF6xhfgAE/gCkq5qAWAOwdVA4QsffD
	ZkmhxPUqYORhMsl0QiGl44j9YnwFUtn3Xa0NvNuHLYVbdUyeNJyMZB6GTKeCSgMn+VJn4dSbCXW
	ba9riTnaVcC/nSsKI4HsPxnrgqFqsrmr7ko1LKYnlvAWahei
X-Google-Smtp-Source: AGHT+IFJXG+ZAc6aSsP/TLrdtpd9ymEZvmqs4+Y8AAQtnIEGb2pYE1iRRI6PfSoONQjn41daLbimcw==
X-Received: by 2002:a05:6402:3547:b0:5e4:cfb0:f66b with SMTP id 4fb4d7f45d1cf-5e59f35248amr6527924a12.7.1741260249102;
        Thu, 06 Mar 2025 03:24:09 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a194sm787181a12.59.2025.03.06.03.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:24:08 -0800 (PST)
Message-ID: <4a200a7bf5f39034ce206a6c9240a307eadd45af.camel@linaro.org>
Subject: Re: [PATCH v2 1/4] pinctrl: samsung: add support for
 eint_fltcon_offset
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com, stable@vger.kernel.org
Date: Thu, 06 Mar 2025 11:24:07 +0000
In-Reply-To: <20250301-pinctrl-fltcon-suspend-v2-1-a7eef9bb443b@linaro.org>
References: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
	 <20250301-pinctrl-fltcon-suspend-v2-1-a7eef9bb443b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-01 at 11:43 +0000, Peter Griffin wrote:
> On gs101 SoC the fltcon0 (filter configuration 0) offset
> isn't at a fixed offset like previous SoCs as the fltcon1
> register only exists when there are more than 4 pins in the
> bank.
>=20
> Add a eint_fltcon_offset and new GS101_PIN_BANK_EINT*
> macros that take an additional fltcon_offs variable.
>=20
> This can then be used in suspend/resume callbacks to
> save and restore the fltcon0 and fltcon1 registers.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configurati=
on")
> Cc: stable@vger.kernel.org

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


