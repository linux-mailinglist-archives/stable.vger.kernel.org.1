Return-Path: <stable+bounces-121319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A919A5576C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4867A3B0A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6B271295;
	Thu,  6 Mar 2025 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sl6MefK3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F126BD9F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292891; cv=none; b=jaJ1kBpF4hN0UpM0y3JbMpbsDPFH5UDmckC2WvjSgPV1NlcwoR7qIzdAbnlfEL2spsSIZb0Vhw5qFfoHXR7jjtOVjjMCwigEtyHBSL8amBL1c4CB3szFJdkUhZFO+FmLp4vSVK8TjH12X85Pzyerwmh0jSMP3Lu0REuo4/be88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292891; c=relaxed/simple;
	bh=9r+fgi7YcM+OL8YzPJvXm3Tu+DUfhRSJTGCEsOmaks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLJ7EfK8KlGOkCN0OvPZ8Scf8D6Zra/PVoPmz+qJgJAVYc9bGB8FR1fFKKOejgZ4QTTM0YPC6ec9hEvcES5mQ9ZykBjQyyrQJ78KjlJ2z6Icx4pylF6iw7a3U8LMJYKMXwTwGdJ0YZMc1+JMM6HX3oniHBZ00BxKewwwdLAHbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sl6MefK3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso22626835ad.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741292889; x=1741897689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GctVpXPllCHYWuu9hUwNfCuRYyncGsuqbdCvzTlEz48=;
        b=sl6MefK3MtTdAeJS2XOh1/FXZgS6w+Z9Y5mE+VQbBE8xZITjJG46CegOrVxm4DOFcO
         9vjnWBzclMwieDcH3CPJFDppVoWIf+LOsYp6ox3H1Z0gElhGVRB+tXWoXOSolyLPbQlU
         bXG8zCLWHjyPINYwhKK4PeUSqV8gBicvO147bfQkFEC5qWoxDRkqNiKOuyzeD5ZlXWGT
         yCL9ixVGmKlDLGXXuE7gdgl0BScra55pLOsf3JZFFdE8D6pE8nlYIKtWvXxqJk2BJi5k
         KbMuOLnhn71mc+goufmrhGLN3WbT7mIOlGs7WdBABqkZ7AoKScsK+wmh4Q3p3STng5Lu
         RUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292889; x=1741897689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GctVpXPllCHYWuu9hUwNfCuRYyncGsuqbdCvzTlEz48=;
        b=es8czTa6g7ilzUr/9AUVfOhy/TUOrgdCcye/B7npsggKqxLgNtwrP50qi1bUqXGgGo
         STKMuVw1GDYBTRrcgTMSjhCQh373hU/LMpu3xQavYxctcbfu1ZbtjU1+k3PaKqPhQ5js
         EW+hbS93omoqLrJGetHiIcptmxSrmS7X3Cglpsaxe84QhQS2gNd/MIhK3zRgoBEkXQGD
         d3ewRtjkS9rrcYTJiXvaSqp87G8WdsM5MjOndNd2tcRcuorBzMPsZDXxrsDXviOnLbHl
         nzqTZ48NDKPz1vGdaBe+YX8v/5VuvToL5Q6JDfDMsFzqNjBASbZHdKhWhVF+NoTSlESj
         sUYg==
X-Forwarded-Encrypted: i=1; AJvYcCVsnpsoy/3x+pfX3X9lqgX/APE35dTBos2dViQKZUX4H1y7uC2nsqaGZ4nY/2sdcrPZGOKlmr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgTXBNx9xANQZ18RQsxP+TqSiloO6gpPFlMEhkRMv/2Q7vSyQ
	MYrRssVxifCNbd0dxUc6/vc1xrsP35IkLDHUBrkaJKxm+5u+RndavQC8/t4LcA==
X-Gm-Gg: ASbGncu+KKhApRKDzPlhwcd3kg344IKrQqZBg6NAxlWZLGTpmsOOEz6kbxhFIJFfWmF
	OUI4eqC6jEiN9zFhnPCQMb44W02FR7xEg1Q/7eTIJbqBEFs3AimA33lpZDjtzsZyEY7sXksExeH
	Ld48NBuuPx1m4FGBCFVnUgfg/8zVLHVWGnmq+K5eJEhru4UdOH7ryXOGUWdwVAcwjEtPzgPw66H
	hTX4HtvYSwpN/fAbWN24YD7UnG0XoGpDoIpLTEJlnD1CsFPnRv/v8jOaehCHlK3t4bXX+RQZP7k
	moRf2Mk40t99CdFCLUtB3S065bTkX6eNiyB5oPFUtkURu3jvdrSkqtDKx/WbCurd/Dis93oFvxe
	pq5yY
X-Google-Smtp-Source: AGHT+IFiSHnSkJOs/EER/kwvfX8Ds31VHyJZRbQKYI8qPXYDZiuyjKY9f0E3k62CA9zP4luRElVERw==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-1f54493353emr1884457637.0.1741292888662;
        Thu, 06 Mar 2025 12:28:08 -0800 (PST)
Received: from google.com (65.185.125.34.bc.googleusercontent.com. [34.125.185.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985387d3sm1837619b3a.172.2025.03.06.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:28:07 -0800 (PST)
Date: Thu, 6 Mar 2025 20:28:02 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi: Fix NULL pointer access
Message-ID: <Z8oFUiazzBTKnGRB@google.com>
References: <20250305111739.1489003-1-akuchynski@chromium.org>
 <20250305111739.1489003-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VDE8sWMpSlokQIQ6"
Content-Disposition: inline
In-Reply-To: <20250305111739.1489003-2-akuchynski@chromium.org>


--VDE8sWMpSlokQIQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Wed, Mar 05, 2025 at 11:17:39AM +0000, Andrei Kuchynski wrote:
> Resources should be released only after all threads that utilize them
> have been destroyed.
> This commit ensures that resources are not released prematurely by waiting
> for the associated workqueue to complete before deallocating them.
>=20
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner=
 tasks like alt mode checking")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/ucsi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..43b4f8207bb3 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
> =20
>  err_unregister:
>  	for (con =3D connector; con->port; con++) {
> +		if (con->wq)
> +			destroy_workqueue(con->wq);
>  		ucsi_unregister_partner(con);
>  		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>  		ucsi_unregister_port_psy(con);
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> =20
>  		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
>  		con->port_sink_caps =3D NULL;
> @@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
> =20
>  	for (i =3D 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
> =20
>  		if (ucsi->connector[i].wq) {
>  			struct ucsi_work *uwork;
> @@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
>  			destroy_workqueue(ucsi->connector[i].wq);
>  		}
> =20
> +		ucsi_unregister_partner(&ucsi->connector[i]);
> +		ucsi_unregister_altmodes(&ucsi->connector[i],
> +					 UCSI_RECIPIENT_CON);
> +		ucsi_unregister_port_psy(&ucsi->connector[i]);
> +
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sin=
k_caps);
>  		ucsi->connector[i].port_sink_caps =3D NULL;
>  		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sou=
rce_caps);
> --=20
> 2.49.0.rc0.332.g42c0ae87b1-goog
>=20

--VDE8sWMpSlokQIQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ8oFUgAKCRBzbaomhzOw
wshkAP9k51Btf5PLARneuF9jO3cYwi1O6adrJbgGw5ruHc53pAD9E7feIK9I8n4/
Py+0rXhG6xMiyiRaA6KCf6/Q9iXhpQ8=
=l0KK
-----END PGP SIGNATURE-----

--VDE8sWMpSlokQIQ6--

