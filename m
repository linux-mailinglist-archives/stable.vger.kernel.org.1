Return-Path: <stable+bounces-253596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKt7NM0uD2r+HQYAu9opvQ
	(envelope-from <stable+bounces-253596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:11:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8E5A8F73
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42CA2306AB7B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA431283E;
	Thu, 21 May 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZBQTa8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF13043B2
	for <stable@vger.kernel.org>; Thu, 21 May 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376264; cv=pass; b=Wh6uFQ8OYeVXmbOKp/AmoAs7wm4uz8pZsMMtYYZbzWTHVWopI0RG1tkpdUQI7JTukloocy+zlpXTk9KWwx6UtgSrgxzBXxWW0zXljUeXyBB1M5KUxGXtOlYvGtWxLfs4f62hM/HuBIcGiA2mITVIn4La+wG7ZcpVMcKhAuogs/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376264; c=relaxed/simple;
	bh=ILfPKmm6WIP8+pTKfALGk8orSX2OR5gYrWIIqKa6xG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFdSUDmIKimxmYxoE3l36w+ywXxQdbGTc9pedKxqLvTtjkQL8WA5Z7X9cPuZedxO0zCfxSdxrKEpXN2IEiOrf9coVyFW2tNQmnQ0t02/R6m0hbM4x16cW5HTdq8XRcCKE7iq0unmzMliyIKAo1wptOQRiwrsZA/xIc6EPIXYor8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTZBQTa8; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso8820370eec.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 08:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779376262; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc/VMi2aBKHy2HcWzIiLoKsVaJnsePI+p8tze6zILB51rod2/vHTnBtf0pmYNAV+yh
         XjKCkSiCtcRXUK+Cjaesko581OV3UbO+Y7dbRxrV3ZPk7J05xpvdJUk1L5UF1J5V3B24
         cvVoBTDBcUgJXY76H/fkcQhEEj0cE6y+OxJcRiyUYdXSKQe4LEEJQHhn6/RC9DTvgWxM
         3NOGUwojlYuO/S24v7MI7CtiAegE9hgSmni7F2oV+kKnwXCo/qPNv0tKZ/zdb2E4bZUa
         0LjXlLf8TqCr+9QCO+Pr2tT050kR9FFU/s/R5KO6ixgFnbIavHIr5DTYmvUpw+fLxC3k
         RE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/zKjoIM90nBhcCHwQGZzjnKjYO07HjblWjtUDxE6Lnw=;
        fh=jXPLrAGSwxP6MLXwXr7aVZQ/hwIpeRp3ERhKIN8FGh4=;
        b=VJt3jYKQPz4XHz8eb2p5mH51zkIdpdyyFRZt+7bQeebyDYQhHRrB+U9IOfgbjmSplo
         2z/R/9NGaEEWZW9xC1aIqWo+0A/Sjkwq1n5Usfn11349//PbDtdMom8GnnBAn+tbkHg+
         F0RA7KAbijpJXq6sxO70AoAj3VUCFxmvrOuDOefs8ADfHjTrHoyOvSw6+b+pGRSLCXuy
         fTmGYcK82wCURLWaQknqS4EglPo7EpNrrne4Fo0LtHGQ7/oEBAlZmQhVYQINl5NtZRUJ
         iDfGoLr94iKjDk1bQM9CkkdFY4xy8lBmrn0vNiy6m9Vz0t/EthxbDnYbY0nQ3TqxklrC
         GIdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779376262; x=1779981062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zKjoIM90nBhcCHwQGZzjnKjYO07HjblWjtUDxE6Lnw=;
        b=BTZBQTa8De88wQAXrxTIk4INGe85Az9ZvybgZdud7cOtr/j0BgIj76D9Lu+f7VslLk
         VL23FdfNzqse5Fh/Bh7OAg4u3rjwbNlLRwtM30BuGQVQeZYHCPo2lyCuAihpt2zGODT/
         4qnh8iQa5vk+/BuV9jEQFsKVSYwcYVUp6TGBRwdfA64NvGUvT3XLXSBzb/N5GlPgby6H
         6Vwcp5Hz9hP0RhdjpP0EIh0WeJBZ1a+XOkn9dPUQVyH8dxSe+A4YWzChciOvh66IXCjd
         1IODIyIz90OUzRVUvWF/p3vJHUqDHCxn4AUy/lVNO7LUAAlXqBn4bqTCWtRBZ1uOH21N
         wrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376262; x=1779981062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zKjoIM90nBhcCHwQGZzjnKjYO07HjblWjtUDxE6Lnw=;
        b=DRKm62iWK3C49zdSJOc+9PSFaT3n9gMUg9Sw2kSskIWyIzlmOhQru4btPo2RnzQ2V5
         HBs45ELTUU2LDWAaxglww+65TBoZ9coxjVOQ/I3RtYANJIB10FVG6s3kn3fGofBsmj7F
         RkEfYo8CgpzrENtK12mp6QMyLPqthVxb4pTpyJUsg6GWu+BOANwwV0+VHpyPWEkIg0q7
         WCs4nbPoyXnC47sccNSOD8EZxl9CVuZxE1vZ56BweHRfjNMy+uEByRy6MVD5oo7OKXhE
         KtxBg9sb34zms/4jL5OvrwJwsEfnb/00x5Xt3tbws2UqNQJyIRQ9x53Mt1FkuS3mU3+I
         t9MA==
X-Forwarded-Encrypted: i=1; AFNElJ/x7m8gKTf87yGDXXwBOE8Skas7eqDZfF6s9R/xuF26m2UgqENr9gkMisWclqdusndm/PyVbHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6TFTaRTLmRkpNEPRz70bAuFymMWh7nsh69O97nfv+H/yNw5/
	Ij7BER7T0pGFciWbf+a2N/uQnKFP24a+0M/eTm+8h6wjaezkk2r7kX6qlVDU3+BY7XjLRkZ1N0h
	lUA73tqKehcfbGzl96SXNeV9NuoyCD/k=
X-Gm-Gg: Acq92OGcb5bKwo9mH5Lg4yoUlaq+NbPrHO01K/3pU6z5KxQMSHLakOzc32zBY+F6ldw
	tbftmT+9vgNu5uCGzFihW29h0j/np056j+7zSBAd8QJBdKJbNxe+RxRClbw9lV7uzXIXVEnQQPJ
	lLB+plsdSsg5qvSx3HaMtn25M0m/JzE1nlFzmjuHnaU8adCTyQDMpa8jUqX5UXWHnHKm7aPR96d
	kPEg16froh7rS7gjU3OJdX0jg6TC/N3X+BgDqAdZIlM0AFSSRpXeF0RDwvrYr8UwQ5bVgEHf/HC
	FdD+mr5QodQQ5pkY1p+FB2aJJu/ucDUe0kA1SP7oJkIxJYs+qE7cXT9MpQEYoSe7QFVv+lPAbDr
	PGbFB4oJ75ciG/lsi4/3Jt1WxUXxzuzGRwJp7D2XNSpgLhrqoMZEUmfcYT/sb5ZJRHxQRpeBLKF
	Zgee250LisJClDnuSOQLeCOS9AdBfqLBOb1e/jIQ==
X-Received: by 2002:a05:7301:e2a:b0:2c4:61be:1d33 with SMTP id
 5a478bee46e88-3042f48021fmr1929829eec.6.1779376261938; Thu, 21 May 2026
 08:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org> <0d67203ea22a7e63018ec8faf64ed2926a35b217.camel@polito.it>
In-Reply-To: <0d67203ea22a7e63018ec8faf64ed2926a35b217.camel@polito.it>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 21 May 2026 17:10:48 +0200
X-Gm-Features: AVHnY4I0z_lnmAtyJSTYF4yO7FwKP_QbNXUE4-v__QJHCIyrlaCcdQay2R76stQ
Message-ID: <CADo9pHhq41HL66NxeFBoPZjhmowJuDPOn39zw4n=KLzuAwrwhA@mail.gmail.com>
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
To: Enrico Bravi <enrico.bravi@polito.it>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, "pavel@nabladev.com" <pavel@nabladev.com>, 
	"sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@kernelci.org" <patches@kernelci.org>, "conor@kernel.org" <conor@kernel.org>, 
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>, "sr@sladewatkins.com" <sr@sladewatkins.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "hargar@microsoft.com" <hargar@microsoft.com>, 
	"achill@achill.org" <achill@achill.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, 
	"rwarsow@gmx.de" <rwarsow@gmx.de>, "broonie@kernel.org" <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,nvidia.com,kernel.org,linux-foundation.org,lists.linux.dev,nabladev.com,gmail.com,kernelci.org,lists.linaro.org,sladewatkins.com,roeck-us.net,microsoft.com,achill.org,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,inet.se:url]
X-Rspamd-Queue-Id: 3FB8E5A8F73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

Den tors 21 maj 2026 kl 15:52 skrev Enrico Bravi <enrico.bravi@polito.it>:
>
> Hi,
>
> On Wed, 2026-05-20 at 18:04 +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 7.0.10 release.
> > There are 1146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.10-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-
> > rc.git linux-7.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> kernel builds and boots with no regressions. Tested on x86_64 (13th Gen Intel(R)
> Core(TM) i9-13900H).
>
> Tested-by: Enrico Bravi <enrico.bravi@polito.it>
>
> Best regards,
>
> Enrico

