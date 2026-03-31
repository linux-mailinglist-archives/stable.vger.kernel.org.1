Return-Path: <stable+bounces-232552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKAZMdAFzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8D36EF30
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17FF307841D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47A366567;
	Tue, 31 Mar 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="JZoWszX+"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B433ADB1;
	Tue, 31 Mar 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977904; cv=pass; b=T2tI7d0EQKvYHBQL9bEC5bZXLsg4Yi6eZVrSdFbQpk2J28bAzJJ1Dtu+oyCF0UV6RFWzlzCA928gm4t4AELrfqUI71RujWAAaGL0Mkw8wIY1Lbvnyus1I6mwy5NzvbhyW8hodf8ovsi35ZJkrsRkH5BlkD/zkmog1/jOG0batbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977904; c=relaxed/simple;
	bh=6/ql8FNUYX9RLdMQCve36DQhol1c980WJqD9NgB4JNM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IlThPzAmDYwUkddHNu8VMKtxPtk893Gc0sNFRjGRmieF/hnPK8opGciTKSq8jb2/QeIB7fQ1jPhxJKEvALkSq4QMYslEj/8Wcmx2OHPlSJfFYTHIS1PH5fZrgfsGWHHK2BhR+uS4eIVN8qJkzReedKspyQ0l00/gV6rcDrf3fnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=JZoWszX+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1774977888; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mfbt8ZYJ6fshY+e/lkfd53wlVQvbQ9Nq7ar0G6ZNYGddmuua6oHlpemYCCmBuh/eaSyqNfqseSNtAGv9mOJR2dUakgBAuk8bHp/4gDkqyPQW7Nuz53rzGAHOjYd5Mmubwi/dsxYdZpmDdRx5uqTN49rb7i+J/B+QtzFNLByCaVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774977888; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FHilIAO4qYKYoZuc+6OM/D/bi/vbmK9PrJA5dc3G+Wo=; 
	b=j40JT1/yzk7zz7Xl0RTPl9XPfGb7PVsBkXLz3EVScArOvQpuzBqsTzPGqFUR2CtJBvr0xQa5MOLV7bWtBfs3t4sucLvbVptra7VEmJ0ihJmloJJMqKRILuGA8CF3OZj3Gkh66LB2XDQGgyTpoyKY4JRKPboaSFvh/UH4gI8gLUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774977888;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=FHilIAO4qYKYoZuc+6OM/D/bi/vbmK9PrJA5dc3G+Wo=;
	b=JZoWszX+mWWY3RGvXfQBIxPA0Ikxsgk8p+i7OBdaj5bOLxtxhvcUO/Vbs75Fg7Db
	ePJ1w8KFhexU4TkB7t4ryG+ORBoCNLJWXA0kDIjUcCIveahzazSu+zT4ffiQdjATPJ2
	AyLQq1qbsq3uK4+kles1SSK/KMUsvyp8eIx4vP3iGCnhWolBDwXXZqnMHDXDmuQDL91
	hjzEZVCfURs+ps2xPAUU/xXF+emzdwIxyI2zAfPzditfsy7dikpE+dN4OxuO6WABC8a
	6dFsJTReIplyMwPWVw4Utg1n/TShTb4qmh2QUa3U9J4hhG4mUigedc9o+COk/gmtURA
	FsgKLCyscg==
Received: by mx.zohomail.com with SMTPS id 1774977886130130.76757325486403;
	Tue, 31 Mar 2026 10:24:46 -0700 (PDT)
Message-ID: <ed27a1c24bfc05717f2c0d5a1c052630484d313f.camel@rong.moe>
Subject: Re: [PATCH] platform/x86: lenovo: Decouple lenovo-wmi-gamezone and
 lenovo-wmi-other
From: Rong Zhang <i@rong.moe>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hans
 de Goede <hansg@kernel.org>, oe-kbuild-all@lists.linux.dev, Mark Pearson
 <mpearson-lenovo@squebb.ca>,  Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet
 <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 kernel test robot	 <lkp@intel.com>, stable@vger.kernel.org
In-Reply-To: <CAFqHKTkSQsEDeFif8+OrAm2tr2VQjx7N0UEdXxJRmy+N_4i==g@mail.gmail.com>
References: <861d0276a759461be446df8e996d196037c9b581.camel@rong.moe>
		 <20260326161724.72186-1-i@rong.moe>
		 <d824bf55-8c1a-1374-04f9-aff9ffdaaa0d@linux.intel.com>
		 <afa0c48c0adac075411dae92ff9079e52c77a3fe.camel@rong.moe>
		 <CAFqHKTkSQsEDeFif8+OrAm2tr2VQjx7N0UEdXxJRmy+N_4i==g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Apr 2026 00:07:46 +0800
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
	TAGGED_FROM(0.00)[bounces-232552-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,lists.linux.dev,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org,intel.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,rong.moe:dkim,rong.moe:email,rong.moe:mid]
X-Rspamd-Queue-Id: 06D8D36EF30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Derek,

On Mon, 2026-03-30 at 13:04 -0700, Derek John Clark wrote:
> On Fri, Mar 27, 2026 at 8:21=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
> >=20
> > Hi Ilpo,
> >=20
> > On Fri, 2026-03-27 at 13:25 +0200, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 27 Mar 2026, Rong Zhang wrote:
> > >=20
> > > > Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the f=
ormer
> > > > imports symbols from the latter. The imported symbols are just used=
 to
> > > > register a notifier block. However, there is no runtime dependency
> > > > between both drivers, and either of them can run without the other,
> > > > which is the major purpose of using the notifier framework.
> > > >=20
> > > > Such a link-time dependency is non-optimal. A previous attempt to "=
fix"
> > > > it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
> > > > fundamentally broken and resulted in undefined Kconfig behavior, as
> > > > `select' cannot be used on a symbol with potentially unmet dependen=
cies.
> > > >=20
> > > > Decouple both drivers by moving the thermal mode notifier chain to
> > > > lenovo-wmi-helpers. Methods for notifier block (un)registration are
> > > > exported for lenovo-wmi-gamezone, while a method for querying the
> > > > current thermal mode are exported for lenovo-wmi-other.
> > > >=20
> > > > This turns the dependency graph from
> > > >=20
> > > >             +------------ lenovo-wmi-gamezone
> > > >             |                     |
> > > >             v                     |
> > > >     lenovo-wmi-helpers            |
> > > >             ^                     |
> > > >             |                     V
> > > >             +------------ lenovo-wmi-other
> > > >=20
> > > > into
> > > >=20
> > > >             +------------ lenovo-wmi-gamezone
> > > >             |
> > > >             v
> > > >     lenovo-wmi-helpers
> > > >             ^
> > > >             |
> > > >             +------------ lenovo-wmi-other
> > > >=20
> > > > To make it clear, the name of the notifier chain is also renamed fr=
om
> > > > `om_chain_head' to `tm_chain_head', indicating that it's used to qu=
ery
> > > > the current thermal mode.
> > > >=20
> > > > No functional change intended.
> > > >=20
> > > > Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other m=
ode"")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda=
-lkp@intel.com/
> > > > Signed-off-by: Rong Zhang <i@rong.moe>
> > > > ---
> > > >  drivers/platform/x86/lenovo/Kconfig        |   1 -
> > > >  drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
> > > >  drivers/platform/x86/lenovo/wmi-helpers.c  | 102 +++++++++++++++++=
+++
> > > >  drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
> > > >  drivers/platform/x86/lenovo/wmi-other.c    | 104 +----------------=
----
> > > >  drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
> > > >  6 files changed, 113 insertions(+), 122 deletions(-)
> > > >  delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
> > > >=20
> > > > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform=
/x86/lenovo/Kconfig
> > > > index f885127b007f..09b1b055d2e0 100644
> > > > --- a/drivers/platform/x86/lenovo/Kconfig
> > > > +++ b/drivers/platform/x86/lenovo/Kconfig
> > > > @@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
> > > >     select ACPI_PLATFORM_PROFILE
> > > >     select LENOVO_WMI_EVENTS
> > > >     select LENOVO_WMI_HELPERS
> > > > -   select LENOVO_WMI_TUNING
> > > >     help
> > > >       Say Y here if you have a WMI aware Lenovo Legion device and w=
ould like to use the
> > > >       platform-profile firmware interface to manage power usage.
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/p=
latform/x86/lenovo/wmi-gamezone.c
> > > > index c7fe7e3c9f17..92020225db27 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> > > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> > > > @@ -23,7 +23,6 @@
> > > >  #include "wmi-events.h"
> > > >  #include "wmi-gamezone.h"
> > > >  #include "wmi-helpers.h"
> > > > -#include "wmi-other.h"
> > > >=20
> > > >  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0=
"
> > > >=20
> > > > @@ -383,7 +382,7 @@ static int lwmi_gz_probe(struct wmi_device *wde=
v, const void *context)
> > > >             return ret;
> > > >=20
> > > >     priv->mode_nb.notifier_call =3D lwmi_gz_mode_call;
> > > > -   return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_n=
b);
> > > > +   return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_n=
b);
> > > >  }
> > > >=20
> > > >  static const struct wmi_device_id lwmi_gz_id_table[] =3D {
> > > > @@ -405,7 +404,6 @@ module_wmi_driver(lwmi_gz_driver);
> > > >=20
> > > >  MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
> > > >  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> > > > -MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
> > > >  MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
> > > >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > > >  MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/pl=
atform/x86/lenovo/wmi-helpers.c
> > > > index 7379defac500..5a88bccb5037 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> > > > +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> > > > @@ -21,11 +21,16 @@
> > > >  #include <linux/errno.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/notifier.h>
> > > >  #include <linux/unaligned.h>
> > > >  #include <linux/wmi.h>
> > > >=20
> > > > +#include "wmi-gamezone.h"
> > > >  #include "wmi-helpers.h"
> > > >=20
> > > > +/* Thermal mode notifier chain. */
> > > > +static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
> > > > +
> > > >  /**
> > > >   * lwmi_dev_evaluate_int() - Helper function for calling WMI metho=
ds that
> > > >   * return an integer.
> > > > @@ -84,6 +89,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wd=
ev, u8 instance, u32 method_id,
> > > >  };
> > > >  EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
> > > >=20
> > > > +/**
> > > > + * lwmi_tm_register_notifier() - Add a notifier to the blocking no=
tifier chain
> > > > + * @nb: The notifier_block struct to register
> > > > + *
> > > > + * Call blocking_notifier_chain_register to register the notifier =
block to the
> > > > + * thermal mode notifier chain.
> > > > + *
> > > > + * Return: 0 on success, %-EEXIST on error.
> > > > + */
> > > > +int lwmi_tm_register_notifier(struct notifier_block *nb)
> > > > +{
> > > > +   return blocking_notifier_chain_register(&tm_chain_head, nb);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPER=
S");
> > > > +
> > > > +/**
> > > > + * lwmi_tm_unregister_notifier() - Remove a notifier from the bloc=
king notifier
> > > > + * chain.
> > > > + * @nb: The notifier_block struct to register
> > > > + *
> > > > + * Call blocking_notifier_chain_unregister to unregister the notif=
ier block from the
> > > > + * thermal mode notifier chain.
> > > > + *
> > > > + * Return: 0 on success, %-ENOENT on error.
> > > > + */
> > > > +int lwmi_tm_unregister_notifier(struct notifier_block *nb)
> > > > +{
> > > > +   return blocking_notifier_chain_unregister(&tm_chain_head, nb);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELP=
ERS");
> > > > +
> > > > +/**
> > > > + * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the=
 blocking
> > > > + * notifier chain.
> > > > + * @data: Void pointer to the notifier_block struct to register.
> > > > + *
> > > > + * Call lwmi_tm_unregister_notifier to unregister the notifier blo=
ck from the
> > > > + * thermal mode notifier chain.
> > > > + *
> > > > + * Return: 0 on success, %-ENOENT on error.
> > > > + */
> > > > +static void devm_lwmi_tm_unregister_notifier(void *data)
> > > > +{
> > > > +   struct notifier_block *nb =3D data;
> > > > +
> > > > +   lwmi_tm_unregister_notifier(nb);
> > > > +}
> > > > +
> > > > +/**
> > > > + * devm_lwmi_tm_register_notifier() - Add a notifier to the blocki=
ng notifier
> > > > + * chain.
> > > > + * @dev: The parent device of the notifier_block struct.
> > > > + * @nb: The notifier_block struct to register
> > > > + *
> > > > + * Call lwmi_tm_register_notifier to register the notifier block t=
o the
> > > > + * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_n=
otifier
> > > > + * as a device managed action to automatically unregister the noti=
fier block
> > > > + * upon parent device removal.
> > > > + *
> > > > + * Return: 0 on success, or an error code.
> > > > + */
> > > > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > > > +                              struct notifier_block *nb)
> > > > +{
> > > > +   int ret;
> > > > +
> > > > +   ret =3D lwmi_tm_register_notifier(nb);
> > > > +   if (ret < 0)
> > > > +           return ret;
> > > > +
> > > > +   return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_no=
tifier,
> > > > +                                   nb);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_H=
ELPERS");
> > > > +
> > > > +/**
> > > > + * lwmi_tm_notifier_call() - Call functions for the notifier call =
chain.
> > > > + * @mode: Pointer to a thermal mode enum to retrieve the data from=
.
> > > > + *
> > > > + * Call blocking_notifier_call_chain to retrieve the thermal mode =
from the
> > > > + * lenovo-wmi-gamezone driver.
> > > > + *
> > > > + * Return: 0 on success, or an error code.
> > > > + */
> > > > +int lwmi_tm_notifier_call(enum thermal_mode *mode)
> > > > +{
> > > > +   int ret;
> > > > +
> > > > +   ret =3D blocking_notifier_call_chain(&tm_chain_head,
> > > > +                                      LWMI_GZ_GET_THERMAL_MODE, &m=
ode);
> > > > +   if ((ret & ~NOTIFY_STOP_MASK) !=3D NOTIFY_OK)
> > > > +           return -EINVAL;
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
> > > > +
> > > >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > > >  MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
> > > >  MODULE_LICENSE("GPL");
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/pl=
atform/x86/lenovo/wmi-helpers.h
> > > > index 20fd21749803..651a039228ed 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> > > > +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> > > > @@ -7,6 +7,8 @@
> > > >=20
> > > >  #include <linux/types.h>
> > > >=20
> > > > +struct device;
> > > > +struct notifier_block;
> > > >  struct wmi_device;
> > > >=20
> > > >  struct wmi_method_args_32 {
> > > > @@ -17,4 +19,10 @@ struct wmi_method_args_32 {
> > > >  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u3=
2 method_id,
> > > >                       unsigned char *buf, size_t size, u32 *retval)=
;
> > > >=20
> > > > +int lwmi_tm_register_notifier(struct notifier_block *nb);
> > > > +int lwmi_tm_unregister_notifier(struct notifier_block *nb);
> > > > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > > > +                              struct notifier_block *nb);
> > > > +int lwmi_tm_notifier_call(enum thermal_mode *mode);
> > >=20
> > > This enum is not introduced earlier within this header?
> >=20
> > Hmm, no. Declaring a opaque enum earlier should be enough to fix it, as
> > wmi-gamezone.h shouldn't be included here. Derek, what do you think?
>=20
> I think it makes more sense at this point to move everything from
> wmi_gamezone.h into wmi_helpers.h. This prevents wmi_capdata.c from
> needing to import wmi_gamezone.h, since the thermal mode enum will be
> moved (now used by capdata, gamezone, and other). Then the only thing
> in the gamezone header would be the gamezone_events_type enum, which
> is only used by gamezone and helpers anyway, so that can safely move
> and we can delete the entire file. To make that enum name more generic
> I'll rename it in the move from gamezone_events_type to
> lwmi_event_type (the enum isn't directly referenced anywhere anyway).
>=20
> If that works for everyone I'll add one more patch to do the move &
> cleanup before  "platform/x86: lenovo-wmi-other: Add lwmi_attr_id()
> function" where I'm adding the .._NONE thermal mode. That will keep
> the purpose of each patch clean and avoid me needing to modify your
> patches too much.

That sounds good to me.

Moving everything from wmi_gamezone.h into wmi_helpers.h also seems more
semantically correct from my perspective, since the former was just used
to glue things together, which instead matches the purpose of the
latter.

Thanks,
Rong

>=20
> Thanks,
> Derek.
>=20
> > Thanks,
> > Rong

