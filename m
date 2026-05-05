Return-Path: <stable+bounces-244083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHiHN9LK+Wn3EAMAu9opvQ
	(envelope-from <stable+bounces-244083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:47:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196D4CBC86
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12808316AAB3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6B7339847;
	Tue,  5 May 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFTg4f1o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8023016F5;
	Tue,  5 May 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976743; cv=none; b=tuwW9uohAxha7covYe6e5rjdWVoofGcOcRTi7sjO9BalSDuEePIQj5pPBc8Di34t0EhP9S8T/+BrmJeGKjYHtiFmtFwDKUf4oDHTJxBXqnXznoJOKbZQjH5qvj+9vVbRntd6SJ6hYFH4J0VTwR7xBPRb/AbxAiZ/7YLOZOv9KqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976743; c=relaxed/simple;
	bh=Ad6ELkCuf56OvKBHSd+3doXnGWHGUi+zQs+2lrZMm5I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MViuDW8tdkCpaMszz5FFNpAy1//hm7ZnBd6NlmG3iLmhJ+Qr+Dk0bZVfepzHiJdy1BsOVyMnOUqsdDPnP5G9H9HNiXVkYueWe1O8HLLKSAU1IDMHxH2hF8acm/+hEyGujpCQd7J99Q+GFgN53J2cMpOzx6M1l6OjFRiUjRDZ3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFTg4f1o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777976741; x=1809512741;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ad6ELkCuf56OvKBHSd+3doXnGWHGUi+zQs+2lrZMm5I=;
  b=ZFTg4f1oybL4iLddVUFf8WEzhab0P63Ay+4mzqmJFFl+AuM7N0WnTNNP
   RTHbqJiig8HVmYL02o4ybXAxjNrosudfP6kykQ99PdGpIAc1jF3HQEORV
   CwrSoSZtjD3emzsg0ihFN+Oz0bxQol/gkhuoNROFsXDvkgSsx46MmVc7y
   epBPRD3W+1EzQTn2kLruNHE0u+Oidx4FripRW5lQ708bUbyf9kb5GXbLg
   2ilUFp2ObGMS1BtvnEoFBwq2+NPgbBaQVL2ODdRBWkJM9A+zvWt44dtvh
   0lKDS+vWs8sVBmLMZ/vG7vaS/TfrC5QxFz8DxBujuiLn35VnNj84O1GfF
   w==;
X-CSE-ConnectionGUID: 7sLZou2pQneF2TtQvUlKVQ==
X-CSE-MsgGUID: UixE6R8kSMelUGIzqxzuMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90216477"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="90216477"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 03:25:40 -0700
X-CSE-ConnectionGUID: CfUOhukYSCO55MrHq5RhYw==
X-CSE-MsgGUID: TqHIzBelTouMyP7Z9067XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259128063"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.85])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 03:25:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 May 2026 13:25:34 +0300 (EEST)
To: Rong Zhang <i@rong.moe>
cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>, 
    Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v10 06/16] platform/x86: lenovo-wmi-other: Limit adding
 attributes to supported devices
In-Reply-To: <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe>
Message-ID: <a824cd39-8e28-96db-df59-599c283ffcdb@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com>  <20260412211121.2220556-7-derekjohn.clark@gmail.com>  <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com>  <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com>
 <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1884497484-1777976734=:993"
X-Rspamd-Queue-Id: 5196D4CBC86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244083-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,squebb.ca,gmx.de,lwn.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,rong.moe:email,squebb.ca:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1884497484-1777976734=:993
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 May 2026, Rong Zhang wrote:
> On Thu, 2026-04-30 at 07:56 -0700, Derek J. Clark wrote:
> > On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@l=
inux.intel.com> wrote:
> > > On Sun, 12 Apr 2026, Derek J. Clark wrote:
> > >=20
> > > > Adds lwmi_is_attr_01_supported, and only creates the attribute subf=
older
> > > > if the attribute is supported by the hardware. Due to some poorly
> > > > implemented BIOS this is a multi-step sequence of events. This is
> > > > because:
> > > > - Some BIOS support getting the capability data from custom mode (0=
xff),
> > > >   while others only support it in no-mode (0x00).
> > > > - Some BIOS support get/set for the current value from custom mode =
(0xff),
> > > >   while others only support it in no-mode (0x00).
> > > > - Some BIOS report capability data for a method that is not fully
> > > >   implemented.
> > > > - Some BIOS have methods fully implemented, but no complimentary
> > > >   capability data.
> > > >=20
> > > > To ensure we only expose fully implemented methods with correspondi=
ng
> > > > capability data, we check each outcome before reporting that an
> > > > attribute can be supported.
> > > >=20
> > > > Checking for lwmi_is_attr_01_supported during remove is not done to
> > > > ensure that we don't attempt to call cd01 or send WMI events if one=
 of
> > > > the interfaces being removed was the cause of the driver unloading.
> > > >=20
> > > > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Drive=
r")
> > > > Reported-by: Kurt Borja <kuurtb@gmail.com>
> > > > Closes: https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3N=
SEHMZ6J7XRC@gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Reviewed-by: Rong Zhang <i@rong.moe>
> > > > Tested-by: Rong Zhang <i@rong.moe>
> > > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > > ---
> > > > v7:
> > > >   - Move earlier in the series. This required dropping the use of
> > > >     lwmi_attr_id as it will be added later.
> > > >   - Add missing switch between cd_mode_id and cv_mode_id in
> > > >     current_value_store.
> > > > v6:
> > > >   - Zero initialize args in lwmi_is_attr_01_supported.
> > > >   - Fix formatting.
> > > > v5:
> > > >   - Move cv/cd_mode_id refrences from path 3/4.
> > > >   - Add missing import for ARRAY_SIZE.
> > > >   - Make lwmi_is_attr_01_supported return bool instead of u32.
> > > >   - Various formatting fixes.
> > > > v4:
> > > >   - Use for loop instead of backtrace gotos for checking if an attr=
ibute
> > > >     is supported.
> > > >   - Add include for dev_printk.
> > > >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
> > > >   - Don't use symmetric cleanup of attributes in error states.
> > > > ---
> > > >  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
> > > >  drivers/platform/x86/lenovo/wmi-other.c    | 114 +++++++++++++++++=
+---
> > > >  2 files changed, 98 insertions(+), 17 deletions(-)
> > > >=20
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/p=
latform/x86/lenovo/wmi-gamezone.h
> > > > index 6b163a5eeb95..ddb919cf6c36 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> > > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> > > > @@ -10,6 +10,7 @@ enum gamezone_events_type {
> > > >  };
> > > > =20
> > > >  enum thermal_mode {
> > > > +=09LWMI_GZ_THERMAL_MODE_NONE =3D=09   0x00,
> > > >  =09LWMI_GZ_THERMAL_MODE_QUIET =3D=09   0x01,
> > > >  =09LWMI_GZ_THERMAL_MODE_BALANCED =3D=09   0x02,
> > > >  =09LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/plat=
form/x86/lenovo/wmi-other.c
> > > > index 50a03f5fd6ab..29d062a1c6dc 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > > > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > > > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
> > > >  =09u8 feature_id;
> > > >  =09u8 device_id;
> > > >  =09u8 type_id;
> > > > +=09u8 cd_mode_id; /* mode arg for searching capdata */
> > > > +=09u8 cv_mode_id; /* mode arg for set/get current_value */
> > > >  };
> > > > =20
> > > >  static struct tunable_attr_01 ppt_pl1_spl =3D {
> > > > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct =
kobject *kobj,
> > > >  =09struct wmi_method_args_32 args =3D {};
> > > >  =09struct capdata01 capdata;
> > > >  =09enum thermal_mode mode;
> > > > -=09u32 attribute_id;
> > > >  =09u32 value;
> > > >  =09int ret;
> > > > =20
> > > > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struc=
t kobject *kobj,
> > > >  =09if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
> > > >  =09=09return -EBUSY;
> > > > =20
> > > > -=09attribute_id =3D
> > > > -=09=09FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> > > > -=09=09FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id)=
 |
> > > > -=09=09FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> > > > -=09=09FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> > > > +=09args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->d=
evice_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature=
_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode=
_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id=
);
> > > > =20
> > > > -=09ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capd=
ata);
> > > > +=09ret =3D lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata=
);
> > > >  =09if (ret)
> > > >  =09=09return ret;
> > > > =20
> > > > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct=
 kobject *kobj,
> > > >  =09if (value < capdata.min_value || value > capdata.max_value)
> > > >  =09=09return -EINVAL;
> > > > =20
> > > > -=09args.arg0 =3D attribute_id;
> > > > +=09args.arg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->d=
evice_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature=
_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode=
_id) |
> > > > +=09=09    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id=
);
> > >=20
> > > It's already repeated a few times and you're adding more in this patc=
h.
> > >=20
> > > We should have a helper function for this encoding as it seems to=20
> > > repeat. That is, something that takes tunable_attr and mode as input
> > > (the conversion of existing entries should be in own patch preceeding=
=20
> > > this fix patch).
> > >=20
> >=20
> > Hi Ilpo,
> >=20
> > A function for that is added in patch 10, though it is slightly modifie=
d from that to be more flexible is tunable_attr isn't used (such as with th=
e fan test attributes)
> >=20
> > Originally I had that patch preceding any additions, but after=20
> > discussing with Rong we felt like it would be easier for stable=20
> > backports if all the fixes were upfront. I can certainly move it back=
=20
> > if  you still prefer.=20
>
> Moving it back is OK for me, too.
>
> I think exposing non-fully-functioning fw-attrs on stable/LTS kernels
> should be acceptable as long as reading/writing these attributes doesn't
> break anything, which is exactly the case now (i.e., without this
> patch).

How would refactoring the code into a helper result in changing stable=20
interface?

Or did you perhaps move to talk about something entirely else (and I=20
ended up losing the context)?

> Thanks a lot for your hard work in this series,


--=20
 i.

--8323328-1884497484-1777976734=:993--

