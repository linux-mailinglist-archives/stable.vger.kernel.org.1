Return-Path: <stable+bounces-233428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKjxEUL+02lbpAcAu9opvQ
	(envelope-from <stable+bounces-233428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A081E3A64CF
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD903017071
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4C391E60;
	Mon,  6 Apr 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AydQfnlb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3838F621
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500863; cv=pass; b=dkPdM90fnufgDNGIITLXdexLeGQpYJHfPmOGfbonMVxH9bNdtHCG9clxUxidWJ2enPhXEdmVpEwviH+Jj5x5LyleCridnqtFBoAtrP2uFA2dr2UicQAqD8WupfQNLi6LpaJ+m4ArLMjHspEVeRBA6jiapJh72xxJ4/N1hGBQbNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500863; c=relaxed/simple;
	bh=itbSgjuM/hijuv8ozRCl7pcwf83pOf92MbcIFgmT+Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OytJwyD6uA8btPd9mZtZ6Y1f5mK+nLfjEVlMH2X25Ks9EmhK37ghehK+w/oOI8mEIEnm276vAdRwzQ+tguTZLM4jcYJRirUD9DzNQ5oRsAmTv4lCVIDFmc+suAPz4jfUqbBfCrgdSxFezID0vXCbmE5+GGlVNKMr+oNlgwqgWOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AydQfnlb; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b2ebca625so44092191cf.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775500860; cv=none;
        d=google.com; s=arc-20240605;
        b=BBXs9/xBN/wgADUZFizgpX9xXOiOQXKpfHmsGPEYdVW4BfpaSdy0iEeLMiLtioZtuK
         aHkH/Z81V5iA3nwwVH2vYcYELaFw8JUGvp5vQrkx9eB5sufsBSHXZRjgfHzm3f4ip6yt
         Nca2wefWfsT3tm8G40qnHfQ0G1+8tQ+7kyQ1ygyiL089ubCYnlRnjUW2S5cjAYoWNeVw
         Nm2Z17uvzV6vircPcgJ/dbywbXAm+ph3d712QhAKgN98lrvz2O9bwrs8LSclzHw0Khgq
         TZDWm8ONJb6Goctxj2XvaPGgnuKQbgUiIAi6IfxUauKHAZg2zW8IOqM6epDEp+huqHyE
         4axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12qt9cAgRuNIzAl41U0jlXVpP16G7YKp6dn4gm822lw=;
        fh=mz3K6FmV/9qEJAsTVqXtRvkqVUsfr7dqqBogfYSAkSA=;
        b=VlEnPsdwPjymaxn4DkJHI0jTc/VO49poNYPH+TKTt6SWIQj/2zQSLs7lJghAQ+FnDo
         hvVjTQjI1whGNW+wlIqQ1k74K3H8nmbkCQtsr5xb9bxuHDTclkhWuf9JLOK6lzKJvTE8
         3esBnnQPFByZJEfFX6DNARlpTdE61qIBKN9ArTsoHqXAqfOQF0L3GNnH0cn2PhwB0S4b
         /rPOgGDQ9QZh+Z9VJBt0oqtpd318eIFCJAbNELetmQvrPT7iDzwYblBu63xasBCvXwkR
         R1tI7nCTmieKdIh457F1OIYbJeMbNaLby1Ud61O5c1zr2N+bDR2LZ1dRL9Py4qUF7y7h
         motQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500860; x=1776105660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12qt9cAgRuNIzAl41U0jlXVpP16G7YKp6dn4gm822lw=;
        b=AydQfnlbzeKN5eS9onfJifq4EXmJBjI0HdaW5lyskiwmuoPTZFr9GMr3Z/m+rBcnxH
         efMcS1csErlE7h6aecMEMxgFbpGxRCK4u1KtWeZKazdQxLxWcnx1p7pfsallVXvy8sf+
         /qV8zvH6qF9f8Z4fPQP5Sw1Dgnxg54ZE5CYglvjbn5lBBcJjA15arGSP44L0Qq+2giNC
         9+tJdrFFs161TJlAdzDxp+9+AP66wHBjwQml+MWfEughQRt/z299ghJm/Fwe9yQIGUWA
         klvE8J2TwjOxT9RfCZo25iFYnfyHsjTsHPTcURvJ7EpCsQPovF3nY7o0eRaZTFRrvhf2
         8PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500860; x=1776105660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12qt9cAgRuNIzAl41U0jlXVpP16G7YKp6dn4gm822lw=;
        b=HrtsnC5qVihYYkEW1A4l2D7adSWvLOhM3qUNRs1EGlWaJ+irqD8EWTohMJZOE6IN3e
         +7FxfBm0qeFxjWjKwSDAPPSmTzl+IGbv/nEXluznIXDLq21WN7jnUHXJ1IKZHfnGhtUC
         yT7+k/hAJYK8ZeRZFR0ajr//cVmBbblFlvPd5A/0SjUIrSODrkm9K2jxRTntOBBfFID9
         mLo29lXSfsBSKJ4HzRvMZC2W2IRaAywaGL/jAJEHMa/jmOfThLALD67F/IWYgmY3Yxzt
         JSR8QBP5zInyG25LgL+C2pKECOgkrT9LdSypp97FAaeNpx3FA50q2C1P1yWFP4aA74Ot
         taxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXGPzu09FPhHbacV6njmE+5G5ak/RpQ8S0PSqL7fXaU+cyW9zB1C1ZRhbO+p542C4bybeXETc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLq82y9lqQQUw+4O6QCVN3WOOWF23+pZGgCld4rc0TdtLuQ30
	f306kOExiiu0wXwNwKbMgYU8vqxvlfujvVJ8m80n5XHlGKknHgADcdhXZ//DuDq9ILKfDCz1FAM
	/CvqcjVW9WSxJLutXirgKUsFy8hWZ7grL2Q==
X-Gm-Gg: AeBDieu8+zgqmPhWiQb31R3JTxuDrQiBZfzrJiykjlQbhDVOaHucJmbhxLRv8QG29Gv
	zYxtPQnMgExt8DJPekJPLBPIu+KdhwOSvt1AoBoFm6iSjcx0skmEXoFkLqgFzfoZctZocKypiCq
	pWnZcwhlDfDeKAl+nOUgidsx3QNUipisFdEyKRsomr7FUYWViVwFhbL6itcQ7fh9CZvBBCu53et
	FRv65z+BAkRoS35FawqPgd38cYg/TkUg1h7my5P2KM77voYwsS4Z1pMAUrlo1NioAPN0vxv0OeP
	E63Kg6+t
X-Received: by 2002:a05:622a:148e:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-50d4fa6ef2cmr215903271cf.11.1775500860318; Mon, 06 Apr 2026
 11:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402032424.678528-1-derekjohn.clark@gmail.com>
 <20260402032424.678528-7-derekjohn.clark@gmail.com> <b1877396-593b-47a0-b84c-30e6f000d759@app.fastmail.com>
In-Reply-To: <b1877396-593b-47a0-b84c-30e6f000d759@app.fastmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 6 Apr 2026 11:40:46 -0700
X-Gm-Features: AQROBzC_8Ralz_vdmumdz6JCRxuHNf5_HKKuypC9_JGBNsDD0aAR7Qq-54o2llE
Message-ID: <CAFqHKTmKpk8+rxhxCyie4G7NC4Bz31Z=iTi8aTR6Sey5So5t1A@mail.gmail.com>
Subject: Re: [PATCH v7 06/16] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
	Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-233428-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A081E3A64CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 4, 2026 at 2:51=E2=80=AFPM Mark Pearson <mpearson-lenovo@squebb=
.ca> wrote:
>
> Hi Derek,
>
> On Wed, Apr 1, 2026, at 11:24 PM, Derek J. Clark wrote:
> > Adds lwmi_is_attr_01_supported, and only creates the attribute subfolde=
r
> > if the attribute is supported by the hardware. Due to some poorly
> > implemented BIOS this is a multi-step sequence of events. This is
> > because:
> > - Some BIOS support getting the capability data from custom mode (0xff)=
,
> >   while others only support it in no-mode (0x00).
> > - Some BIOS support get/set for the current value from custom mode (0xf=
f),
> >   while others only support it in no-mode (0x00).
> > - Some BIOS report capability data for a method that is not fully
> >   implemented.
> > - Some BIOS have methods fully implemented, but no complimentary
> >   capability data.
> >
> > To ensure we only expose fully implemented methods with corresponding
> > capability data, we check each outcome before reporting that an
> > attribute can be supported.
> >
>
> I've been trying to go through this series a bit more carefully, while re=
ading the (not exactly clear) Lenovo internal spec.
> I was curious if the cap00, ID 290000, method would work here? ("Thermal =
Mode Capability")
>
> I don't have systems to try it out on, but it looked like it might give y=
ou which modes are supported (or not). Not sure if it would be more reliabl=
e than the cap01 methods?
>
> Apologies if you've tried this before and it doesn't work - just wanted t=
o check. Nothing wrong (that I can see) with your method below if that's sa=
fer :)

Hi Mark,

That wasn't added until v3.8 of the spec, so most devices won't have
that until gen 11, and it only reports the thermal modes supported. It
doesn't really provide the information we're gathering here, which is
whether or not the given attribute's get/set methods and the
capability data structure include the thermal mode as part of the
command or not. We need to this because some older hardware only
reports any of that information with 0x00 as the thermal mode, some
hardware reports get/set is supported but has no capability data, and
some hardware has capability data but the get/set methods are stubbed
and have no effect.

Perhaps in a later series I can add FID 0x00290000 as a "Step 1" for
the extreme supported function, but I have no hardware to test it with
and I'd rather not delay this series any further for it.

Thanks,
Derek

> Mark
>
> > Checking for lwmi_is_attr_01_supported during remove is not done to
> > ensure that we don't attempt to call cd01 or send WMI events if one of
> > the interfaces being removed was the cause of the driver unloading.
> >
> > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
> > Reported-by: Kurt Borja <kuurtb@gmail.com>
> > Closes:
> > https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3NSEHMZ6J7XRC@=
gmail.com/
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Rong Zhang <i@rong.moe>
> > Tested-by: Rong Zhang <i@rong.moe>
> > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> > v7:
> >   - Move earlier in the series. This required dropping the use of
> >     lwmi_attr_id as it will be added later.
> >   - Add missing switch between cd_mode_id and cv_mode_id in
> >     current_value_store.
> > v6:
> >   - Zero initialize args in lwmi_is_attr_01_supported.
> >   - Fix formatting.
> > v5:
> >   - Move cv/cd_mode_id refrences from path 3/4.
> >   - Add missing import for ARRAY_SIZE.
> >   - Make lwmi_is_attr_01_supported return bool instead of u32.
> >   - Various formatting fixes.
> > v4:
> >   - Use for loop instead of backtrace gotos for checking if an attribut=
e
> >     is supported.
> >   - Add include for dev_printk.
> >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
> >   - Don't use symmetric cleanup of attributes in error states.
> > ---
> >  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
> >  drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++++++---
> >  2 files changed, 98 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h
> > b/drivers/platform/x86/lenovo/wmi-gamezone.h
> > index 6b163a5eeb95..ddb919cf6c36 100644
> > --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> > @@ -10,6 +10,7 @@ enum gamezone_events_type {
> >  };
> >
> >  enum thermal_mode {
> > +     LWMI_GZ_THERMAL_MODE_NONE =3D        0x00,
> >       LWMI_GZ_THERMAL_MODE_QUIET =3D       0x01,
> >       LWMI_GZ_THERMAL_MODE_BALANCED =3D    0x02,
> >       LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
> > diff --git a/drivers/platform/x86/lenovo/wmi-other.c
> > b/drivers/platform/x86/lenovo/wmi-other.c
> > index 0e8a69309ec4..3e7dfe94499b 100644
> > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
> >       u8 feature_id;
> >       u8 device_id;
> >       u8 type_id;
> > +     u8 cd_mode_id; /* mode arg for searching capdata */
> > +     u8 cv_mode_id; /* mode arg for set/get current_value */
> >  };
> >
> >  static struct tunable_attr_01 ppt_pl1_spl =3D {
> > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct
> > kobject *kobj,
> >       struct wmi_method_args_32 args =3D {};
> >       struct capdata01 capdata;
> >       enum thermal_mode mode;
> > -     u32 attribute_id;
> >       u32 value;
> >       int ret;
> >
> > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct
> > kobject *kobj,
> >       if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
> >               return -EBUSY;
> >
> > -     attribute_id =3D
> > -             FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id=
) |
> > -             FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_=
id) |
> > -             FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > -             FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id)=
;
> > +     args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->dev=
ice_id) |
> > +                 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feat=
ure_id) |
> > +                 FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_m=
ode_id) |
> > +                 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type=
_id);
> >
> > -     ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdat=
a);
> > +     ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> >       if (ret)
> >               return ret;
> >
> > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct
> > kobject *kobj,
> >       if (value < capdata.min_value || value > capdata.max_value)
> >               return -EINVAL;
> >
> > -     args.arg0 =3D attribute_id;
> > +     args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->dev=
ice_id) |
> > +                 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feat=
ure_id) |
> > +                 FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_m=
ode_id) |
> > +                 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type=
_id);
> >       args.arg1 =3D value;
> >
> >       ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE=
_SET,
> > @@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kobje=
ct *kobj,
> >       struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
> >       struct wmi_method_args_32 args =3D {};
> >       enum thermal_mode mode;
> > -     u32 attribute_id;
> >       int retval;
> >       int ret;
> >
> > @@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct
> > kobject *kobj,
> >       if (ret)
> >               return ret;
> >
> > -     attribute_id =3D
> > -             FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id=
) |
> > -             FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_=
id) |
> > -             FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > -             FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id)=
;
> > +     /* If "no-mode" is the supported mode, ensure we never send curre=
nt mode */
> > +     if (tunable_attr->cv_mode_id =3D=3D LWMI_GZ_THERMAL_MODE_NONE)
> > +             mode =3D tunable_attr->cv_mode_id;
> >
> > -     args.arg0 =3D attribute_id;
> > +     args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->dev=
ice_id) |
> > +                 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feat=
ure_id) |
> > +                 FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > +                 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type=
_id);
> >
> >       ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE=
_GET,
> >                                   (unsigned char *)&args, sizeof(args),
> > @@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct
> > kobject *kobj,
> >       return sysfs_emit(buf, "%d\n", retval);
> >  }
> >
> > +/**
> > + * lwmi_attr_01_is_supported() - Determine if the given attribute is
> > supported.
> > + * @tunable_attr: The attribute to verify.
> > + *
> > + * First check if the attribute has a corresponding capdata01 table in
> > the cd01
> > + * module under the "custom" mode (0xff). If that is not present then
> > check if
> > + * there is a corresponding "no-mode" (0x00) entry. If either of those
> > passes,
> > + * check capdata->supported for values > 0. If capdata is available,
> > attempt to
> > + * determine the set/get mode for the current value property using a
> > similar
> > + * pattern. If the value returned by either custom or no-mode is 0, or
> > we get
> > + * an error, we assume that mode is not supported. If any of the above
> > checks
> > + * fail then the attribute is not fully supported.
> > + *
> > + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for
> > later
> > + * reference.
> > + *
> > + * Return: bool.
> > + */
> > +static bool lwmi_attr_01_is_supported(struct tunable_attr_01
> > *tunable_attr)
> > +{
> > +     u8 modes[2] =3D { LWMI_GZ_THERMAL_MODE_CUSTOM,
> > LWMI_GZ_THERMAL_MODE_NONE };
> > +     struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
> > +     struct wmi_method_args_32 args =3D { 0x0, 0x0 };
> > +     bool cd_mode_found =3D false;
> > +     bool cv_mode_found =3D false;
> > +     struct capdata01 capdata;
> > +     int retval, ret, i;
> > +
> > +     /* Determine tunable_attr->cd_mode_id*/
> > +     for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
> > +             args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK,
> > tunable_attr->device_id) |
> > +                         FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_at=
tr->feature_id) |
> > +                         FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) =
|
> > +                         FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_at=
tr->type_id);
> > +
> > +             ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &c=
apdata);
> > +             if (ret || !capdata.supported)
> > +                     continue;
> > +             tunable_attr->cd_mode_id =3D modes[i];
> > +             cd_mode_found =3D true;
> > +             break;
> > +     }
> > +
> > +     if (!cd_mode_found)
> > +             return cd_mode_found;
> > +
> > +     dev_dbg(tunable_attr->dev,
> > +             "cd_mode_id: %#010x\n", args.arg0);
> > +
> > +     /* Determine tunable_attr->cv_mode_id, returns 1 if supported*/
> > +     for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
> > +             args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK,
> > tunable_attr->device_id) |
> > +                         FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_at=
tr->feature_id) |
> > +                         FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) =
|
> > +                         FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_at=
tr->type_id);
> > +
> > +             ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATU=
RE_VALUE_GET,
> > +                                         (unsigned char *)&args, sizeo=
f(args),
> > +                                         &retval);
> > +             if (ret || !retval)
> > +                     continue;
> > +             tunable_attr->cv_mode_id =3D modes[i];
> > +             cv_mode_found =3D true;
> > +             break;
> > +     }
> > +
> > +     if (!cv_mode_found)
> > +             return cv_mode_found;
> > +
> > +     dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support
> > level: %#010x\n",
> > +             args.arg0, capdata.supported);
> > +
> > +     return capdata.supported > 0 ? true : false;
> > +}
> > +
> >  /* Lenovo WMI Other Mode Attribute macros */
> >  #define __LWMI_ATTR_RO(_func, _name)                                  =
\
> >       {                                                             \
> > @@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct
> > lwmi_om_priv *priv)
> >       }
> >
> >       for (i =3D 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
> > +             cd01_attr_groups[i].tunable_attr->dev =3D &priv->wdev->de=
v;
> > +             if (!lwmi_attr_01_is_supported(cd01_attr_groups[i].tunabl=
e_attr))
> > +                     continue;
> > +
> >               err =3D sysfs_create_group(&priv->fw_attr_kset->kobj,
> >                                        cd01_attr_groups[i].attr_group);
> >               if (err)
> >                       goto err_remove_groups;
> > -
> > -             cd01_attr_groups[i].tunable_attr->dev =3D &priv->wdev->de=
v;
> >       }
> >       return;
> >
> > --
> > 2.53.0

