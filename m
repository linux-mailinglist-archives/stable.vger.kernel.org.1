Return-Path: <stable+bounces-83264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04374997558
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C17285CE0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563D1A286D;
	Wed,  9 Oct 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpbaLkvK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400A1E5704;
	Wed,  9 Oct 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500459; cv=none; b=SL273m87/8ubucogNvw51p5AwDk9k8uJJlyTZWCvyJgovK3LcrjZKo+u59Tpjjxk502+jYhDJbihB/HQLsIlFYLruljTG3ZpRX2RoQAbyTamUMFHpg7fOjAIdHcAB4WatKP8ogXRq9LJKuBXVxvtf5vDP9EIfeBxxp0V+IwIlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500459; c=relaxed/simple;
	bh=xfVX20iq/fvCNNDymhtyhei4CPO+G7cClG0ZFUmkiMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea/ZFbFbZiyEo+H9xwpmkpg+HUzggnJzhLhRWwCn3gR2CyZORTmpWnZ9lxykpIFZr8ch98pe048KFr0zm6NM/6K5bvv90rd30aRVCWfTbjYVUWbMlYg8NqQxuNrQVotwkRjtKzoK0uDhCf2ADazRbHyf9oHDoj51g7nk5siZ1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpbaLkvK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so743905e9.3;
        Wed, 09 Oct 2024 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728500446; x=1729105246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5N8/fjlE0efDR6dBiW5OBlDtiY5DqAblDupUGfXzs0I=;
        b=JpbaLkvKIHzUJ2IT2WIAEuRBlVSE1qSs1CvZHBCRA+mh+glE7jZtg2hJQcXOtOTgjE
         gvD5TAv5SE5KeYeySrf65YjB7lI6ln14pCwNKVZ7oS1pdfNtf7XVkH3pz7rOx2HJxke2
         BdIsnuZFfV393yS4Tf06R6t7kMQis6WPyiuEWinMsOCBOZN4293h6idkSFTJS5Ma9uC7
         Sx2DIkz/OX045SZnbl2FjgnWP6LzMcbdV1xoAF9nfBRby5gBkHWqe5Ev9JuTO7vCKo6S
         rklHZQKRlrRbv1e5+nT6SPNdAOAI3yHCrhE30LJwwvJFepBqwVrlwxHwsvyzXPsyn7dh
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500446; x=1729105246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N8/fjlE0efDR6dBiW5OBlDtiY5DqAblDupUGfXzs0I=;
        b=M1I8G45zI8jsWaHppd0ZQ/8yjgZl9LQKCHIAEoQgVvrcsQ/49aa6gBmBoYxZpS01IP
         F/yOYhwOo6Nlf1IMRpU6GpZsm0wmNR0B0nhQbTVFwlDDeBEIEBk9vCTZQJChllX+GDr5
         wXHrL70wIooO149TgzJMUfObCmMGo6zBlI5VZJC+0xPSS6ErBn9PmRl0CK8KOe/N0Sad
         RCmtb75SV8dY6y5weIMArtyab7Vi26FsFDZM7RcB1YyuaWmBE0pJjUze2vKCnhwbRSD1
         PSUvdpCs8sPfZuGMsf4nBTdcS+PVHbTwaxPB9M0OCVMqJe78LvzqfPXDa9cf3Y5qs4RM
         7A6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjCyHDp/ImVsTghPsdgiWYZK9yP5fOA0Yf7BfRny99qEo/tWkvLpBvvR9zpmNKzTLK/Ag0xN+kqJGvt9c=@vger.kernel.org, AJvYcCWOKmbjAdB1G+6mEISKSJ7E9931jfCoOf4+0OdDCLiLzidlYX6rNod5AbXq/PpaHCexZvP0c8uR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4ar9VFHHkboyE3Lra2JvJZjxcA2AgBP53J0gqLe/ee5ZT39z
	XZ70hYd9WAvlVpTJMPzv74rdCGy2k3OpyIsHCw3ZZHAHL4WIt1Iq
X-Google-Smtp-Source: AGHT+IEGCCHp3D/6Dt9OSOkQA2nDN2D7cRs2CWGmw2cTfgoWx0J7ELUF5pZXGr2nQ7WK/SpT/WIvbw==
X-Received: by 2002:a05:6000:b82:b0:371:8f32:557e with SMTP id ffacd0b85a97d-37d3aa8f54amr2418657f8f.39.1728500446339;
        Wed, 09 Oct 2024 12:00:46 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:268e:1448:f66b:a421? (2a02-8389-41cf-e200-268e-1448-f66b-a421.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:268e:1448:f66b:a421])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d443cb76dsm1612731f8f.67.2024.10.09.12.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:00:45 -0700 (PDT)
Message-ID: <7767afd2-0ada-4cca-8861-ccdc874d555b@gmail.com>
Date: Wed, 9 Oct 2024 21:00:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/chrome: cross_ec_type: fix missing fwnode
 reference decrement
To: Prashant Malani <pmalani@chromium.org>, Benson Leung
 <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241009-cross_ec_typec_fwnode_handle_put-v1-1-f17bdb48d780@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241009-cross_ec_typec_fwnode_handle_put-v1-1-f17bdb48d780@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2024 20:55, Javier Carrasco wrote:
> The device_for_each_child_node() macro requires explicit calls to
> fwnode_handle_put() upon early exits (return, break, goto) to decrement
> the fwnode's refcount, and avoid levaing a node reference behind.
> 
> Add the missing fwnode_handle_put() after the common label for all error
> paths.
> 
> Cc: stable@vger.kernel.org
> Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> I usually switch to the scoped variant of the macro to fix such issues,
> but given that the fix is relevant for stable kernels, I have provided
> the "classical" approach by adding the missing fwnode_handle_put().
> 
> If switching to the scoped variant is desired, please let me know.
> This driver and cross_typec_switch could be easily converted.
> 
> By the way, I wonder why all error paths are redirected to the same
> label to unregister ports, even before registering them (which seems to
> be harmless because unregistered ports are ignored, but still). With this
> fix, that jump to the label is definitely required, but if the scoped
> variant is used, maybe some simple returns would be enough.
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index c7781aea0b88..f1324466efac 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -409,6 +409,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  	return 0;
>  
>  unregister_ports:
> +	fwnode_handle_put(fwnode);
>  	cros_unregister_ports(typec);
>  	return ret;
>  }
> 
> ---
> base-commit: b6270c3bca987530eafc6a15f9d54ecd0033e0e3
> change-id: 20241009-cross_ec_typec_fwnode_handle_put-9f13b4bd467f
> 
> Best regards,

Small typo in the description, should be cross_ec_typec (last c is
missing). I will fix that for v2, but I will wait for feedback and
reviews to this first version.

Best regards,
Javier Carrasco

