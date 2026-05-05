Return-Path: <stable+bounces-244234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVCNfsr+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D19474D23A9
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9AD930008B9
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19884A2E32;
	Tue,  5 May 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTLW5FCq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C312492507
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002849; cv=none; b=MlT147ciizsz2udndAxNzf27WQBZMxXeYCWOH+YPSahxbS/XCU8yFhEhkFLUeBN+fkjvcf0BfbC/k7cplGPqU6aczvjBTIXXYQw+jNPw+bP9nzH/5UwKBmHT2jEFoT09Fqxtfry+WfdjFcMyP9rgL9jlVYoAoiqIFs5YLgNawRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002849; c=relaxed/simple;
	bh=/Wk0G6OMx58JB4J28VjOe9IKhJZt/KpmPk/ZuiImfiw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lYUrrUdp4LvBQT+EgNJ3EjYckchtI8CHvOXFryRqk5bDkyplzadHs5LdVQV3rcux2cEfqAymBzlNpnh0giRXSfwEsSF2++xLOkWqYN3neZSf0CTi5JtdB45A51be19sOnQdlpk6j+UZJqNVf5bxeG0grELTXlTUBaXkGifdO13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTLW5FCq; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so5578308eec.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002847; x=1778607647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhXVt+AnL0NfCyigv8QAWVK+PRj4tez0zQo7Ju/B5eA=;
        b=sTLW5FCqXp0+/11Q68AoJ1OphWr41fotHWQtWW2DGEBA9nvT7ONTHBmE3qt0wQ8j0m
         uX8TOo1pSo+hiCEnB7fh4LXAorHWjNJ0+p1wsTbHXzhgTF3rhU27rHy/77oTEN4rIiiN
         rvdoMHbTYKU5j0QAxSiPwlt8+Tu0sch9gQm4l4WHREkkqFyYYTJz0gGnEOk16CPjhACW
         bkJPNov2yK3AP52de3swyrETGduQ/r4lrAmXaP8n9ZrkjOgtFUgQwf5ThoqmFrlTsRbJ
         9Hl/ZivWaT+RPttcxczEMj+aqT+T+vXf70a+h2k79NB7+yxInZbQs0pEX4qeR281h3RL
         arnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002847; x=1778607647;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhXVt+AnL0NfCyigv8QAWVK+PRj4tez0zQo7Ju/B5eA=;
        b=pgWpaEV6SHWUIIh67OYW/j6tCQMtdWASUdxmkrn2e/+PX7zCt49sFFiptOFGjoOJ4p
         oIzCm2EyvPscpPFuCwhq9FAVL0QTeIztS8smdcTuRsk0YLlNxP7EPH5SUnvf5jGa6Rwi
         7VOOpeYCzLA6CaDLBJBCgPG02fYPjS7ZdHzNVbyxVuHV1oh/Lwn0wwjK+NCFom4CQ4aF
         vnTIsNbM6mgoOKqMOIp4/fP46cO+gddD8jZaua2x8dVoI5UeXy56eQym4e9WIPME4LxP
         CCKRLGZM7LHvtII5mKhdR+Cojo/nilaccmNZcA6PWBgghP5ITotaFib+pF8wSeiSWn5d
         JByw==
X-Forwarded-Encrypted: i=1; AFNElJ/xyRvLfdkKUR52a/QYIlL7cwupKwgaNwwBvWKsaeZdq2K8Dl/IZBdD/8NB1svacevjsT15pWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvlBABvmxumFyg7GliS7WQ1lptjHMp/YaVDf0lWJnI/s2tXHH
	VpoOE6NCW4VsB9WGPjtiY4/LlmKn8Mz7KtcxAMEs8OAhvqZ1sI2hP8Ke
X-Gm-Gg: AeBDietuQu21iQuV85N5QG0jsYCZoTRwyeQoEYT9LNfQ31XYXZphIHe5hEwls89VakA
	irmUYi1CONyO74sL5JogdpbBeifKT7Jz2K8ZsUE+c4gIz6gq0w+3a0dd5haIphjAdWBEoFVsH6I
	QEg9JjtzYsui058UiVkiRoZ9AgHhARJaTWeY/8gGAi7PkFec5J5G5sE343lzGruyC0W4YbQ6Djx
	4YHhw4nbhuGf9fivt6FZ6TzWZrDlDLADLFWCV6AysWv4uVBdGeTztLPi8HlXhm0xQXpqa4/Isr1
	JA08ZoopDWpYzzSir82j0OpvGzFf5Q7FqQRW97GP/qGzKK1A6W+ak/nTGAkaEsN9VlCb4iFfcRP
	uVfGt2y0ueyNnXXRui9+SBMzFJU6l+Ubqit+s9soMztc+SPbVcm33W4HHCptE1+OYHhCDSBo5T7
	K4ddAjLh4ib9PAZS4W9K+WLG8+AaoKyTKe0P2ty1FS2gLTxLvVTE0B5cUt7FPdAe4uWXn/TcW/Q
	5VEi3hDBXHTBuhuxqSrD0xTXMLFvyD3
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr127551eec.12.1778002846955;
        Tue, 05 May 2026 10:40:46 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb60811sm20995714eec.24.2026.05.05.10.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:40:46 -0700 (PDT)
Date: Tue, 05 May 2026 10:40:46 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v10_06/16=5D_platform/x86=3A_lenovo-wmi-ot?=
 =?US-ASCII?Q?her=3A_Limit_adding_attributes_to_supported_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <3032887f-bfa2-6968-7a8e-db141e5ef649@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com> <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com> <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com> <3032887f-bfa2-6968-7a8e-db141e5ef649@linux.intel.com>
Message-ID: <6ABDB1EF-324B-48EB-A5F2-18E13DD9F5B8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D19474D23A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244234-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,squebb.ca:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]

On May 5, 2026 2:48:08 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvinen@linux=
=2Eintel=2Ecom> wrote:
>On Thu, 30 Apr 2026, Derek J=2E Clark wrote:
>> On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvinen=
@linux=2Eintel=2Ecom> wrote:
>> >On Sun, 12 Apr 2026, Derek J=2E Clark wrote:
>> >
>> >> Adds lwmi_is_attr_01_supported, and only creates the attribute subfo=
lder
>> >> if the attribute is supported by the hardware=2E Due to some poorly
>> >> implemented BIOS this is a multi-step sequence of events=2E This is
>> >> because:
>> >> - Some BIOS support getting the capability data from custom mode (0x=
ff),
>> >>   while others only support it in no-mode (0x00)=2E
>> >> - Some BIOS support get/set for the current value from custom mode (=
0xff),
>> >>   while others only support it in no-mode (0x00)=2E
>> >> - Some BIOS report capability data for a method that is not fully
>> >>   implemented=2E
>> >> - Some BIOS have methods fully implemented, but no complimentary
>> >>   capability data=2E
>> >>=20
>> >> To ensure we only expose fully implemented methods with correspondin=
g
>> >> capability data, we check each outcome before reporting that an
>> >> attribute can be supported=2E
>> >>=20
>> >> Checking for lwmi_is_attr_01_supported during remove is not done to
>> >> ensure that we don't attempt to call cd01 or send WMI events if one =
of
>> >> the interfaces being removed was the cause of the driver unloading=
=2E
>> >>=20
>> >> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver=
")
>> >> Reported-by: Kurt Borja <kuurtb@gmail=2Ecom>
>> >> Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/DG60P3SHXR8H=
=2E3NSEHMZ6J7XRC@gmail=2Ecom/
>> >> Cc: stable@vger=2Ekernel=2Eorg
>> >> Reviewed-by: Rong Zhang <i@rong=2Emoe>
>> >> Tested-by: Rong Zhang <i@rong=2Emoe>
>> >> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb=2Eca>
>> >> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> >> ---
>> >> v7:
>> >>   - Move earlier in the series=2E This required dropping the use of
>> >>     lwmi_attr_id as it will be added later=2E
>> >>   - Add missing switch between cd_mode_id and cv_mode_id in
>> >>     current_value_store=2E
>> >> v6:
>> >>   - Zero initialize args in lwmi_is_attr_01_supported=2E
>> >>   - Fix formatting=2E
>> >> v5:
>> >>   - Move cv/cd_mode_id refrences from path 3/4=2E
>> >>   - Add missing import for ARRAY_SIZE=2E
>> >>   - Make lwmi_is_attr_01_supported return bool instead of u32=2E
>> >>   - Various formatting fixes=2E
>> >> v4:
>> >>   - Use for loop instead of backtrace gotos for checking if an attri=
bute
>> >>     is supported=2E
>> >>   - Add include for dev_printk=2E
>> >>   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier=2E
>> >>   - Don't use symmetric cleanup of attributes in error states=2E
>> >> ---
>> >>  drivers/platform/x86/lenovo/wmi-gamezone=2Eh |   1 +
>> >>  drivers/platform/x86/lenovo/wmi-other=2Ec    | 114 ++++++++++++++++=
++---
>> >>  2 files changed, 98 insertions(+), 17 deletions(-)
>> >>=20
>> >> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh b/drivers/=
platform/x86/lenovo/wmi-gamezone=2Eh
>> >> index 6b163a5eeb95=2E=2Eddb919cf6c36 100644
>> >> --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> >> +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> >> @@ -10,6 +10,7 @@ enum gamezone_events_type {
>> >>  };
>> >> =20
>> >>  enum thermal_mode {
>> >> +	LWMI_GZ_THERMAL_MODE_NONE =3D	   0x00,
>> >>  	LWMI_GZ_THERMAL_MODE_QUIET =3D	   0x01,
>> >>  	LWMI_GZ_THERMAL_MODE_BALANCED =3D	   0x02,
>> >>  	LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
>> >> diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers/pla=
tform/x86/lenovo/wmi-other=2Ec
>> >> index 50a03f5fd6ab=2E=2E29d062a1c6dc 100644
>> >> --- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>> >> +++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>> >> @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>> >>  	u8 feature_id;
>> >>  	u8 device_id;
>> >>  	u8 type_id;
>> >> +	u8 cd_mode_id; /* mode arg for searching capdata */
>> >> +	u8 cv_mode_id; /* mode arg for set/get current_value */
>> >>  };
>> >> =20
>> >>  static struct tunable_attr_01 ppt_pl1_spl =3D {
>> >> @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct k=
object *kobj,
>> >>  	struct wmi_method_args_32 args =3D {};
>> >>  	struct capdata01 capdata;
>> >>  	enum thermal_mode mode;
>> >> -	u32 attribute_id;
>> >>  	u32 value;
>> >>  	int ret;
>> >> =20
>> >> @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct=
 kobject *kobj,
>> >>  	if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
>> >>  		return -EBUSY;
>> >> =20
>> >> -	attribute_id =3D
>> >> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
>> >> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> >> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>> >> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> >> +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->de=
vice_id) |
>> >> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) =
|
>> >> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) =
|
>> >> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> >> =20
>> >> -	ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata=
);
>> >> +	ret =3D lwmi_cd01_get_data(priv->cd01_list, args=2Earg0, &capdata)=
;
>> >>  	if (ret)
>> >>  		return ret;
>> >> =20
>> >> @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct =
kobject *kobj,
>> >>  	if (value < capdata=2Emin_value || value > capdata=2Emax_value)
>> >>  		return -EINVAL;
>> >> =20
>> >> -	args=2Earg0 =3D attribute_id;
>> >> +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->de=
vice_id) |
>> >> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) =
|
>> >> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) =
|
>> >> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> >
>> >It's already repeated a few times and you're adding more in this patch=
=2E
>> >
>> >We should have a helper function for this encoding as it seems to=20
>> >repeat=2E That is, something that takes tunable_attr and mode as input
>> >(the conversion of existing entries should be in own patch preceeding=
=20
>> >this fix patch)=2E
>> >
>>=20
>> Hi Ilpo,
>>=20
>> A function for that is added in patch 10, though it is slightly modifie=
d=20
>> from that to be more flexible is tunable_attr isn't used (such as with=
=20
>> the fan test attributes)
>
>It still leaves some boilerplate having to deref all those tunable_attr=
=20
>fields so perhaps it would be better to do nested helpers, one taking=20
>tunable_attr and that calls the more flexible helper=2E IMO that would be=
=20
>the best approach here=2E
>

That's simple enough=2E I assume that can be added to that same patch inst=
ead of an additional one?

- Derek

>> Originally I had that patch preceding any additions, but after=20
>> discussing with Rong we felt like it would be easier for stable=20
>> backports if all the fixes were upfront=2E I can certainly move it back=
=20
>> if you still prefer=2E
>
>I see=2E This patch would be cleaner though if we have the helper already=
 in=20
>place but I'm not insisting if you two prefer the current order of the=20
>patches=2E
>


