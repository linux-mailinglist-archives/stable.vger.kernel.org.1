Return-Path: <stable+bounces-235738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BHTOThv2mn02QgAu9opvQ
	(envelope-from <stable+bounces-235738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:56:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A95213E0B95
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B07793053295
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286593A963E;
	Sat, 11 Apr 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWrdfzaJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDE3A7595
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775922875; cv=pass; b=L6uAAqwI70idbssFVPEpPEH4jXudUjnMy06mQJ+3VRAEoG368jIsheyOYGbX7ZAXj8uBj/ZQB3mdLBKZxRuckou7OSlGMfROrKFYuYqPugphZjAybGSF8O6q0XvXK9N6UghL1Kedle2RP2e10s0jaxxrjK8j+d+FZZ59tuJn/hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775922875; c=relaxed/simple;
	bh=wnFTSL5+5AvqU1zw0FEeS0hEKxpvnDpxKGI1rQHHzSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHhaEYtBGhxrMZj4fOMYmjyDQMXt0p2SrzbIYMUlT2xmGAd69USEtmZQjTlZAoLRbj0fUFl15LN6Splw6ug5ugmWdf7qxv1tWvMqD3yB5KhtR9NT6/ZBac8/CCIwepdLVD59M/2ZaU2yM0XWXVjgxx7ImM4WEGRLszpr08lGCD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWrdfzaJ; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89cc797547fso38274566d6.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922872; cv=none;
        d=google.com; s=arc-20240605;
        b=Adxr6Y/nSbIrpdoO0rf9IQT7LSj7JUJF+G5JAcrGQBcodlfPOfLVX96eTBWIwgG/Uc
         p1ViKhF9y9DvMUed255Vn9WkKRFJHapIOvVbOevN447JE5TH+Qb3/IOoQGCLxx1KUvBa
         mfaFiIpO+BqWEZXnLu2pP6EexiLoJktvjWU8D9MqjI6C9ILYzGeJN/4Tg/RdvP5u1pVv
         nife+fy8cTyijMf0EqFKIyRK+h3cBNGswFQ/oIsQnZTutXrDK3eeKOAO14BKuya+SXuU
         kFZEC4p0XQyGOQDEOw2S7bJZVGB0eB6/TZh0ffS3HkfMnCwyK4TOwZspT+Aq3mmk6zrC
         6yIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XdA/ZLC4RhdlMmk5sZOK048aLbs3qsqStKVz7rhwQwU=;
        fh=W/JE46uAnM/JUl/sf6lUsD6W/LXmgPhghXtAcR1kcRE=;
        b=grPMiG4ZWPt65pIu/KLl6IssROwOsWR3F1ZLuchFoiDrcQCPNSji1xyZ4hBI6TCu0R
         K6gHURkhWuIg+gRWfCDjXp0GfEW0JR0c+IZvkU1UHbmJ90mbVod5vTB9EnMyvh7BLYhA
         XeoYGOckSoqwm42OFfT/TOb3lUCETEkn9lhapon47eCahrmYylpUZZ92/byeXnSM4Y27
         pmJAWatL/zlB4VDGbyz4+OStBbz6YPIwE1sYY4nbhnK/lV3WaBxKpe/AKQx+lVs95wYG
         iegRVHB4fhxlIn23v7h/+8lzSmfBU29YcQXPg8HaHJuWDc9DArUpYiMR3VQRnHoZgrWq
         S46g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775922872; x=1776527672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdA/ZLC4RhdlMmk5sZOK048aLbs3qsqStKVz7rhwQwU=;
        b=cWrdfzaJZZrEKWMEK5G+AB0SG1P1AaaBxY7jSG4g6bsD6aMgTsJeHI6s59gt0Bmwxv
         XcNcnXBCJJXsLlJes1RY53NMJATWp/8GRWKDtOJyE0SrriibpsJVvLCe3ZT8OygSbLam
         QNPEH3tFaEYNevkbMxOG++OzjlKJVQzp9INEXjEb92th6zGZIcf/4k0vDr39lDErJu91
         xmFT3+MmsZ/4neOvp2TxekraY+EIlBVp07vY8PJneUMkaaU7j8uhGumk/ALGts4Z9ODp
         0q/2JYhfZvNBCilwVgEnJKVw/mTBs4tcVKQQwbIiHEaexNKlbEfizZ7va2alxQK9ZUYk
         ry9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775922872; x=1776527672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdA/ZLC4RhdlMmk5sZOK048aLbs3qsqStKVz7rhwQwU=;
        b=AQYLxpKOF9PBQKRe77zXefuf3CVs3YwOlOcpaD/n+ot910vQhUGqj3eeiUCGIbQsLa
         lFp0k6Yx4uzbXX8UFMbqM7fVp5JU3nId1+98E/SpS9cSCGLVQYZppLoJCEwQrv+q2LuL
         5I+sDM6sjhQMMqABcje5b7p/vNNd4k8Ib5yii1f9QEphfLxNL5JuiAMsUIZFOAftmXuY
         U8o3qwqT5Zp7Kgpnolz9f6PptXYzGgssEDcb11O121Mz13rbIBrhL4twvYPTD/prPUbL
         RgMO5gQ4hm/QKW84IPoQQ7VbwfMi9l9nFPP+OHNbempHxn8seGeBULcpdr1ofiyN5gBB
         NbJw==
X-Forwarded-Encrypted: i=1; AJvYcCWFQmvQYrciGcClDG0BTRIdBjj9Kio/eIoHJ04FfhQnKSOYsMqcddJqQwtAQ7z727qQPpKODDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRC/fYYB96xNgIeV6zUfMvFlyM3NJdQ7GrKbl38jtHElRTRE48
	1cVysfRYBe+gDTexatGepvnGeanOPdAJQat7QV6ckIC06lJgHeFs8vaDDLVf70/LIgAqk7mMBpl
	UiYdCz32n3ukqSZ2v585p8oEv8P6i0jU=
X-Gm-Gg: AeBDieuPFqeTrr0nH0mAHDwUiF0PdW2d3GwM7w/piNdfmplTgIYQNzOnfp4um5NgD3B
	VRQvgCTQUUBkknkVBvfPqYyKyQRpXvupJFONr50nkOBvD+jJcgJxXX9aSLV2dimysU3JYF7x/ys
	FN0WFonTwLqeKh1VsL3SQCoGPeGRoPHtGhlp4d1/aSP7goNRarrwleisP1OHaZ2vZGI3uJKc9zE
	QxThLFC5QDaA0tDjrshRnCPjh0O9XQWmQHQ9qNy9iqnkr0Sku4lkeTt75lyc0j1uMBQMBw8vaeA
	NkUlzp2azxFDdpxQNEg=
X-Received: by 2002:a05:6214:2b86:b0:89c:5e9c:4158 with SMTP id
 6a1803df08f44-8ac860efeaamr115004046d6.18.1775922872028; Sat, 11 Apr 2026
 08:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
 <20260401190221.1595264-2-i@rong.moe> <6a796411-67b4-943b-f8aa-1e5f6b0b2c97@linux.intel.com>
In-Reply-To: <6a796411-67b4-943b-f8aa-1e5f6b0b2c97@linux.intel.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 11 Apr 2026 08:54:21 -0700
X-Gm-Features: AQROBzAW3_jb7iBeg_RoPELa2yh8qdd48j14mkjbuYYcSS-TIAvYhm8zUKWTldM
Message-ID: <CAFqHKT=O4h=w_3kNqEArd9su=4kK2qwdPDJ=4CsWrv-PWEQwWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: lenovo-wmi-other: Balance IDA id
 allocation and free
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>, Hans de Goede <hansg@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Jonathan Corbet <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235738-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[rong.moe,kernel.org,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rong.moe:email,intel.com:email]
X-Rspamd-Queue-Id: A95213E0B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 5:30=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 2 Apr 2026, Rong Zhang wrote:
>
> > Currently, the IDA id is only freed on wmi-other device removal or
> > failure to create firmware-attributes device, kset, or attributes. It
> > leaks IDA ids if the wmi-other device is bound multiple times, as the
> > unbind callback never frees the previously allocated IDA id.
> > Additionally, if the wmi-other device has failed to create a
> > firmware-attributes device before it gets removed, the wmi-device
> > removal callback double frees the same IDA id.
> >
> > These bugs were found by sashiko.dev [1].
> >
> > Fix them by moving ida_free() into lwmi_om_fw_attr_remove() so it is
> > balanced with ida_alloc() in lwmi_om_fw_attr_add(). With them fixed,
> > properly set and utilize the validity of priv->ida_id to balance
> > firmware-attributes registration and removal, without relying on
> > propagating the registration error to the component framework, which is
> > more reliable and aligns with the hwmon device registration and removal
> > sequences.
> >
> > No functional change intended.
> >
> > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
> > Cc: stable@vger.kernel.org
> > Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.=
clark%40gmail.com [1]
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  drivers/platform/x86/lenovo/wmi-other.c | 34 +++++++++++++++----------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform=
/x86/lenovo/wmi-other.c
> > index 6040f45aa2b0..b47418df099f 100644
> > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > @@ -957,17 +957,17 @@ static struct capdata01_attr_group cd01_attr_grou=
ps[] =3D {
> >  /**
> >   * lwmi_om_fw_attr_add() - Register all firmware_attributes_class memb=
ers
> >   * @priv: The Other Mode driver data.
> > - *
> > - * Return: Either 0, or an error code.
> >   */
> > -static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
> > +static void lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
> >  {
> >       unsigned int i;
> >       int err;
> >
> >       priv->ida_id =3D ida_alloc(&lwmi_om_ida, GFP_KERNEL);
> > -     if (priv->ida_id < 0)
> > -             return priv->ida_id;
> > +     if (priv->ida_id < 0) {
> > +             err =3D priv->ida_id;
>
> This looks a bit backwards. It would be better to do:
>
>         err =3D ida_alloc(&lwmi_om_ida, GFP_KERNEL);
>         if (err < 0)
> > +             goto err;
>
>         priv->ida_id =3D err;
>
> ...This, btw, tells us why "ret" would have been superior name for the
> generic return variable as it does not carry "error" connotation.
>

I've taken a note of this. In the next series I'll add a patch to
rename any "err" to "ret" for all lenovo wmi drivers. This series is
already getting out of hand though so I don't want to introduce more
complexity at this time. For now I'll just invert the logic as stated.

Thanks,
Derek

> > +     }
> >
> >       priv->fw_attr_dev =3D device_create(&firmware_attributes_class, N=
ULL,
> >                                         MKDEV(0, 0), NULL, "%s-%u",
> > @@ -993,7 +993,7 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv =
*priv)
> >
> >               cd01_attr_groups[i].tunable_attr->dev =3D &priv->wdev->de=
v;
> >       }
> > -     return 0;
> > +     return;
> >
> >  err_remove_groups:
> >       while (i--)
> > @@ -1007,7 +1007,12 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_pr=
iv *priv)
> >
> >  err_free_ida:
> >       ida_free(&lwmi_om_ida, priv->ida_id);
> > -     return err;
> > +
> > +err:
> > +     priv->ida_id =3D -EIDRM;
> > +
> > +     dev_warn(&priv->wdev->dev,
> > +              "failed to register firmware-attributes device: %d\n", e=
rr);
> >  }
> >
> >  /**
> > @@ -1016,12 +1021,17 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_p=
riv *priv)
> >   */
> >  static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
> >  {
> > +     if (priv->ida_id < 0)
> > +             return;
> > +
> >       for (unsigned int i =3D 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; =
i++)
> >               sysfs_remove_group(&priv->fw_attr_kset->kobj,
> >                                  cd01_attr_groups[i].attr_group);
> >
> >       kset_unregister(priv->fw_attr_kset);
> >       device_unregister(priv->fw_attr_dev);
> > +     ida_free(&lwmi_om_ida, priv->ida_id);
> > +     priv->ida_id =3D -EIDRM;
> >  }
> >
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=3D=
=3D=3D=3D=3D=3D */
> > @@ -1063,7 +1073,9 @@ static int lwmi_om_master_bind(struct device *dev=
)
> >
> >       lwmi_om_fan_info_collect_cd00(priv);
> >
> > -     return lwmi_om_fw_attr_add(priv);
> > +     lwmi_om_fw_attr_add(priv);
> > +
> > +     return 0;
> >  }
> >
> >  /**
> > @@ -1115,13 +1127,7 @@ static int lwmi_other_probe(struct wmi_device *w=
dev, const void *context)
> >
> >  static void lwmi_other_remove(struct wmi_device *wdev)
> >  {
> > -     struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
> > -
> >       component_master_del(&wdev->dev, &lwmi_om_master_ops);
> > -
> > -     /* No IDA to free if the driver is never bound to its components.=
 */
> > -     if (priv->ida_id >=3D 0)
> > -             ida_free(&lwmi_om_ida, priv->ida_id);
> >  }
> >
> >  static const struct wmi_device_id lwmi_other_id_table[] =3D {
> >
>
> --
>  i.
>

