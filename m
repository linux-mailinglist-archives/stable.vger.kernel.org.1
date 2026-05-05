Return-Path: <stable+bounces-244232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDkOKVos+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:43:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D04D2414
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF084302975A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417F4A2E32;
	Tue,  5 May 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB+ynK3Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26848C411
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002723; cv=none; b=okpefy8S+tX9cOE0IA2a5vgz7a1omj7SSZtW9XHc4r6eAbpAlqq2DtltPA4DhTOh1ruzS6Kz1h1lO+E7NlbFOpmGwJTNFjk7H+T+W7s27kphkUB+0Y6Mhe6G4mV/kdL/MHxoI6talqy/wnHC1mlBthPnJlspjl9jOawfamoDGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002723; c=relaxed/simple;
	bh=ONTttrMUZew0Aooh9F2p0Z1LmJuLUtxo/9VZeZR61qc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WDXIMzJoG7KhqdvfaCG4qQUtyrVXzm+J68t7KI279f0g5HmtzrWoJI9RsqG4iaWa3PxO95akPBE5G4djrSsuLSF64QrrYySazcsmShQXmcSFGY+VvRC1jKl4u9BUa7gKSwwWb67oUT5ghH7gYfZNU8k1TnePfsN56bpj+EBLudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB+ynK3Z; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f33ae12f97so3169827eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002721; x=1778607521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYlavuQ8ld+CKANDl2X+Fta2TfR9wiu5gpK6ggQh6gk=;
        b=UB+ynK3ZZ863FJrwxB8WvHZ3LZNxZztPfzqbHD8pAczcwfgUaReQYkhN87dwOoDivg
         DpP+1Jcchd4KcbbESdfqIoSm8pwce+yTZgqWIKkCKxT9rQEwRTqp/Pp9alULN2rlXhWk
         aIQNsl9qT1u8hF1kInxbf0y3dHPvDlhc0lX4f0+BPqdBiJTIK49nv2RFB87u0PP5LRTk
         N22wrXcuYcEuLRjJZ2Bu8r1Dun3t8pmpJZDenE15Y60gma/rGo2YrM4a+cf5y4nctynp
         GissNS0Tbu/iEKbh462Zo4aAVsNA5Pf8aqB1p3U9T5S1DgriLwgcVH6mDRK23XqKL/OI
         DryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002721; x=1778607521;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYlavuQ8ld+CKANDl2X+Fta2TfR9wiu5gpK6ggQh6gk=;
        b=kQzH6JI41Q5vARX6XCd8uptKc7kbOoWcjHoGr2l+2THznGCTR2lVr0fnkB3HS0nTBg
         +O8SxOMi/CClXp3EKnGKl6e6JXadmF9t3uCd0j8ApSBiRD4YK4nIg+AEYI1w7iCRPjfM
         5X36bUbpMtUdcVWQ0M2L/uU2ZyKc3lM43QujWlWHeWMHEayBt6fYrFyYn9mVSVhlZSNE
         1sIMNV+zHzdyA13cJVjz1QXX/7r4HNqcDo7tGhXl656dJmWA5wykPvrr6GoRliPxGcos
         Vrcrb5YwP/F1gZU0Regva0nq3BK5WAJ+2dROhiMD07pgdGSK/poo6NbFYaYIrc7vk/cD
         xbCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3NGnR54WZw7yFsmT6VGoV3lPo18LcFmi5mr/T8jVKHXBJRxhOWIdqCFydYgUhb/igLhRaVLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxL8vMwgY/6sqEp7G2QqnU+7/mq6V85WA18mnGdclCKuuv0od
	u5WNjxslESPFbMNcAvCGpAEENbQ1PkRJll93fHPht5TWBa2uR8H1rZGL
X-Gm-Gg: AeBDieskmEV/l4UA5DEQ2z7jNyLKSXHxUZurGxo/hyUnY/FxF2tGmXqKabBNauPt4ed
	uY1/+jxmtR2hnvfBU5NsbP4jT0qFOiI/oM1gSwK5tFv4ID1L2y8YHBjOM/yQAeYk/f4r11+jOv5
	dxe0jNwcS5tNdoKvvjBAoYQKoNcbowVvwMmxTFIiAGybmJH5+TdUEqvk7zIUCnfFcx3gWUqcHxz
	4F4gZC1HJ5SEkqUN5yt4KXhQFETqmXfIyWkhnQu4lNjJZBOtRTJijS2LU0po7rWqxMSxWAqZdK/
	aVTz4FsJNbHHAkWMnXZLSjPO1xiMJFhLr9DL7WHLS2Uu28jZfHVfgB0Y5kQzY1a/7DMg5L4dbK0
	CjSHYxW8It1PUb+5pj3xKs3/x78XZtGxBt8g1oRxV5UzI+No1FnpfXa2q8rO12osqJUZamEGxoQ
	BqFned6ButWpmtP0i9MZrB0MEuPSblBoShmp3eKlY0WoKjKeoFj71DYT6EzFGV/SFGj0PmKVA/k
	htKhDItphM4n/uS2KpYzA4Jr5WkGx2hRWS/KoW8IBI=
X-Received: by 2002:a05:7300:6402:b0:2f2:6dde:df67 with SMTP id 5a478bee46e88-2f54ad76437mr98693eec.22.1778002720678;
        Tue, 05 May 2026 10:38:40 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71cedsm25566870eec.9.2026.05.05.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:38:40 -0700 (PDT)
Date: Tue, 05 May 2026 10:38:39 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_06/16=5D_platform/x86=3A_lenovo-wmi-ot?=
 =?US-ASCII?Q?her=3A_Limit_adding_attributes_to_supported_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <13A5927F-E79C-4F09-B7D9-92A1C777E5AC@rong.moe>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com> <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com> <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com> <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe> <a824cd39-8e28-96db-df59-599c283ffcdb@linux.intel.com> <13A5927F-E79C-4F09-B7D9-92A1C777E5AC@rong.moe>
Message-ID: <8BB653FC-30AA-4BB5-9E74-AFCD507F33D2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EF5D04D2414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,squebb.ca:server fail,rong.moe:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244232-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rong.moe:email,squebb.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On May 5, 2026 10:20:15 AM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>Hi Ilpo,
>
>=E4=BA=8E 2026=E5=B9=B45=E6=9C=885=E6=97=A5 GMT+08:00 18:25:34=EF=BC=8C"I=
lpo J=C3=A4rvinen" <ilpo=2Ejarvinen@linux=2Eintel=2Ecom> =E5=86=99=E9=81=93=
=EF=BC=9A
>>On Fri, 1 May 2026, Rong Zhang wrote:
>>> On Thu, 2026-04-30 at 07:56 -0700, Derek J=2E Clark wrote:
>>> > On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvi=
nen@linux=2Eintel=2Ecom> wrote:
>>> > > On Sun, 12 Apr 2026, Derek J=2E Clark wrote:
>>> > >=20
>>> > > > Adds lwmi_is_attr_01_supported, and only creates the attribute s=
ubfolder
>>> > > > if the attribute is supported by the hardware=2E Due to some poo=
rly
>>> > > > implemented BIOS this is a multi-step sequence of events=2E This=
 is
>>> > > > because:
>>> > > > - Some BIOS support getting the capability data from custom mode=
 (0xff),
>>> > > >   while others only support it in no-mode (0x00)=2E
>>> > > > - Some BIOS support get/set for the current value from custom mo=
de (0xff),
>>> > > >   while others only support it in no-mode (0x00)=2E
>>> > > > - Some BIOS report capability data for a method that is not full=
y
>>> > > >   implemented=2E
>>> > > > - Some BIOS have methods fully implemented, but no complimentary
>>> > > >   capability data=2E
>>> > > >=20
>>> > > > To ensure we only expose fully implemented methods with correspo=
nding
>>> > > > capability data, we check each outcome before reporting that an
>>> > > > attribute can be supported=2E
>>> > > >=20
>>> > > > Checking for lwmi_is_attr_01_supported during remove is not done=
 to
>>> > > > ensure that we don't attempt to call cd01 or send WMI events if =
one of
>>> > > > the interfaces being removed was the cause of the driver unloadi=
ng=2E
>>> > > >=20
>>> > > > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Dr=
iver")
>>> > > > Reported-by: Kurt Borja <kuurtb@gmail=2Ecom>
>>> > > > Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/DG60P3SH=
XR8H=2E3NSEHMZ6J7XRC@gmail=2Ecom/
>>> > > > Cc: stable@vger=2Ekernel=2Eorg
>>> > > > Reviewed-by: Rong Zhang <i@rong=2Emoe>
>>> > > > Tested-by: Rong Zhang <i@rong=2Emoe>
>>> > > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb=2Eca>
>>> > > > Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>>> > > > ---
>>> > > > v7:
>>> > > >   - Move earlier in the series=2E This required dropping the use=
 of
>>> > > >     lwmi_attr_id as it will be added later=2E
>>> > > >   - Add missing switch between cd_mode_id and cv_mode_id in
>>> > > >     current_value_store=2E
>>> > > > v6:
>>> > > >   - Zero initialize args in lwmi_is_attr_01_supported=2E
>>> > > >   - Fix formatting=2E
>>> > > > v5:
>>> > > >   - Move cv/cd_mode_id refrences from path 3/4=2E
>>> > > >   - Add missing import for ARRAY_SIZE=2E
>>> > > >   - Make lwmi_is_attr_01_supported return bool instead of u32=2E
>>> > > >   - Various formatting fixes=2E
>>> > > > v4:
>>> > > >   - Use for loop instead of backtrace gotos for checking if an a=
ttribute
>>> > > >     is supported=2E
>>> > > >   - Add include for dev_printk=2E
>>> > > >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier=2E
>>> > > >   - Don't use symmetric cleanup of attributes in error states=2E
>>> > > > ---
>>> > > >  drivers/platform/x86/lenovo/wmi-gamezone=2Eh |   1 +
>>> > > >  drivers/platform/x86/lenovo/wmi-other=2Ec    | 114 ++++++++++++=
++++++---
>>> > > >  2 files changed, 98 insertions(+), 17 deletions(-)
>>> > > >=20
>>> > > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh b/driv=
ers/platform/x86/lenovo/wmi-gamezone=2Eh
>>> > > > index 6b163a5eeb95=2E=2Eddb919cf6c36 100644
>>> > > > --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>>> > > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>>> > > > @@ -10,6 +10,7 @@ enum gamezone_events_type {
>>> > > >  };
>>> > > > =20
>>> > > >  enum thermal_mode {
>>> > > > +	LWMI_GZ_THERMAL_MODE_NONE =3D	   0x00,
>>> > > >  	LWMI_GZ_THERMAL_MODE_QUIET =3D	   0x01,
>>> > > >  	LWMI_GZ_THERMAL_MODE_BALANCED =3D	   0x02,
>>> > > >  	LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
>>> > > > diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers=
/platform/x86/lenovo/wmi-other=2Ec
>>> > > > index 50a03f5fd6ab=2E=2E29d062a1c6dc 100644
>>> > > > --- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>>> > > > +++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>>> > > > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>>> > > >  	u8 feature_id;
>>> > > >  	u8 device_id;
>>> > > >  	u8 type_id;
>>> > > > +	u8 cd_mode_id; /* mode arg for searching capdata */
>>> > > > +	u8 cv_mode_id; /* mode arg for set/get current_value */
>>> > > >  };
>>> > > > =20
>>> > > >  static struct tunable_attr_01 ppt_pl1_spl =3D {
>>> > > > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(stru=
ct kobject *kobj,
>>> > > >  	struct wmi_method_args_32 args =3D {};
>>> > > >  	struct capdata01 capdata;
>>> > > >  	enum thermal_mode mode;
>>> > > > -	u32 attribute_id;
>>> > > >  	u32 value;
>>> > > >  	int ret;
>>> > > > =20
>>> > > > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(st=
ruct kobject *kobj,
>>> > > >  	if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
>>> > > >  		return -EBUSY;
>>> > > > =20
>>> > > > -	attribute_id =3D
>>> > > > -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
>>> > > > -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) =
|
>>> > > > -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>>> > > > -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>>> > > > +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr=
->device_id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_=
id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_=
id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id)=
;
>>> > > > =20
>>> > > > -	ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &cap=
data);
>>> > > > +	ret =3D lwmi_cd01_get_data(priv->cd01_list, args=2Earg0, &capd=
ata);
>>> > > >  	if (ret)
>>> > > >  		return ret;
>>> > > > =20
>>> > > > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(str=
uct kobject *kobj,
>>> > > >  	if (value < capdata=2Emin_value || value > capdata=2Emax_value=
)
>>> > > >  		return -EINVAL;
>>> > > > =20
>>> > > > -	args=2Earg0 =3D attribute_id;
>>> > > > +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr=
->device_id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_=
id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_=
id) |
>>> > > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id)=
;
>>> > >=20
>>> > > It's already repeated a few times and you're adding more in this p=
atch=2E
>>> > >=20
>>> > > We should have a helper function for this encoding as it seems to=
=20
>>> > > repeat=2E That is, something that takes tunable_attr and mode as i=
nput
>>> > > (the conversion of existing entries should be in own patch preceed=
ing=20
>>> > > this fix patch)=2E
>>> > >=20
>>> >=20
>>> > Hi Ilpo,
>>> >=20
>>> > A function for that is added in patch 10, though it is slightly modi=
fied from that to be more flexible is tunable_attr isn't used (such as with=
 the fan test attributes)
>>> >=20
>>> > Originally I had that patch preceding any additions, but after=20
>>> > discussing with Rong we felt like it would be easier for stable=20
>>> > backports if all the fixes were upfront=2E I can certainly move it b=
ack=20
>>> > if  you still prefer=2E=20
>>>
>>> Moving it back is OK for me, too=2E
>>>
>>> I think exposing non-fully-functioning fw-attrs on stable/LTS kernels
>>> should be acceptable as long as reading/writing these attributes doesn=
't
>>> break anything, which is exactly the case now (i=2Ee=2E, without this
>>> patch)=2E
>>
>>How would refactoring the code into a helper result in changing stable=
=20
>>interface?
>>
>>Or did you perhaps move to talk about something entirely else (and I=20
>>ended up losing the context)?
>
>I meant the *current* LTS/stable state is acceptable for me as reading/wr=
iting these attributes doesn't break anything=2E Moving it back would be OK=
 for me even if it made this patch unable to be backported (though unlikely=
, since moving it back makes the patch clearer as you've said)=2E In other =
words, it doesn't matter for me whether the patch is backported or not=2E
>
>Some context: I didn't ask Derek to add Fixes: tag to this patch or move =
it=2E I asked him to rearrange other patches to make them backportable=2E
>
>Sorry for causing misunderstandings=2E
>
>Thanks,
>Rong
>

I preferred it earlier myself since the rest of the series was cleaner tha=
t way=2E I'll move it again as that's fairly simple=2E IMO stable should be=
 able to take it as part of the fixes it affects since there are no functio=
nal changes and it will be a prerequisite for some much needed fixes on sta=
ble, but I suppose that's ultimately up to them=2E

I'll submit in a couple of days as I'm currently waiting on some feedback =
from Lenovo regarding some clarification of the charge limiting features af=
ter getting some unexpected results in a test=2E

Thanks,
Derek
>>
>>> Thanks a lot for your hard work in this series,
>>
>>


