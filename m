Return-Path: <stable+bounces-271661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s+f0A1RiR2oIXgAAu9opvQ
	(envelope-from <stable+bounces-271661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:18:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF06FF7BB
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:18:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=XL0rbM8l;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271661-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271661-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72C75308824C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F433E348;
	Fri,  3 Jul 2026 07:16:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336D35675F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:16:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062972; cv=none; b=Ucaybmj+lFwEUAyAJO842hDeUVOXDkwzJ2BURXAg4+RyUJ/7T6bHeFWP2E+H5g4gvcAy01WYkZ3PBcBaWH+7lQJvkdTo1P1FFf2XR9EbkJMIkIZXmD8pJHH1lA6y7S+SgVy/kuxCKz7LmPP/UMruOv/ynEJepYflgpEDSJpiqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062972; c=relaxed/simple;
	bh=0bRCW/0G1EaCEUzVrCTzra1GYsba1RlFOpEqB6cyziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYmZNk7pxj70tRwu86+3bu4bK9likRzILvDWJBDxGtT60sRtd4UbbD30LRhhA7oQzsnJyidSAChr6J1eg6nGZLkWZ3C82U/O2hAyk/8gZ9js9PBtLilnfhbYANoEwBBBY2V8XMIT/YyHLyVS9wvivRpKHU88Yw4i9NGC+CqAv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XL0rbM8l; arc=none smtp.client-ip=74.125.228.131
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c1268e71e78so9315366b.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062969; x=1783667769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yEtuMKx0BNg5wnLSISs/1Vqqgf3SkbjWVf7WS0QWr1E=;
        b=XL0rbM8l1GowF7pgnj46Wi9LXvok65/5mChg8WFcONREK0Do+DfJahKqAYIfD8WiRe
         L8oZhHQcFsdR4cXMVJXRGUw4awx2h2f1oEiVFsF2Fa6M9fvK7P6vm6gey61SrylVSZyC
         MG+TvjmVvPnucdb59fQqXpL+XmXI5qAp3O2TU9tUUTsdKmlYCHQio6UvMhqZyyQ2+LJl
         NQNUadJsBFzvloHUbqNP1KkJSvla20Hw4y/Lf8fqY5DXLDM3pLxl4yalT2Ime6ZFd4rx
         h/P2ed9pKBW+M8MeIFrkv6pFVQssI1HnJH8bZd2Awv3N5SKJH20A1FKB9jw9f5JMoVEr
         7jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062969; x=1783667769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEtuMKx0BNg5wnLSISs/1Vqqgf3SkbjWVf7WS0QWr1E=;
        b=M0QsPN7Eestzj+iQd7fR7MQ/jJGoA9omES+w91HjaW5YcwzdsISq0XNkDp0Z9D4ey2
         Q8sBxTYqGuHdSTmBtEZno1BrrlagnNmEEPvzklEDnaUpyUNujHK/qBDTxeXT1+v1M2Fu
         uF8JmG5WdJsgsQGG5PP7k6A5GHO64tRWIF5/LiKUVMIpxP0bDsHfX266yLlDVzbzCt4e
         dv63HH74aetBr7RDVAdOXIt0WW3kJIqnDpDxm43aJLqBTeGy+iK9ilg2O2Jh/pKjJlQ7
         msNERoimYLqsLmca/CQ2nHmfU2SdkTa7TIBqYn36MikRMm8IeOHLymuwq1QFhNa3wT/P
         fOXA==
X-Gm-Message-State: AOJu0YxL6o9f+t0tUWbth9cvY4SHHp4rEDKys75KKj/4vjO0TaTY9mzP
	LhLAwfXToH6VfQjl658u2VvuSenk8sheQTdvUasC2QpUf4GFjo+h3U0u8+61AyujwTc=
X-Gm-Gg: AfdE7clLdOYegjI2i1mBUz4lEnEYkwyaTVBtBe43sKcKpWWVw5brFAfrLyHhIPMEaaf
	PRQoMqF1ACNCJnYMMdIASNZZEbCOEmX+npfGLVjAupYHHC9lJfhNcDxEK64PfZNU6rh2oEaqPjW
	0p5EHQFk/iGuqgsMFFD26N8LHquUaiK+VgeWe5jXec+lwhr8VQvgqNnfepVvVLLQu5QvW9mROVs
	OmSuoAmJ/UtDWodCS39ne63SCi7vGT7d8nDDCGTVbUgYqRu33oxjnmMEP/JxfAiKrA/G8tCLpeE
	tWoH8Na0jMFMaFk0ZCjog0sbcmyKVml48FjjBEplOTXlpXGXYZ0jhlu8kT+JmeEozpqhSKKoeQo
	KvbABP2WfAAY/P4fmkEht1E4Ehvwr/rbuz1XTvLxjHM9GWv2YS5lSij0BkInXtht8+DlH73/xtv
	WQdT1cwsN44T0ukO4GyOJXPSx6aPojp9vsFKCaATIkmfc=
X-Received: by 2002:a17:907:fd86:b0:c11:fe9d:2544 with SMTP id a640c23a62f3a-c12ae4a690bmr346459966b.22.1783062969233;
        Fri, 03 Jul 2026 00:16:09 -0700 (PDT)
Received: from u94a (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310003927sm3402688eaf.6.2026.07.03.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:16:07 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:15:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/129] 6.1.177-rc1 review
Message-ID: <akdhbLZ_CEa1QvlX@u94a>
References: <20260702155112.163984240@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u94a:mid,suse.com:from_mime,suse.com:email,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FDF06FF7BB

On Thu, Jul 02, 2026 at 06:18:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.177 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28642578397/job/84941873172

[...]

