Return-Path: <stable+bounces-93779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED39D0E03
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C49E2834BF
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3B193416;
	Mon, 18 Nov 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4noGX3k"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67527193063
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924775; cv=none; b=NkOQrugySLkj4qup3hiypz9Ms3n4qHxaonl+aNeaNr+jUDGdlelnbsIqJ/q0mIVdNDAvdKw80t3yTuGUepPUI+vKa2YUQUkasHoKEra+fnoqwppxQtagrMWiYONXg42TwnbcMT4FmcQrGvwoViL5yt5nBSYT/WXZAJo2RfhANpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924775; c=relaxed/simple;
	bh=Z7m1/bx2XWgczsdkfVN/oo1Lh19kiLa/SWjmZrMNdBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB3eTA/KmQFLsisoBZL7mOFXddo5EoDXhlv1RkKlj1IGtB+1JqEFWJ/bnmP1CD7fli+tnfoXp6LHTdLbZ6ffRNJfyTYLVWJRihW1BLr5dH9o1le0hvRexKxEjKg0tppoBjMwTiJIk370BmIEsMqyBl0EiCnT13ycLJ/bTQ0esqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D4noGX3k; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53c779ef19cso3385330e87.3
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 02:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731924771; x=1732529571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7xLm61FDHK5h8G4Fa84tFI0U4ziv9T+kSyJudn7tic=;
        b=D4noGX3k7X4cn+bDz3Xm7RMyz/63yEdmpQ90qrHN9PVdRu6m69z5B0IrM9ti3x3Gq8
         TByrR8p+wLzWy2UswfJd1y5p8lABf22rGjzemqo35pkH4bKUMMmbvX4oHcsbGU/Yn/yV
         8r8vNQ3jxjILBLKOwzeDQtfo2U1nvgBQ0120Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924771; x=1732529571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7xLm61FDHK5h8G4Fa84tFI0U4ziv9T+kSyJudn7tic=;
        b=lchLFFeX5njUTibH0jTTZf7pbiez1arwIhcwD1naHXxk85w5X7tsnMNqcGgCrG2WzU
         ySozbPml2bfhsQAOaL/WuJnIEeFGFDIcovFFgTDNhhgzctOY4y2njPSM+ECDm6+u2tV/
         PEhjYS9IzijTwaD8K5e3JvLJ6MpGjKsaTT97b8W5nmPdJ4VOBsEvv/afpVmB2NEg43mG
         FEVMC7VmMLVaBAcTW+xjzDXxA1uWc6T4VtTCOykkizQiMiwgY8GmEygPFuFJvgzM606A
         EwmEN4wUELTwMTDa3obui/1Asg98ZWFAbVOvl0AFUaKzoNYcYoV9sGrPizM2EgLjgyqh
         MRUw==
X-Forwarded-Encrypted: i=1; AJvYcCWpciPK/mO6xGLk9Jc6RHobPe3IlUo0aFar1QsE7ePwC+N8nrz+txdW+pCZXHkYGLZ3jHYJyg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKgljfO1Kdtblbycjk5JkFc7/yttogfT+SNukbuggMk+BqeZV
	gydlyxECeeVmaD743T+4xHGLx/H7NVKlzUczGPIzEJJR1jPaOkqvy6+xEJO3qOKFSxweOeP1L2d
	OZ2grDkFZS0sTv05D3rB7nDurD1lh9IsPCmk=
X-Google-Smtp-Source: AGHT+IFAbDpEPszG9w7z7at9t7rD47jqj7cWtWXgASiH+i18zL9EwcJja2gshu9D861K/FbtBgtPbitSYXzF0NLj9SI=
X-Received: by 2002:ac2:4c4d:0:b0:53a:d8b:95c0 with SMTP id
 2adb3069b0e04-53dab2a92e7mr4252988e87.30.1731924771472; Mon, 18 Nov 2024
 02:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104154252.1463188-1-ukaszb@chromium.org>
In-Reply-To: <20241104154252.1463188-1-ukaszb@chromium.org>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Mon, 18 Nov 2024 11:12:40 +0100
Message-ID: <CALwA+NY0khkOAdZ2bfGJpx937rtJ+HKt4FBVYo8TE63YafEuyw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 4:43=E2=80=AFPM =C5=81ukasz Bartosik <ukaszb@chromiu=
m.org> wrote:
>
> OPM                         PPM                         LPM
>  |        1.send cmd         |                           |
>  |-------------------------->|                           |
>  |                           |--                         |
>  |                           |  | 2.set busy bit in CCI  |
>  |                           |<-                         |
>  |      3.notify the OPM     |                           |
>  |<--------------------------|                           |
>  |                           | 4.send cmd to be executed |
>  |                           |-------------------------->|
>  |                           |                           |
>  |                           |      5.cmd completed      |
>  |                           |<--------------------------|
>  |                           |                           |
>  |                           |--                         |
>  |                           |  | 6.set cmd completed    |
>  |                           |<-       bit in CCI        |
>  |                           |                           |
>  |   7.handle notification   |                           |
>  |   from point 3, read CCI  |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>  |     8.notify the OPM      |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>
> When the PPM receives command from the OPM (p.1) it sets the busy bit
> in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> command to be executed by the LPM (p.4). When the PPM receives command
> completion from the LPM (p.5) it sets command completion bit in the CCI
> (p.6) and sends notification to the OPM (p.8). If command execution by
> the LPM is fast enough then when the OPM starts handling the notification
> from p.3 in p.7 and reads the CCI value it will see command completion bi=
t
> and will call complete(). Then complete() might be called again when the
> OPM handles notification from p.8.
>
> This fix replaces test_bit() with test_and_clear_bit()
> in ucsi_notify_common() in order to call complete() only
> once per request.
>
> Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command h=
andling")
> Cc: stable@vger.kernel.org
> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index e0f3925e401b..7a9b987ea80c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>                 ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>
>         if (cci & UCSI_CCI_ACK_COMPLETE &&
> -           test_bit(ACK_PENDING, &ucsi->flags))
> +           test_and_clear_bit(ACK_PENDING, &ucsi->flags))
>                 complete(&ucsi->complete);
>
>         if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> -           test_bit(COMMAND_PENDING, &ucsi->flags))
> +           test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
>                 complete(&ucsi->complete);
>  }
>  EXPORT_SYMBOL_GPL(ucsi_notify_common);

Guys,

Any thoughts on this change ?

Thank you,
Lukasz

> --
> 2.47.0.199.ga7371fff76-goog
>

