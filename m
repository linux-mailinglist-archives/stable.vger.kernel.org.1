Return-Path: <stable+bounces-28619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCCC886DAE
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3261B22C28
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7113604CE;
	Fri, 22 Mar 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNLUfcsA"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F36604BC
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114789; cv=none; b=nkwPaIVeD9Vdm/BRriN+7/jnAfe+E7SHjIKPYv4p/OhLz8WheT6zeBWUP1EtGZueP6Bf2Y2ajaIJFwQju5xLA14i6Yk6ZetbGuPkDHvnXKCGJzoFFZs2EDsW5z0bHIG8MOJ/XErQA/cpInLc5FwBWKSvT60FG0juuvPM83fHaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114789; c=relaxed/simple;
	bh=UDjFpzbAEqCAi5Y5vmNjlDhNVDOOgnsTYKHQXiVRLBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lqq3cJ0dNINAQp5OCZGDKG24Adx8CFNLMYNrkptNaPFGsSsxwWcDOz05YiuHaByhlEFClsGu3ALj9bkm8NnHr8Og/QSSOPoeapsV3ijd0kP2/OEZM+voQ85O2ht3rKkvre7iOGxLXv8wQpMYt0xMyi/q1mLr9yh//rBgJ/6CcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bNLUfcsA; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd045349d42so1914050276.2
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711114787; x=1711719587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sdAgVv6zhpdXmVCOrDLXm+TnDpfj136yA4wyluooSzw=;
        b=bNLUfcsAWqqXhk19DEm9SBrltq0l9yAsYs79/qsqOhKxncR4iFhX84ApOxL0EoGlGt
         qEP9OFUJ4y88v3USD5N0U3VvICX05omOJwwDBxq3o0MkjboBimzDSSoV67nNgZ00VNSI
         EkD2sPQ8YPQHd8eEJzI0fU+7d4fJ4QQ5ieTDoJa+q4/D+wYsSzsowDDnDO/h9hv/q4p2
         Uy9YFQZTOZdbIw60Ja91IhCtJAdAo8CWZVXWKs36VgeJp1HkFQP+AzkdsWCnMXnlIHpV
         kpPc5aIEHjc3rgfFvy9FFDgl3fHUpUzSob0ztItN2wOsWx8fM2u87QgOcYo/zv1JFoXh
         Wo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711114787; x=1711719587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdAgVv6zhpdXmVCOrDLXm+TnDpfj136yA4wyluooSzw=;
        b=GUKgDLQHOeY5Dw2TaQUc8nsxp8KFf5q4nkjv2cet2xNMyGZkehHKl1USClJZF/A8GO
         F9qPPZ7OV4v9wNts70O1BrHs25f301Rz2qNUS7AaxDs/v5nChxr9LgJ/STeuioJZeQoD
         WhQR7/vANU9QwESFIszh4s32/fRXAd3JGeqwGfE4AyTl1k/Vi3p1r+zRHn+CBMLKVqt5
         wqicyluIS0BDc4AziU4AIzVg2eym5m8nJOu6XnNAFddKr08EWKTa9QAJ0MOuyLOIzb43
         6d5972DC1ce7bg/+hz4lg4L+3t3ZY8BIf1UpE/t1tBQbakUJ68S1HAxGHPZiVMCtrlCT
         ZfQA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfEZa6In9RbJD02dYqkD3vokNh39wBvNgb4rdNt5mUy7vIEYu+9aTroXsNiF9dRF0tgjcTqpH39E5ZLdiTmnCDbsM4onY
X-Gm-Message-State: AOJu0YxKJeFa7S9OW4XZTvFkcmvXGnLqv2Xr0yGPuLSzTek0cGeBIzXq
	uLmDxhCp+Lc2AacmboFrc8fylNWig9W33SipxQj9uNTEsaTNnKaa/PDXG9oNUReTi/RHpFHRLT4
	TkMY29pip3YgatCOMtsrldTvY+LZtTc32JmL2Gw==
X-Google-Smtp-Source: AGHT+IFSeQFc2Ozoj6Sey7X2Zk7t1MshvdnX/12EzWx5OJ+045kOG7AhCFtR6g5PLNSsST8vX2XpBMe3opH8KZoKJ8E=
X-Received: by 2002:a25:8704:0:b0:dcc:4b44:3377 with SMTP id
 a4-20020a258704000000b00dcc4b443377mr1978234ybl.25.1711114787050; Fri, 22 Mar
 2024 06:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-qcom-ucsi-fixes-v1-0-74d90cb48a00@linaro.org> <Zf12vSHvDiFTufLE@hovoldconsulting.com>
In-Reply-To: <Zf12vSHvDiFTufLE@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 15:39:36 +0200
Message-ID: <CAA8EJpoat+u6OK35BNEUT3xv5Da0UdMKhC-wEs0ZoViSr7xFZg@mail.gmail.com>
Subject: Re: [PATCH 0/7] usb: typec: ucsi: fix several issues manifesting on
 Qualcomm platforms
To: Johan Hovold <johan@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 14:16, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Mar 13, 2024 at 05:54:10AM +0200, Dmitry Baryshkov wrote:
> > Fix several issues discovered while debugging UCSI implementation on
> > Qualcomm platforms (ucsi_glink). With these patches I was able to
> > get a working Type-C port managament implementation. Tested on SC8280XP
> > (Lenovo X13s laptop) and SM8350-HDK.
>
> > Dmitry Baryshkov (7):
> >       usb: typec: ucsi: fix race condition in connection change ACK'ing
> >       usb: typec: ucsi: acknowledge the UCSI_CCI_NOT_SUPPORTED
> >       usb: typec: ucsi: make ACK_CC_CI rules more obvious
> >       usb: typec: ucsi: allow non-partner GET_PDOS for Qualcomm devices
> >       usb: typec: ucsi: limit the UCSI_NO_PARTNER_PDOS even further
> >       usb: typec: ucsi: properly register partner's PD device
>
> >       soc: qcom: pmic_glink: reenable UCSI on sc8280xp
>
> I just gave this series a quick spin on my X13s and it seems there are
> still some issues that needs to be resolved before merging at least the
> final patch in this series:
>
> [    7.786167] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> [    7.786445] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> [    7.883493] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> [    7.883614] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> [    7.905194] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> [    7.905295] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> [    7.913340] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> [    7.913409] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
>
> I see these errors on boot both with and without my charger and ethernet
> device connected.

Just to doublecheck: do you have latest adsp installed? Do you have
your bootloaders updated?

If you back up the patch #5 ("limit the UCSI_NO_PARTNER_PDOS even
further"), does it still break for you?


>
> I'm afraid I won't have to time to help debug this myself at least for
> another week.
>
> Johan



--
With best wishes
Dmitry

