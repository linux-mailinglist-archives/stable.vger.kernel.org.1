Return-Path: <stable+bounces-242190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHwNGHSc82kx5QEAu9opvQ
	(envelope-from <stable+bounces-242190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:16:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCA4A6C39
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD7F3022FBB
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEA47B406;
	Thu, 30 Apr 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="pq7r7E3B"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7546AF21;
	Thu, 30 Apr 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572962; cv=pass; b=UHcHKPlLpfKsfPcxF3b1PrH4BYTmQcGOPmDMBA9Hkvj52frNpu5vHFIhCqi4HUSYBh9UY/VBzibwg0HZdtG5WIZs1BAjC8stN7FrnfobCgv+e8Eond/idIJ1hIcL16fuUMNt6jSs45pIlqlzOWIBxhe+5TwL584lpRjR8jxWiMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572962; c=relaxed/simple;
	bh=mCf4AaTYi/gXyO034hCcH04yGG1e/G2ZsWlg0y4dDmU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pk/ndWZ3ncujA/j+apENorZgbGEyb1zxrfZKgP0GPJy2mjewqqgorR6bpcHC2a1LfengPwwE5LPy3TCenf95nSJG/WlN4NamNZP2y0tqnRBXkbQ2wB6B2g6Mc+hG09hgIy1AgdjDFIArfTVPp+hwNnLIBn35gVUs1PYdc1IfvGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=pq7r7E3B; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1777572951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d661YFcXVTWLrMshK1pbPLTfpT24NY5f7DDHe8FbM5w3BamcPBg98otNuBz6O3JA3S72JuNqJPQzFhgk4QzsWc+ClMiAVvUiaD/6y4HdgUroVPZ+i7WLoCrByw+HGysneA/YsP4S8TLYq5CajRcH3dpW6XEtTih/xBPTK5P5uIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777572951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cj5Mp0fk5sz1fvgYnGU9nSyBpwp/Vp6go4TlSjYCrDs=; 
	b=OuzcpxyGYtOLUBh2deiZ+z2qNafbRqxCaNQIHoyOiVVzIVLfej+q8UEWQu8wG+JfCB6UOJ5YzP8LL/pm8FqDcNx+zMudDJpmIHEO9RV6DjmsyMMiiKTj6gWiF5+UtuB3lrY0xXfYGPjQqApWeMnRk7QCzfH8PN5diKzzXfEd+b4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777572951;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=Cj5Mp0fk5sz1fvgYnGU9nSyBpwp/Vp6go4TlSjYCrDs=;
	b=pq7r7E3Bzjt7Osx6rIWahiHrcBMBW+FSeap92BvUkt/RQVZ/lmb5dajGqMqez8zW
	am4G7y9VlaDtDTTXw06KcVL+Cdnq0TIKIu8O2mGoYfN+rl2JOZ6nCMYROg3IXrWzhPh
	1py1MNfltKfNEjLyomT5YzfGCwE8raJzVUjcMrRHYLQoueWnOSYr3l1FRnrKeVqTLaZ
	7chXcEmh4QCs/f/FZxSjPAxXQE4fz9m/LTzzfEWrN+PB1lj9WAUiUjCaqSsraGjQtIB
	3lppgKXc9nhd8jpR/60UMI/fo5Q1ctpG+KOvgTO26CjhDuBtAtkl6Wd/pqZz9EjDFcl
	XtNwySbhtA==
Received: by mx.zohomail.com with SMTPS id 1777572947936673.0187289364471;
	Thu, 30 Apr 2026 11:15:47 -0700 (PDT)
Message-ID: <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe>
Subject: Re: [PATCH v10 06/16] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
From: Rong Zhang <i@rong.moe>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,  Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet
 <corbet@lwn.net>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
In-Reply-To: <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>
	 <20260412211121.2220556-7-derekjohn.clark@gmail.com>
	 <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com>
	 <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 02:10:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External
X-Rspamd-Queue-Id: BFFCA4A6C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242190-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rong.moe:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,rong.moe:dkim,rong.moe:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

Hi Derek,

On Thu, 2026-04-30 at 07:56 -0700, Derek J. Clark wrote:
> On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@lin=
ux.intel.com> wrote:
> > On Sun, 12 Apr 2026, Derek J. Clark wrote:
> >=20
> > > Adds lwmi_is_attr_01_supported, and only creates the attribute subfol=
der
> > > if the attribute is supported by the hardware. Due to some poorly
> > > implemented BIOS this is a multi-step sequence of events. This is
> > > because:
> > > - Some BIOS support getting the capability data from custom mode (0xf=
f),
> > >   while others only support it in no-mode (0x00).
> > > - Some BIOS support get/set for the current value from custom mode (0=
xff),
> > >   while others only support it in no-mode (0x00).
> > > - Some BIOS report capability data for a method that is not fully
> > >   implemented.
> > > - Some BIOS have methods fully implemented, but no complimentary
> > >   capability data.
> > >=20
> > > To ensure we only expose fully implemented methods with corresponding
> > > capability data, we check each outcome before reporting that an
> > > attribute can be supported.
> > >=20
> > > Checking for lwmi_is_attr_01_supported during remove is not done to
> > > ensure that we don't attempt to call cd01 or send WMI events if one o=
f
> > > the interfaces being removed was the cause of the driver unloading.
> > >=20
> > > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver"=
)
> > > Reported-by: Kurt Borja <kuurtb@gmail.com>
> > > Closes: https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3NSE=
HMZ6J7XRC@gmail.com/
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Rong Zhang <i@rong.moe>
> > > Tested-by: Rong Zhang <i@rong.moe>
> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > ---
> > > v7:
> > >   - Move earlier in the series. This required dropping the use of
> > >     lwmi_attr_id as it will be added later.
> > >   - Add missing switch between cd_mode_id and cv_mode_id in
> > >     current_value_store.
> > > v6:
> > >   - Zero initialize args in lwmi_is_attr_01_supported.
> > >   - Fix formatting.
> > > v5:
> > >   - Move cv/cd_mode_id refrences from path 3/4.
> > >   - Add missing import for ARRAY_SIZE.
> > >   - Make lwmi_is_attr_01_supported return bool instead of u32.
> > >   - Various formatting fixes.
> > > v4:
> > >   - Use for loop instead of backtrace gotos for checking if an attrib=
ute
> > >     is supported.
> > >   - Add include for dev_printk.
> > >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
> > >   - Don't use symmetric cleanup of attributes in error states.
> > > ---
> > >  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
> > >  drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++++++-=
--
> > >  2 files changed, 98 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/pla=
tform/x86/lenovo/wmi-gamezone.h
> > > index 6b163a5eeb95..ddb919cf6c36 100644
> > > --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> > > @@ -10,6 +10,7 @@ enum gamezone_events_type {
> > >  };
> > > =20
> > >  enum thermal_mode {
> > > +	LWMI_GZ_THERMAL_MODE_NONE =3D	   0x00,
> > >  	LWMI_GZ_THERMAL_MODE_QUIET =3D	   0x01,
> > >  	LWMI_GZ_THERMAL_MODE_BALANCED =3D	   0x02,
> > >  	LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
> > > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platfo=
rm/x86/lenovo/wmi-other.c
> > > index 50a03f5fd6ab..29d062a1c6dc 100644
> > > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
> > >  	u8 feature_id;
> > >  	u8 device_id;
> > >  	u8 type_id;
> > > +	u8 cd_mode_id; /* mode arg for searching capdata */
> > > +	u8 cv_mode_id; /* mode arg for set/get current_value */
> > >  };
> > > =20
> > >  static struct tunable_attr_01 ppt_pl1_spl =3D {
> > > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct ko=
bject *kobj,
> > >  	struct wmi_method_args_32 args =3D {};
> > >  	struct capdata01 capdata;
> > >  	enum thermal_mode mode;
> > > -	u32 attribute_id;
> > >  	u32 value;
> > >  	int ret;
> > > =20
> > > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct =
kobject *kobj,
> > >  	if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
> > >  		return -EBUSY;
> > > =20
> > > -	attribute_id =3D
> > > -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> > > -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > > -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > > -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > +	args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > =20
> > > -	ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata)=
;
> > > +	ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct k=
object *kobj,
> > >  	if (value < capdata.min_value || value > capdata.max_value)
> > >  		return -EINVAL;
> > > =20
> > > -	args.arg0 =3D attribute_id;
> > > +	args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> >=20
> > It's already repeated a few times and you're adding more in this patch.
> >=20
> > We should have a helper function for this encoding as it seems to=20
> > repeat. That is, something that takes tunable_attr and mode as input
> > (the conversion of existing entries should be in own patch preceeding=
=20
> > this fix patch).
> >=20
>=20
> Hi Ilpo,
>=20
> A function for that is added in patch 10, though it is slightly modified =
from that to be more flexible is tunable_attr isn't used (such as with the =
fan test attributes)
>=20
> Originally I had that patch preceding any additions, but after discussing=
 with Rong we felt like it would be easier for stable backports if all the =
fixes were upfront. I can certainly move it back if you still prefer.

Moving it back is OK for me, too.

I think exposing non-fully-functioning fw-attrs on stable/LTS kernels
should be acceptable as long as reading/writing these attributes doesn't
break anything, which is exactly the case now (i.e., without this
patch).

Thanks a lot for your hard work in this series,
Rong

>=20
> Thanks,
> Derek
>=20
>=20
> > >  	args.arg1 =3D value;
> > > =20
> > >  	ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_S=
ET,
> > > @@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kob=
ject *kobj,
> > >  	struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
> > >  	struct wmi_method_args_32 args =3D {};
> > >  	enum thermal_mode mode;
> > > -	u32 attribute_id;
> > >  	int retval;
> > >  	int ret;
> > > =20
> > > @@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct k=
object *kobj,
> > >  	if (ret)
> > >  		return ret;
> > > =20
> > > -	attribute_id =3D
> > > -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> > > -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > > -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > > -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > +	/* If "no-mode" is the supported mode, ensure we never send current=
 mode */
> > > +	if (tunable_attr->cv_mode_id =3D=3D LWMI_GZ_THERMAL_MODE_NONE)
> > > +		mode =3D tunable_attr->cv_mode_id;
> > > =20
> > > -	args.arg0 =3D attribute_id;
> > > +	args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > =20
> > >  	ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_G=
ET,
> > >  				    (unsigned char *)&args, sizeof(args),
> > > @@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct ko=
bject *kobj,
> > >  	return sysfs_emit(buf, "%d\n", retval);
> > >  }
> > > =20
> > > +/**
> > > + * lwmi_attr_01_is_supported() - Determine if the given attribute is=
 supported.
> > > + * @tunable_attr: The attribute to verify.
> > > + *
> > > + * First check if the attribute has a corresponding capdata01 table =
in the cd01
> > > + * module under the "custom" mode (0xff). If that is not present the=
n check if
> > > + * there is a corresponding "no-mode" (0x00) entry. If either of tho=
se passes,
> > > + * check capdata->supported for values > 0. If capdata is available,=
 attempt to
> > > + * determine the set/get mode for the current value property using a=
 similar
> > > + * pattern. If the value returned by either custom or no-mode is 0, =
or we get
> > > + * an error, we assume that mode is not supported. If any of the abo=
ve checks
> > > + * fail then the attribute is not fully supported.
> > > + *
> > > + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr f=
or later
> > > + * reference.
> > > + *
> > > + * Return: bool.
> > > + */
> > > +static bool lwmi_attr_01_is_supported(struct tunable_attr_01 *tunabl=
e_attr)
> > > +{
> > > +	u8 modes[2] =3D { LWMI_GZ_THERMAL_MODE_CUSTOM, LWMI_GZ_THERMAL_MODE=
_NONE };
> > > +	struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
> > > +	struct wmi_method_args_32 args =3D {};
> > > +	bool cd_mode_found =3D false;
> > > +	bool cv_mode_found =3D false;
> > > +	struct capdata01 capdata;
> > > +	int retval, ret, i;
> > > +
> > > +	/* Determine tunable_attr->cd_mode_id*/
> > > +	for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
> > > +		args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devi=
ce_id) |
> > > +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) =
|
> > > +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> > > +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > +
> > > +		ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> > > +		if (ret || !capdata.supported)
> > > +			continue;
> > > +		tunable_attr->cd_mode_id =3D modes[i];
> > > +		cd_mode_found =3D true;
> > > +		break;
> > > +	}
> > > +
> > > +	if (!cd_mode_found)
> > > +		return cd_mode_found;
> > > +
> > > +	dev_dbg(tunable_attr->dev,
> > > +		"cd_mode_id: %#010x\n", args.arg0);
> > > +
> > > +	/* Determine tunable_attr->cv_mode_id, returns 1 if supported*/
> > > +	for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
> > > +		args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devi=
ce_id) |
> > > +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) =
|
> > > +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> > > +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > +
> > > +		ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_=
GET,
> > > +					    (unsigned char *)&args, sizeof(args),
> > > +					    &retval);
> > > +		if (ret || !retval)
> > > +			continue;
> > > +		tunable_attr->cv_mode_id =3D modes[i];
> > > +		cv_mode_found =3D true;
> > > +		break;
> > > +	}
> > > +
> > > +	if (!cv_mode_found)
> > > +		return cv_mode_found;
> > > +
> > > +	dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support l=
evel: %#010x\n",
> > > +		args.arg0, capdata.supported);
> > > +
> > > +	return capdata.supported > 0 ? true : false;
> > > +}
> > > +
> > >  /* Lenovo WMI Other Mode Attribute macros */
> > >  #define __LWMI_ATTR_RO(_func, _name)                                =
  \
> > >  	{                                                             \
> > > @@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om=
_priv *priv)
> > >  	}
> > > =20
> > >  	for (i =3D 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
> > > +		cd01_attr_groups[i].tunable_attr->dev =3D &priv->wdev->dev;
> > > +		if (!lwmi_attr_01_is_supported(cd01_attr_groups[i].tunable_attr))
> > > +			continue;
> > > +
> > >  		err =3D sysfs_create_group(&priv->fw_attr_kset->kobj,
> > >  					 cd01_attr_groups[i].attr_group);
> > >  		if (err)
> > >  			goto err_remove_groups;
> > > -
> > > -		cd01_attr_groups[i].tunable_attr->dev =3D &priv->wdev->dev;
> > >  	}
> > >  	return;
> > > =20
> > >=20
> >=20

