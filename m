Return-Path: <stable+bounces-232841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KItlD7ZnzWnddAYAu9opvQ
	(envelope-from <stable+bounces-232841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:45:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5637F63A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B1A3025738
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B03477E40;
	Wed,  1 Apr 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Tn8D2HOI"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4A478E5D;
	Wed,  1 Apr 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068833; cv=pass; b=R+Plz+A5Tf7wZaNWQ/jQUj4zQiL3M8ce+CitFYmvLQEKV037F9iR8j0X+GfOriQpCtFYAd+mT+49+IGVuakYKGpmsh+ElMZs8Ux2Sjs0afbhHt3NBSzF/I1Nl37I1MrTE+3lsKKD4NG4wLWhfdw7W0h8QymGkFfv95ewnDvL1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068833; c=relaxed/simple;
	bh=JPcqdugqAn+4v7f0h/X88SxE0XgcPyoWecOGUdvFdZk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Tp02kWaR0VaBKid/DJIMn+FHfWhH2uFTGdS4ZpFf557I1dqaggFucvEVma1ul64czYL14gf3Dy7IqtrrFGUIbwnyd7O3ylS7fKxO9x/1MxXI6p3TuT9GsOsaWSMq6OzikHbQKoiFjeRyNYv6RmJ+fftOj4r7LsiqfNaKS3M43d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Tn8D2HOI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1775068821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FwABBAu1XOurFWSNvjPdhni0/NX8wAD+m7gaPAGevDnaAEj7JVcdn8RKnSU2D+6Lq8O0w7jzsdNCsRl95bX7Mn8VZjl2kUutMSJIWZBzg/zGU9kb5mZw5SLo85RmZQfJsp06r9tT6feD4MmXfTdVhnsUj44g6Q567WKwLELzPqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775068821; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6DNdW2rrkbYb/8sFawJBCTsWDBCytgqmPfqRMGhCq+4=; 
	b=VGBdf3SgYX0tVsqA8xy+R8AbJ1b7rtjwzFCvwlGcX/L1tDX2dAXmrpAEdqzD5bJFKDn5pGrMkQn0yU+SwA1gxKyMi9QUXAf+GbaCp0IvTGg3VFUmIta+ZgdUGWb73TGHSKF3oozxJyUAFCHG2/PCNob0sjU4IVqix+1EdMbpSE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775068821;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=6DNdW2rrkbYb/8sFawJBCTsWDBCytgqmPfqRMGhCq+4=;
	b=Tn8D2HOI7Iw3NmFXTcBJGi0avWp75EkxmsAOpcyiXf7DuURdnKHAashFvtNyoIC4
	UIEV89y9+ibUQXxuHqqJK15Yw7dmWTYoJpXXprKZp3oAiuMl0r8Kxw9kHHFmwmdaupD
	5sPd9aCLRHOZCE1JM8LHmMapF0igDjh+1pL3L224sSHma61OIcq13LXzHjDaGP7fhN4
	48KSlUkKAQJaLMWNeX5SK6NlPJmCNsUfo257F4wu4CsWlPwwmJVsW0XUq8MeuatXFDd
	UEEkjxzoozoTKnl3KCBWiBcpmXWVNmIZgJx6IiEESRqLfq/YMVmb9PsHqzwM6eMnBHQ
	tL5dSfVSnw==
Received: by mx.zohomail.com with SMTPS id 1775068819835982.0744146282948;
	Wed, 1 Apr 2026 11:40:19 -0700 (PDT)
Message-ID: <00f7e42b626b35a1fe89c3a1256f95b788350fa3.camel@rong.moe>
Subject: Re: [PATCH v6 11/13] platform/x86: lenovo: Decouple
 lenovo-wmi-gamezone and lenovo-wmi-other
From: Rong Zhang <i@rong.moe>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hans de Goede
 <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20260331181208.421552-12-derekjohn.clark@gmail.com>
References: <20260331181208.421552-1-derekjohn.clark@gmail.com>
	 <20260331181208.421552-12-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Apr 2026 02:34:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232841-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rong.moe:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,rong.moe:dkim,rong.moe:email,rong.moe:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5E5637F63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Derek,

On Tue, 2026-03-31 at 18:12 +0000, Derek J. Clark wrote:
> From: Rong Zhang <i@rong.moe>
>=20
> Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the former
> imports symbols from the latter. The imported symbols are just used to
> register a notifier block. However, there is no runtime dependency
> between both drivers, and either of them can run without the other,
> which is the major purpose of using the notifier framework.
>=20
> Such a link-time dependency is non-optimal. A previous attempt to "fix"
> it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
> fundamentally broken and resulted in undefined Kconfig behavior, as
> `select' cannot be used on a symbol with potentially unmet dependencies.
>=20
> Decouple both drivers by moving the thermal mode notifier chain to
> lenovo-wmi-helpers. Methods for notifier block (un)registration are
> exported for lenovo-wmi-gamezone, while a method for querying the
> current thermal mode are exported for lenovo-wmi-other.
>=20
> This turns the dependency graph from
>=20
>             +------------ lenovo-wmi-gamezone
>             |                     |
>             v                     |
>     lenovo-wmi-helpers            |
>             ^                     |
>             |                     V
>             +------------ lenovo-wmi-other
>=20
> into
>=20
>             +------------ lenovo-wmi-gamezone
>             |
>             v
>     lenovo-wmi-helpers
>             ^
>             |
>             +------------ lenovo-wmi-other
>=20
> To make it clear, the name of the notifier chain is also renamed from
> `om_chain_head' to `tm_chain_head', indicating that it's used to query
> the current thermal mode.
>=20
> No functional change intended.
>=20
> Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other mode"")

I tagged it as a fix patch as stable kernel may also run into a broken
randconfig where CONFIG_LENOVO_WMI_TUNING=3Dm/y is selected by
CONFIG_LENOVO_WMI_GAMEZONE=3Dm/y but CONFIG_LENOVO_WMI_CAPDATA=3Dn is still
selected by the randomizer, which is almost identical to [1].

Fix patches should be the very first patches in the series so that
backporting is less painful. See also my reply to the cover letter.

> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3-lkp@i=
ntel.com/

^ [1]

> Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda-lkp@i=
ntel.com/
> Signed-off-by: Rong Zhang <i@rong.moe>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  drivers/platform/x86/lenovo/Kconfig        |   1 -
>  drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
>  drivers/platform/x86/lenovo/wmi-helpers.c  | 101 ++++++++++++++++++++
>  drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
>  drivers/platform/x86/lenovo/wmi-other.c    | 104 +--------------------
>  drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
>  6 files changed, 112 insertions(+), 122 deletions(-)
>  delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
>=20
> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/l=
enovo/Kconfig
> index 75a8b144b0da..b9a5d18caa1e 100644
> --- a/drivers/platform/x86/lenovo/Kconfig
> +++ b/drivers/platform/x86/lenovo/Kconfig
> @@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
>  	select ACPI_PLATFORM_PROFILE
>  	select LENOVO_WMI_EVENTS
>  	select LENOVO_WMI_HELPERS
> -	select LENOVO_WMI_TUNING
>  	help
>  	  Say Y here if you have a WMI aware Lenovo Legion device and would lik=
e to use the
>  	  platform-profile firmware interface to manage power usage.
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platfor=
m/x86/lenovo/wmi-gamezone.c
> index 602a48de1b4e..a614af8f08e8 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -22,7 +22,6 @@
> =20
>  #include "wmi-events.h"
>  #include "wmi-helpers.h"
> -#include "wmi-other.h"
> =20
>  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> =20
> @@ -384,7 +383,7 @@ static int lwmi_gz_probe(struct wmi_device *wdev, con=
st void *context)
>  		return ret;
> =20
>  	priv->mode_nb.notifier_call =3D lwmi_gz_mode_call;
> -	return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb);
> +	return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_nb);
>  }
> =20
>  static const struct wmi_device_id lwmi_gz_id_table[] =3D {
> @@ -406,7 +405,6 @@ module_wmi_driver(lwmi_gz_driver);
> =20
>  MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
>  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> -MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
>  MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>  MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform=
/x86/lenovo/wmi-helpers.c
> index 7379defac500..e1cf869224d2 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> @@ -21,11 +21,15 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/unaligned.h>
>  #include <linux/wmi.h>
> =20
>  #include "wmi-helpers.h"
> =20
> +/* Thermal mode notifier chain. */
> +static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
> +
>  /**
>   * lwmi_dev_evaluate_int() - Helper function for calling WMI methods tha=
t
>   * return an integer.
> @@ -84,6 +88,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8=
 instance, u32 method_id,
>  };
>  EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
> =20
> +/**
> + * lwmi_tm_register_notifier() - Add a notifier to the blocking notifier=
 chain
> + * @nb: The notifier_block struct to register
> + *
> + * Call blocking_notifier_chain_register to register the notifier block =
to the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-EEXIST on error.
> + */
> +int lwmi_tm_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&tm_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
> +
> +/**
> + * lwmi_tm_unregister_notifier() - Remove a notifier from the blocking n=
otifier
> + * chain.
> + * @nb: The notifier_block struct to register

There is a typo. s/register/unregister/

(found by sashiko.dev)

https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gm=
ail.com

> + *
> + * Call blocking_notifier_chain_unregister to unregister the notifier bl=
ock from the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-ENOENT on error.
> + */
> +int lwmi_tm_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&tm_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELPERS");
> +
> +/**
> + * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the block=
ing
> + * notifier chain.
> + * @data: Void pointer to the notifier_block struct to register.

Ditto (found by sashiko.dev).

> + *
> + * Call lwmi_tm_unregister_notifier to unregister the notifier block fro=
m the
> + * thermal mode notifier chain.
> + *
> + * Return: 0 on success, %-ENOENT on error.

Remove it as it's a void function (found by sashiko.dev).

These typos have existed since its first appearance. I didn't catch them
when I was moving them.

Let's fix them as we are anyway touching them.

Thanks,
Rong

> + */
> +static void devm_lwmi_tm_unregister_notifier(void *data)
> +{
> +	struct notifier_block *nb =3D data;
> +
> +	lwmi_tm_unregister_notifier(nb);
> +}
> +
> +/**
> + * devm_lwmi_tm_register_notifier() - Add a notifier to the blocking not=
ifier
> + * chain.
> + * @dev: The parent device of the notifier_block struct.
> + * @nb: The notifier_block struct to register
> + *
> + * Call lwmi_tm_register_notifier to register the notifier block to the
> + * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_notifie=
r
> + * as a device managed action to automatically unregister the notifier b=
lock
> + * upon parent device removal.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +int devm_lwmi_tm_register_notifier(struct device *dev,
> +				   struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret =3D lwmi_tm_register_notifier(nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_notifier,
> +					nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS=
");
> +
> +/**
> + * lwmi_tm_notifier_call() - Call functions for the notifier call chain.
> + * @mode: Pointer to a thermal mode enum to retrieve the data from.
> + *
> + * Call blocking_notifier_call_chain to retrieve the thermal mode from t=
he
> + * lenovo-wmi-gamezone driver.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +int lwmi_tm_notifier_call(enum thermal_mode *mode)
> +{
> +	int ret;
> +
> +	ret =3D blocking_notifier_call_chain(&tm_chain_head,
> +					   LWMI_GZ_GET_THERMAL_MODE, &mode);
> +	if ((ret & ~NOTIFY_STOP_MASK) !=3D NOTIFY_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
> +
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>  MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platform=
/x86/lenovo/wmi-helpers.h
> index 3364d8e152ca..ed7db3ebba6c 100644
> --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/types.h>
> =20
> +struct device;
> +struct notifier_block;
>  struct wmi_device;
> =20
>  struct wmi_method_args_32 {
> @@ -30,4 +32,10 @@ enum thermal_mode {
>  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 meth=
od_id,
>  			  unsigned char *buf, size_t size, u32 *retval);
> =20
> +int lwmi_tm_register_notifier(struct notifier_block *nb);
> +int lwmi_tm_unregister_notifier(struct notifier_block *nb);
> +int devm_lwmi_tm_register_notifier(struct device *dev,
> +				   struct notifier_block *nb);
> +int lwmi_tm_notifier_call(enum thermal_mode *mode);
> +
>  #endif /* !_LENOVO_WMI_HELPERS_H_ */
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x=
86/lenovo/wmi-other.c
> index e0633c42972c..d871ee02dfcb 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -41,7 +41,6 @@
>  #include <linux/kobject.h>
>  #include <linux/limits.h>
>  #include <linux/module.h>
> -#include <linux/notifier.h>
>  #include <linux/platform_profile.h>
>  #include <linux/power_supply.h>
>  #include <linux/types.h>
> @@ -52,7 +51,6 @@
>  #include "wmi-capdata.h"
>  #include "wmi-events.h"
>  #include "wmi-helpers.h"
> -#include "wmi-other.h"
>  #include "../firmware_attributes_class.h"
> =20
>  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
> @@ -110,7 +108,6 @@ enum lwmi_feature_id_gpu {
>  #define LWMI_OM_SYSFS_NAME "lenovo-wmi-other"
>  #define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
> =20
> -static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>  static DEFINE_IDA(lwmi_om_ida);
> =20
>  enum attribute_property {
> @@ -138,7 +135,6 @@ struct lwmi_om_priv {
>  	struct device *hwmon_dev;
>  	struct device *fw_attr_dev;
>  	struct kset *fw_attr_kset;
> -	struct notifier_block nb;
>  	struct wmi_device *wdev;
>  	int ida_id;
> =20
> @@ -979,102 +975,6 @@ struct capdata01_attr_group {
>  	struct tunable_attr_01 *tunable_attr;
>  };
> =20
> -/**
> - * lwmi_om_register_notifier() - Add a notifier to the blocking notifier=
 chain
> - * @nb: The notifier_block struct to register
> - *
> - * Call blocking_notifier_chain_register to register the notifier block =
to the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-EEXIST on error.
> - */
> -int lwmi_om_register_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_register(&om_chain_head, nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(lwmi_om_register_notifier, "LENOVO_WMI_OTHER");
> -
> -/**
> - * lwmi_om_unregister_notifier() - Remove a notifier from the blocking n=
otifier
> - * chain.
> - * @nb: The notifier_block struct to register
> - *
> - * Call blocking_notifier_chain_unregister to unregister the notifier bl=
ock from the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-ENOENT on error.
> - */
> -int lwmi_om_unregister_notifier(struct notifier_block *nb)
> -{
> -	return blocking_notifier_chain_unregister(&om_chain_head, nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(lwmi_om_unregister_notifier, "LENOVO_WMI_OTHER");
> -
> -/**
> - * devm_lwmi_om_unregister_notifier() - Remove a notifier from the block=
ing
> - * notifier chain.
> - * @data: Void pointer to the notifier_block struct to register.
> - *
> - * Call lwmi_om_unregister_notifier to unregister the notifier block fro=
m the
> - * lenovo-wmi-other driver notifier chain.
> - *
> - * Return: 0 on success, %-ENOENT on error.
> - */
> -static void devm_lwmi_om_unregister_notifier(void *data)
> -{
> -	struct notifier_block *nb =3D data;
> -
> -	lwmi_om_unregister_notifier(nb);
> -}
> -
> -/**
> - * devm_lwmi_om_register_notifier() - Add a notifier to the blocking not=
ifier
> - * chain.
> - * @dev: The parent device of the notifier_block struct.
> - * @nb: The notifier_block struct to register
> - *
> - * Call lwmi_om_register_notifier to register the notifier block to the
> - * lenovo-wmi-other driver notifier chain. Then add devm_lwmi_om_unregis=
ter_notifier
> - * as a device managed action to automatically unregister the notifier b=
lock
> - * upon parent device removal.
> - *
> - * Return: 0 on success, or an error code.
> - */
> -int devm_lwmi_om_register_notifier(struct device *dev,
> -				   struct notifier_block *nb)
> -{
> -	int ret;
> -
> -	ret =3D lwmi_om_register_notifier(nb);
> -	if (ret < 0)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, devm_lwmi_om_unregister_notifier,
> -					nb);
> -}
> -EXPORT_SYMBOL_NS_GPL(devm_lwmi_om_register_notifier, "LENOVO_WMI_OTHER")=
;
> -
> -/**
> - * lwmi_om_notifier_call() - Call functions for the notifier call chain.
> - * @mode: Pointer to a thermal mode enum to retrieve the data from.
> - *
> - * Call blocking_notifier_call_chain to retrieve the thermal mode from t=
he
> - * lenovo-wmi-gamezone driver.
> - *
> - * Return: 0 on success, or an error code.
> - */
> -static int lwmi_om_notifier_call(enum thermal_mode *mode)
> -{
> -	int ret;
> -
> -	ret =3D blocking_notifier_call_chain(&om_chain_head,
> -					   LWMI_GZ_GET_THERMAL_MODE, &mode);
> -	if ((ret & ~NOTIFY_STOP_MASK) !=3D NOTIFY_OK)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  /* Attribute Methods */
> =20
>  /**
> @@ -1178,7 +1078,7 @@ static ssize_t attr_current_value_store(struct kobj=
ect *kobj,
>  	u32 value;
>  	int ret;
> =20
> -	ret =3D lwmi_om_notifier_call(&mode);
> +	ret =3D lwmi_tm_notifier_call(&mode);
>  	if (ret)
>  		return ret;
> =20
> @@ -1237,7 +1137,7 @@ static ssize_t attr_current_value_show(struct kobje=
ct *kobj,
>  	int retval;
>  	int ret;
> =20
> -	ret =3D lwmi_om_notifier_call(&mode);
> +	ret =3D lwmi_tm_notifier_call(&mode);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/platform/x86/lenovo/wmi-other.h b/drivers/platform/x=
86/lenovo/wmi-other.h
> deleted file mode 100644
> index 8ebf5602bb99..000000000000
> --- a/drivers/platform/x86/lenovo/wmi-other.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -
> -/* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
> -
> -#ifndef _LENOVO_WMI_OTHER_H_
> -#define _LENOVO_WMI_OTHER_H_
> -
> -struct device;
> -struct notifier_block;
> -
> -int lwmi_om_register_notifier(struct notifier_block *nb);
> -int lwmi_om_unregister_notifier(struct notifier_block *nb);
> -int devm_lwmi_om_register_notifier(struct device *dev,
> -				   struct notifier_block *nb);
> -
> -#endif /* !_LENOVO_WMI_OTHER_H_ */

