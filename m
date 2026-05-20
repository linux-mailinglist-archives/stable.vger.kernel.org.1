Return-Path: <stable+bounces-249936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGHKBEvDDWr32wUAu9opvQ
	(envelope-from <stable+bounces-249936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:20:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC3758F7A9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B82319F7D6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE1325491;
	Wed, 20 May 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np5Eo/MD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7C3E7179
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285755; cv=none; b=tKSRoKJiCMpvfYJ92TdqgHf5ivtlvWJ6K0OPGj6o9AJsqreUz7BkcTYn97Mpr5ZHlOjet/ivdy9u21ohnV8ZJ0mWHNQBZSrpG1l0yZuPwiu2VlK3jxD0bvuM2lrF1uqJfCsSteJZQZinr4TNaAVuhBsB7nHAwQ66gL+e0wQ3SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285755; c=relaxed/simple;
	bh=lfU22JuMTGqpNRTq06SvaHT2aCYrYJ0561qqJVpzVFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC/f2HjZg31coBgBjSP0/907NWY+b+8FuMKu/jqHVXvS+iRqz7Ma3y4k/DtbLy6J1WsX5L9hkAM1FWIDAaj/rwyeX9edJSWzZUpC2PHDehw+JfXEJUaIxa2QC4jsonGeQMN4mlbaU6bAdO01U/vG+jg7z3PvlDInJmjR9qxaswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np5Eo/MD; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f3c623322bso3002957eec.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285753; x=1779890553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QH/+hBnpTGrzN0wXR/d49KtC+d0ximgNyQb80BoPFYo=;
        b=np5Eo/MD5LAX/iJ9qESoz0oIMTdgSbEJmsZTcRYlokvoFDq/Ea8LChtTEnlVZTgreM
         hfRx650/UjmJzeQ16wg8BYwSRTs1QUPkBgbrv0O9eLKG32Z3BQO4WhJobJzggqyZt5kW
         iWOfoKKQ9S3Itlj9fKXoHZQF3Fhge3SnLC3iWHazfcNrrbF2B8BjpH1bKo47l2Nrul1l
         32qTlUKqw0qkCkM5lzYGIGsYrNzW45qTpzHwhuxTff7OOh40Aqyv6c9kJ2bpJbrLisMd
         UTmi1rEnH3iRE0M9ZEGt5mbsdCkxirccvp1/VSZ7HJqbrNKbHTfMVF4aKSUyf5d4OXT9
         9kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285753; x=1779890553;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QH/+hBnpTGrzN0wXR/d49KtC+d0ximgNyQb80BoPFYo=;
        b=bnQYhKUcAaPQ1NgHTFKNDJPUsh1phusHyvIIucGXlBPXCjS18dMLkTAleTbalK14jP
         XUDBHm1gDzE8C61HBLd15kUs8IIXaDtJ0AA3JcyfjjayslNlCWibUdr1q9vh0wn7vcfG
         P4luw5Xb2S4mPqE9QDiiJVkR1q1T3JLVAvvzj0hUbvBzzB11A5t9jBQVK3uEuNpILxzS
         /4rOIiTHhVEzxbIzLbwFvICSSm9PwmGdsVhRYiTC7WbdokrHJAFXkzQE/rc3KXkSrENR
         GxXTsKUNyPzXcMsdD2TESbS36MX3l2CS/cPZWtQUnbpcIAf6P8yrkjtCGG54gVakfdBe
         ZBvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8z2QFYHU4oEfkwAoi0Eut+RrjcjSB5igHBXqjhnx+aaRkqYB8/nne9G+EDDrRviPBoqvfyXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkwmwa38KS6DLdHWR8x69luVPXA4+gCHotUHiOZ8RCrOXUtdEH
	X4R/gkH7csEDQeM6qFBzbCpRiUP1qjI75QoVFSz9ToYH2EU4irB4xpaB
X-Gm-Gg: Acq92OF7x0BRMTz7J7dwnRrsnkpzY1mh/ZYjaanysd7/feWhH0c9xpn4xgQRYvTgoBI
	FZaqLD61qfvbqxF+eF23uefzO/rXExhF4u1aAa68aaeut0O8ax3O/wukjIHKiVr5e78tJfudnGo
	Z95LYjurG5eCmLO0MVGHT6E6Q+el4GMvvpSqBRY41+ammQHGrJwyWwSfzgMx91F7jHjq7A76USR
	TSFAYzVuTU7QktAG5Bx8mqdMuw5O2+bE0THZjWm4zMp9vp/uQlkAD30erUW9PNxE5b0yOX6wTww
	yDe69ekqcP56Qx/lSzOr8h443Wm4YBAsdCVG/MMMB6Zc73zu9QCumV6rqvw0JpNrDTheW7p287/
	iFyeJTrb8tJqrzbXZC5N1PuFTM0V54mhsKm7bNIeHoHYb0JkhiqKQPlE+AFqksdUz5lGrlqQltt
	TbOJs3UICdiv5AZn1FoCQ/Ybw/KlNmECt90MKAXQaAjckgkVXbkVqW//Lqd2ErQzq0tVwg5VHAU
	fveCKn6TZQ=
X-Received: by 2002:a05:7300:6c21:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-303983c6376mr13070641eec.14.1779285752147;
        Wed, 20 May 2026 07:02:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm18484883eec.20.2026.05.20.07.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:02:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57f31aba-b7d0-4e8d-8abe-84e4fc6cad84@roeck-us.net>
Date: Wed, 20 May 2026 07:02:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] hwmon: (pmbus/adm1266) GPIO, NVMEM, and debugfs
 accessor fixes
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-249936-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7BC3758F7A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 17:52, Abdurrahman Hussain wrote:
> Eight pre-existing bugs in the adm1266 driver's userspace-facing
> accessors and probe ordering.  Each is reachable any time userspace
> touches an ADM1266 GPIO/PDIO line via the gpiolib char-dev or sysfs
> interfaces, opens the nvmem device, or reads the sequencer_state
> debugfs entry.  Five landed when GPIO support was added (commit
> d98dfad35c38), one when blackbox/NVMEM was added (commit
> 15609d189302), and one when the sequencer_state debugfs entry was
> added (commit ed1ff457e187).
> 
> Patch 1 caps the PDIO scan loop in adm1266_gpio_get_multiple() at
> ADM1266_PDIO_NR (16) instead of ADM1266_PDIO_STATUS (0xE9 = 233, a
> PMBus command code that ended up in the bound by mistake).  As
> written, the scan walks find_next_bit() up to bit 242 across a
> 25-bit caller mask, reading out of bounds and -- if any of that
> incidental memory contains a set bit -- driving a corresponding
> out-of-bounds write to the caller's bits array.
> 
> Patch 2 drops a redundant "*bits = 0" reset that sits between the
> GPIO and PDIO halves of adm1266_gpio_get_multiple().  As written,
> the GPIO bits the first loop populates are immediately discarded
> before the PDIO loop runs, so any caller asking for a mix of GPIO
> and PDIO lines sees the GPIO half always reported as 0.
> 
> Patch 3 adds the missing "ret < 2" length check after the three
> i2c_smbus_read_block_data() calls in adm1266_gpio_get() and
> adm1266_gpio_get_multiple().  A device returning a 0- or 1-byte
> response would otherwise compose pin status from uninitialised
> stack memory and leak it to userspace via gpiolib.
> 
> Patch 4 moves adm1266_config_gpio() past pmbus_do_probe() in
> adm1266_probe() so the gpio_chip isn't registered (and reachable
> from userspace) until the PMBus state the GPIO accessors depend
> on is initialised.  This is a prerequisite for patch 6.
> 
> Patch 5 does the same for adm1266_config_nvmem(): the nvmem
> device is now also registered after pmbus_do_probe(), so the
> nvmem callback (adm1266_nvmem_read) cannot race
> pmbus_do_probe()'s own device accesses.
> 
> Patch 6 takes pmbus_lock at the top of adm1266_gpio_get(),
> adm1266_gpio_get_multiple(), and adm1266_gpio_dbg_show() so the
> GPIO PMBus reads can't land between a PAGE write and the paged
> read pmbus_core does in another thread.
> 
> Patch 7 takes pmbus_lock in adm1266_nvmem_read() so its memset /
> blackbox refill / memcpy run as a single critical section.  The
> NVMEM core does not serialise concurrent reg_read invocations, so
> without this two readers racing at offset 0 can interleave the
> memset on data->dev_mem with another reader's memcpy to userspace
> and return torn data.  The same lock also serialises the refill's
> PMBus traffic against pmbus_core's own PAGE+register sequences.
> 
> Patch 8 takes pmbus_lock in adm1266_state_read() (the
> sequencer_state debugfs handler) for the same defensive-locking
> reason: any direct device access from outside pmbus_core should
> be ordered with respect to pmbus_core's own.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Series applied.

Thanks,
Guenter


