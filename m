Return-Path: <stable+bounces-249939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JjXGkzDDWr32wUAu9opvQ
	(envelope-from <stable+bounces-249939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:21:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6931258F7B1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6CC43028557
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FFE3E7179;
	Wed, 20 May 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlp5qwYo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873C3E7BA9
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286242; cv=none; b=S+uRUanEaM/JDxLOOnG1RX3wn/i+e/w0GXzvOu6eW+SMmN8+xYdBMRYZ3cZgSabp6IbALJicVT1ifb5CwhVfHAj1uwKi1cwvq2IyFW3B1/PX9EuaYAQgnPythvThPo656BWcs+AvUCUIut92/IXjzHqpvdRWMRhswpbfLpOwHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286242; c=relaxed/simple;
	bh=XQgEKoH849abWsbxo1M1atnHeGVK5Jyx+/o8fqXWk+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRKyInc0h10p+KSdascSqwb8+8lUxTj5bsbsf9kjYePIUiv0Q4iak4OKitNRk8b4EcvRnxR7hRVHqhPaZN08D7ixYBGj/dI/NogoJbgfgrT3+e7pnK3Cpue/P13QAmbmsmMbxnk0HskIpu89XZqNtvYBwzHbQaZrQ3E9nVsA4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlp5qwYo; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132d1b2519eso11600104c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286240; x=1779891040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EiPClLqae8Upbz6DjNktjtX9MKwPfN6I1jEnEXn6D2U=;
        b=qlp5qwYo8yEnHUhjp++iAKQhtCGJb/S86VA7rI48zZbSNtVdrrN4Y6Q8pIy+gUO+AX
         LckTIMPpgPHoCVNGL/PdsVfm5qIRrWXVfXj5v+uP9VT1dbq/xmdJSD61YOi2YcSPWZ6X
         uxo+Sp0LC/AuAu9M40INEVe+BetxMYr4dwjdxi9580QAUdnXxgQRUl9HUVk+mS8ybil3
         tTL4Ke7SzHgGk7nUjbLEchcdhcO3vsMOCfwCRtsRxucHiXZxkTVqWT3uMRpVWAetM+/a
         zhURNES3AZX3iY0/sEIwTzieMfapshtaW5a8RAbyRmz1Xbbo6hQw93mLj+uZe6WW6DDh
         l3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286240; x=1779891040;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiPClLqae8Upbz6DjNktjtX9MKwPfN6I1jEnEXn6D2U=;
        b=mDABoUPYsEjvZIanmWkTSun3tRRNFcQOVZTYeRkDNZ1IORqUnA/snCT3d9pbnO3pR3
         lXHJSm2rGMrbp9ZefSSYLWoqWu1UsVD4wo0BAEp2wlM/5945ZrrrIPgqyfe6Ivxvn+yA
         gtsAgkZoXEb6dWJ6JOMq7RyXfFAa2gwop/4Rg2OPlNCL5KwwDuwhsNDyY6k1ghCKUsru
         KOBOoPhY9I4uX0YBpnH+EPrqqXu/tMor9Cq/1amd6+TwtJn/8tkcxf+VOILHpYZ1dXdO
         3DMNrQiGfXR7nxR2ewi+/BOpLw+MkI4IUIREMdwMgKIrft/Rr6htLI7w13/wBf0rrGKg
         4qUg==
X-Forwarded-Encrypted: i=1; AFNElJ9C7kZrP0J3QoZkPdKtwZEl/hJk/2buwPwECKeDj73H0p1bv0PEo77xdlGdJhlnkEHDQXZhmGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmI5h51KiTT22ntR3PaV51u0ccW1qQDyTw7WFFpHHrVxP1RZ2
	KUiIgxSD/dPMDFUuCQyCXsktQ3aCyL07Ev9jShd/fPRaN5br/fMRZ0UU
X-Gm-Gg: Acq92OFFdS+c45vFu38UK0VLcHIZpAwVBRa+r0jH3SQBMuBd9myQjXHcn2Of68zOl15
	8InLzckcQy1Kw3IlTOXwEyeGQwVkkYtnqc3EshGns4ouZjil1VUt2t/nyF8T9pmU+bNGjo99hMW
	fGuH+Z53eLaoThFLH2+LqUFi7DRBU2dCrYMIcqnfXnG3LjdkA5hF839Q7KsHJE/VhjuhlsHVdel
	Fzt6eMxdoON7nMbqiIjoGnwBvoaaoAfkmaGtoNCWQ/l49D/y3g22p9a94f4YIoIR5XE3EpUNT1I
	M7n8sCNjWtLA2P2OIDxuNeYgtndHLdZem6S5G8bp3WpKXMnYTW1X6PJzjmMXphj1phEgp7LCAaE
	zh1kzvNAHGMMwDRoj8+OkKxmPZj8L77XTkg7mX4wMR+haXinf+XfUa9ltapV9JX0u00VLORABgJ
	vPdxZK6Tnn5Z5PZwLCESWDrASqoLfz7FBmITarAl+uxAXmudu1O5KhRE3gxjBWHebF+hjkvGVRk
	4tFYydXCYs=
X-Received: by 2002:a05:7022:661e:b0:12d:de3f:d844 with SMTP id a92af1059eb24-13504951829mr10455629c88.39.1779286239727;
        Wed, 20 May 2026 07:10:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm4241668c88.14.2026.05.20.07.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:10:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
Date: Wed, 20 May 2026 07:10:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249939-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6931258F7B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/16/26 18:18, Abdurrahman Hussain wrote:
> This is what remains of the v3 series after Guenter applied patches
> 1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
> asked for patch 4/5 (rtc_class) to be dropped.
> 
> Patch 1 adds a write-only clear_blackbox debugfs file. Devices
> configured for single-recording mode (BLACKBOX_CONFIG[0] = 0) need
> an explicit clear once the 32-record buffer fills; the documented
> sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
> from userspace. The patch also acquires pmbus_lock at the
> adm1266_nvmem_read() callback boundary so the memset of
> data->dev_mem, the blackbox refill, and the memcpy to userspace run
> as a single critical section -- the nvmem core does not serialize
> concurrent reg_read calls.
> 
> Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
> The same value is embedded in every blackbox record, so the live
> value lets userspace match a captured record back to the boot it
> came from when correlating logs. The block-read is taken under
> pmbus_lock to serialise against any pmbus_core PAGE+register
> sequence on the device.
> 
> Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
> sequencer_state debugfs handler) for the same defensive-locking
> reason that motivates the new debugfs files in patches 1 and 2:
> any direct device access from outside pmbus_core should be ordered
> with respect to pmbus_core's own PAGE+register sequences.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The series no longer applies after applying the bug fix series.
Please rebase it on top of the hwmon-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
and resubmit.

Sorry for the trouble, and thanks a lot for fixing all the problems
with the driver.

Guenter


