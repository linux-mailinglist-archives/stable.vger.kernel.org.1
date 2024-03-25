Return-Path: <stable+bounces-32269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C988B326
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 22:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DED1F621BD
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496C6FE15;
	Mon, 25 Mar 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZMpLRZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641776F524
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403417; cv=none; b=bCJEyk0s9GF3s6MzE/Xuyf8ObfHU7HmHn1cUO9vA39wvOuq2UzvpPcqriDhwQ5zRgsIZIR2O/lcIUG2SBmqDUMwP6fHIOW/Mhl/MiDID261SXwgrGECfMCfpX0IBKrr132UlMx04gZvOWYnOJQLmvoLC+uZCzIY6tG+MrDk5sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403417; c=relaxed/simple;
	bh=oMwZrCFp8dMUvhWDn6c0mXIOD2/iSsSXxQYY8pZyntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSy49HqUQuSjsYIRKe4vEnj13//kWO5NCnLtIB8F3UYA0/YG2oexALXpmZP2/WxUWluY4DwTS7Gtm6deJhB1enxCcKaYneAtMw1inTMr8izabFgZrd89KsFXGhp0vMSLQwRbYyrbt+6OG9/0U1hYAJDBBX3xnOhrHmxwPNWJddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZMpLRZ/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-431347c6c99so36331cf.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711403414; x=1712008214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlpfV5Tydfz9QyOmPbOHYJo9SnZWGh9oswRld/5cI2o=;
        b=QZMpLRZ//70d8RXbaSbuDxlnhXIDjyOt8qjCz77lNLdDto/ARhSmVLxMKVpur7loyo
         xTK/MT6AWWqnreiRAzlyPumW2XZNdWYW84JOhK6Vs3f3GAkOF5+hbpX7zrtbfkcDMG53
         wAjEAQHY0vitEl4oYxbRTt0dTfN9L5N4w5AysbRffHQBgKYFSQ9iMeDfPQ5W95l7aKTY
         ism1R5sTfaeEbaaLQBthXv3zHyZNqseL5gdNDohXv71Zh3G41oDy6nXu1hqlnDJQ2w/5
         4vZGCFAfqiTgkPzrfFXtTp9fK+u9K1HVcoDLaTXj6iPc2XngWkkIzjRRgmVFxbU11fbV
         PxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403414; x=1712008214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlpfV5Tydfz9QyOmPbOHYJo9SnZWGh9oswRld/5cI2o=;
        b=Td1gO3KNIKQ44KQCFADGncoFuAfQGLxMnboTMXhQX0Ry4OccZlnIgNlv2oG6iITupl
         ZhiRv+vzVDOXwwzTHcHH9z/ecteTHCCXTbzBfODaRb454MFyNVhLoCm2FI0oKzw0fpXm
         uuNIbNG70cA0qJbo3ZoBFqNCmFMbJmAPvzQm6HkKjLbTkPB6SxqPgrKq9rzEGulfepoI
         YtLqKwPP339DCyhg1xTBn+nOv83ASKPV3yn1FpLSgvEh1sbdTy/Qpt24H33n1hiPrUPo
         VRdKY7yuE3tTVZRQu777QkT5onzdSCvd36u4LK4PGZ0V8IfEZPRIXU1FiSj0GxUe30JN
         vHFg==
X-Forwarded-Encrypted: i=1; AJvYcCXtNitd3ULUKdHEqnc07QMSXJ4BMo5hUm/lERH/HDAtKFBBq/rIqyGnEei9sFgwces2o1WhbSh5wWOC1V980ELI5dTYv3GN
X-Gm-Message-State: AOJu0YzG6xhZ+VkYxp0cAo2rBHTql/kUJO0/+rJivaQQA7jSacMOrBxD
	d4Kzme9nrSr8zO0vPxf3ArQqKnJGIhRbKxuS96Oc8CgsRvcAZczpVSk77Ul1T1lrpX+MTHNLttx
	8ZAmUErWYtd5uIUd8jkqSNELP1qOd1nV8k3Nv
X-Google-Smtp-Source: AGHT+IHasoIaZGVqEl3+edaST5U18ERq0E2RdaIswtzIAMiCmx0wbzav9E6PID12WAD1iyP+5AzI3qWX/zPasJs4gH0=
X-Received: by 2002:a05:622a:40ca:b0:431:60bf:bba1 with SMTP id
 ch10-20020a05622a40ca00b0043160bfbba1mr24695qtb.15.1711403414204; Mon, 25 Mar
 2024 14:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325163831.203014-1-herve.codina@bootlin.com>
In-Reply-To: <20240325163831.203014-1-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 25 Mar 2024 14:49:38 -0700
Message-ID: <CAGETcx9YpqNhnNgpVNCuxm_nbApVbdXgFRiLVNYP64DKcDEm8g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] driver core: Keep the supplier fwnode
 consistent with the device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:39=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> fwnode's consumer links") introduces the possibility to use the
> supplier's parent device instead of the supplier itself.
> In that case the supplier fwnode used is not updated and is no more
> consistent with the supplier device used.
>
> Use the fwnode consistent with the supplier device when checking flags.

Please drop this patch. It's unnecessary churn. fw_devlink took years
to get to where it is. There are lots of corner cases. So I'd rather
not touch something if it's not broken. If a particular case for you
is broken, start with describing the issue please and then we can
figure out if it needs a change and what's a good way to do it.

Nack.

-Saravana

>
> Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's=
 consumer links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v2 -> v3:
>   Do not update the supplier handle in order to keep the original handle
>   for debug traces.
>
> Changes v1 -> v2:
>   Remove sup_handle check and related pr_debug() call as sup_handle canno=
t be
>   invalid if sup_dev is valid.
>
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b93f3c5716ae..0d335b0dc396 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2163,7 +2163,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>                  * supplier device indefinitely.
>                  */
>                 if (sup_dev->links.status =3D=3D DL_DEV_NO_DRIVER &&
> -                   sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> +                   sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
>                         dev_dbg(con,
>                                 "Not linking %pfwf - dev might never prob=
e\n",
>                                 sup_handle);
> --
> 2.44.0
>

