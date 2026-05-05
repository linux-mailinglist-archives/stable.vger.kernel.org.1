Return-Path: <stable+bounces-244221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLgtKOkm+mmHKQMAu9opvQ
	(envelope-from <stable+bounces-244221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAFD4D1F4F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4E2303E4A2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160648B384;
	Tue,  5 May 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="DxdSm7o0"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51F3E929C;
	Tue,  5 May 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001636; cv=pass; b=MX2TdAqtLLOzNPuHUwIgPkl85nyBP3uIv5mbsGVd2NTJpE8OLdD23B9jUAYreMw4Qka04Nx3fAztIQL1WjswjdpZqiceMIbQsF/HoAXGx/WtJ3P/lD5asyshW0VTR/d8qAuy10z6hDcpEoXRVQ2UprrBCGowOhDC+wZfb6zxoRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001636; c=relaxed/simple;
	bh=4e4lWMK8bWxQq+EMq2tVBEdPS5zH9FNybcB/TtKS1gk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eebNQqwX6fEsgcDoO5fUrCZfrv6QEP7j7MjDZEu0Xbu7bnQi6AYBQByjTxrVyd4aJ/rHc8VY2uVCE5RdusEdyaExgj3wD7Gs4XJTlGYubKXFMnY8oJKCRbbk/U6I7dP2O9zmYxKILdt8tyTxcAPLLJgoz4qWlhRVbzu6u8VP0D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=DxdSm7o0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1778001624; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qlc++u5lcJuLMHKTI7rrkbMYoVwg/7mxJWkZ/yxH4ckiyb/unLAns8ydxBHuvMg4jZ1qwtakixs1UaTRiGEiPMllZa6XVF8QVVNWaVQuhaQgP13VEKZsHbYPuOT0pA4oww56QjWtmkYi7xMn6furv8k6r20CzDg3q1+tpgPLgXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778001624; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FmjkcII2P5r6Qmn17aMfMDneBiZpDrCCAGtIXnvqg/s=; 
	b=fTsqzUCjtJYPAu9A6osYJCfeqOfFUGJWE8yGADxQwS9wzYNJ4ybM7hFxH0aSPyTzlsekMxb4u0jbFSw+3mW7stXDt4cAF57ecaWprAY2P3Lwu9XAzj0FhBL2NTHroH1uypVnRW/AsNe2IKgJH8Me1m+njxH4ws+1lKXgqNlqPPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778001624;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=FmjkcII2P5r6Qmn17aMfMDneBiZpDrCCAGtIXnvqg/s=;
	b=DxdSm7o0eqmuWhQkMyK8Qb6YHmlKvsFnuBwExpYUW9gy5Rf5VGqEnyanv0TjG1+t
	aO8JlLpXCcyANJLzfyRigfpO4WeepSI9PLwVEkBvxU3E5kVlCar0wIIHKKXKZaOBnwU
	hHccZB1+ARyFpuvapIhnvkXTtu4S++HWdiOPwQqsNKRt8nHafGQI2h1lY+nAiT4EFrC
	xuMGfK/hLoKK+9GiZ9h2rUQeFmkUSt4IrC64fsWG3y7C7SaE1k2GmYrcgd8XKnDFGLo
	FFgClN5zTkEzGbpzEAToqRvSdPqWrNZXWW0U33+4csTvFT1UdV4F6RbSVUSeALX3AgD
	gjt6wVPfIQ==
Received: by mx.zohomail.com with SMTPS id 1778001622755711.0439934026193;
	Tue, 5 May 2026 10:20:22 -0700 (PDT)
Date: Wed, 06 May 2026 01:20:15 +0800
From: Rong Zhang <i@rong.moe>
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_06/16=5D_platform/x86=3A_lenovo-wmi-ot?=
 =?US-ASCII?Q?her=3A_Limit_adding_attributes_to_supported_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <a824cd39-8e28-96db-df59-599c283ffcdb@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com> <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com> <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com> <6d1aa0f0bbbd82fd0633619ec4905419db15592e.camel@rong.moe> <a824cd39-8e28-96db-df59-599c283ffcdb@linux.intel.com>
Message-ID: <13A5927F-E79C-4F09-B7D9-92A1C777E5AC@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0EAFD4D1F4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244221-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,squebb.ca,gmx.de,lwn.net,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rong.moe:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rong.moe:email,rong.moe:dkim,rong.moe:mid]

Hi Ilpo,

=E4=BA=8E 2026=E5=B9=B45=E6=9C=885=E6=97=A5 GMT+08:00 18:25:34=EF=BC=8C"Il=
po J=C3=A4rvinen" <ilpo=2Ejarvinen@linux=2Eintel=2Ecom> =E5=86=99=E9=81=93=
=EF=BC=9A
>On Fri, 1 May 2026, Rong Zhang wrote:
>> On Thu, 2026-04-30 at 07:56 -0700, Derek J=2E Clark wrote:
>> > On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvin=
en@linux=2Eintel=2Ecom> wrote:
>> > > On Sun, 12 Apr 2026, Derek J=2E Clark wrote:
>> > >=20
>> > > > Adds lwmi_is_attr_01_supported, and only creates the attribute su=
bfolder
>> > > > if the attribute is supported by the hardware=2E Due to some poor=
ly
>> > > > implemented BIOS this is a multi-step sequence of events=2E This =
is
>> > > > because:
>> > > > - Some BIOS support getting the capability data from custom mode =
(0xff),
>> > > >   while others only support it in no-mode (0x00)=2E
>> > > > - Some BIOS support get/set for the current value from custom mod=
e (0xff),
>> > > >   while others only support it in no-mode (0x00)=2E
>> > > > - Some BIOS report capability data for a method that is not fully
>> > > >   implemented=2E
>> > > > - Some BIOS have methods fully implemented, but no complimentary
>> > > >   capability data=2E
>> > > >=20
>> > > > To ensure we only expose fully implemented methods with correspon=
ding
>> > > > capability data, we check each outcome before reporting that an
>> > > > attribute can be supported=2E
>> > > >=20
>> > > > Checking for lwmi_is_attr_01_supported during remove is not done =
to
>> > > > ensure that we don't attempt to call cd01 or send WMI events if o=
ne of
>> > > > the interfaces being removed was the cause of the driver unloadin=
g=2E
>> > > >=20
>> > > > Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Dri=
ver")
>> > > > Reported-by: Kurt Borja <kuurtb@gmail=2Ecom>
>> > > > Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/DG60P3SHX=
R8H=2E3NSEHMZ6J7XRC@gmail=2Ecom/
>> > > > Cc: stable@vger=2Ekernel=2Eorg
>> > > > Reviewed-by: Rong Zhang <i@rong=2Emoe>
>> > > > Tested-by: Rong Zhang <i@rong=2Emoe>
>> > > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb=2Eca>
>> > > > Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> > > > ---
>> > > > v7:
>> > > >   - Move earlier in the series=2E This required dropping the use =
of
>> > > >     lwmi_attr_id as it will be added later=2E
>> > > >   - Add missing switch between cd_mode_id and cv_mode_id in
>> > > >     current_value_store=2E
>> > > > v6:
>> > > >   - Zero initialize args in lwmi_is_attr_01_supported=2E
>> > > >   - Fix formatting=2E
>> > > > v5:
>> > > >   - Move cv/cd_mode_id refrences from path 3/4=2E
>> > > >   - Add missing import for ARRAY_SIZE=2E
>> > > >   - Make lwmi_is_attr_01_supported return bool instead of u32=2E
>> > > >   - Various formatting fixes=2E
>> > > > v4:
>> > > >   - Use for loop instead of backtrace gotos for checking if an at=
tribute
>> > > >     is supported=2E
>> > > >   - Add include for dev_printk=2E
>> > > >   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier=2E
>> > > >   - Don't use symmetric cleanup of attributes in error states=2E
>> > > > ---
>> > > >  drivers/platform/x86/lenovo/wmi-gamezone=2Eh |   1 +
>> > > >  drivers/platform/x86/lenovo/wmi-other=2Ec    | 114 +++++++++++++=
+++++---
>> > > >  2 files changed, 98 insertions(+), 17 deletions(-)
>> > > >=20
>> > > > diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh b/drive=
rs/platform/x86/lenovo/wmi-gamezone=2Eh
>> > > > index 6b163a5eeb95=2E=2Eddb919cf6c36 100644
>> > > > --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> > > > +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> > > > @@ -10,6 +10,7 @@ enum gamezone_events_type {
>> > > >  };
>> > > > =20
>> > > >  enum thermal_mode {
>> > > > +	LWMI_GZ_THERMAL_MODE_NONE =3D	   0x00,
>> > > >  	LWMI_GZ_THERMAL_MODE_QUIET =3D	   0x01,
>> > > >  	LWMI_GZ_THERMAL_MODE_BALANCED =3D	   0x02,
>> > > >  	LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
>> > > > diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers/=
platform/x86/lenovo/wmi-other=2Ec
>> > > > index 50a03f5fd6ab=2E=2E29d062a1c6dc 100644
>> > > > --- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>> > > > +++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>> > > > @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>> > > >  	u8 feature_id;
>> > > >  	u8 device_id;
>> > > >  	u8 type_id;
>> > > > +	u8 cd_mode_id; /* mode arg for searching capdata */
>> > > > +	u8 cv_mode_id; /* mode arg for set/get current_value */
>> > > >  };
>> > > > =20
>> > > >  static struct tunable_attr_01 ppt_pl1_spl =3D {
>> > > > @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struc=
t kobject *kobj,
>> > > >  	struct wmi_method_args_32 args =3D {};
>> > > >  	struct capdata01 capdata;
>> > > >  	enum thermal_mode mode;
>> > > > -	u32 attribute_id;
>> > > >  	u32 value;
>> > > >  	int ret;
>> > > > =20
>> > > > @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(str=
uct kobject *kobj,
>> > > >  	if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
>> > > >  		return -EBUSY;
>> > > > =20
>> > > > -	attribute_id =3D
>> > > > -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
>> > > > -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> > > > -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>> > > > -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> > > > +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr-=
>device_id) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_i=
d) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_i=
d) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> > > > =20
>> > > > -	ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capd=
ata);
>> > > > +	ret =3D lwmi_cd01_get_data(priv->cd01_list, args=2Earg0, &capda=
ta);
>> > > >  	if (ret)
>> > > >  		return ret;
>> > > > =20
>> > > > @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(stru=
ct kobject *kobj,
>> > > >  	if (value < capdata=2Emin_value || value > capdata=2Emax_value)
>> > > >  		return -EINVAL;
>> > > > =20
>> > > > -	args=2Earg0 =3D attribute_id;
>> > > > +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr-=
>device_id) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_i=
d) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_i=
d) |
>> > > > +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> > >=20
>> > > It's already repeated a few times and you're adding more in this pa=
tch=2E
>> > >=20
>> > > We should have a helper function for this encoding as it seems to=
=20
>> > > repeat=2E That is, something that takes tunable_attr and mode as in=
put
>> > > (the conversion of existing entries should be in own patch preceedi=
ng=20
>> > > this fix patch)=2E
>> > >=20
>> >=20
>> > Hi Ilpo,
>> >=20
>> > A function for that is added in patch 10, though it is slightly modif=
ied from that to be more flexible is tunable_attr isn't used (such as with =
the fan test attributes)
>> >=20
>> > Originally I had that patch preceding any additions, but after=20
>> > discussing with Rong we felt like it would be easier for stable=20
>> > backports if all the fixes were upfront=2E I can certainly move it ba=
ck=20
>> > if  you still prefer=2E=20
>>
>> Moving it back is OK for me, too=2E
>>
>> I think exposing non-fully-functioning fw-attrs on stable/LTS kernels
>> should be acceptable as long as reading/writing these attributes doesn'=
t
>> break anything, which is exactly the case now (i=2Ee=2E, without this
>> patch)=2E
>
>How would refactoring the code into a helper result in changing stable=20
>interface?
>
>Or did you perhaps move to talk about something entirely else (and I=20
>ended up losing the context)?

I meant the *current* LTS/stable state is acceptable for me as reading/wri=
ting these attributes doesn't break anything=2E Moving it back would be OK =
for me even if it made this patch unable to be backported (though unlikely,=
 since moving it back makes the patch clearer as you've said)=2E In other w=
ords, it doesn't matter for me whether the patch is backported or not=2E

Some context: I didn't ask Derek to add Fixes: tag to this patch or move i=
t=2E I asked him to rearrange other patches to make them backportable=2E

Sorry for causing misunderstandings=2E

Thanks,
Rong

>
>> Thanks a lot for your hard work in this series,
>
>

