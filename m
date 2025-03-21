Return-Path: <stable+bounces-125796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6BFA6C662
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A701742EF
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED02343D4;
	Fri, 21 Mar 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCAjuQP2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACE230BDF
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599149; cv=none; b=dMtrUep9hvc6bd1gfhXcfJQORaHkveNtr597H+08/cQLhhCuD2/mqz9ohaNescO9ncmU14UVNw8shBAknqObIRcCvtlTT9Wf9uK36mzIstysbwKWFZL5G4aB/iXnIq04dXM35YxzA1U2sW/t79yl+iyqD1kyAObdQh2okcXjt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599149; c=relaxed/simple;
	bh=7R7aUV+pTd9zyynGBCXb4GYWyEVGu6gupsqBeQ35lLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwnniBts3gnmmYsH8cGVoBUvzt0u5QBH0BGTqQT0Ljh+yy3kzyDtZ4uW/gcDF7lUaU3qAku1dmXCOLD2WcO7BpulvEOLmqVyTYggdS+L3zXELFxgrDz4DC4pu3rxLfdm41mcfUd2lm742Wgc1MzVGgiV4x5ftuPkqt3cu2YRrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCAjuQP2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2254e0b4b79so27321595ad.2
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742599147; x=1743203947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLVVtEiYY62MhsiRQ4vP6SNkQCOsvwGGW3jtnlnRhnQ=;
        b=ZCAjuQP2FAacEUDfJlVLeLg/0KuuKIUUuS9g4/o7Ht+KiGjd/AzTrlxbKxTudSwmLU
         vooqOqnMpS14fuPWhFV2Yzo+06+J3mPtE7og9gRkYoQLrI3efZZKDR6tyjfmGw9I7VnD
         w8hU0mlfH4xuh3aW1C+cbN6wj+WcP5aPeF7dd/BwDQV5OkVXt5oozJ8VqAfEB9ZITW2/
         WPhGSlrzRdJMqmWO1wlptlVAvFgAJu4wGEJwYFj1l4IOu+KSISp50oBv60Khz0eMB56R
         2Ma204k/ZWRWOPYi17zXgFc9NWzrJhAjTUWX175R9b5dYTuluGoVheRVmoMRdedE6gWH
         TcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599147; x=1743203947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLVVtEiYY62MhsiRQ4vP6SNkQCOsvwGGW3jtnlnRhnQ=;
        b=ZjI64YIQCBs/GtUWDJHswt1WPolO6n33cvPsrPzmsMKDz7lfYtO/hgDdTSLbX0R1uo
         sGpSqP8bz9Is9093CgdDtwKKZkEcV0X90w2FiTu9Ff//0uWQhiNRzEySO0kNyGkYLOxF
         yFZnuxGZCyqZPXgjjK/PXsSSHtEQgNsBYceMc5JNXZxrSxdePPUka92zNweA3wXDcig0
         3u/qxCoXYMAlnA7TV828pTY9DIDyhTTTycZNyOFpZANsds1bpdVtVVMuQQ24qpbzqTA6
         g9fpwQRzTr7W5mAt+gDx15ld3rxgkNod8oJMwR4Yp2o0HtKgxLJQ/JlBza3BosnpTiec
         6Qcg==
X-Forwarded-Encrypted: i=1; AJvYcCXuITL4lqgJo4qxKBv562aEBXb9tl0AfSaYAGMXXeimPZOWSo9Y3fLFGxY6HYI04lF3cQiYy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtv70R4WxzQCIEcefwHPkV6BGdwPaQmesLL5j4Apjk0hZOR+hW
	Y1bePj09z5fhCkiQYDDM275H9ItE2EisaAPng4oQJsVnY/7XBOJ5zAbKXxYYzw==
X-Gm-Gg: ASbGncu8ZL8GhcPRsvRsogZbLH2+6PyXeJ6Ng0/R26NGLFV6RVsQTrok+6e4E2tRtqk
	EAPfVrXj1UoTMh8ioOLaHdJxzV2Ss80MHTwLUV6yvT2zkoqjh3cqvmV2ELBZpN1l5q5MP/quLHi
	0tOjqBI4q1XWcMZ1EN4gVbrI9t9XPnSU6U9B5+ENVGhEmMXTJ5qeD1DjSsV/m38eSV4FgUxMNuc
	Y9T84HjJwe1Qi2nLMWix8tbxI0lC6b03kYcUgGs7cUUzN3L9xlieZN5Gn9VEOKmm9sp39Nwv300
	P1Ray2FpR7MF52U8HkVe/P+HuiRYAh7p7edzuiyjB4KXa6rxgxw5IbXeuH1WdMGpwYCt96ll37M
	9NhDyGbAkwYw6lWt7ng==
X-Google-Smtp-Source: AGHT+IF195diPWEKYH6Ae8Xu5+le/VenNZhzDbi1MXz0VeJbXGBB6rQE3KK3GWeNmszmqE1ZmR6hRg==
X-Received: by 2002:a17:902:ea07:b0:224:179a:3b8f with SMTP id d9443c01a7336-22780d83b53mr70549105ad.23.1742599147135;
        Fri, 21 Mar 2025 16:19:07 -0700 (PDT)
Received: from google.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811c1b8fsm23330555ad.154.2025.03.21.16.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:19:05 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:19:01 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: class: Invalidate USB device pointers on
 partner unregistration
Message-ID: <Z93z5WqL-u4ZyBhH@google.com>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
 <20250321143728.4092417-3-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cN3cAe1kDpvEvgtB"
Content-Disposition: inline
In-Reply-To: <20250321143728.4092417-3-akuchynski@chromium.org>


--cN3cAe1kDpvEvgtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Mar 21, 2025 at 02:37:27PM +0000, Andrei Kuchynski wrote:
> To avoid using invalid USB device pointers after a Type-C partner
> disconnects, this patch clears the pointers upon partner unregistration.
> This ensures a clean state for future connections.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C=
 partner")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/class.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index eadb150223f8..3df3e3736916 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1086,10 +1086,14 @@ void typec_unregister_partner(struct typec_partne=
r *partner)
>  	port =3D to_typec_port(partner->dev.parent);
> =20
>  	mutex_lock(&port->partner_link_lock);
> -	if (port->usb2_dev)
> +	if (port->usb2_dev) {
>  		typec_partner_unlink_device(partner, port->usb2_dev);
> -	if (port->usb3_dev)
> +		port->usb2_dev =3D NULL;
> +	}
> +	if (port->usb3_dev) {
>  		typec_partner_unlink_device(partner, port->usb3_dev);
> +		port->usb3_dev =3D NULL;
> +	}
> =20
>  	device_unregister(&partner->dev);
>  	mutex_unlock(&port->partner_link_lock);
> --=20
> 2.49.0.395.g12beb8f557-goog
>=20

--cN3cAe1kDpvEvgtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ93z5QAKCRBzbaomhzOw
wuFRAP4tlk6s6adpSCRvWDdtv0FaODRXc1HiADy+70TI9ectMAD/bOW7B2uK9KrQ
c+EbKHzy8PaWNAxKs4biseORVjHi6gU=
=CBy0
-----END PGP SIGNATURE-----

--cN3cAe1kDpvEvgtB--

