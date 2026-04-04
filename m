Return-Path: <stable+bounces-233300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v9/2K+WH0WmMKwcAu9opvQ
	(envelope-from <stable+bounces-233300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9439CA67
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8FF4300B98D
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A23537FF;
	Sat,  4 Apr 2026 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="dFCcZSVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l803stDG"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D212D1F1;
	Sat,  4 Apr 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775339490; cv=none; b=T12ynkbq46cM37PuoboI1D80MzY8cniHOUzhI8OJKIGU8wi3B17rTp4tYqicPOtBtxVOIkpVK7xlXZphfmH0Mh2X4ckfZHZowftURdtHkSfW0+wPS4fXWdkiuBGUVRfqiyv8ETHZFK0iUxXWbV56NJ7yLXMWYFr3QWyNZxmmH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775339490; c=relaxed/simple;
	bh=0TGGy4xs/3Qm62fPKz5GzKeBjjv/QFumGq2CRV+GIYc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YfkpsnfuqD/SjXJZol3181FUsh2hvX/uP9Tx0IRl2dGlidbeopeWZ+C8K5drjqkFU6IxsjQLqCQBcMSNKnTzdxU/5OWBvStSm0sEAmpqhH87KC+kuwf8zxpzyMXhbfr6BH9lxJkTDfH0EkVdJix5QwEFajpZrwoUfFpl7Wz50oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=dFCcZSVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l803stDG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D188EC0090;
	Sat,  4 Apr 2026 17:51:26 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sat, 04 Apr 2026 17:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775339486;
	 x=1775425886; bh=G8h72ka5Q/2aOd1dhna+wGDc7iM6FtED7LlbfdQbOUY=; b=
	dFCcZSVFedcGrTLR6IsrKQDYQF/HDD9fUxTduybPQQlvM8CS5RApz5/KmRMOo0Rt
	3yD+ZlKJTnLAbw3ZfkHuX0AbCEChXmqMtJyAT6Puui46Qhl5VtRHvhpZ+MNNFToD
	86+w7Pi7LtIhPXkX3WZnIqPAcZs4dshJ2men0bvtWKCA2sf8kEGhYn4ISi3pO5Ur
	UKfHj6D6lLRl+K2UQdVWtfFd1nnazh5J6A14I8VEQRGCd59mRUjj88Kn7c6+meeC
	JlxWrPIGJOhZV2GKH89dQ2zGpdgf0n4SjHWGPAlPJAhsZKlY6H+t+rBv3su/m3Os
	fPzRMrrLwOvV1gTGDVkYqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775339486; x=
	1775425886; bh=G8h72ka5Q/2aOd1dhna+wGDc7iM6FtED7LlbfdQbOUY=; b=l
	803stDG/fEp5fbuQEGVqMluE98tR6RnycrhwrLraMfj5Pk67zljHPcNapHC5SLxs
	Hua00sA4AegeacbQB4Au+ngQ/Ky/eL+vrVNF2yFHvczkjhIOycmE4P/vayDpyQD1
	/78jJ/A1jB+dx5oDBpTELoXBGeRxFl21GQm0svFfFB1HH3/rSPiJ3spI9oT1brA2
	hHyuvpQZsCnDTSZvcV0NqKrwwnAJe5GQG1p3Z9IVXJeqOe9sJwx+EMuYXYIeT2Gk
	swiAQY7NQcXUsqBi6uALl+1gNIRQjRyLV0+o/B22WDBdlVDxEsadfBdV+z/qS/yl
	V25lz5mlQdjwYDtolfCxQ==
X-ME-Sender: <xms:3YfRaSynWTyC_qvubGQbII-bALTOv0gcIl9g3ZJ1FIeLq65PR2997g>
    <xme:3YfRaZGJfF6VNG0JdjugIwpfIGd7looWivtohwd0B3JBL8n5eGxP58cF4VNBrY37V
    hJFjyOtbz7pQ_a4fEMl9ZBRckD_r70-wi3K8Ia49uwcYoSTIKk0x_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnheptdffvefgtefhveetuddvfeelveektdduvdelgfehgfei
    keffjeetjeevffektdfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdq
    lhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedutddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkuhhurhhtsgesghhmrghilhdrtghomhdprhgtphhtth
    hopeifpggrrhhmihhnsehgmhigrdguvgdprhgtphhtthhopehhrghnshhgsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthht
    ohepihesrhhonhhgrdhmohgvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgv
    rhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3YfRaR-I_KMpM4DFNy8ybrTELDNSaoYpW6U_KrKot4RMZrguzSu6Gw>
    <xmx:3YfRaT9V3nUcM_g0SX8W_BiKZyA1-NZ5-91k2qk2fRMI3YHYWZfOIw>
    <xmx:3YfRaYUpox9Amr-0JjuR6ffInqMSj0uCsSpcqjq_S6ovelf47MU5Zw>
    <xmx:3YfRaYf-RqPFeLsEGRYKNn113To9mIkg4O3bgUa46W29y31Ea9hk9w>
    <xmx:3ofRafDZuy9FMw7wPnt86Aq07R27q--2YZ47vLh6ao0so8nKsaWRXA7n>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 37F312CE3F98; Sat,  4 Apr 2026 17:51:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AslR-nfUL6QJ
Date: Sat, 04 Apr 2026 17:51:04 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hansg@kernel.org>
Cc: "Armin Wolf" <W_Armin@gmx.de>, "Jonathan Corbet" <corbet@lwn.net>,
 "Rong Zhang" <i@rong.moe>, "Kurt Borja" <kuurtb@gmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <b1877396-593b-47a0-b84c-30e6f000d759@app.fastmail.com>
In-Reply-To: <20260402032424.678528-7-derekjohn.clark@gmail.com>
References: <20260402032424.678528-1-derekjohn.clark@gmail.com>
 <20260402032424.678528-7-derekjohn.clark@gmail.com>
Subject: Re: [PATCH v7 06/16] platform/x86: lenovo-wmi-other: Limit adding attributes
 to supported devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[squebb.ca:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233300-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[squebb.ca];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[squebb.ca:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpearson-lenovo@squebb.ca,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.837];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 58F9439CA67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Derek,

On Wed, Apr 1, 2026, at 11:24 PM, Derek J. Clark wrote:
> Adds lwmi_is_attr_01_supported, and only creates the attribute subfolder
> if the attribute is supported by the hardware. Due to some poorly
> implemented BIOS this is a multi-step sequence of events. This is
> because:
> - Some BIOS support getting the capability data from custom mode (0xff),
>   while others only support it in no-mode (0x00).
> - Some BIOS support get/set for the current value from custom mode (0xff),
>   while others only support it in no-mode (0x00).
> - Some BIOS report capability data for a method that is not fully
>   implemented.
> - Some BIOS have methods fully implemented, but no complimentary
>   capability data.
>
> To ensure we only expose fully implemented methods with corresponding
> capability data, we check each outcome before reporting that an
> attribute can be supported.
>

I've been trying to go through this series a bit more carefully, while reading the (not exactly clear) Lenovo internal spec.
I was curious if the cap00, ID 290000, method would work here? ("Thermal Mode Capability")

I don't have systems to try it out on, but it looked like it might give you which modes are supported (or not). Not sure if it would be more reliable than the cap01 methods?

Apologies if you've tried this before and it doesn't work - just wanted to check. Nothing wrong (that I can see) with your method below if that's safer :)

Mark

> Checking for lwmi_is_attr_01_supported during remove is not done to
> ensure that we don't attempt to call cd01 or send WMI events if one of
> the interfaces being removed was the cause of the driver unloading.
>
> Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
> Reported-by: Kurt Borja <kuurtb@gmail.com>
> Closes: 
> https://lore.kernel.org/platform-driver-x86/DG60P3SHXR8H.3NSEHMZ6J7XRC@gmail.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Rong Zhang <i@rong.moe>
> Tested-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v7:
>   - Move earlier in the series. This required dropping the use of
>     lwmi_attr_id as it will be added later.
>   - Add missing switch between cd_mode_id and cv_mode_id in
>     current_value_store.
> v6:
>   - Zero initialize args in lwmi_is_attr_01_supported.
>   - Fix formatting.
> v5:
>   - Move cv/cd_mode_id refrences from path 3/4.
>   - Add missing import for ARRAY_SIZE.
>   - Make lwmi_is_attr_01_supported return bool instead of u32.
>   - Various formatting fixes.
> v4:
>   - Use for loop instead of backtrace gotos for checking if an attribute
>     is supported.
>   - Add include for dev_printk.
>   - Wrap dev_dbg in lwmi_is_attr_01_supported earlier.
>   - Don't use symmetric cleanup of attributes in error states.
> ---
>  drivers/platform/x86/lenovo/wmi-gamezone.h |   1 +
>  drivers/platform/x86/lenovo/wmi-other.c    | 114 ++++++++++++++++++---
>  2 files changed, 98 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h 
> b/drivers/platform/x86/lenovo/wmi-gamezone.h
> index 6b163a5eeb95..ddb919cf6c36 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.h
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.h
> @@ -10,6 +10,7 @@ enum gamezone_events_type {
>  };
> 
>  enum thermal_mode {
> +	LWMI_GZ_THERMAL_MODE_NONE =	   0x00,
>  	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
>  	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
>  	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c 
> b/drivers/platform/x86/lenovo/wmi-other.c
> index 0e8a69309ec4..3e7dfe94499b 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -550,6 +550,8 @@ struct tunable_attr_01 {
>  	u8 feature_id;
>  	u8 device_id;
>  	u8 type_id;
> +	u8 cd_mode_id; /* mode arg for searching capdata */
> +	u8 cv_mode_id; /* mode arg for set/get current_value */
>  };
> 
>  static struct tunable_attr_01 ppt_pl1_spl = {
> @@ -775,7 +777,6 @@ static ssize_t attr_current_value_store(struct 
> kobject *kobj,
>  	struct wmi_method_args_32 args = {};
>  	struct capdata01 capdata;
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	u32 value;
>  	int ret;
> 
> @@ -786,13 +787,12 @@ static ssize_t attr_current_value_store(struct 
> kobject *kobj,
>  	if (mode != LWMI_GZ_THERMAL_MODE_CUSTOM)
>  		return -EBUSY;
> 
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cd_mode_id) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> 
> -	ret = lwmi_cd01_get_data(priv->cd01_list, attribute_id, &capdata);
> +	ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
>  	if (ret)
>  		return ret;
> 
> @@ -803,7 +803,10 @@ static ssize_t attr_current_value_store(struct 
> kobject *kobj,
>  	if (value < capdata.min_value || value > capdata.max_value)
>  		return -EINVAL;
> 
> -	args.arg0 = attribute_id;
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, tunable_attr->cv_mode_id) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
>  	args.arg1 = value;
> 
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_SET,
> @@ -837,7 +840,6 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
>  	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
>  	struct wmi_method_args_32 args = {};
>  	enum thermal_mode mode;
> -	u32 attribute_id;
>  	int retval;
>  	int ret;
> 
> @@ -845,13 +847,14 @@ static ssize_t attr_current_value_show(struct 
> kobject *kobj,
>  	if (ret)
>  		return ret;
> 
> -	attribute_id =
> -		FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> -		FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> -		FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> -		FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +	/* If "no-mode" is the supported mode, ensure we never send current mode */
> +	if (tunable_attr->cv_mode_id == LWMI_GZ_THERMAL_MODE_NONE)
> +		mode = tunable_attr->cv_mode_id;
> 
> -	args.arg0 = attribute_id;
> +	args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, tunable_attr->device_id) |
> +		    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +		    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, mode) |
> +		    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> 
>  	ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
>  				    (unsigned char *)&args, sizeof(args),
> @@ -862,6 +865,81 @@ static ssize_t attr_current_value_show(struct 
> kobject *kobj,
>  	return sysfs_emit(buf, "%d\n", retval);
>  }
> 
> +/**
> + * lwmi_attr_01_is_supported() - Determine if the given attribute is 
> supported.
> + * @tunable_attr: The attribute to verify.
> + *
> + * First check if the attribute has a corresponding capdata01 table in 
> the cd01
> + * module under the "custom" mode (0xff). If that is not present then 
> check if
> + * there is a corresponding "no-mode" (0x00) entry. If either of those 
> passes,
> + * check capdata->supported for values > 0. If capdata is available, 
> attempt to
> + * determine the set/get mode for the current value property using a 
> similar
> + * pattern. If the value returned by either custom or no-mode is 0, or 
> we get
> + * an error, we assume that mode is not supported. If any of the above 
> checks
> + * fail then the attribute is not fully supported.
> + *
> + * The probed cd_mode_id/cv_mode_id are stored on the tunable_attr for 
> later
> + * reference.
> + *
> + * Return: bool.
> + */
> +static bool lwmi_attr_01_is_supported(struct tunable_attr_01 
> *tunable_attr)
> +{
> +	u8 modes[2] = { LWMI_GZ_THERMAL_MODE_CUSTOM, 
> LWMI_GZ_THERMAL_MODE_NONE };
> +	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
> +	struct wmi_method_args_32 args = { 0x0, 0x0 };
> +	bool cd_mode_found = false;
> +	bool cv_mode_found = false;
> +	struct capdata01 capdata;
> +	int retval, ret, i;
> +
> +	/* Determine tunable_attr->cd_mode_id*/
> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, 
> tunable_attr->device_id) |
> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +
> +		ret = lwmi_cd01_get_data(priv->cd01_list, args.arg0, &capdata);
> +		if (ret || !capdata.supported)
> +			continue;
> +		tunable_attr->cd_mode_id = modes[i];
> +		cd_mode_found = true;
> +		break;
> +	}
> +
> +	if (!cd_mode_found)
> +		return cd_mode_found;
> +
> +	dev_dbg(tunable_attr->dev,
> +		"cd_mode_id: %#010x\n", args.arg0);
> +
> +	/* Determine tunable_attr->cv_mode_id, returns 1 if supported*/
> +	for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +		args.arg0 = FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, 
> tunable_attr->device_id) |
> +			    FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, tunable_attr->feature_id) |
> +			    FIELD_PREP(LWMI_ATTR_MODE_ID_MASK, modes[i]) |
> +			    FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, tunable_attr->type_id);
> +
> +		ret = lwmi_dev_evaluate_int(priv->wdev, 0x0, LWMI_FEATURE_VALUE_GET,
> +					    (unsigned char *)&args, sizeof(args),
> +					    &retval);
> +		if (ret || !retval)
> +			continue;
> +		tunable_attr->cv_mode_id = modes[i];
> +		cv_mode_found = true;
> +		break;
> +	}
> +
> +	if (!cv_mode_found)
> +		return cv_mode_found;
> +
> +	dev_dbg(tunable_attr->dev, "cv_mode_id: %#010x, attribute support 
> level: %#010x\n",
> +		args.arg0, capdata.supported);
> +
> +	return capdata.supported > 0 ? true : false;
> +}
> +
>  /* Lenovo WMI Other Mode Attribute macros */
>  #define __LWMI_ATTR_RO(_func, _name)                                  \
>  	{                                                             \
> @@ -985,12 +1063,14 @@ static void lwmi_om_fw_attr_add(struct 
> lwmi_om_priv *priv)
>  	}
> 
>  	for (i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++) {
> +		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
> +		if (!lwmi_attr_01_is_supported(cd01_attr_groups[i].tunable_attr))
> +			continue;
> +
>  		err = sysfs_create_group(&priv->fw_attr_kset->kobj,
>  					 cd01_attr_groups[i].attr_group);
>  		if (err)
>  			goto err_remove_groups;
> -
> -		cd01_attr_groups[i].tunable_attr->dev = &priv->wdev->dev;
>  	}
>  	return;
> 
> -- 
> 2.53.0

