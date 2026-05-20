Return-Path: <stable+bounces-250468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFjnGgPzDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA5594746
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56E8378B9F6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA831F9BE;
	Wed, 20 May 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsOtRvXL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76A37D101
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295490; cv=none; b=lPj16YE8zzM4JS/QIPVl+IKr00exfGdIsnYUIPXlCfO6oho9+lBeRwDf7M57h80LSU3uWEqAxXEieMhr+ei2va6xLmnVZ4HucblymLVJjdKWVQfBi5KE3MpWdBuv4E29Ob+rJrCAZ/Y8ISAqeahoYFPfm91rFifw2d64KsiIKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295490; c=relaxed/simple;
	bh=5bD+8kQCvsBJwvio8J+ONYs68ydymK7KFx9Ur+b2V04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opv8og8ySE+89Zw+9lbug6WAFcl1R8MoDcQG6sjgC0J7FWIhvCmpvQZrpN1cydm1H9V5HQCpwvm+SHsk37ebax/5GW3WPssckzlHNBgFWs89gn2eyuz6qbg949GyTgK4Uwn8iGHB0FmO0AuoF0XDAmien8ujyY3YGLMzJyPCox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsOtRvXL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4585a116a4aso4272439f8f.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295487; x=1779900287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0simBUITpJ94FD8/rlgEoQYzs3fEqZ4WjqfFO1n/CM=;
        b=nsOtRvXLNTxhe8BXFAxzqNHrnXARmpZdxHa6x1S8RJ9bsmiXP32XigrwomA7eRGdeR
         jLOHR1g3lKgGft+Qnwac7hL8pRR9u9h11SfXtFfOrEkxDb61lhBNn90KvrdpkDh/gQ7/
         AL+wYm9EkNc2qMuVFFTIKa8TJn/dVB5YJDqRBU8FT9tc/e6IA3ePnPzqLXaSPDtOI4YZ
         HyZKhbf5AlgIR6Nf9GjaWDqMHMhZn1vN2Hzb9uXYf60JJq65jpkRdIB3lrqZQI8d6DlT
         7Eo+8D6/qp3w4PisYBMCLl8cJg+OEjVte6h0Jba8yF5PYjPOrQLmVXzaWIULEIecb6mD
         6sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295487; x=1779900287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0simBUITpJ94FD8/rlgEoQYzs3fEqZ4WjqfFO1n/CM=;
        b=XD5nDDx3kTq8oNy/17j9bR0Ddw1Hhl0L+PmMfSwjqCYIxTV6NNIZ1kHXDOwglUFFCd
         3RWKQXOOZEB9sEIN4b55xyQh4waihIl/Y/hCKv3pfJRuUtBpij5XNbYSikQLXTP6jDYT
         uI7QFAPfy07OrB4svj+UAQUFdubKmfKjGSNLeEZSL45QpM4IF72RQjGHLPu4FnIKuJ8U
         eG4VroBrkBrQ7eJzxO7BsJPnRFU9zAMk8+JHGCvA3anknm9R0vWIisAj6/SS48xpYly+
         kU5nX+qy2ULzxxGyCibI55qCeotq93Y02Jw4XcSO5MZbu1yE02R1ERPxgG8jEA+WfWtl
         dnpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C7yMrOQbQJYnigDvYVRfmDhXg6FUNjHcgb0gSUWtHbBAUzKnLdQRMxmQRApulLuocsX1S4CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaVDrGjpHHyRsdYoCnN1baLlWps6kIwy/yMQc01SxGyVMypTh
	K3Xo9o+6yyOukjJXRlfoieKw13Eoe/eWpby5pTq20f2k5bAqTsq49s9h
X-Gm-Gg: Acq92OGuxkDAjDB9Ugf0XesToWs8q6t3v7pwRh5i2RW/X19AC4Odt7a8QWu/S9fYt/r
	LQekWo5r3KS/rXFD/VG8s18dG/bOPNLYLzh93arevMSxMQV3HhF8mkozucYxD7sdupAc1PxiunP
	JoN0QcGMMf/efZ784iYuestwlJNRBiL+zRmwKMI5oCYI38Q8wvaJOdf3xzUa1eAfzNfJ2GE/LGb
	lsgCp71M/48czY62x6LiGXN5i1SllyFUwggeVowVRJJcCt6suyxLjRrS04uK8rw4XmW7apezY8t
	PXP/yrr1cgcPFgnD5zUBxubow5bmLUBeItee2oYLSy/OoHcKOggw0Ib7lMLnUcsxKqwX9FXJ43F
	S5TqrvJLzzqP3xqW+br9D54eIKntBgI1U9woCql29n8/VgZo7Q9spT4j7wvOkziClrS3XTPFYYz
	3F9qNO6NH6jfVReA//KKkxY4ZIZReaxC10d1lJtSkMkoo2p/DiK1TW/t2e9jr5OCCf
X-Received: by 2002:a05:6000:2383:b0:449:9aee:4575 with SMTP id ffacd0b85a97d-45e5c5ccbf6mr41532748f8f.30.1779295487009;
        Wed, 20 May 2026 09:44:47 -0700 (PDT)
Received: from [192.168.2.178] (109-252-156-195.dynamic.spd-mgts.ru. [109.252.156.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm50797773f8f.11.2026.05.20.09.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:44:46 -0700 (PDT)
Message-ID: <286ebc23-944a-4374-8128-3511c68cd1bf@gmail.com>
Date: Wed, 20 May 2026 19:44:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
 <20260520161900.GM2767592@google.com>
 <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250468-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digetx@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0AEA5594746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

20.05.2026 19:23, Mark Brown пишет:
> On Wed, May 20, 2026 at 05:19:00PM +0100, Lee Jones wrote:
>> On Wed, 20 May 2026, Diogo Ivo wrote:
> 
>>> This patch was motivated by the Sashiko review I got in [1]. Its point
>>> here is that there is a possibility for a deadlock scenario in which
>>> a secondary CPU obtains the mutex for the regmap and then smp_send_stop()
>>> is called before this secondary CPU gets a chance to release the mutex,
>>> making it so that when the primary CPU tries to acquire it to issue the
>>> write it hangs. Is there something that I am misunderstanding here?
>>>
> 
>> It's my understanding that using the Regmap wrappers _prevents_ locking
>> issues, rather than causes them.
> 
> In the case where the CPU is being powered off during a regmap write
> there is a potential issue - as Diogo says if we're in the middle of
> holding the lock and we power off the CPU that owns the lock then it
> will never be able to release the lock.  I would expect the same issue
> to apply to a bus like I2C or SPI though, they'll hold a lock while
> they're in the middle of doing bus I/O unless you use some special API.

Sounds bad

Diogo, check if shutdown works with added nosmp to kernel's cmdline.

BTW, you can use i2c_smbus_read_byte_data+i2c_smbus_write_byte_data to
keep the old regmap_update_bits behaviour.


