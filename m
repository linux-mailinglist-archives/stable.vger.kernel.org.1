Return-Path: <stable+bounces-227874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO9ON8KawGmJJAQAu9opvQ
	(envelope-from <stable+bounces-227874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:43:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAB2EB8F8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85161302A040
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD81EDA0F;
	Mon, 23 Mar 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amorlrcv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924971E98E3
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230021; cv=none; b=gag+++czgMjkwkLMhV5nPxK5EatT2nTwZTIIfGJSO0tycchccMGqjoV2g2DgylvwYtKD7s79g0d/bPtUXBLW9z7o8vaxmfxwJsAcgacVGM1Ai0j5y63bEvgHuYgVzz5POuLV9U8FkOvRRDBq9i4UyBLvr6dRVIcRxO6sTwLwPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230021; c=relaxed/simple;
	bh=x+NQTNG7TLJbf1+gAkp809JyPlVQTm3JsLRUYPdDhxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBLQ7lEFV6BDOBMj9ks3o9xbXYb9btepxfB4r7Ag8Xf7lT6VMTAG8UU+rCKE/Hk9IHZ2eJ4qlG7LRmyKV0DMZV7IzLmiog11xH8nsy6lrcazjvmNsM2c1UqII9fTOBnO6I0fmIv07e7DVljECjFMX3Q8V9kkhmMTgcpXWyPY+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amorlrcv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso32067445ad.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230020; x=1774834820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lK2HLOWAGj+69lEc/65okI9MbvVHw7Gm/K5aPIjtCA=;
        b=AmorlrcvRkClBJQ/8FxkBsNIs2XlO1cYiJtw3C+VbJ1hK3M1hFO0t31QFRnzrzje3c
         z5l6nLLaf4GU27dmnipepDyRkt1kl5XScLAKMM+mUxHIbIbMhTgjBKBeCSs0PqRBy7lx
         haQc/hcr//sgEMxsFiO+1KNeuTWpgLwvQp7eQClO92V2EAg52FSTxsSzLLL3KEyVPzDY
         tjtdockQL+P5TJltums+I1Ajs9KQ9+1BJfl9vvdZvc5WRLU3E9i1RfFLHpi+Xk+F8vsQ
         XnrkluzFzgPZfIvyI9m9ML0O+VVpHSG8iMnk6+mVF1tyGK3DHCyvUtOOvuagEqUK4m4t
         +xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230020; x=1774834820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lK2HLOWAGj+69lEc/65okI9MbvVHw7Gm/K5aPIjtCA=;
        b=CdICh/ktuJdO0zFdYR6LoXGkelZgTaVqthbt7X5vPpZPcy/DNDAJIWN/VPMyMSzQeN
         3za4rn3b/yTGu85q7r0ed4fCalXzsjxqb6KkFQ9IWnbQ9kBIEM7ilFGEJqpYujX1IsRf
         5BTQNn67GIeSQ63vtXx3zz6GfUhoJ4cdnqJWEHk4bhb7dCS9QLsGSly/ayaiFcnDLlDw
         zF1RgVufFo7D1m0oROEHvX+zf1g2i1pN/9Ny9BfQbKIExFV9OtT3TBgZUDf6FkMmwk1J
         86rWhrHFGfwSGKjRTxprZkj/Hj9cHkRa52agNftA9vPe0S3Rd8SdpUf0UTwu23BgYPd9
         chtw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ADP9YVlDFGpR8jhT83BwlKiDHk033qWohDJEZ6pkeiIYzGisJ8ESTvOjvduy+cT1mtBK73I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVj9xwEGwe650Q0QPEA5ksQ1Wv2cTtnBPbFcXWrpWCsNI1dkjo
	cVfcaGuEMB+0teym533uGkwhIKUMHMwX8NUB4KO8xMtNT1vleBk2+DuG
X-Gm-Gg: ATEYQzx/BAucXa9kbUMhOXAPhdL1aHDypw2PqKnkCYz6iZxLnpS1ed5S3xKyiGYZMr0
	QmglDD5vOyqW923pt3iUbZUUA8Yszb/9VuyGTZ5DfCT9/tmhMevK9PkqwdPBzvgSljQu65es+Jl
	fFtUdLyy1dCu45RgLjtsO0nnLGSMP631R4QHyE8bSseynKjDLR2cdr5s2ChX1axkPd4fUdQjwBL
	dYd4EBHra9MOpvBN/OfAtWWQ9wtSKES8oxTCO5sWKjcphwEo15FJBJDWSuRzt3nNg4vVjHFDKk5
	yTNOj1QZPx+CW57Ke87VfrIF6OxRGGaDfnO3eKDx9tgvpEZcDPALZR9iy88a9/FskkiLicQkk3Q
	DHuQ3sxnuiUsa4ej/3hnJJGxFskJubkvQGGMWLcyqW7dfef8XK169Lyr69ffsWNse9b8+WwKziS
	GVBvW6+405nkqcNVklDB8YkOjpcBQF58ljd7J0
X-Received: by 2002:a17:903:94c:b0:2b0:5ac2:9aa5 with SMTP id d9443c01a7336-2b0771eddb7mr117594055ad.19.1774230019940;
        Sun, 22 Mar 2026 18:40:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354b109sm115638305ad.31.2026.03.22.18.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:40:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Mar 2026 18:40:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"iwona.winiarska@intel.com" <iwona.winiarska@intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: (peci/cputemp) Fix crit_hyst returning delta
 instead of absolute temperature
Message-ID: <5f7d51e7-0f63-4f06-be4a-faa168773c66@roeck-us.net>
References: <20260323002352.93417-1-sanman.pradhan@hpe.com>
 <20260323002352.93417-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323002352.93417-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-227874-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 80BAB2EB8F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:24:25AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The hwmon sysfs ABI expects tempN_crit_hyst to report the temperature at
> which the critical condition clears, not the hysteresis delta from the
> critical limit.
> 
> The peci cputemp driver currently returns tjmax - tcontrol for
> crit_hyst_type, which is the hysteresis margin rather than the
> corresponding absolute temperature.
> 
> Return tcontrol directly, and update the documentation accordingly.
> 
> Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/peci-cputemp.rst | 10 ++++++----
>  drivers/hwmon/peci/cputemp.c         |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/hwmon/peci-cputemp.rst b/Documentation/hwmon/peci-cputemp.rst
> index fe0422248dc5e..266b62a46f49c 100644
> --- a/Documentation/hwmon/peci-cputemp.rst
> +++ b/Documentation/hwmon/peci-cputemp.rst
> @@ -51,8 +51,9 @@ temp1_max		Provides thermal control temperature of the CPU package
>  temp1_crit		Provides shutdown temperature of the CPU package which
>  			is also known as the maximum processor junction
>  			temperature, Tjmax or Tprochot.
> -temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
> -			the CPU package.
> +temp1_crit_hyst		Provides the hysteresis temperature of the CPU
> +			package. Returns Tcontrol, the temperature at which
> +			the critical condition clears.
>  
>  temp2_label		"DTS"
>  temp2_input		Provides current temperature of the CPU package scaled
> @@ -62,8 +63,9 @@ temp2_max		Provides thermal control temperature of the CPU package
>  temp2_crit		Provides shutdown temperature of the CPU package which
>  			is also known as the maximum processor junction
>  			temperature, Tjmax or Tprochot.
> -temp2_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
> -			the CPU package.
> +temp2_crit_hyst		Provides the hysteresis temperature of the CPU
> +			package. Returns Tcontrol, the temperature at which
> +			the critical condition clears.
>  
>  temp3_label		"Tcontrol"
>  temp3_input		Provides current Tcontrol temperature of the CPU
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index b2fc936851e14..badec53ff4461 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -131,7 +131,7 @@ static int get_temp_target(struct peci_cputemp *priv, enum peci_temp_target_type
>  		*val = priv->temp.target.tjmax;
>  		break;
>  	case crit_hyst_type:
> -		*val = priv->temp.target.tjmax - priv->temp.target.tcontrol;
> +		*val = priv->temp.target.tcontrol;
>  		break;
>  	default:
>  		ret = -EOPNOTSUPP;

