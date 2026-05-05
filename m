Return-Path: <stable+bounces-244255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCi3Ghk6+mnHKwMAu9opvQ
	(envelope-from <stable+bounces-244255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F14D2CBD
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF968301E76C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0E248B398;
	Tue,  5 May 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD/jpDYe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A1480943;
	Tue,  5 May 2026 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006547; cv=none; b=d+u1qrfZwbk/qvNuxTvrbUix66cBHHWMZst6lgE1TPzp2eGdpTDv4CmFR5m3dy9cPDYcpgH8Wy07J3MSbJitX4EiA+Xs3+zHh8t1o3LTISE2FWyUTO9GqezLfxBJ7eCLrkdRaiYiN44LhThj1F2Vl8wNCdEm640NjwwCsICDZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006547; c=relaxed/simple;
	bh=WNOvmrvtuNrjardUzpYumuRqnauw/la/yb2e1/PqdDA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sWN+OhgUj9rqo/XWcZ5ovbotKziw8qsoNoem8xLxplif9xKzi6CHbDIX1o3HED2+6AYJbBu9IZoa98EbBWFAy6gXzZANK+itqVelRv0H7LDRkhMe1aw+JCULdxpWSDiezt8mpuW2aYFItWbDZgIktoaJ7qvMfzebD2hWrdKstvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD/jpDYe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778006545; x=1809542545;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WNOvmrvtuNrjardUzpYumuRqnauw/la/yb2e1/PqdDA=;
  b=PD/jpDYeQjInh8tGDuQwr2/mKFRzR6XJN0lmxm9Pg5AOiaZ3c+EIONXx
   coPrYj4qW+2WbLAphO12BMgd3zQUiK/Um6t7oah7Vil+qMf6N+MQBdZGa
   0Bl035NfRvssXWBe9PW1k01uCpkesy0tK36VZEM0Ir+gjGAskCGirRJ5l
   NBAHS9He3g+nWbKt/OOIBpVImOfgxwGklF+v4wgG4+NE6CDhUHc4ALqeH
   1W7XHNwGi5l9V9qPTkuoE112oRSe8DHnbzUpuZVbNeu6kArQvRCJHvgPK
   TlzdMhmclQXQ0JRnIvNn1UrqD74y/AbwSOQjmYrnFZRH3UNmhtQ1gH5qX
   Q==;
X-CSE-ConnectionGUID: X37tuuf5SPiv9MLoDfex+Q==
X-CSE-MsgGUID: WnwpS1EfRweza+9bqrPN2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89482345"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="89482345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 11:42:25 -0700
X-CSE-ConnectionGUID: bisxMB5nQxqpUItjHnQnIA==
X-CSE-MsgGUID: /sh5g3Q4TJGgxs5s6ZGzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="231514770"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.85])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 11:42:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 May 2026 21:42:17 +0300 (EEST)
To: Rong Zhang <i@rong.moe>
cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v10 06/16] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
In-Reply-To: <13A5927F-E79C-4F09-B7D9-92A1C777E5AC@rong.moe>
Message-ID: <e8dac175-42cd-f0e9-a96e-f13cefa05b23@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com> <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com> <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com> <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe>
 <a824cd39-8e28-96db-df59-599c283ffcdb@linux.intel.com> <13A5927F-E79C-4F09-B7D9-92A1C777E5AC@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-585479447-1778006349=:993"
Content-ID: <541c04c7-d1b8-afab-7a25-ed4715d6f183@linux.intel.com>
X-Rspamd-Queue-Id: 092F14D2CBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,squebb.ca,gmx.de,lwn.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244255-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-585479447-1778006349=:993
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c72d7267-8895-0824-ac82-fad29dc22af1@linux.intel.com>

On Wed, 6 May 2026, Rong Zhang wrote:

> Hi Ilpo,
>=20
> =E4=BA=8E 2026=E5=B9=B45=E6=9C=885=E6=97=A5 GMT+08:00 18:25:34=EF=BC=8C"I=
lpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com> =E5=86=99=E9=81=93=EF=BC=
=9A
> >On Fri, 1 May 2026, Rong Zhang wrote:
> >> On Thu, 2026-04-30 at 07:56 -0700, Derek J. Clark wrote:
> >> > On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo.jarvine=
n@linux.intel.com> wrote:
> >> > > On Sun, 12 Apr 2026, Derek J. Clark wrote:
> >> > >=20
> >> > > > Adds lwmi_is_attr_01_supported, and only creates the attribute s=
ubfolder
> >> > > > if the attribute is supported by the hardware. Due to some poorl=
y
> >> > > > implemented BIOS this is a multi-step sequence of events. This i=
s
> >> > > > because:
> >> > > > - Some BIOS support getting the capability data from custom mode=
 (0xff),
> >> > > >   while others only support it in no-mode (0x00).
> >> > > > - Some BIOS support get/set for the current value from custom mo=
de (0xff),
> >> > > >   while others only support it in no-mode (0x00).
> >> > > > - Some BIOS report capability data for a method that is not full=
y
> >> > > >   implemented.
> >> > > > - Some BIOS have methods fully implemented, but no complimentary
> >> > > >   capability data.
> >> > > >=20
> >> > > > To ensure we only expose fully implemented methods with correspo=
nding
> >> > > > capability data, we check each outcome before reporting that an
> >> > > > attribute can be supported.
> >> > > >=20
> >> > > > Checking for lwmi_is_attr_01_supported during remove is not done=
 to
> >> > > > ensure that we don't attempt to call cd01 or send WMI events if =
one of
> >> > > > the interfaces being removed was the cause of the driver unloadi=
ng.
> >> > > >=20
> >> > > > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Dr=
iver")
> >> > > > Reported-by: Kurt Borja <kuurtb@gmail.com>
> >> > > > Closes: https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H=
=2E3NSEHMZ6J7XRC@gmail.com/
> >> > > > Cc: stable@vger.kernel.org
> >> > > > Reviewed-by: Rong Zhang <i@rong.moe>
> >> > > > Tested-by: Rong Zhang <i@rong.moe>
> >> > > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> > > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >> > > > ---
> >> > > > v7:
> >> > > >   - Move earlier in the series. This required dropping the use o=
f
> >> > > >     lwmi_attr_id as it will be added later.
> >> > > >   - Add missing switch between cd_mode_id and cv_mode_id in
> >> > > >     current_value_store.
> >> > > > v6:
> >> > > >   - Zero initialize args in lwmi_is_attr_01_supported.
> >> > > >   - Fix formatting.
> >> > > > v5:
> >> > > >   - Move cv/cd_mode_id refrences from path 3/4.
> >> > > >   - Add missing import for ARRAY_SIZE.
> >> > > >   - Make lwmi_is_attr_01_supported return bool instead of u32.
> >> > > >   - Various formatting fixes.
> >> > > > v4:
> >> > > >   - Use for loop instead of backtrace gotos for checking if an a=
ttribute
> >> > > >     is supported.
> >> > > >   - Add include for dev_printk.
> >> > > >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
> >> > > >   - Don't use symmetric cleanup of attributes in error states.
> >> > > > ---
> >> > > >  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
> >> > > >  drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++=
++++---
> >> > > >  2 files changed, 98 insertions(+), 17 deletions(-)
> >> > > >=20
> >> > > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/driver=
s/platform/x86/lenovo/wmi-gamezone.h
> >> > > > index 6b163a5eeb95..ddb919cf6c36 100644
> >> > > > --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> >> > > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> >> > > > @@ -10,6 +10,7 @@ enum gamezone_events_type {
> >> > > >  };
> >> > > > =20
> >> > > >  enum thermal_mode {
> >> > > > +=09LWMI_GZ_THERMAL_MODE_NONE =3D=09   0x00,
> >> > > >  =09LWMI_GZ_THERMAL_MODE_QUIET =3D=09   0x01,
> >> > > >  =09LWMI_GZ_THERMAL_MODE_BALANCED =3D=09   0x02,
> >> > > >  =09LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
> >> > > > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/p=
latform/x86/lenovo/wmi-other.c
> >> > > > index 50a03f5fd6ab..29d062a1c6dc 100644
> >> > > > --- a/drivers/platform/x86/lenovo/wmi-other.c
> >> > > > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> >> > > > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
> >> > > >  =09u8 feature_id;
> >> > > >  =09u8 device_id;
> >> > > >  =09u8 type_id;
> >> > > > +=09u8 cd_mode_id; /* mode arg for searching capdata */
> >> > > > +=09u8 cv_mode_id; /* mode arg for set/get current_value */
> >> > > >  };
> >> > > > =20
> >> > > >  static struct tunable_attr_01 ppt_pl1_spl =3D {
> >> > > > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(stru=
ct kobject *kobj,
> >> > > >  =09struct wmi_method_args_32 args =3D {};
> >> > > >  =09struct capdata01 capdata;
> >> > > >  =09enum thermal_mode mode;
> >> > > > -=09u32 attribute_id;
> >> > > >  =09u32 value;
> >> > > >  =09int ret;
> >> > > > =20
> >> > > > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(st=
ruct kobject *kobj,
> >> > > >  =09if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
> >> > > >  =09=09return -EBUSY;
> >> > > > =20
> >> > > > -=09attribute_id =3D
> >> > > > -=09=09FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id=
) |
> >> > > > -=09=09FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_=
id) |
> >> > > > -=09=09FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> >> > > > -=09=09FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id)=
;
> >> > > > +=09args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr=
->device_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feat=
ure_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_m=
ode_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type=
_id);
> >> > > > =20
> >> > > > -=09ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &c=
apdata);
> >> > > > +=09ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capd=
ata);
> >> > > >  =09if (ret)
> >> > > >  =09=09return ret;
> >> > > > =20
> >> > > > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(str=
uct kobject *kobj,
> >> > > >  =09if (value < capdata.min_value || value > capdata.max_value)
> >> > > >  =09=09return -EINVAL;
> >> > > > =20
> >> > > > -=09args.arg0 =3D attribute_id;
> >> > > > +=09args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr=
->device_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feat=
ure_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_m=
ode_id) |
> >> > > > +=09=09    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type=
_id);
> >> > >=20
> >> > > It's already repeated a few times and you're adding more in this p=
atch.
> >> > >=20
> >> > > We should have a helper function for this encoding as it seems to=
=20
> >> > > repeat. That is, something that takes tunable_attr and mode as inp=
ut
> >> > > (the conversion of existing entries should be in own patch preceed=
ing=20
> >> > > this fix patch).
> >> > >=20
> >> >=20
> >> > Hi Ilpo,
> >> >=20
> >> > A function for that is added in patch 10, though it is slightly modi=
fied from that to be more flexible is tunable_attr isn't used (such as with=
 the fan test attributes)
> >> >=20
> >> > Originally I had that patch preceding any additions, but after=20
> >> > discussing with Rong we felt like it would be easier for stable=20
> >> > backports if all the fixes were upfront. I can certainly move it bac=
k=20
> >> > if  you still prefer.=20
> >>
> >> Moving it back is OK for me, too.
> >>
> >> I think exposing non-fully-functioning fw-attrs on stable/LTS kernels
> >> should be acceptable as long as reading/writing these attributes doesn=
't
> >> break anything, which is exactly the case now (i.e., without this
> >> patch).
> >
> >How would refactoring the code into a helper result in changing stable=
=20
> >interface?
> >
> >Or did you perhaps move to talk about something entirely else (and I=20
> >ended up losing the context)?
>=20
> I meant the *current* LTS/stable state is acceptable for me as=20
> reading/writing these attributes doesn't break anything. Moving it back=
=20
> would be OK for me even if it made this patch unable to be backported=20
> (though unlikely, since moving it back makes the patch clearer as you've=
=20
> said). In other words, it doesn't matter for me whether the patch is=20
> backported or not.

Hi,

While I'm not a stable maintainer, I think they'd likely take the=20
non-fixes patch together with the fix.

In some cases, there's also benefit from having mainline and stable code=20
closer to each other which helps future backporting. And here the fix=20
patch actually becomes simpler if you do the cleanup first so each change=
=20
can be reviewed independently (its easier to trust correctness of both=20
because the fix change becomes simpler and a "no functional changes=20
intended" patches are typically much simpler to review that those with any=
=20
functional changes).

You can even ask stable people to pick up non-fixes by adding Cc:=20
stable to them.

(TBH, I personally feel that at times stable people do take too many=20
non-fixes, not the other way around.)

> Some context: I didn't ask Derek to add Fixes: tag to this patch or move=
=20
> it. I asked him to rearrange other patches to make them backportable.
>=20
> Sorry for causing misunderstandings.

It's no problem at all. :-)

--=20
 i.
--8323328-585479447-1778006349=:993--

