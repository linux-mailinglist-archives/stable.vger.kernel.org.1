Return-Path: <stable+bounces-27004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F536873B5B
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B02BB25963
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4813791B;
	Wed,  6 Mar 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+9JnmEF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4D60912
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740625; cv=none; b=JPNy4nOthphh37BYuZ31fYcjHN2jKtEC4L17nJqktYFk2rlsTGfhbPsQn3VOeJcjtXX+5ca7tn+4TkomiHZZxzxBg9lyX2rKAc4EEpochcfHJerH8FWyy8AJFv9/l/vdpb+NAb88ZLVeWIjY7puUI61fWbFuthFzJnLgCmLR+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740625; c=relaxed/simple;
	bh=y1KNSY2klj9TyNv0mKj+D0MKiuhGSXTO5BHMy1t7fH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJMX7hp1ObHJjBP/2DYkEJu7ziLBYyppR3YQ+jwqMTrRwjX0pf1XeCiMQyepmZkzNEoCtMy4mVlNnduiw0p4LPMw98zWS/8OHJc1pNhRQugt6r8qwTqQ2TTOocj9g8pZN6AOWOmEhI7oE6zQI4D1x96GFHKWDhlseI3T7BAAcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+9JnmEF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1132927276.3
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709740623; x=1710345423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f+5aPU/XdbNCp1ggYwNVgQ5AaKBkNmvjYLVF7eMmS8=;
        b=G+9JnmEFomgLSXSdnMmXKue6XtwdWTMZFLJDq62dzc4zs0lo6Ee2KwAFQQCz/Ga23o
         QCQpNBVDawtZDlD3hZTeFCR0hcmn6liXnD8yTfQKFB5RNCA6u2DNfgguYOmD3NA15rOa
         K87ivmidMac+if65s7GvP8GOWsFeIxBeew02QlL4A1Kbs+YjDxhNf/2J7RwUGDNTHUoJ
         nQH3eXGailZepNEgGqP0Rmxn/BTbtfw/heGmle7/GA2ZpVm05fT1lqEWfiIlwS+itICi
         7DpYNyXiVQBW3FM8FzHAT6uu1DBgC9n7Y012oL6okeVHwEYOUlX9sb6m+iGn+xF7I9II
         j91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740623; x=1710345423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f+5aPU/XdbNCp1ggYwNVgQ5AaKBkNmvjYLVF7eMmS8=;
        b=J7xN3LIBQtsxcMLn6l7B1Ha63NI6mb9IbdxaP9Krm448Y0uu2GmxZ7GyI8MCtV8l/z
         uWm7E0vQ0je45JNEARWaX3DSTMHi63aZk/FLLYtpvv2mIbaKiZorMULwemtFKYnsH5B8
         qBW/vwVWNTQa/DaAxYpuQI2ko1dMjFuxmzxvqAH/Xt2YTuodYRxO+8Kk+k4xUffz+vDe
         BAtsoH7j/nsBwgR+CzQ5QG8QnprzWnJ+38nTcHE3EyTHmd8X+EN3DHJg7nM0c6+wlTVf
         kyqeupE+jFdZ0I2KPvkehWLeRE/rIioEUA3bVMHA/zzftlNWZ+YWzxrY8Vs/PUJ6IXd0
         xgig==
X-Forwarded-Encrypted: i=1; AJvYcCWcL8+Oxj1nBi+prTEF5WN8fmdDy7RKgTE1Ws/zwPzJlOwRsOuAg5ULkE7tuGEJ03z8TKqQOx9xjJXeDo9tayhzTLsq08Ek
X-Gm-Message-State: AOJu0YxCJQyGwtzM0Sd85n3g4a+xibqqlh8ELKS06IxcE0xHHvUiQqI4
	GEYFYSTk3ZADbI8SAD0GFygxyOL9N9VPiHRDdbopxQsFlT00EV3VhHJvd7MDhZNqoIlppmMPlA7
	j02JZLkelCk4Ll8uuyxatJhnHoisQaFBI+54u5g==
X-Google-Smtp-Source: AGHT+IEiBAntuAC1iQgfrTxPAdJ0FUKBL/8fqeqAZ/6SuiKB3vWu9Qa4XggVFqJogNCxgNIqcJZDkJj8OmAWXl+Vt8g=
X-Received: by 2002:a25:6b09:0:b0:dcd:24b6:1aee with SMTP id
 g9-20020a256b09000000b00dcd24b61aeemr10930675ybc.47.1709740622702; Wed, 06
 Mar 2024 07:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
In-Reply-To: <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 16:56:26 +0100
Message-ID: <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Wed, Mar 6, 2024 at 3:22=E2=80=AFPM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
>
> > I still cant grasp how "target_part =3D idata->rpmb->part_index" is
> > helping in the design.
> >
> > What happens when:
> > 1) EXT_CSD_PART_CONFIG_ACC_MASK > part_index > EXT_CSD_PART_CONFIG_ACC_=
RPMB
> > target_part now could be indicating a GP instead of an RPMB leading to =
failures.
> >
> > 2) part_index <=3D EXT_CSD_PART_CONFIG_ACC_RPMB
> > loses the part_index value .
> >
> > So part_index should be larger than EXT_CSD_PART_CONFIG_ACC_MASK even
> > though the comment indicates it starts at 0?
> >
> > /**
> >  * struct mmc_rpmb_data - special RPMB device type for these areas
> >  * @dev: the device for the RPMB area
> >  * @chrdev: character device for the RPMB area
> >  * @id: unique device ID number
> >  * @part_index: partition index (0 on first)    <---------------------
> >  * @md: parent MMC block device
> >  * @node: list item, so we can put this device on a list
> >  */
> > struct mmc_rpmb_data {
> >         struct device dev;
> >         struct cdev chrdev;
> >         int id;
> >
> > is it just possible that "target_part =3D idata->rpmb->part_index" just
> > needs to be shifted to avoid issues?
> >
> > I think the fix to the regression I introduced could perhaps address
> > this as well.
>
> I have no clue how the regression happened really ... heh.
>
> We should probably rename it part_cfg because that is what we
> store in it, it's assigned from card->part[idx].part_cfg.
>
> Then the id field in mmc_rpmb_data should be deleted along
> with all the IDA counter code etc and the partition name hardcoded
> to be "0" as there will never be anything else.

Seems reasonable to me. Are you thinking of sending a cleanup patch on
top of $subject patch?

Kind regards
Uffe

