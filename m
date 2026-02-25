Return-Path: <stable+bounces-219637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOiZGfoIn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1169198D08
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6318A3024EC3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058633AE713;
	Wed, 25 Feb 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="dWxcjpZb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED2387362
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030199; cv=pass; b=lLsWJuLSnWpC0PHFmi/CgbS8/DfoQJewJy2I4ttjRexnKV7MgVRVdaWyRhfVOx9gcuQ9CtkkTKzop10IrR41MG1/cG6KRGwjbYyo1k3ltAk+C0P7a8pb57vCW9f9PT/zLgBB3HuILu3TawY/X20GjOhDab4cGIys6B8QMes+UGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030199; c=relaxed/simple;
	bh=3o3jV1yPotn5Ay2C7EwxJyn8N/Xj/yz6IduDQ0zFG74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR6pK1JAh6t1VNI2A8kipVMFV3Pg6ZmvwI4h6AjQ0w5okosU2V1FKxtIDuBNJsJzwkrfMHiG9KW01J24h1gtZqHBVFPHhgbqqEneo0sU2FJTldnEKYgrELlaEET4lyTlkAIdy/yk9X5XEsqx95vexE623KL2jy7fx+j6thKKuPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=dWxcjpZb; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f7a30515aso800879666b.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772030197; cv=none;
        d=google.com; s=arc-20240605;
        b=JaCz+W18D9G49loFn8ed3XqGJ4bIhjeHYYCJhG+ev08V6ZdQ3t1YrnGnmsjvjvLk36
         siENXmXK9hXJpl7iyl8M//2Ussa2FxMMTxUBCP6Z9Sn+GB4HMnb7T1pIxeYe3LxrdLC9
         unHQjHCiSZD5/G6/cpBrUfJDElZiqMxnzOXJ0CPdpMbApU0/wPC+asdrq48Se49B1sGg
         6jDFj8ixk0X52eAXexm2LjvnnAPexpv2cCAdh79HKB8PIfqSPwMwF9TSVYsQuNbRI4vi
         RXL9lAr8n1EqaJFaFv3ompHbhzFrcgQjLFMYWrkvehTowG9u21plwGP7kRWiJabNCBzn
         BWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zp5unT2XQ1YJf2wpzP11qQXI2wzEEGxzhd1xDPuzeN4=;
        fh=vMhX5fX6hkCbGdV29FDoCHLzq8OZyAzc05JVDKUKOws=;
        b=RzpCKR73p3ZS8iS0H2b9XpPoRy3SLYGpvT8amWZHDt37taw66zRMskP4/9uywSbu+d
         aJeNOAyvgi2H9fbcdwg1gayGD+hk2CKl11BQ15NnSsGwdNPkBPU9n1d0DZZM2OSMl1ZA
         aRRe0hNbEos4XRMyqoesEc77zdMplAII/B3EJWvwoduHb/CAZlwFAbsp9bidrcZVP5pU
         SnuqVxYcUV9DAkEMDt8T1sqvSJb9lHW10ET58DgSwrerW4Eeul5Oh9YHKCSPFhEoETIP
         W5IFszc5Fy47ZshlcxB+cedVnyA3HZwu8J/tls7qaKFQuy+DDq1lmXO4fwXHuz9UjGy/
         fdwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1772030197; x=1772634997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zp5unT2XQ1YJf2wpzP11qQXI2wzEEGxzhd1xDPuzeN4=;
        b=dWxcjpZbj5qjJ+aTe9UUbtwucoeSP/REyxjxc/Y5eCzCtIZMf6JJKCb66hcTn1VpyT
         Mnxv58Xeas6H5pMvz5kGn80IIT6h2b8nOkTKUzB0KPcF9rgSfasH6ROjl4wOYyMkGHFe
         mCQP38woAqzLsrO6iJBVnDQTUTg+sx5y07x4hM3srZ32E9u5J9bPTS7m8vS5KprjIDhW
         hAz89QXK0C34OnCAjZNCXUlIJSO4KCGzViExplZ3R4lKnY9Oz2osTPAcbTZQzT0Vmlf+
         5RhZP5vALn1GLjNQP87bfqHBLD4Z8cyNAjJBZNlRdPa+U7nGHh31aKML39ojfQJHpnY7
         wMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030197; x=1772634997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp5unT2XQ1YJf2wpzP11qQXI2wzEEGxzhd1xDPuzeN4=;
        b=wqp5+UeRxOaogDHv+SnSegezWfJiFRlTpE+aB+Ofk4kki9a2KKgRUge07uhlSv0ey+
         3PfBvGMBnu6pR31pfuZ1E2ZcDHlIsxo8iEBtgSWAO00PZDctTYmeEiGI9ZxcDvUGvrQp
         Q30X3fNEGmwR+f5tfQBlCyVn14NcBG/kQIA368+kL3hIVZaGnX2T4TvB2nD0gLRik02K
         bqmtJdEpZghMhxIZ4JBVQ6ZdMpvWDmc9MmHrK49tvbdgLWLjODdx0/4qGeaEd3bOCaxt
         9qaGaLzCTU5XBquT71PzaIgufz/RJ4VzYVU36F1SnMg3sf+LPkgqQhR5aQ+aOoNGDW+n
         3wKw==
X-Gm-Message-State: AOJu0Yz8BkvhnjYHh7peNlYZhuLvq6Bp9BLLCXfPQfxUId5tae+14fO1
	H+u/w6N6zibRTlxjNXL8Y/qUL605x+n1oXbKaT5m9B5+ySDzNMZZNQR9sNFpfXvMQwxma8yH4Ib
	ZzxH9sPHqHNmiIowv7ZoFRtHa16sc0x1UqfUKBQYWQA==
X-Gm-Gg: ATEYQzwfi+eyaabot7XY77Oo1GmTUQAcaKqHOQIEj2mtNDXwTBd78MvoDbTpGrSDHhq
	cInxKk4lRvkhmibyb9+3oh6PvpufCs5xGV6tMup26Z4zJOZAdNLSPuZqfdJyTO7BV2CjkzBrFUO
	HNSppjn6uOjt9YJi70v5+K6MKQXIPqeR0iVyUcXjfmGEDJm2OrWo5Rg6OPwN0SqsDLAK5+00aEa
	wGqTa9TPvBFJLrSTkCn97n8TeltTQQJfz9mQ0S9lIeI3gNhcm+WfvoCz8rRk9XGlF+no7/MALMj
	kKdGmS6loudLqmElIEvmA1zOEaVsqxlz3OJqIHbBv/rk1JnaGtBfk2iG5HIIN6n78JhuXsA=
X-Received: by 2002:a17:907:9347:b0:b8f:9d12:2390 with SMTP id
 a640c23a62f3a-b93517ece31mr28684866b.58.1772030196916; Wed, 25 Feb 2026
 06:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225012348.915798704@linuxfoundation.org>
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 25 Feb 2026 20:05:59 +0530
X-Gm-Features: AaiRm51dFPxFAjtNDltCSh9T-PORoFUyIe-AxoTdzJjCL4PMD3axwmNmKN25HEs
Message-ID: <CAG=yYwmBmC_eT9iFznY2OgmZ0yaZ91GAkvZTxoJHb00F7W+6Jw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Tested-by: Jeffrin Jose T" <jeffrin@rajagiritech.edu.in>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219637-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1169198D08
X-Rspamd-Action: no action

 hello,

Compiled and booted  6.18.14-rc1+
dmesg related error

----------------------err--------------------------
$sudo dmesg -l err
[   22.068694] kobject: kobject_add_internal failed for lp.0 (error:
-2 parent: parport0)
$
-----------------------err-------------------------

.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

