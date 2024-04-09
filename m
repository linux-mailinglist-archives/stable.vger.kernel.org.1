Return-Path: <stable+bounces-37851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED50989D4F7
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD8B22E15
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DA7F494;
	Tue,  9 Apr 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVasyAs4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB27EEF2
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653061; cv=none; b=GFhVE/sPsSQEz28FaE/rxEsoKyPb9GPjjCQ/1nVuvWPy8gEezWNLjQv8cQRAAKwyegTQTLdu8K98rElcExcsltgqsg86whL/1c4pB+UCclPBLsONziK1wg0X9/WaQc2YD0KXR+N+yT3CJgGPxwCDYKtmW7sAuZXjsQ4mxEkrBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653061; c=relaxed/simple;
	bh=CxCGe2NjYljVhclTe67VbksuAnNNFNM3JgkjmmKKa2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jv5oGaMniCkCBVnGXLC49nPsDvTpdDYGGdk2ntpMFu7JwEdkIsBsTKYUoaaatAGJgcJHhVaLGmDUNglG62a+HVUU+qsbQ/kRN/CXpNxDT3eDQoGZFNbYaMaOG3RWYar/BMrTgAj1pXP5cGr6Vzds3qDDrGtFrq0+IWpN6mXQVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVasyAs4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712653058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OxG++9ua1DJsCcQ+aybgr3Iv1qrzsmtXRd0e50eFDVs=;
	b=XVasyAs4wdwRqBLZTW+R/kDtYsosSIw+JE3dr8VOFfQbz+ZoZKw7SqTBLnh36ydo8S/5GC
	nq9rYq3dVMDr0KVU8h8bzJ/wCl5PhpsWhhfu/v1AwhvADTHg8fG57Tg/lIxxWx8GPlMLbN
	VEsd3H0N4pJ8lYoRMCJtAXHpdzv8QC0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-zOBSHyCGP86NADfXvEtpeg-1; Tue, 09 Apr 2024 04:57:28 -0400
X-MC-Unique: zOBSHyCGP86NADfXvEtpeg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d861423aebso10167751fa.0
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 01:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653047; x=1713257847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxG++9ua1DJsCcQ+aybgr3Iv1qrzsmtXRd0e50eFDVs=;
        b=J21g64PM3fh5VxFGHHQKRRFbzXBqVGKEDBkJ6N1ZVoRSOlzOhXqEw38f9lZtJ6t6LA
         W8hnSV5KXdBSPd8buGxE0kAErV3WbM+h372+Umve7OEFWvNdoJB3dOWSlDW7NyhtYGuk
         V819dbGxosfKnKWWjZqtkBRWvkzbYGLT8Waxk8YLkWy53ZaYBOjX25N/nHbT8rCYYTyH
         YkAjZQnb6VTsyxeWdTmXjxEmjMte5z2d5TRTDqlgyOp24A42IUWeIqjcPSIaQlk5k9wB
         fPbnpgEHnQD8pFWQnfBRJ33m4PYkrhZXlA2CgS7nafd+crTuun/MsHROWgU4UBkSu4kF
         bF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUus7qg/+wSli2Hl/cSAlEYAJ2u0wZ/Kw++vjO5Mw5nShmQ0opSNq15mYMVNBGNkCx1lxli/EFv3l43ZbdvFef2HJ/GelR4
X-Gm-Message-State: AOJu0YzuQTpA0CTANAj2uDR0+qDSFZru3gl2FNad1mBo9rNyliFsGOZS
	nb2FO/MonYGHCpyJxb5tRtVyWr3VYP6h/9Qw5n4Cb0DDZy53+T/fHTDDWyBRwi7hupWIzXEKW0D
	uEIvRrJluYbfv2hbNTojrll3wK7Ajc7xUkkjTu/motjQJRsuvFv1JOQ==
X-Received: by 2002:a2e:9ed0:0:b0:2d8:9656:8137 with SMTP id h16-20020a2e9ed0000000b002d896568137mr2554038ljk.4.1712653047488;
        Tue, 09 Apr 2024 01:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHXWKjF7l3Lh2FtRQ2nKK1SBArCUjP6TTbtSP1/GvJj2QqxmnLuZ/axnPvPW5ZJ2iIAZ8kxA==
X-Received: by 2002:a2e:9ed0:0:b0:2d8:9656:8137 with SMTP id h16-20020a2e9ed0000000b002d896568137mr2554025ljk.4.1712653047022;
        Tue, 09 Apr 2024 01:57:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-144.dyn.eolo.it. [146.241.244.144])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c1d8400b00416b74deaf0sm156675wms.33.2024.04.09.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:57:26 -0700 (PDT)
Message-ID: <e6bc6f826aa59e8023e18892276ec875f4fc3bda.camel@redhat.com>
Subject: Re: [PATCH net 2/2] net: usb: asix: Replace the direct return with
 goto statement
From: Paolo Abeni <pabeni@redhat.com>
To: Yi Yang <yiyang13@huawei.com>, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, nichen@iscas.ac.cn
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org,  wangweiyang2@huawei.com
Date: Tue, 09 Apr 2024 10:57:25 +0200
In-Reply-To: <20240407075513.923435-3-yiyang13@huawei.com>
References: <20240407075513.923435-1-yiyang13@huawei.com>
	 <20240407075513.923435-3-yiyang13@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-07 at 07:55 +0000, Yi Yang wrote:
> Replace the direct return statement in ax88772_bind() with goto, to adher=
e
> to the kernel coding style.
>=20
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/net/usb/asix_devices.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_device=
s.c
> index d8f86bafad6a..11417ed86d9e 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -838,7 +838,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
> =20
>  	ret =3D usbnet_get_endpoints(dev, intf);
>  	if (ret)
> -		return ret;
> +		goto mdio_err;
> =20
>  	/* Maybe the boot loader passed the MAC address via device tree */
>  	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
> @@ -862,7 +862,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
>  		if (ret < 0) {
>  			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
>  				   ret);
> -			return ret;
> +			goto mdio_err;
>  		}
>  	}
> =20
> @@ -875,7 +875,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
> =20
>  	ret =3D asix_read_phy_addr(dev, true);
>  	if (ret < 0)
> -		return ret;
> +		goto mdio_err;
> =20
>  	priv->phy_addr =3D ret;
>  	priv->embd_phy =3D ((priv->phy_addr & 0x1f) =3D=3D AX_EMBD_PHY_ADDR);
> @@ -884,7 +884,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
>  			    &priv->chipcode, 0);
>  	if (ret < 0) {
>  		netdev_dbg(dev->net, "Failed to read STATMNGSTS_REG: %d\n", ret);
> -		return ret;
> +		goto mdio_err;
>  	}
> =20
>  	priv->chipcode &=3D AX_CHIPCODE_MASK;
> @@ -899,7 +899,7 @@ static int ax88772_bind(struct usbnet *dev, struct us=
b_interface *intf)
>  	ret =3D priv->reset(dev, 0);
>  	if (ret < 0) {
>  		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
> -		return ret;
> +		goto mdio_err;
>  	}
> =20
>  	/* Asix framing packs multiple eth frames into a 2K usb bulk transfer *=
/

As noted by Simon in the previous submission, this kind of change
should target the 'net-next' tree, you can't bundle it in a 'net'
series. You have to submit the 'net' patch, get it merged, wait until
'net' is merged back into 'net-next' and then submit the 'net-next'
follow-up.

Please read Documentation/process/maintainer-netdev.rst for the gory
details.

Additionally, I would also suggest to drop instead the 'mdio_err'
label: there is little/no gain replacing a return statement with jump
to a return statement.

Cheers,

Paolo



