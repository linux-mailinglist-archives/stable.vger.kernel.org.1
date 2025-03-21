Return-Path: <stable+bounces-125795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56EA6C65C
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 00:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356213BB51A
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D123237A;
	Fri, 21 Mar 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="083mogp6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDC230D0F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599013; cv=none; b=hF2C/xM/Hy1q4IsLRjxnJEShB7k+1AYNEdsjh+yrm/YnGD21MoCUr6zu7ivo7BHj/xY99IaaB8+OwcvYPHYCtrKA+FhjPG7hd7vIQ++qJpCodxkr8n5zxg0w1XDYEjaf6zbhT2r8daUnHrQ6ncR6SVXhk34ZUAHCvGLDxZKHC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599013; c=relaxed/simple;
	bh=8DKaaQsE+scs9IafPhGAEN9NCbmfrSyJ0w8/Xd4IlfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVyL1166jlKNVfcsN2b5/agNU15+2AiHwBWaA3zYoexvLKpfz6HPACfhwWpqaYjji+SSMatIL5wO0HbCcn4gxoEXAgC/mvL/g5cUWt1/sAVyyNnyWwPSEJM5mbScTn4gR7ls8nAt33wzoaSrmhXzxRVL7VULAnz0XQAWLOAD/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=083mogp6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225e3002dffso37714045ad.1
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742599011; x=1743203811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIH7ijeBPiqYRtbzIPfbeGjnxQWH5Tz1Ymx0+lmARm8=;
        b=083mogp6PTA20FKNijOETmLv9aZtDH212EAJBGgs6DaPl1IGtRZspiCRxofSUmVGcf
         l2aYeIdHzGFqnyBdsh16TMhHAbeUI/B8SGQkcSget+a0bPeLb2Qaj4nrX7rYmZgaYeQB
         ZuL+cr+3bTolgbfY368hH9/H+8BFSHUKzNL5Y+Wu4bDuJzy6FGMouSI4urYRnQ6wno0d
         +68tqci+8nXz7v0Qsqor0iHl+UQ68/MdE+TbegoYpCcg7VliuD2CKtcJlXnDfY96w40Y
         2kxQnoYGV5PJH7qd+YvGExYCL5tNn1Kd1W4eeD0ShKpFSwvG3U4en9gOupYUG3RZ5Z/K
         xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599011; x=1743203811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIH7ijeBPiqYRtbzIPfbeGjnxQWH5Tz1Ymx0+lmARm8=;
        b=cvOkTo8wl4P5guaZLzLiyFqry0BYpOwzc+FU5GFdGnDOi/Hr+QKnNJA/4NR4B3rkQS
         3/rQhgglW98cG8QN3h3+M2o1kxXwonmy1aGPbuPCYpPQoxMxiqoKhOoB+vE+ZEyyY64p
         vdiVCyzSSM0pUxAsPp6ooi70EWigKhHRChLFTlL2v7KxE28g7CjtWdTd187CWPuZvuVK
         yNhiJyfGT+AsiY1+H6+H1p8P/4qbHDuwTtx2vtvafz6paCk/0izUhN/V4FrZsnKxgPZd
         S1KdcHK3vlZmbpPDNlHeKHirBLVLp7WUbeBbupdrJ0S5ekiShzQAATHulx81vS8JJbsW
         cxlg==
X-Forwarded-Encrypted: i=1; AJvYcCW9o3RB/DNIA94G8HI2sbS73vNjRYimXyNm5dH1o/3f7G2EzXzyg29l79VPMGOXsKmB2Nt55o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjcMO1mZ8vg0VBWrvknPBYa7STE3MwTtyfa7WwGEzWQnnjJrh
	Wesr5sISaIcYpYIl3K6+tMO6+x4cSvdycZbVbpixtDN9MjqcLPsny/DjzWrydA==
X-Gm-Gg: ASbGncvmq2nwxKD+7P/MUTX6NP0MDOBvl/PJghMrXeXi3mJODajbcXIMxr+r1lN4fD3
	lUmL9UFLS+U2TSC4N5qTlpeqbtVldDrir7tB5y8/mc94RPZ9xutziCnwKemCJ+aknX/YRj/eK8i
	3U5q1D0inejL/bHR7cU8mQ/Hb9TJ7BEa8ebhAfgsRZ+o/lCuSXFbgXaMLHaKKbtaia6aCcmPkQA
	LltLpLfRjJVXswV2UQfxNB2dMDks5zl2ol9BjGlrFnWGD9jExcLMfS5K5y+qyHGQBjt/QDL2a2x
	cSzBNXKo1FxzBf+UuEeICsnj564Hy0n7N2bxoBAGZ/lkMETNRWAb7zfakwygpJ2FFHupoP8OXVN
	P1FsV3XA=
X-Google-Smtp-Source: AGHT+IG+S/vbJZ8UdHGhIlmSLgyiSEb9xnXeh1Dx5wYWoCCxNEnUuuhrUbiG8myJeH5qClc9kzs0uw==
X-Received: by 2002:a05:6a00:1393:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-7390599a142mr8273307b3a.8.1742599010047;
        Fri, 21 Mar 2025 16:16:50 -0700 (PDT)
Received: from google.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fa92dfsm2639905b3a.5.2025.03.21.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:16:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:16:44 +0000
From: Benson Leung <bleung@google.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: class: Fix NULL pointer access
Message-ID: <Z93zXHJPO3UHY_YF@google.com>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
 <20250321143728.4092417-2-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oA1blLjyxrjfEY96"
Content-Disposition: inline
In-Reply-To: <20250321143728.4092417-2-akuchynski@chromium.org>


--oA1blLjyxrjfEY96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrei,


On Fri, Mar 21, 2025 at 02:37:26PM +0000, Andrei Kuchynski wrote:
> Concurrent calls to typec_partner_unlink_device can lead to a NULL pointer
> dereference. This patch adds a mutex to protect USB device pointers and
> prevent this issue. The same mutex protects both the device pointers and
> the partner device registration.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C=
 partner")      =20
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  drivers/usb/typec/class.c | 15 +++++++++++++--
>  drivers/usb/typec/class.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9c76c3d0c6cf..eadb150223f8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1052,6 +1052,7 @@ struct typec_partner *typec_register_partner(struct=
 typec_port *port,
>  		partner->usb_mode =3D USB_MODE_USB3;
>  	}
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	ret =3D device_register(&partner->dev);
>  	if (ret) {
>  		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
> @@ -1063,6 +1064,7 @@ struct typec_partner *typec_register_partner(struct=
 typec_port *port,
>  		typec_partner_link_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_link_device(partner, port->usb3_dev);
> +	mutex_unlock(&port->partner_link_lock);
> =20
>  	return partner;
>  }
> @@ -1083,12 +1085,14 @@ void typec_unregister_partner(struct typec_partne=
r *partner)
> =20
>  	port =3D to_typec_port(partner->dev.parent);
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	if (port->usb2_dev)
>  		typec_partner_unlink_device(partner, port->usb2_dev);
>  	if (port->usb3_dev)
>  		typec_partner_unlink_device(partner, port->usb3_dev);
> =20
>  	device_unregister(&partner->dev);
> +	mutex_unlock(&port->partner_link_lock);
>  }
>  EXPORT_SYMBOL_GPL(typec_unregister_partner);
> =20
> @@ -2041,10 +2045,11 @@ static struct typec_partner *typec_get_partner(st=
ruct typec_port *port)
>  static void typec_partner_attach(struct typec_connector *con, struct dev=
ice *dev)
>  {
>  	struct typec_port *port =3D container_of(con, struct typec_port, con);
> -	struct typec_partner *partner =3D typec_get_partner(port);
> +	struct typec_partner *partner;
>  	struct usb_device *udev =3D to_usb_device(dev);
>  	enum usb_mode usb_mode;
> =20
> +	mutex_lock(&port->partner_link_lock);
>  	if (udev->speed < USB_SPEED_SUPER) {
>  		usb_mode =3D USB_MODE_USB2;
>  		port->usb2_dev =3D dev;
> @@ -2053,18 +2058,22 @@ static void typec_partner_attach(struct typec_con=
nector *con, struct device *dev
>  		port->usb3_dev =3D dev;
>  	}
> =20
> +	partner =3D typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_set_usb_mode(partner, usb_mode);
>  		typec_partner_link_device(partner, dev);
>  		put_device(&partner->dev);
>  	}
> +	mutex_unlock(&port->partner_link_lock);
>  }
> =20
>  static void typec_partner_deattach(struct typec_connector *con, struct d=
evice *dev)
>  {
>  	struct typec_port *port =3D container_of(con, struct typec_port, con);
> -	struct typec_partner *partner =3D typec_get_partner(port);
> +	struct typec_partner *partner;
> =20
> +	mutex_lock(&port->partner_link_lock);
> +	partner =3D typec_get_partner(port);
>  	if (partner) {
>  		typec_partner_unlink_device(partner, dev);
>  		put_device(&partner->dev);
> @@ -2074,6 +2083,7 @@ static void typec_partner_deattach(struct typec_con=
nector *con, struct device *d
>  		port->usb2_dev =3D NULL;
>  	else if (port->usb3_dev =3D=3D dev)
>  		port->usb3_dev =3D NULL;
> +	mutex_unlock(&port->partner_link_lock);
>  }
> =20
>  /**
> @@ -2614,6 +2624,7 @@ struct typec_port *typec_register_port(struct devic=
e *parent,
> =20
>  	ida_init(&port->mode_ids);
>  	mutex_init(&port->port_type_lock);
> +	mutex_init(&port->partner_link_lock);
> =20
>  	port->id =3D id;
>  	port->ops =3D cap->ops;
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index b3076a24ad2e..db2fe96c48ff 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -59,6 +59,7 @@ struct typec_port {
>  	enum typec_port_type		port_type;
>  	enum usb_mode			usb_mode;
>  	struct mutex			port_type_lock;
> +	struct mutex			partner_link_lock;
> =20
>  	enum typec_orientation		orientation;
>  	struct typec_switch		*sw;
> --=20
> 2.49.0.395.g12beb8f557-goog
>=20

--oA1blLjyxrjfEY96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCZ93zWwAKCRBzbaomhzOw
whHhAQD+8sY8h9MFvLXXJX6m474QUzZ0HHuNX40P6R8IYKKqagD9GKf8CySd6Duo
INhWr5qPzNJGGbEPtJO1uox4DHWFuQg=
=yS43
-----END PGP SIGNATURE-----

--oA1blLjyxrjfEY96--

