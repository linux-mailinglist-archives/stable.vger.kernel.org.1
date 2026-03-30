Return-Path: <stable+bounces-231270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBDxEdjYymmWAgYAu9opvQ
	(envelope-from <stable+bounces-231270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:11:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E22360D74
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BE2E30A3DEA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666339E182;
	Mon, 30 Mar 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Liirv87A"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD833399344
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901095; cv=pass; b=RKREyY12RydYvMLYpwPvB6ardETyKoFniNlm40j7ZYMVL7V/ybf3IMrgSaiBB9ZzYCJNfpu70DwfnvrdvnmiUGvn5Mc+qYaYoVKbx2uexnqDOvQjRL3mJOfuf6NtfRfJNdN1nuCZerlNQDvvem3OFJIpflxVT7MA5hfQZDzU4Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901095; c=relaxed/simple;
	bh=KJuJuhqUaZ55M8ruejRz7A3V09B3RWMTzMHuYnfDh/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Proaq7BYR4j9QtpuTLWQcjt3bh8+3pNgdjQiFvNpThOkYqyES29IhKdPMab2ctey9zj6/qHoF6iXzXzZS7EqyPtFCNq5zfae55IORDxGRk+pm0kzMY58Cr89pxmMBobqnLco832nfzOB+2lGBYRo7BMh20/4fjxNCg3AxQNE/K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Liirv87A; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a9f445cbso56685156d6.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 13:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774901093; cv=none;
        d=google.com; s=arc-20240605;
        b=hVGCUZuVjz2Ue2NroN4e7QGPW/2MY20ZXG6OEfqCaHj3YQ5W/JczR/ivo6j8osHbYM
         JPcc5qP17gUtJJvrOejxwkF6aCto3/8m4RqM8eeFX3N0m5R1auFwgn2rcboW/Dzc1bpj
         GlIFlEWuwyAeDypZh9ID12zReCiMJZS4Fu3jy1BM1+YneqpMqAopUbl0l7TBELWKrV5e
         NRSztAYoQ95G+z48xHBIDo3xH1y5uFt1DeInNQJ5IFJKVOSd3v/m3M939Ac0ETBxfiLw
         URRg7+yqbLc915QjOdP62XZ/1RfKHnQ9CCvsgTIFIzeTXfFAUZpOSHXboN7HTKzphh/Y
         yTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oSkfhNu1ynunF/nJxn9CMmPexHLJKgIbYNXwLG1ZZTI=;
        fh=MgQpCdbiEZL/CxoC6HabxzDPAFDi8CF21a4E851RnNE=;
        b=Odz8MlJze2DEbTily9j4u0vY33na70ERW5QiGSmk36Gg7lJUNpuDn7mz/PeQA/NPV+
         BzmYcSybtt6qcvMzEUyYgal9+lHTFghzjfdAZpiMJWsYsQCqOjjzLpaNXF1QGdo8ayTX
         y40B8zDUXR14gEFbHRzY4zvjA9H+T0cAklRSTf6Fzo5bHtMHFxqVKAPQf92x6XC0XWOz
         zk5lOyphQ/roQJGpYblHs4Li5Bd4Kv/EP+v+ove5QOabFFpCv9g1Q7z/awvRMwIIALDC
         HdsYl3ojJ85i6TLPPuZXk9ih7yPZN6ih/ld2uk48BFQtbENWa9jJf/7HOAmXJLgFS1d/
         08vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774901093; x=1775505893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSkfhNu1ynunF/nJxn9CMmPexHLJKgIbYNXwLG1ZZTI=;
        b=Liirv87AstAdm5ulkGdu8ebYdkZxvHLBy1DgAp0lAyaUyXNHQsLs3Q3DVtnCoUJwBX
         yXNM9uJ1Hyq0D1/OjUScGkBGWkxtUyj30ZWP/05z7camrBCMWx98dWT4sciMzM9azMG6
         LBQS62bDzTyMVrdR0E4pJv308atqxkQDrvMDxAJ8xChJnWRJnJXY621K+FeZrvaDO0ke
         HHTQIJGaNgU28qBaJKAJwk3/DsvE/ADKpTtTZgeG2L+xL5jECgQvHcLIAprVSfRWNpPe
         ZjmwJIfBWKc+lFNYR/cbFLs/jBKG0a80yCyN6KpQz1agos96SLX0Jl8D8Ytvw16zY3Tb
         4ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774901093; x=1775505893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSkfhNu1ynunF/nJxn9CMmPexHLJKgIbYNXwLG1ZZTI=;
        b=sp7PYuaQ8uUcvkpWYlnRaZt+TX9a/ed9xvi8uW/4nHzfnole0n4k0gkncwsfUHrMKI
         bpwm1HY30gWEc6J1irdCpUuPYPVTAChMAt5Z7u2XUa3bXYuxN+9aO4RqUhTAAf0EdGfq
         FhLEf3fLSR1cDo9T4LQOBwcfo10mcqXVP/LkCFqKLTx0dWjlo55xDXwq0GZkY6xhAVUd
         e/CsuyIBP18iox5Zr8y+28ejMo4PGxDnAeXu4Kb6/cFhRkGTv/6TNpmgnCmtH8LNKAvG
         rXYCMoVz+AHAhqpnvyU/ThFT4clG23pobRDEEX4XywGPdWEBnHPMegK3DdusVsE7f8wG
         miUg==
X-Forwarded-Encrypted: i=1; AJvYcCW03pSBX/aahF7HpE5AHNEUlD5lE+tS3T0yPU2/zhKVy+8tNzkfgjc28Z6KzZCe4C7v6S0/axE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6TRiLryPTfPUIj9KSBCRfUIyuhmKtGjf/syJZaj5C1QO3WPC
	B4a5xrz2sB0SGTF33pP3HBJEB2Zt4pC2HFDEqdzHVmjfDl9s/9LRFSqXOkJ2OMuz2ZZBN/rkwOf
	yHK7BOVbOWZKLYrI7RlElhbFeIQIVV4s=
X-Gm-Gg: ATEYQzxUaXolyB433ujZIXHWyfnAhwCMg1Jt15lV+KO9ydChaeLjpj4m0m0QSBM585q
	3wEJUbSqxRlhAIpmz20Ni6HoQlM2z55WMT+mscEMeRBNVUxDbTAVDgDugyykQNZUFUtJILYSH93
	XaFX7uM8I4OGienW5DfkZ0VNkRZkOCdYIdv8tARK3x2DY6xf0lcn5LHzRPAhcdK9CfN0p33hCxX
	tMtwzucWUXlr66mzC2GyfM6ZtKK5uQLke7WlKmKeOUklU80SAFcRDnSENDFwrnLClxNWKQWYMYt
	PsMWDNbQ
X-Received: by 2002:a05:6214:20e2:b0:89c:ac72:2f6e with SMTP id
 6a1803df08f44-89ce8f2cfd2mr188112966d6.43.1774901092614; Mon, 30 Mar 2026
 13:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <861d0276a759461be446df8e996d196037c9b581.camel@rong.moe>
 <20260326161724.72186-1-i@rong.moe> <d824bf55-8c1a-1374-04f9-aff9ffdaaa0d@linux.intel.com>
 <afa0c48c0adac075411dae92ff9079e52c77a3fe.camel@rong.moe>
In-Reply-To: <afa0c48c0adac075411dae92ff9079e52c77a3fe.camel@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 30 Mar 2026 13:04:41 -0700
X-Gm-Features: AQROBzCUCvaRnIMxt9qXTKpRMu_60KmC2N-WJ-TFOAoyaYdRkGu52ecrs59LVC0
Message-ID: <CAFqHKTkSQsEDeFif8+OrAm2tr2VQjx7N0UEdXxJRmy+N_4i==g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: lenovo: Decouple lenovo-wmi-gamezone and lenovo-wmi-other
To: Rong Zhang <i@rong.moe>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Jonathan Corbet <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,rong.moe:server fail,intel.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-231270-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,lists.linux.dev,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rong.moe:email]
X-Rspamd-Queue-Id: 94E22360D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 8:21=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
>
> Hi Ilpo,
>
> On Fri, 2026-03-27 at 13:25 +0200, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 27 Mar 2026, Rong Zhang wrote:
> >
> > > Currently, lenovo-wmi-gamezone depends on lenovo-wmi-other as the for=
mer
> > > imports symbols from the latter. The imported symbols are just used t=
o
> > > register a notifier block. However, there is no runtime dependency
> > > between both drivers, and either of them can run without the other,
> > > which is the major purpose of using the notifier framework.
> > >
> > > Such a link-time dependency is non-optimal. A previous attempt to "fi=
x"
> > > it made LENOVO_WMI_GAMEZONE select LENOVO_WMI_TUNING, which was
> > > fundamentally broken and resulted in undefined Kconfig behavior, as
> > > `select' cannot be used on a symbol with potentially unmet dependenci=
es.
> > >
> > > Decouple both drivers by moving the thermal mode notifier chain to
> > > lenovo-wmi-helpers. Methods for notifier block (un)registration are
> > > exported for lenovo-wmi-gamezone, while a method for querying the
> > > current thermal mode are exported for lenovo-wmi-other.
> > >
> > > This turns the dependency graph from
> > >
> > >             +------------ lenovo-wmi-gamezone
> > >             |                     |
> > >             v                     |
> > >     lenovo-wmi-helpers            |
> > >             ^                     |
> > >             |                     V
> > >             +------------ lenovo-wmi-other
> > >
> > > into
> > >
> > >             +------------ lenovo-wmi-gamezone
> > >             |
> > >             v
> > >     lenovo-wmi-helpers
> > >             ^
> > >             |
> > >             +------------ lenovo-wmi-other
> > >
> > > To make it clear, the name of the notifier chain is also renamed from
> > > `om_chain_head' to `tm_chain_head', indicating that it's used to quer=
y
> > > the current thermal mode.
> > >
> > > No functional change intended.
> > >
> > > Fixes: 6e38b9fcbfa3 ("platform/x86: lenovo: gamezone needs "other mod=
e"")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202603252259.gHvJDyh3-l=
kp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202603260302.X0NjQOda-l=
kp@intel.com/
> > > Signed-off-by: Rong Zhang <i@rong.moe>
> > > ---
> > >  drivers/platform/x86/lenovo/Kconfig        |   1 -
> > >  drivers/platform/x86/lenovo/wmi-gamezone.c |   4 +-
> > >  drivers/platform/x86/lenovo/wmi-helpers.c  | 102 +++++++++++++++++++=
+
> > >  drivers/platform/x86/lenovo/wmi-helpers.h  |   8 ++
> > >  drivers/platform/x86/lenovo/wmi-other.c    | 104 +------------------=
--
> > >  drivers/platform/x86/lenovo/wmi-other.h    |  16 ----
> > >  6 files changed, 113 insertions(+), 122 deletions(-)
> > >  delete mode 100644 drivers/platform/x86/lenovo/wmi-other.h
> > >
> > > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x=
86/lenovo/Kconfig
> > > index f885127b007f..09b1b055d2e0 100644
> > > --- a/drivers/platform/x86/lenovo/Kconfig
> > > +++ b/drivers/platform/x86/lenovo/Kconfig
> > > @@ -252,7 +252,6 @@ config LENOVO_WMI_GAMEZONE
> > >     select ACPI_PLATFORM_PROFILE
> > >     select LENOVO_WMI_EVENTS
> > >     select LENOVO_WMI_HELPERS
> > > -   select LENOVO_WMI_TUNING
> > >     help
> > >       Say Y here if you have a WMI aware Lenovo Legion device and wou=
ld like to use the
> > >       platform-profile firmware interface to manage power usage.
> > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/pla=
tform/x86/lenovo/wmi-gamezone.c
> > > index c7fe7e3c9f17..92020225db27 100644
> > > --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> > > @@ -23,7 +23,6 @@
> > >  #include "wmi-events.h"
> > >  #include "wmi-gamezone.h"
> > >  #include "wmi-helpers.h"
> > > -#include "wmi-other.h"
> > >
> > >  #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> > >
> > > @@ -383,7 +382,7 @@ static int lwmi_gz_probe(struct wmi_device *wdev,=
 const void *context)
> > >             return ret;
> > >
> > >     priv->mode_nb.notifier_call =3D lwmi_gz_mode_call;
> > > -   return devm_lwmi_om_register_notifier(&wdev->dev, &priv->mode_nb)=
;
> > > +   return devm_lwmi_tm_register_notifier(&wdev->dev, &priv->mode_nb)=
;
> > >  }
> > >
> > >  static const struct wmi_device_id lwmi_gz_id_table[] =3D {
> > > @@ -405,7 +404,6 @@ module_wmi_driver(lwmi_gz_driver);
> > >
> > >  MODULE_IMPORT_NS("LENOVO_WMI_EVENTS");
> > >  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> > > -MODULE_IMPORT_NS("LENOVO_WMI_OTHER");
> > >  MODULE_DEVICE_TABLE(wmi, lwmi_gz_id_table);
> > >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > >  MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> > > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/plat=
form/x86/lenovo/wmi-helpers.c
> > > index 7379defac500..5a88bccb5037 100644
> > > --- a/drivers/platform/x86/lenovo/wmi-helpers.c
> > > +++ b/drivers/platform/x86/lenovo/wmi-helpers.c
> > > @@ -21,11 +21,16 @@
> > >  #include <linux/errno.h>
> > >  #include <linux/export.h>
> > >  #include <linux/module.h>
> > > +#include <linux/notifier.h>
> > >  #include <linux/unaligned.h>
> > >  #include <linux/wmi.h>
> > >
> > > +#include "wmi-gamezone.h"
> > >  #include "wmi-helpers.h"
> > >
> > > +/* Thermal mode notifier chain. */
> > > +static BLOCKING_NOTIFIER_HEAD(tm_chain_head);
> > > +
> > >  /**
> > >   * lwmi_dev_evaluate_int() - Helper function for calling WMI methods=
 that
> > >   * return an integer.
> > > @@ -84,6 +89,103 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev=
, u8 instance, u32 method_id,
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_int, "LENOVO_WMI_HELPERS");
> > >
> > > +/**
> > > + * lwmi_tm_register_notifier() - Add a notifier to the blocking noti=
fier chain
> > > + * @nb: The notifier_block struct to register
> > > + *
> > > + * Call blocking_notifier_chain_register to register the notifier bl=
ock to the
> > > + * thermal mode notifier chain.
> > > + *
> > > + * Return: 0 on success, %-EEXIST on error.
> > > + */
> > > +int lwmi_tm_register_notifier(struct notifier_block *nb)
> > > +{
> > > +   return blocking_notifier_chain_register(&tm_chain_head, nb);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_register_notifier, "LENOVO_WMI_HELPERS"=
);
> > > +
> > > +/**
> > > + * lwmi_tm_unregister_notifier() - Remove a notifier from the blocki=
ng notifier
> > > + * chain.
> > > + * @nb: The notifier_block struct to register
> > > + *
> > > + * Call blocking_notifier_chain_unregister to unregister the notifie=
r block from the
> > > + * thermal mode notifier chain.
> > > + *
> > > + * Return: 0 on success, %-ENOENT on error.
> > > + */
> > > +int lwmi_tm_unregister_notifier(struct notifier_block *nb)
> > > +{
> > > +   return blocking_notifier_chain_unregister(&tm_chain_head, nb);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_unregister_notifier, "LENOVO_WMI_HELPER=
S");
> > > +
> > > +/**
> > > + * devm_lwmi_tm_unregister_notifier() - Remove a notifier from the b=
locking
> > > + * notifier chain.
> > > + * @data: Void pointer to the notifier_block struct to register.
> > > + *
> > > + * Call lwmi_tm_unregister_notifier to unregister the notifier block=
 from the
> > > + * thermal mode notifier chain.
> > > + *
> > > + * Return: 0 on success, %-ENOENT on error.
> > > + */
> > > +static void devm_lwmi_tm_unregister_notifier(void *data)
> > > +{
> > > +   struct notifier_block *nb =3D data;
> > > +
> > > +   lwmi_tm_unregister_notifier(nb);
> > > +}
> > > +
> > > +/**
> > > + * devm_lwmi_tm_register_notifier() - Add a notifier to the blocking=
 notifier
> > > + * chain.
> > > + * @dev: The parent device of the notifier_block struct.
> > > + * @nb: The notifier_block struct to register
> > > + *
> > > + * Call lwmi_tm_register_notifier to register the notifier block to =
the
> > > + * thermal mode notifier chain. Then add devm_lwmi_tm_unregister_not=
ifier
> > > + * as a device managed action to automatically unregister the notifi=
er block
> > > + * upon parent device removal.
> > > + *
> > > + * Return: 0 on success, or an error code.
> > > + */
> > > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > > +                              struct notifier_block *nb)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret =3D lwmi_tm_register_notifier(nb);
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   return devm_add_action_or_reset(dev, devm_lwmi_tm_unregister_noti=
fier,
> > > +                                   nb);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(devm_lwmi_tm_register_notifier, "LENOVO_WMI_HEL=
PERS");
> > > +
> > > +/**
> > > + * lwmi_tm_notifier_call() - Call functions for the notifier call ch=
ain.
> > > + * @mode: Pointer to a thermal mode enum to retrieve the data from.
> > > + *
> > > + * Call blocking_notifier_call_chain to retrieve the thermal mode fr=
om the
> > > + * lenovo-wmi-gamezone driver.
> > > + *
> > > + * Return: 0 on success, or an error code.
> > > + */
> > > +int lwmi_tm_notifier_call(enum thermal_mode *mode)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret =3D blocking_notifier_call_chain(&tm_chain_head,
> > > +                                      LWMI_GZ_GET_THERMAL_MODE, &mod=
e);
> > > +   if ((ret & ~NOTIFY_STOP_MASK) !=3D NOTIFY_OK)
> > > +           return -EINVAL;
> > > +
> > > +   return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(lwmi_tm_notifier_call, "LENOVO_WMI_HELPERS");
> > > +
> > >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > >  MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/plat=
form/x86/lenovo/wmi-helpers.h
> > > index 20fd21749803..651a039228ed 100644
> > > --- a/drivers/platform/x86/lenovo/wmi-helpers.h
> > > +++ b/drivers/platform/x86/lenovo/wmi-helpers.h
> > > @@ -7,6 +7,8 @@
> > >
> > >  #include <linux/types.h>
> > >
> > > +struct device;
> > > +struct notifier_block;
> > >  struct wmi_device;
> > >
> > >  struct wmi_method_args_32 {
> > > @@ -17,4 +19,10 @@ struct wmi_method_args_32 {
> > >  int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 =
method_id,
> > >                       unsigned char *buf, size_t size, u32 *retval);
> > >
> > > +int lwmi_tm_register_notifier(struct notifier_block *nb);
> > > +int lwmi_tm_unregister_notifier(struct notifier_block *nb);
> > > +int devm_lwmi_tm_register_notifier(struct device *dev,
> > > +                              struct notifier_block *nb);
> > > +int lwmi_tm_notifier_call(enum thermal_mode *mode);
> >
> > This enum is not introduced earlier within this header?
>
> Hmm, no. Declaring a opaque enum earlier should be enough to fix it, as
> wmi-gamezone.h shouldn't be included here. Derek, what do you think?

I think it makes more sense at this point to move everything from
wmi_gamezone.h into wmi_helpers.h. This prevents wmi_capdata.c from
needing to import wmi_gamezone.h, since the thermal mode enum will be
moved (now used by capdata, gamezone, and other). Then the only thing
in the gamezone header would be the gamezone_events_type enum, which
is only used by gamezone and helpers anyway, so that can safely move
and we can delete the entire file. To make that enum name more generic
I'll rename it in the move from gamezone_events_type to
lwmi_event_type (the enum isn't directly referenced anywhere anyway).

If that works for everyone I'll add one more patch to do the move &
cleanup before  "platform/x86: lenovo-wmi-other: Add lwmi_attr_id()
function" where I'm adding the .._NONE thermal mode. That will keep
the purpose of each patch clean and avoid me needing to modify your
patches too much.

Thanks,
Derek.

> Thanks,
> Rong

