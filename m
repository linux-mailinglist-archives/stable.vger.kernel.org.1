Return-Path: <stable+bounces-125747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A8A6BA94
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 13:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1BD4821A7
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435AE225768;
	Fri, 21 Mar 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey0jfvvq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE151C2DB2;
	Fri, 21 Mar 2025 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559716; cv=none; b=E0Puk0xM1Utk3uKhUpAP6m4iUMO30GDULMatAaGGfs2U78A/oKscA3NClu0+WpBj3+6Ycv5H4JkauqJNRuZ8zBxoZDVOhskUQzG0JDKUmSpw+chhRZilqGP9OXW07Gq8ZHuDjViRdP+9KuvaZdskwHnfvDR4O+SShs4iZnw2zCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559716; c=relaxed/simple;
	bh=8GlsX8P8+YW5Ey99DzKoYstQ8VKaGSm2U6mu23tugKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY5uU0h7CrL851QXw1bK9GmlDXcse7OHZRnVb6xvpxt0fSioHuWHcoD+0pU0vJJ/irwN0zPA9T8QRmNwccocGPmKUT9FZtaMp3F30eCkTORYtq+obwoopVUuEe+OaD2h1giqr+2r6pr/COgFWlrIr7IlJEeUj0LuKgbWG+6CqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey0jfvvq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so15413305e9.2;
        Fri, 21 Mar 2025 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742559712; x=1743164512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeLp0PPN12i4t9OzH+eFQ8hoce13ODzGoYOiG4kZka4=;
        b=ey0jfvvquQPX2pTBJnbGrC+avX694IvZSS4Yoy3dmFuVIw2r9Y/xX+2qvDgCuFzkMq
         Uc6/FT0Wbzbd/k8mz4iEW6OMMQ7knQRiTj5P4nGW7iw6i25kTDfxitflP+7wtmgrwIVT
         nkiltNA1qgvkTfkxNGUepQ2tqydlLvpovIjuSC7cwg7qHzQ1xDw/OzF3DOmANUuy6SMP
         e9Zme8fuTIWwmn/gawFyyNpV/2FMnic/arVDdqos7V05XValjEzoDb5Mx6CxFPnq38Wq
         2CX8lVcb7DDxUhajRgzVcgZJzNv8SGMv0yiugYBWAtrG5HpiTt0uWStrVINBlZt6mlon
         crpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559712; x=1743164512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeLp0PPN12i4t9OzH+eFQ8hoce13ODzGoYOiG4kZka4=;
        b=JcCa+IukBdwjrikq21pDqOTHpl3gpqVUNXDj70NSZttF150byV1q+K6JCTdl0yM3QZ
         WIVrjj2e5qgeOXyRRJUk/muK7IMXnAZOKM8/3aewNoZs8wTro8hShyrohp21ujqsnnjr
         0SwaKag6j6iWG6UqqFEr9p9I8PFmabNdAbEv72aH0BUDJqw0e2KYulqJVY4Rx7KTnIr/
         Y2/zt3iJuWsUw/xyfh1IvJvNHG/cN7DRTLF/LlrpY8mauTiBmI4tnFPn9DwsvXxaSvvO
         E0BZ40uLJ/l81VoCCsEP7Ccjg0+7Z+GDnPi6rhZ9fa8OOC5o3xXIkq86eNmo6LxK/QMi
         eWUA==
X-Forwarded-Encrypted: i=1; AJvYcCUowuO808b1ZBTg/V+YpuR11A5aDI3fP1062+p7hGa+W2zziz3dhcbv2csBsFdKDjuN02uMykoXghU2yLY=@vger.kernel.org, AJvYcCVhJOoKOjS8hxr+tgRihqmBHV6/EZce78cSbOS/zQ9a7pjyqrx1Ga6uv+l6LBy6JBc+fsoTSD40@vger.kernel.org, AJvYcCWFEOINfVrZ3lwHibFGowT9Zc+bzk4VpwitDLc5enicxkClGxaRFbxK8kbb3t1YS8GNAs5YYhHgrGOll/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFGFxSdZlSrz2r1rkm27bvEhkSUaA3LKge79stzBiX8WvcMdl
	XJCQrNYZD8tRg6JegHco/9rBo0xMV8tzdXp+dxX5QeRlamWlY+1k
X-Gm-Gg: ASbGncvny8jQVUqY0JTq3eIt8IQpXLxH71MqlG3cSwMFJp0NgJj4M4MtLJ2SlQ6fk1G
	/M2duDArRB1l79673N2T3yGRfNP6L8T2F1Axt9ERKUlxajD+AB87VJ2+BhdyUNYfTQEUTfxL8dD
	LXGc0Z762HOYYFO3mHy1LGtxwrnkwbs3eSESq29pdALG1NojjZo+QRDitJ8gETYI+M7yN1lKCJ4
	Z3vutOW9y6rUO9+7sEOCjRlXHfuRo/bA5TAMxlbYiEfr08Q5296qNB85t3mwNkdgy4Xlq5/5pox
	RCMG78P8IKkifjSQJ8SAt0zTRDoCOhHhQG/NkSAdZDc9MDQ4rNGCJ+pVyB6sF3S3nkJLkCdXLGs
	pj56UCGCLknHFvNOUxPP+nc11LYVzmpE=
X-Google-Smtp-Source: AGHT+IHx1O01egCAj9TrUHG+NFBJ663ImNAVCdmyvggpAHypZuF7DKpiI8MNrBJxmhIty6eHtYnVHQ==
X-Received: by 2002:a05:600c:1d9f:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43d50a201a9mr28537605e9.20.1742559712030;
        Fri, 21 Mar 2025 05:21:52 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6544sm2251716f8f.68.2025.03.21.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:21:50 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:21:48 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Wayne Chang <waynec@nvidia.com>
Cc: jonathanh@nvidia.com, jckuo@nvidia.com, vkoul@kernel.org, 
	kishon@kernel.org, linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
Message-ID: <rxr3a5gzlmb6z2x36bwiy6lprdbrjgiojyoqznybyzglpeor7b@gy43enunoxyx>
References: <20250314073348.3705373-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imvx56lho6xkya3j"
Content-Disposition: inline
In-Reply-To: <20250314073348.3705373-1-waynec@nvidia.com>


--imvx56lho6xkya3j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
MIME-Version: 1.0

On Fri, Mar 14, 2025 at 03:33:48PM +0800, Wayne Chang wrote:
> The current implementation uses bias_pad_enable as a reference count to
> manage the shared bias pad for all UTMI PHYs. However, during system
> suspension with connected USB devices, multiple power-down requests for
> the UTMI pad result in a mismatch in the reference count, which in turn
> produces warnings such as:
>=20
> [  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down=
+0x160/0x170
> [  237.763103] Call trace:
> [  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
> [  237.763110]  phy_power_off+0x48/0x100
> [  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
> [  237.763119]  tegra_xusb_suspend+0x48/0x140
> [  237.763122]  platform_pm_suspend+0x2c/0xb0
> [  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
> [  237.763127]  __device_suspend+0x118/0x330
> [  237.763129]  dpm_suspend+0x10c/0x1f0
> [  237.763130]  dpm_suspend_start+0x88/0xb0
> [  237.763132]  suspend_devices_and_enter+0x120/0x500
> [  237.763135]  pm_suspend+0x1ec/0x270
>=20
> The root cause was traced back to the dynamic power-down changes
> introduced in commit a30951d31b25 ("xhci: tegra: USB2 pad power controls"=
),
> where the UTMI pad was being powered down without verifying its current
> state. This unbalanced behavior led to discrepancies in the reference
> count.
>=20
> To rectify this issue, this patch replaces the single reference counter
> with a bitmask, renamed to utmi_pad_enabled. Each bit in the mask
> corresponds to one of the four USB2 PHYs, allowing us to track each pad's
> enablement status individually.
>=20
> With this change:
>   - The bias pad is powered on only when the mask is clear.
>   - Each UTMI pad is powered on or down based on its corresponding bit
>     in the mask, preventing redundant operations.
>   - The overall power state of the shared bias pad is maintained
>     correctly during suspend/resume cycles.
>=20
> Cc: stable@vger.kernel.org
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index fae6242aa730..77bb27a34738 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -237,6 +237,8 @@
>  #define   DATA0_VAL_PD				BIT(1)
>  #define   USE_XUSB_AO				BIT(4)
> =20
> +#define TEGRA_UTMI_PAD_MAX 4
> +
>  #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
>  	{								\
>  		.name =3D _name,						\
> @@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
> =20
>  	/* UTMI bias and tracking */
>  	struct clk *usb2_trk_clk;
> -	unsigned int bias_pad_enable;
> +	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
> =20
>  	/* padctl context */
>  	struct tegra186_xusb_padctl_context context;
> @@ -605,7 +607,7 @@ static void tegra186_utmi_bias_pad_power_on(struct te=
gra_xusb_padctl *padctl)
> =20
>  	mutex_lock(&padctl->lock);
> =20
> -	if (priv->bias_pad_enable++ > 0) {
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
>  		mutex_unlock(&padctl->lock);
>  		return;
>  	}
> @@ -669,12 +671,7 @@ static void tegra186_utmi_bias_pad_power_off(struct =
tegra_xusb_padctl *padctl)
> =20
>  	mutex_lock(&padctl->lock);
> =20
> -	if (WARN_ON(priv->bias_pad_enable =3D=3D 0)) {
> -		mutex_unlock(&padctl->lock);
> -		return;
> -	}
> -
> -	if (--priv->bias_pad_enable > 0) {
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX)) {
>  		mutex_unlock(&padctl->lock);
>  		return;
>  	}
> @@ -697,6 +694,7 @@ static void tegra186_utmi_pad_power_on(struct phy *ph=
y)
>  {
>  	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
>  	struct tegra_xusb_usb2_port *port;
>  	struct device *dev =3D padctl->dev;
>  	unsigned int index =3D lane->index;
> @@ -705,6 +703,9 @@ static void tegra186_utmi_pad_power_on(struct phy *ph=
y)
>  	if (!phy)
>  		return;
> =20
> +	if (test_bit(index, priv->utmi_pad_enabled))
> +		return;

Don't we need to take the padctl->lock mutex before this...

> +
>  	port =3D tegra_xusb_find_usb2_port(padctl, index);
>  	if (!port) {
>  		dev_err(dev, "no port found for USB2 lane %u\n", index);
> @@ -724,18 +725,24 @@ static void tegra186_utmi_pad_power_on(struct phy *=
phy)
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>  	value &=3D ~USB2_OTG_PD_DR;
>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> +
> +	set_bit(index, priv->utmi_pad_enabled);

=2E.. and release it here? Otherwise we might end up testing, setting and/
or clearing from two pads concurrently and loose consistency.

>  }
> =20
>  static void tegra186_utmi_pad_power_down(struct phy *phy)
>  {
>  	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
>  	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
>  	unsigned int index =3D lane->index;
>  	u32 value;
> =20
>  	if (!phy)
>  		return;
> =20
> +	if (!test_bit(index, priv->utmi_pad_enabled))
> +		return;
> +

Same here...

>  	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
> =20
>  	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> @@ -748,6 +755,8 @@ static void tegra186_utmi_pad_power_down(struct phy *=
phy)
> =20
>  	udelay(2);
> =20
> +	clear_bit(index, priv->utmi_pad_enabled);

and here.

Thierry

--imvx56lho6xkya3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfdWdsACgkQ3SOs138+
s6EcPg/+PgMaghXQ/5SDqxhhmBHw/d0cB5stuVU/Rrn0N8I6FsXEPF7VTTGu50+X
vNMHLUuOBqGg43IdpBpX2t/OEqnSY+FgejgizfqBh/kYT0PjxIqoq6WXYVoqNjfD
VVkKIt8yz2nKZ2o9F9vnjjmc6zhiWvujsxOoX/TPS/BcKFpjV1Sy4r/Q5KHlDx2r
DFLdUg4vg35VsHNLjrKwUXIS+wohnM3l1xRJq5IGrFgDl6gBJGq/EuWlbQ8OzoYd
kcRZOUgbXPZ5IFlIwE2Nyi6LNCWYabAnWItB5cJZeSa8JriaIYtwbAcOhxmF5D3s
tAX/J42Sr3cbx3JIlKL6u3FsdWxlijA/zP4IJaZSYE77dv63Sj5ae7tdXfixgo50
THBQ5e7Re/bAUvghN+G9weUqi0yqzFYfVi8nSNWovpLZdc90kAKN1R8HePqT1pfG
ZGi4CJFU9mEMXs5dwKjV01JN5qg6FE6+2ksinM5FT8i6F8sm2QtVsMO+u9Rw5VUk
uNOQnkaquCmqlBp7eFmrq5ICbiZGZI7Pc3f2o+/C/gzaSESEPJYlwAUBKzmmND8O
EsUMjv387LYF1Bi0JI46PIIvxHg2fsUxzkDvf8EOi7o+zTcM8Q8w1F1PNsXjirn6
0BbeFXeiUIykiEr2RcTFcFJD1KeKhurWw2LOObZ/IUae1PA4ygM=
=SVsF
-----END PGP SIGNATURE-----

--imvx56lho6xkya3j--

