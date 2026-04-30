Return-Path: <stable+bounces-242136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOVBENBt82m42gEAu9opvQ
	(envelope-from <stable+bounces-242136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18C4A455B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 664DE3009811
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EF0436353;
	Thu, 30 Apr 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsRxFjGP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB599227B94
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560990; cv=none; b=p12PbgEsOJkvsDHvhcngzOs9JUT/ZHwrWmQ2WAAnE3Qaj2FlccoEOsoFH2pFXDR7PG9G0Kg69tEi/lar9jhcB10v7Gm9EaDY9WTzz6qNM78Tm0fdpGni1zix1oSWxT6fR6y11CVuBdgRVRKj/TWlyhA+n0Dlfg7J9ZvaQr+ITyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560990; c=relaxed/simple;
	bh=nVVdyvWnvMEChGYctnaNOUiWzvIlGJUOyhpd4ZKbW0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VQdWUJDmrPxVB/ae42Mve/x4ve9PGEI+gN89sbTXpso798VG6vrQkwaaELZL242yST3V6DSpBUg1ZSvnT7li9y7q7vm86EZzBYYloNcvOeXjwyX6gWUymmDvGgP6PXM8GkrBZrlIX4Q0BmCgFiXfSKjMnj5tZuPK9mk34kaYToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsRxFjGP; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so404629eec.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777560988; x=1778165788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LUNPqyzWnajU/PD+h7ddsaH410QkU1Ojez7rgykqDvg=;
        b=YsRxFjGPL4tdYC3UGYkm7AczH4vFzmY279qmNYdUo9wdQi9/6Em5T5g/KhlGLJgZyu
         Nck+JA9IDP0b6CAUtnZcPA3UDLnXGRSzakTsyZHXS1LPWIFpBUdnjVJX0uzIqAtON91Y
         nRxck7BqSxwmJ/zBu2/Dtc+MMfd7yuEgqxCZgwjiWcpOZVEuM+PG1chAW56ONrNlxMKz
         BcwYbWBEfyNwkynsnt6zA/yrI2J6kM9HbUF5Uv/cce8quma2P+v7at+WW8cK1YC8pRpq
         /dno3ZHtOyy6Bg7SqbciNbwGEKV+RQJtU2IIbY2Eukx8+0rvblmw1yYbxY16UIYo4COG
         JXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777560988; x=1778165788;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUNPqyzWnajU/PD+h7ddsaH410QkU1Ojez7rgykqDvg=;
        b=cSA6tyYKEQve1tVi/X1Lh2iZMkQStdH3UhTcwHGGedcNoP0x6gXtMIkXB31j3nMOxA
         wFAFT6I+vgkKpUQysG3wKW1uPeUMSH0adrNcbWvURW98Q5wwsSJs60/qxk55nXTI+ksA
         jXUKK7ZYFVcn8k9MbV5NYuVxkWdz+a9diTSZEk45sXQvfjJQh6RvpeURXOMmQk49A4kv
         VCKGdbDkEKxiq7obkZxUnVHLlLZWoTYk7YHgbO+SLU+bPoLoSvwjf/V6KUtxuI/350Jz
         771ZLg8sKqrP7a65+zcPpyFK4e2X9ypqH1QkVXz8ibDWm75qLAt/jMJbURZoIUDtLezx
         FXQw==
X-Forwarded-Encrypted: i=1; AFNElJ/vcIFNO4iVEPI9+JcqWUoigRjBx8mEo7y2VWNZshofA2dIjvvXqXvsievWrNEo04/7bwFArzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBmXyO1mpcokJY/TxW/Xm7DEFQHMbeE0XQQZ29jTjUlJeZM9X
	gwa/Nc2QxSiwf6FcGQq4dW/wA0nE+MzPtN3zUa710ARwRckclXgu6Lkk
X-Gm-Gg: AeBDiev287Pa2BqiyK6MdfTIaNHs8Yp2897waFEUqmGueMJZiISSE9hOB5fWkN1sGK4
	SRD3Cw0dmCo3uEsyUDhLMCsxL/Tx898PEUNPEzwSy5hJ405naALR1EchjDSj7ai/h97TnInfYn5
	AAhVODC8rHdBLf3EWX05SoSVAT9a4PgNmDMtkmWsLPtCgHgbx10XEs/jX/9MctRfFQqi8jZWxAy
	ktQfRpFMVjOkguEFWRnNScUQZ/2MkB+UMeKtYmDW/2o/xI/FQdkxWkQuNtkDoCy11s4UijBUWG3
	/vgjhEfMqvYGUwcI7Ei/08+sG9YFwXh48Tk6ob9IEb7N3beafAvwP5QAjRtgM+uxQYqO4sn+Ysf
	BG1oyBOcvFAvT5NSfU3BOJW24V/WLhjATlg2YydkY4iHqF3Lv+Zcxt70s0hhs9Nr54iVxYIDni/
	08HWS6pZYTetr7dasn2ToVFiMCwF1fqDAihmHxKslZxJul6Vlw6c9zpxiZ4oni8bzGKg==
X-Received: by 2002:a05:7300:7b89:b0:2d4:532e:7e45 with SMTP id 5a478bee46e88-2ed3dbbf845mr1697251eec.23.1777560987790;
        Thu, 30 Apr 2026 07:56:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2607:fb90:fde2:1502:ac39:c338:9ab8:e005])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d628sm230215eec.6.2026.04.30.07.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 07:56:27 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:56:27 -0700
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
In-Reply-To: <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com>
References: <20260412211121.2220556-1-derekjohn.clark@gmail.com> <20260412211121.2220556-7-derekjohn.clark@gmail.com> <1ce1d6f6-9196-c8a1-913d-4bdec2b1af80@linux.intel.com>
Message-ID: <AA4D5F92-E158-48D1-85FC-CAA72A4EDD8A@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6C18C4A455B
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
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	URIBL_MULTI_FAIL(0.00)[squebb.ca:server fail,intel.com:server fail,rong.moe:server fail,sin.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242136-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,rong.moe:email,squebb.ca:email]

On April 30, 2026 7:01:55 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvinen@lin=
ux=2Eintel=2Ecom> wrote:
>On Sun, 12 Apr 2026, Derek J=2E Clark wrote:
>
>> Adds lwmi_is_attr_01_supported, and only creates the attribute subfolde=
r
>> if the attribute is supported by the hardware=2E Due to some poorly
>> implemented BIOS this is a multi-step sequence of events=2E This is
>> because:
>> - Some BIOS support getting the capability data from custom mode (0xff)=
,
>>   while others only support it in no-mode (0x00)=2E
>> - Some BIOS support get/set for the current value from custom mode (0xf=
f),
>>   while others only support it in no-mode (0x00)=2E
>> - Some BIOS report capability data for a method that is not fully
>>   implemented=2E
>> - Some BIOS have methods fully implemented, but no complimentary
>>   capability data=2E
>>=20
>> To ensure we only expose fully implemented methods with corresponding
>> capability data, we check each outcome before reporting that an
>> attribute can be supported=2E
>>=20
>> Checking for lwmi_is_attr_01_supported during remove is not done to
>> ensure that we don't attempt to call cd01 or send WMI events if one of
>> the interfaces being removed was the cause of the driver unloading=2E
>>=20
>> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
>> Reported-by: Kurt Borja <kuurtb@gmail=2Ecom>
>> Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/DG60P3SHXR8H=2E=
3NSEHMZ6J7XRC@gmail=2Ecom/
>> Cc: stable@vger=2Ekernel=2Eorg
>> Reviewed-by: Rong Zhang <i@rong=2Emoe>
>> Tested-by: Rong Zhang <i@rong=2Emoe>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb=2Eca>
>> Signed-off-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>> ---
>> v7:
>>   - Move earlier in the series=2E This required dropping the use of
>>     lwmi_attr_id as it will be added later=2E
>>   - Add missing switch between cd_mode_id and cv_mode_id in
>>     current_value_store=2E
>> v6:
>>   - Zero initialize args in lwmi_is_attr_01_supported=2E
>>   - Fix formatting=2E
>> v5:
>>   - Move cv/cd_mode_id refrences from path 3/4=2E
>>   - Add missing import for ARRAY_SIZE=2E
>>   - Make lwmi_is_attr_01_supported return bool instead of u32=2E
>>   - Various formatting fixes=2E
>> v4:
>>   - Use for loop instead of backtrace gotos for checking if an attribut=
e
>>     is supported=2E
>>   - Add include for dev_printk=2E
>>   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier=2E
>>   - Don't use symmetric cleanup of attributes in error states=2E
>> ---
>>  drivers/platform/x86/lenovo/wmi-gamezone=2Eh |   1 +
>>  drivers/platform/x86/lenovo/wmi-other=2Ec    | 114 ++++++++++++++++++-=
--
>>  2 files changed, 98 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh b/drivers/pla=
tform/x86/lenovo/wmi-gamezone=2Eh
>> index 6b163a5eeb95=2E=2Eddb919cf6c36 100644
>> --- a/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> +++ b/drivers/platform/x86/lenovo/wmi-gamezone=2Eh
>> @@ -10,6 +10,7 @@ enum gamezone_events_type {
>>  };
>> =20
>>  enum thermal_mode {
>> +	LWMI_GZ_THERMAL_MODE_NONE =3D	   0x00,
>>  	LWMI_GZ_THERMAL_MODE_QUIET =3D	   0x01,
>>  	LWMI_GZ_THERMAL_MODE_BALANCED =3D	   0x02,
>>  	LWMI_GZ_THERMAL_MODE_PERFORMANCE =3D 0x03,
>> diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers/platfo=
rm/x86/lenovo/wmi-other=2Ec
>> index 50a03f5fd6ab=2E=2E29d062a1c6dc 100644
>> --- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>> +++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>> @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>>  	u8 feature_id;
>>  	u8 device_id;
>>  	u8 type_id;
>> +	u8 cd_mode_id; /* mode arg for searching capdata */
>> +	u8 cv_mode_id; /* mode arg for set/get current_value */
>>  };
>> =20
>>  static struct tunable_attr_01 ppt_pl1_spl =3D {
>> @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct kobj=
ect *kobj,
>>  	struct wmi_method_args_32 args =3D {};
>>  	struct capdata01 capdata;
>>  	enum thermal_mode mode;
>> -	u32 attribute_id;
>>  	u32 value;
>>  	int ret;
>> =20
>> @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct ko=
bject *kobj,
>>  	if (mode !=3D LWMI_GZ_THERMAL_MODE_CUSTOM)
>>  		return -EBUSY;
>> =20
>> -	attribute_id =3D
>> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
>> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
>> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) |
>> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> =20
>> -	ret =3D lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
>> +	ret =3D lwmi_cd01_get_data(priv->cd01_list, args=2Earg0, &capdata);
>>  	if (ret)
>>  		return ret;
>> =20
>> @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct kob=
ject *kobj,
>>  	if (value < capdata=2Emin_value || value > capdata=2Emax_value)
>>  		return -EINVAL;
>> =20
>> -	args=2Earg0 =3D attribute_id;
>> +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
>> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) |
>> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>
>It's already repeated a few times and you're adding more in this patch=2E
>
>We should have a helper function for this encoding as it seems to=20
>repeat=2E That is, something that takes tunable_attr and mode as input
>(the conversion of existing entries should be in own patch preceeding=20
>this fix patch)=2E
>

Hi Ilpo,

A function for that is added in patch 10, though it is slightly modified f=
rom that to be more flexible is tunable_attr isn't used (such as with the f=
an test attributes)

Originally I had that patch preceding any additions, but after discussing =
with Rong we felt like it would be easier for stable backports if all the f=
ixes were upfront=2E I can certainly move it back if you still prefer=2E

Thanks,
Derek


>>  	args=2Earg1 =3D value;
>> =20
>>  	ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET=
,
>> @@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kobje=
ct *kobj,
>>  	struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
>>  	struct wmi_method_args_32 args =3D {};
>>  	enum thermal_mode mode;
>> -	u32 attribute_id;
>>  	int retval;
>>  	int ret;
>> =20
>> @@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct kob=
ject *kobj,
>>  	if (ret)
>>  		return ret;
>> =20
>> -	attribute_id =3D
>> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
>> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> +	/* If "no-mode" is the supported mode, ensure we never send current m=
ode */
>> +	if (tunable_attr->cv_mode_id =3D=3D LWMI_GZ_THERMAL_MODE_NONE)
>> +		mode =3D tunable_attr->cv_mode_id;
>> =20
>> -	args=2Earg0 =3D attribute_id;
>> +	args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devic=
e_id) |
>> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
>> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> =20
>>  	ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET=
,
>>  				    (unsigned char *)&args, sizeof(args),
>> @@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct kobj=
ect *kobj,
>>  	return sysfs_emit(buf, "%d\n", retval);
>>  }
>> =20
>> +/**
>> + * lwmi_attr_01_is_supported() - Determine if the given attribute is s=
upported=2E
>> + * @tunable_attr: The attribute to verify=2E
>> + *
>> + * First check if the attribute has a corresponding capdata01 table in=
 the cd01
>> + * module under the "custom" mode (0xff)=2E If that is not present the=
n check if
>> + * there is a corresponding "no-mode" (0x00) entry=2E If either of tho=
se passes,
>> + * check capdata->supported for values > 0=2E If capdata is available,=
 attempt to
>> + * determine the set/get mode for the current value property using a s=
imilar
>> + * pattern=2E If the value returned by either custom or no-mode is 0, =
or we get
>> + * an error, we assume that mode is not supported=2E If any of the abo=
ve checks
>> + * fail then the attribute is not fully supported=2E
>> + *
>> + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for=
 later
>> + * reference=2E
>> + *
>> + * Return: bool=2E
>> + */
>> +static bool lwmi_attr_01_is_supported(struct tunable_attr_01 *tunable_=
attr)
>> +{
>> +	u8 modes[2] =3D { LWMI_GZ_THERMAL_MODE_CUSTOM, LWMI_GZ_THERMAL_MODE_N=
ONE };
>> +	struct lwmi_om_priv *priv =3D dev_get_drvdata(tunable_attr->dev);
>> +	struct wmi_method_args_32 args =3D {};
>> +	bool cd_mode_found =3D false;
>> +	bool cv_mode_found =3D false;
>> +	struct capdata01 capdata;
>> +	int retval, ret, i;
>> +
>> +	/* Determine tunable_attr->cd_mode_id*/
>> +	for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
>> +		args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devi=
ce_id) |
>> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
>> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> +
>> +		ret =3D lwmi_cd01_get_data(priv->cd01_list, args=2Earg0, &capdata);
>> +		if (ret || !capdata=2Esupported)
>> +			continue;
>> +		tunable_attr->cd_mode_id =3D modes[i];
>> +		cd_mode_found =3D true;
>> +		break;
>> +	}
>> +
>> +	if (!cd_mode_found)
>> +		return cd_mode_found;
>> +
>> +	dev_dbg(tunable_attr->dev,
>> +		"cd_mode_id: %#010x\n", args=2Earg0);
>> +
>> +	/* Determine tunable_attr->cv_mode_id, returns 1 if supported*/
>> +	for (i =3D 0; i < ARRAY_SIZE(modes); i++) {
>> +		args=2Earg0 =3D FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->devi=
ce_id) |
>> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
>> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
>> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>> +
>> +		ret =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GE=
T,
>> +					    (unsigned char *)&args, sizeof(args),
>> +					    &retval);
>> +		if (ret || !retval)
>> +			continue;
>> +		tunable_attr->cv_mode_id =3D modes[i];
>> +		cv_mode_found =3D true;
>> +		break;
>> +	}
>> +
>> +	if (!cv_mode_found)
>> +		return cv_mode_found;
>> +
>> +	dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support lev=
el: %#010x\n",
>> +		args=2Earg0, capdata=2Esupported);
>> +
>> +	return capdata=2Esupported > 0 ? true : false;
>> +}
>> +
>>  /* Lenovo WMI Other Mode Attribute macros */
>>  #define __LWMI_ATTR_RO(_func, _name)                                  =
\
>>  	{                                                             \
>> @@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct lwmi_om_p=
riv *priv)
>>  	}
>> =20
>>  	for (i =3D 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
>> +		cd01_attr_groups[i]=2Etunable_attr->dev =3D &priv->wdev->dev;
>> +		if (!lwmi_attr_01_is_supported(cd01_attr_groups[i]=2Etunable_attr))
>> +			continue;
>> +
>>  		err =3D sysfs_create_group(&priv->fw_attr_kset->kobj,
>>  					 cd01_attr_groups[i]=2Eattr_group);
>>  		if (err)
>>  			goto err_remove_groups;
>> -
>> -		cd01_attr_groups[i]=2Etunable_attr->dev =3D &priv->wdev->dev;
>>  	}
>>  	return;
>> =20
>>=20
>


