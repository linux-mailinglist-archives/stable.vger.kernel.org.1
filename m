Return-Path: <stable+bounces-254657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGoEI6dHF2qS/QcAu9opvQ
	(envelope-from <stable+bounces-254657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:36:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7C25E98F8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EC73045DDD
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5038947D;
	Wed, 27 May 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJa0tRAT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C63890F1
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910504; cv=none; b=Bw/Pb4LLMZwc+TzW7hViMR6NNPBAPlU3+f5Hp/zJWnEtccXOapsTpv0yaOJX68AP+urYGcbE2iAcHxhHn9gmLL8tNlXtlwoRu/jh3JtQpsDDYr/YDGmwX6aZDJ7pnjv167iLbIo8J1gmt1SQlOa6Kc/lzSr21cEC4AyazfVQPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910504; c=relaxed/simple;
	bh=gNtu3I8dan5PtJoijFcBOSVKlBDemQlQMVY7dWwaBXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtKYz1f6XDd+JYE4BFhLsaqCQLMVmLGGxtzWm3MyFi6Sfmqmjyfh5zaKY1NjGPJ7J0/3ESjg6PxwdN8sVzIm5AWALbPhJssPPTpjV4FWFAryczrTq6839ywSMd2HWH6kRD9lZ2hYoR3b8cbsuNwslw1ABYtcDeEaHhqMwOozrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJa0tRAT; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304997cdb21so4386037eec.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779910486; x=1780515286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTNqcC36SPBRRdFnrJ/yAEkzgUWymNhZiWM/17f+GfM=;
        b=sJa0tRAToHWmztCbhBLAZtOZPSAPZDxvFd7cXV5tYfWVx1gPxMimGz6hgvxjY9AYv/
         j0wkYVubL1rnelar+UvbNtkKuBRs461rg8YyMBzAKbkzb8OH3AhcU89QPa9NuzRI1Mau
         K2LYiMi8WpR1YYWG8AbxOEGbihX2MqrO0jzsDXvPGyQKBNzBgQO6m2nPySAcX8srnZNX
         SchObzcDz9MgU08n7WPU7Ga+bgNaHDu0JNiE+lqjqX1pzqV6diVcvXxDATy7SNac1wNy
         NF3Nq0yUlDTDgYCxgWXE9d7JzscSyS+7GaNaKI8q4ILUBtfWBVR6On3kyh/WIIYFCLcN
         fZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910486; x=1780515286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTNqcC36SPBRRdFnrJ/yAEkzgUWymNhZiWM/17f+GfM=;
        b=BiqDoq90lVRwTjJWXWe7tJMK/r8YYn6B0dVDcsVki1CYMol88Z4QPBV+p3UrGg0PY3
         8yW1pjQSfoToeA8rag7RmaVSvfxK+lNdWU+nlt315VikmvxRZsrOsSNmhTbx9hj+3m65
         fhjjvV0h9ugvzbCiYpXXvRFv0bqhuHJYZOvTBvSKvn8486qB+6EkPEvam0cnWrzHpgIM
         tXDfLJlmY7+GafQ7R3MP+f6aKTfNULKS/HKmcHTtesUtZEiHsNi+Uqv93a7/5r4ZrUZ/
         5DY0rWXzxzMHPNBH2NagRVO5hiRcmIWUPsciOec9iEZajyAVN3TRqUW0RJz0Srg4uQ8m
         quVA==
X-Forwarded-Encrypted: i=1; AFNElJ+nRTKdnZmXdzSJW+4qSo+g2DjFCHLZ6d4yKOACtdjCEj7M24BmJA2uiIrsy5ll4AoyDAyvFGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsiq+seL5/7U1pH973zEW3PGYiHQXf6VMxzJgEhmFnASUb/QV+
	Y9mntFG4+2b2JRUSfh3xGbauODxRxiFZH1LxtHKFHHX7b1qig9Q1CbED
X-Gm-Gg: Acq92OFmzF5iDmR0qGexVba2h4K2rkeezAnEPkyyGdu/Q89IHH27nWIkUZc/IfuKbRj
	8B32x15Jb5X5LefcZVn7FawGxUUg8DGfkTPBvlDnmd34VNOAGmULnklXGgSQ+0qWd0rimdxeUOt
	oaN4AjDxxpk3WQ4yQZuei56bApb+pyUUjQ+KDRVRH8aZkX2aJBeNhYX2ZYqtnvVglo7bmSnWUnM
	lSNw2KThWIzVnHRT2o35NvyLmkjmHNcy/K0Op2B1m6GCSSMIJgb93lE3fgyEaz8WK5ay4iYA7fG
	uY1X07nvLuyD4qqx66KoAXDn6dSQ4k1JALiXMn8HiFHPJk6iXR0kyze0gKicONLCW6dfHOIKY10
	ZE/rTtVos7he9FILBaUinGoCaE37uqM5s15NQzMYtGinnF0N3s9AvVk6Uqc0xRTBo820SHAybwu
	b12Z/kPG11+/zAx6fROWaknmUNhsYqgUl7BWL56JNSTbSYezeLqfTTAI00NyZk6SyW93BFNJkJK
	+I=
X-Received: by 2002:a05:7300:ef89:b0:2ed:23cd:babf with SMTP id 5a478bee46e88-304490906d0mr10929946eec.12.1779910485730;
        Wed, 27 May 2026 12:34:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304524610f7sm13502866eec.29.2026.05.27.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:34:44 -0700 (PDT)
Date: Wed, 27 May 2026 12:34:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe failures
Message-ID: <ahdE9G8I7kd_OoGW@google.com>
References: <20260524175552.1973-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524175552.1973-1-mhun512@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[wacom.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254657-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF7C25E98F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Myeonghun,

On Mon, May 25, 2026 at 02:53:33AM +0900, Myeonghun Pak wrote:
> wacom_parse_and_register() starts HID hardware before registering inputs
> and initializing pad LEDs/remotes. Those later steps can fail, but their
> error paths currently release Wacom resources without stopping the HID
> hardware.
> 
> Route post-hid_hw_start() failures through hid_hw_stop() before
> releasing driver resources.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0d1c6d90fe..c824d9c224 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
>  
>  	error = wacom_register_inputs(wacom);
>  	if (error)
> -		goto fail;
> +		goto fail_hw_stop;
>  
>  	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
>  		error = wacom_initialize_leds(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
>  
>  		error = wacom_initialize_remotes(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
>  	}
>  
>  	if (!wireless) {
> @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
>  	return 0;
>  
>  fail_quirks:
> +fail_hw_stop:
>  	hid_hw_stop(hdev);
>  fail:
>  	wacom_release_resources(wacom);

I'd get rid of 'fail_quirks' and use 'fail_hw_stop' everywhere,
otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

