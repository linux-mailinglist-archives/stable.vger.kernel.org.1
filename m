Return-Path: <stable+bounces-230678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JmAAPCgxmnrMQUAu9opvQ
	(envelope-from <stable+bounces-230678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:23:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7210F346A89
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9B63082CCA
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94232E121;
	Fri, 27 Mar 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="LuDwOLTg"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268802DC764;
	Fri, 27 Mar 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624911; cv=pass; b=ZtUrZBFB3n86Kq3dhCH0+mgr2+mKPx3E4pemLUehJFWi4bmuc3Hij/ZKV+FtirYAvEJ0o1JGGz8zCbmWywP0WFHwQe6QTnaIXqEMGN3oAm+WrJ87soJlGFvqYuhIuU66xuhE0pt3Sch9NMeQiKNe8wKL802pXFjJZ7KFYFZFjhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624911; c=relaxed/simple;
	bh=YgrZg5XAjkLH5f5sVu2AoSl1cCMFK/jzqOnUWwiA5vk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kGBXXRpH2g0VyC6jLxCLB9j+X9jn2hyozOxHLz3Q8hmIpSozsO+7k6Ca30E/Z3p9M5AHPAXe+JVNhdyDIXfZ1YgbmrKUnASn+UHrGVuYSGBL2eJKZs1EVMHo1GBgpniImxwD6NWiftCBDfDyOqgf13hGRe33T8W3hc2RgW49Jw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=LuDwOLTg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1774624897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MDbq14TNDDoD8tniAMHxafY6e3kNLVc0/vjC26pPryOWs+XZwlpCqE4Ro+GJWe70yMLZEqqqzdNE1b97y7MgLBk/ysXvGpx4vWW5lDvfACHSPmYFTYWoERju+b82k+0ZZxEvnOp4z1ib+Cu6IKE0S/9qFp3Wo9R95C1FmSBCE40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774624897; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=38tU4QDZcLf0ZOAVBo9/Q1Vox9MVHRrT2KOUdFjj+1w=; 
	b=PFdBmOfoa8bSfLh8bc0Q5pim45tC+CWU7WFcW6PB/Dp8tdg7/VrGnH632PzS9REBWFX9IXCRZBsl9wQivN2ennTNzZzRDNOMLYnxa56s1lkr5ZhxkAyFrFu2DhOZta4YRdvbbjp8mbIkxjbUbXUjmhrVYTDqVW40DogJoBgZYzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774624896;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=38tU4QDZcLf0ZOAVBo9/Q1Vox9MVHRrT2KOUdFjj+1w=;
	b=LuDwOLTgBb+Pg0qGRcJgeFMv8NvA25JVH9hWu3FEOG8XEe2s9xb6GAE25qoQ28Bt
	I65zx1jJ4ThwfOUaPjr7HE5ERlU8ioQG2r5DMy6V2ODpQA5UHTeonweIW425nFlCdES
	UtEg0Tap7zO0cBN03equOngRxhIpiZVj6oXgTszVqoihYoH1jfjDjMbM7oHZBHzRC41
	ucT6BLTJFH/vIzrSHQSeZOc6Yn6FQP47csoDyJUzLkfO3BOZqNJi8Do+HtvSEwE+kib
	VTeaQhDn9ZUxmURYuLB3UCodAuHrWvB3lz/aKL2OZ8LkdTweD+U4Q/lfdNF6FmAlqHB
	kSCVbrqzEA==
Received: by mx.zohomail.com with SMTPS id 1774624894831431.44387687844517;
	Fri, 27 Mar 2026 08:21:34 -0700 (PDT)
Message-ID: <afa0c48c0adac075411dae92ff9079e52c77a3fe.camel@rong.moe>
Subject: Re: [PATCH] platform/x86: lenovo: Decouple lenovo-wmi-gamezone and
 lenovo-wmi-other
From: Rong Zhang <i@rong.moe>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Derek John Clark <derekjohn.clark@gmail.com>, Hans de Goede
	 <hansg@kernel.org>, oe-kbuild-all@lists.linux.dev, Mark Pearson
	 <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet
	 <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 kernel test robot
	 <lkp@intel.com>, stable@vger.kernel.org
In-Reply-To: <d824bf55-8c1a-1374-04f9-aff9ffdaaa0d@linux.intel.com>
References: <861d0276a759461be446df8e996d196037c9b581.camel@rong.moe>
	 <20260326161724.72186-1-i@rong.moe>
	 <d824bf55-8c1a-1374-04f9-aff9ffdaaa0d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Mar 2026 23:16:25 +0800
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
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230678-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,squebb.ca,gmx.de,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rong.moe:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7210F346A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ilpo,

On Fri, 2026-03-27 at 13:25 +0200, Ilpo J=C3=A4rvinen wrote:
> On Fri, 27 Mar 2026, Rong Zhang wrote:
>=20
> > Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the forme=
r
> > imports symbols from the latter. The imported symbols are just used to
> > register a notifier block. However, there is no runtime dependency
> > between both drivers, and either of them can run without the other,
> > which is the major purpose of using the notifier framework.
> >=20
> > Such a link-time dependency is non-optimal. A previous attempt to "fix"
> > it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
> > fundamentally broken and resulted in undefined Kconfig behavior, as
> > `select' cannot be used on a symbol with potentially unmet dependencies=
.
> >=20
> > Decouple both drivers by moving the thermal mode notifier chain to
> > lenovo-wmi-helpers. Methods for notifier block (un)registration are
> > exported for lenovo-wmi-gamezone, while a method for querying the
> > current thermal mode are exported for lenovo-wmi-other.
> >=20
> > This turns the dependency graph from
> >=20
> >             +------------ lenovo-wmi-gamezone
> >             |                     |
> >             v                     |
> >     lenovo-wmi-helpers            |
> >             ^                     |
> >             |                     V
> >             +------------ lenovo-wmi-other
> >=20
> > into
> >=20
> >             +------------ lenovo-wmi-gamezone
> >             |
> >             v
> >     lenovo-wmi-helpers
> >             ^
> >             |
> >             +------------ lenovo-wmi-other
> >=20
> > To make it clear, the name of the notifier chain is also renamed from
> > `om_chain_head' to `tm_chain_head', indicating that it's used to query
> > the current thermal mode.
> >=20
> > No functional change intended.
> >=20
> > Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other mode"=
")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda-lkp=
@intel.com/
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  drivers/platform/x86/lenovo/Kconfig        |   1 -
> >  drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
> >  drivers/platform/x86/lenovo/wmi-helpers.c  | 102 ++++++++++++++++++++
> >  drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
> >  drivers/platform/x86/lenovo/wmi-other.c    | 104 +--------------------
> >  drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
> >  6 files changed, 113 insertions(+), 122 deletions(-)
> >  delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
> >=20
> > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86=
/lenovo/Kconfig
> > index f885127b007f..09b1b055d2e0 100644
> > --- a/drivers/platform/x86/lenovo/Kconfig
> > +++ b/drivers/platform/x86/lenovo/Kconfig
> > @@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
> >  	select ACPI_PLATFORM_PROFILE
> >  	select LENOVO_WMI_EVENTS
> >  	select LENOVO_WMI_HELPERS
> > -	select LENOVO_WMI_TUNING
> >  	help
> >  	  Say Y here if you have a WMI aware Lenovo Legion device and would l=
ike to use the
> >  	  platform-profile firmware interface to manage power usage.
> > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platf=
orm/x86/lenovo/wmi-gamezone.c
> > index c7fe7e3c9f17..92020225db27 100644
> > --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> > @@ -23,7 +23,6 @@
> >  #include "wmi-events.h"
> >  #include "wmi-gamezone.h"
> >  #include "wmi-helpers.h"
> > -#include "wmi-other.h"
> > =20
> >  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> > =20
> > @@ -383,7 +382,7 @@ static int lwmi_gz_probe(struct wmi_device *wdev, c=
onst void *context)
> >  		return ret;
> > =20
> >  	priv->mode_nb.notifier_call =3D lwmi_gz_mode_call;
> > -	return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb);
> > +	return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_nb);
> >  }
> > =20
> >  static const struct wmi_device_id lwmi_gz_id_table[] =3D {
> > @@ -405,7 +404,6 @@ module_wmi_driver(lwmi_gz_driver);
> > =20
> >  MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
> >  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> > -MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
> >  MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
> >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> >  MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platfo=
rm/x86/lenovo/wmi-helpers.c
> > index 7379defac500..5a88bccb5037 100644
> > --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> > +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> > @@ -21,11 +21,16 @@
> >  #include <linux/errno.h>
> >  #include <linux/export.h>
> >  #include <linux/module.h>
> > +#include <linux/notifier.h>
> >  #include <linux/unaligned.h>
> >  #include <linux/wmi.h>
> > =20
> > +#include "wmi-gamezone.h"
> >  #include "wmi-helpers.h"
> > =20
> > +/* Thermal mode notifier chain. */
> > +static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
> > +
> >  /**
> >   * lwmi_dev_evaluate_int() - Helper function for calling WMI methods t=
hat
> >   * return an integer.
> > @@ -84,6 +89,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, =
u8 instance, u32 method_id,
> >  };
> >  EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
> > =20
> > +/**
> > + * lwmi_tm_register_notifier() - Add a notifier to the blocking notifi=
er chain
> > + * @nb: The notifier_block struct to register
> > + *
> > + * Call blocking_notifier_chain_register to register the notifier bloc=
k to the
> > + * thermal mode notifier chain.
> > + *
> > + * Return: 0 on success, %-EEXIST on error.
> > + */
> > +int lwmi_tm_register_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_register(&tm_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS");
> > +
> > +/**
> > + * lwmi_tm_unregister_notifier() - Remove a notifier from the blocking=
 notifier
> > + * chain.
> > + * @nb: The notifier_block struct to register
> > + *
> > + * Call blocking_notifier_chain_unregister to unregister the notifier =
block from the
> > + * thermal mode notifier chain.
> > + *
> > + * Return: 0 on success, %-ENOENT on error.
> > + */
> > +int lwmi_tm_unregister_notifier(struct notifier_block *nb)
> > +{
> > +	return blocking_notifier_chain_unregister(&tm_chain_head, nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELPERS"=
);
> > +
> > +/**
> > + * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the blo=
cking
> > + * notifier chain.
> > + * @data: Void pointer to the notifier_block struct to register.
> > + *
> > + * Call lwmi_tm_unregister_notifier to unregister the notifier block f=
rom the
> > + * thermal mode notifier chain.
> > + *
> > + * Return: 0 on success, %-ENOENT on error.
> > + */
> > +static void devm_lwmi_tm_unregister_notifier(void *data)
> > +{
> > +	struct notifier_block *nb =3D data;
> > +
> > +	lwmi_tm_unregister_notifier(nb);
> > +}
> > +
> > +/**
> > + * devm_lwmi_tm_register_notifier() - Add a notifier to the blocking n=
otifier
> > + * chain.
> > + * @dev: The parent device of the notifier_block struct.
> > + * @nb: The notifier_block struct to register
> > + *
> > + * Call lwmi_tm_register_notifier to register the notifier block to th=
e
> > + * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_notif=
ier
> > + * as a device managed action to automatically unregister the notifier=
 block
> > + * upon parent device removal.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > +				   struct notifier_block *nb)
> > +{
> > +	int ret;
> > +
> > +	ret =3D lwmi_tm_register_notifier(nb);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_notifier=
,
> > +					nb);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_HELPE=
RS");
> > +
> > +/**
> > + * lwmi_tm_notifier_call() - Call functions for the notifier call chai=
n.
> > + * @mode: Pointer to a thermal mode enum to retrieve the data from.
> > + *
> > + * Call blocking_notifier_call_chain to retrieve the thermal mode from=
 the
> > + * lenovo-wmi-gamezone driver.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +int lwmi_tm_notifier_call(enum thermal_mode *mode)
> > +{
> > +	int ret;
> > +
> > +	ret =3D blocking_notifier_call_chain(&tm_chain_head,
> > +					   LWMI_GZ_GET_THERMAL_MODE, &mode);
> > +	if ((ret & ~NOTIFY_STOP_MASK) !=3D NOTIFY_OK)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
> > +
> >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> >  MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platfo=
rm/x86/lenovo/wmi-helpers.h
> > index 20fd21749803..651a039228ed 100644
> > --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> > +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> > @@ -7,6 +7,8 @@
> > =20
> >  #include <linux/types.h>
> > =20
> > +struct device;
> > +struct notifier_block;
> >  struct wmi_device;
> > =20
> >  struct wmi_method_args_32 {
> > @@ -17,4 +19,10 @@ struct wmi_method_args_32 {
> >  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 me=
thod_id,
> >  			  unsigned char *buf, size_t size, u32 *retval);
> > =20
> > +int lwmi_tm_register_notifier(struct notifier_block *nb);
> > +int lwmi_tm_unregister_notifier(struct notifier_block *nb);
> > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > +				   struct notifier_block *nb);
> > +int lwmi_tm_notifier_call(enum thermal_mode *mode);
>=20
> This enum is not introduced earlier within this header?

Hmm, no. Declaring a opaque enum earlier should be enough to fix it, as
wmi-gamezone.h shouldn't be included here. Derek, what do you think?

Thanks,
Rong

