Return-Path: <stable+bounces-32305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7788BF3C
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A362C1CD1
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12316679F3;
	Tue, 26 Mar 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEgOKATE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529065C904
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448587; cv=none; b=mSfxTExpVZgqEVcYcUzpRaVab2DPHAnY21dWL0cqUrvSj5cV7x10kuAFZ2tcZErMrDJZcYxS5wvRvXrDVhPVxnSPdXK+Fw4jyS4e4l1ekfyJQFmkwFDgXnShIocPmrsydqHShZKAn63l6ypHIuQZjXs+Sgm8yHkYBmnFF7foqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448587; c=relaxed/simple;
	bh=0IMne5VBa+58VtuzJy8j+olboFvZILX2uTItPkJtrOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FssAY5f2AE5YdldBd6szf5W7YxnO0s8SL+DDU44PP8xcMNcq/rLeEXvuzyMtN05AkLsHnIO+w+ZEsBWkbicrUBibp1ieIp9S+RZcmLyrvFz8KsBCVb7DV6titPJOcLi3Jw80A7elYby80pv/JGTBMDrown3t66rlb3wc02qHye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEgOKATE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so5362025276.3
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711448585; x=1712053385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Coz5QHcwkc4vvJyKILt3BgtloDsW9YU/fidz3bPl5fI=;
        b=bEgOKATEUmCwFyAj0sc4Qh04jJA3MiukpC4IWsTj9K0I3hCy5cOJDzlKYRC8ogOjs+
         6UyVpmhmhWbyTnjZ8Xsh5aTxivPgkgHqlgW2u7h23pyBSVmC0pzZ0AAwCVXolNiWhQlQ
         GZT158YdoRODnoiFcy6ixnS7KMfzDYjggL0NdX49BAyX25fV4QaeMioTcmEVG0tR5dNr
         CG+jg9oPTngAKYsms3BEVj/fkj45DH1Dlzovhx5rr4hlCLf/MiLs41ShxLj3bY7o0Dld
         bh0wUxew239+fMt1944m6IYgtsunJJChnYpN+c27GXDsm5+Gx8yOdWoig+7GuAMgbjR2
         Y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448585; x=1712053385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Coz5QHcwkc4vvJyKILt3BgtloDsW9YU/fidz3bPl5fI=;
        b=cYsPwhkGFip5oV15ZZYMXVMJWq+RSSKVaA3IYxtF5QECHRKd+8ygJz3fMIz94ZJ51j
         SrJsdKMVs2qhnkDoaYL5WBWyIz11CVsq4rqBeaQt001kZYbQlhaV05mOQvhsIZdOrs1i
         ECknpokiKOwsHn0HimS+y56ltZXlf/7kKMOyCPJsh2I06IgmoU3CRVh5QPpKi6nYhfZ3
         RmkugLqtiGpeJd7cCG96u63jRe/j8Sl0B4X4qFT6QWGWndr2DEurSI7gHk3IeDwLNBxd
         Ofr0RnInuWWesXOFOOiLT8e0I0IOD4Lbf4QlzifWBMhd+obPprRKs8J4rUo23PRZoOEM
         OkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNfjnD8WCayZiPSSsAOQTtdYuzmdMJT2vcC6I8PuG+UO6pe2Nwk+ob3HmAk/Zh5v6LRP+hJEiDEoBFoFPQhat8WCEyV1SI
X-Gm-Message-State: AOJu0Yx1qIGC7ShSFz2Am7tA0fnfypqP4D10YDNxYtPHvS9JlmT4YyMr
	RxIUQbMGHw8uAAqHY+IuLlR/RNEPxfPlV11A2BhPMz0LpOwuuWeNefPmzKQTDZjeK2oOC8ackXn
	DEtqbbosA1CXT5e/fYhHAhodHblTID8uRxn1rrg==
X-Google-Smtp-Source: AGHT+IHzeL7j+Lap+SUend6NOhzvfZN+ev2xsTWYhqeCohIsS3abfKm94TKmLelfb7+6rCNqB5JgwttmAh38+nk8EuU=
X-Received: by 2002:a25:abef:0:b0:dcb:f7a0:b031 with SMTP id
 v102-20020a25abef000000b00dcbf7a0b031mr487313ybi.50.1711448585041; Tue, 26
 Mar 2024 03:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-qcom-ucsi-fixes-v1-0-74d90cb48a00@linaro.org>
 <Zf12vSHvDiFTufLE@hovoldconsulting.com> <CAA8EJprAzy41pn7RMtRgbA-3MO8LoMf8UXQqJ3hD-SzHS_=AOg@mail.gmail.com>
 <ZgKKPyLUr8qoMi9t@hovoldconsulting.com>
In-Reply-To: <ZgKKPyLUr8qoMi9t@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 12:22:53 +0200
Message-ID: <CAA8EJpqwYrskXMLyyYwW_4e-NXPPS0+MGbumEvXXNwj0p1u12A@mail.gmail.com>
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

On Tue, 26 Mar 2024 at 10:41, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Mar 25, 2024 at 10:56:21PM +0200, Dmitry Baryshkov wrote:
> > On Fri, 22 Mar 2024 at 14:16, Johan Hovold <johan@kernel.org> wrote:
>
> > > I just gave this series a quick spin on my X13s and it seems there are
> > > still some issues that needs to be resolved before merging at least the
> > > final patch in this series:
> > >
> > > [    7.786167] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> > > [    7.786445] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> > > [    7.883493] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> > > [    7.883614] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> > > [    7.905194] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> > > [    7.905295] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> > > [    7.913340] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: unknown error 0
> > > [    7.913409] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PDOS failed (-5)
> >
> > I have traced what is causing these messages. During UCSI startup the
> > ucsi_register_port() function queries for PDOs associated with the
> > on-board USB-C port. This is allowed by the spec. Qualcomm firmware
> > detects that there is no PD-device connected and instead of returning
> > corresponding set of PDOs returns Eerror Indicator set to 1b but then
> > it returns zero error status in response to GET_ERROR_STATUS, causing
> > "unknown error 0" code. I have checked the PPM, it doesn't even have
> > the code to set the error status properly in this case (not to mention
> > that asking for device's PDOs should not be an error, unless the
> > command is inappropriate for the target.
> >
> > Thus said, I think the driver is behaving correctly. Granted that
> > these messages are harmless, we can ignore them for now. I'll later
> > check if we can update PD information for the device's ports when PD
> > device is attached. I have verified that once the PD device is
> > attached, corresponding GET_PDOS command returns correct set of PD
> > objects. Ccurrently the driver registers usb_power_delivery devices,
> > but with neither source nor sink set of capabilities.
> >
> > An alternative option is to drop patches 4 and 5, keeping
> > 'NO_PARTNER_PDOS' quirk equivalent to 'don't send GET_PDOS at all'.
> > However I'd like to abstain from this option, since it doesn't allow
> > us to check PD capabilities of the attached device.
> >
> > Heikki, Johan, WDYT?
>
> Whatever you do, you need to suppress those errors above before enabling
> anything more on sc8280xp (e.g. even if it means adding a quirk to the
> driver).

Why? The errors are legitimate.


-- 
With best wishes
Dmitry

