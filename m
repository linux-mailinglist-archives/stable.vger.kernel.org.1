Return-Path: <stable+bounces-214615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKDvIGCghWlKEAQAu9opvQ
	(envelope-from <stable+bounces-214615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B75FB3A6
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C9FD300493E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FD346E5F;
	Fri,  6 Feb 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHBGmoRz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E96346AD4
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365021; cv=pass; b=R9VSUB9tNk7ddjw612u2nNOm2sEAgqhGk7AXqOg6p0KzdMHgY8KXXkEAOjJm1y7jBdH4UyTWYG+1Bz4NHXE20WK3rbe7UlslQRQA96o0gOwxWiAbkJHmAS/m1a5AU0rBCURX0rSVnDhAMo06CZ6hvB0aAjvcDF/76K6TqYwiZFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365021; c=relaxed/simple;
	bh=QsKcB0T8JN7X3zlFV8+xIhURzxq51vgPi2dHmjDOEcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzpKeP07HZKPbuni3P/cUvHhvdpz8IFpZeHHfFbW7qIOrUueC59FaP9y4RFLjfO4LagupfvGCSWtyCC9V4SsfE8GJ+uGy4yBdCvE1msvrNngfZ5xonEfsiqbZuz0t8fCej0DNFavGQFYGmoA522koja1A0couImhKoAjtpVRy34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHBGmoRz; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dd4b602bfso2328744e87.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 00:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770365020; cv=none;
        d=google.com; s=arc-20240605;
        b=X639WNNwAJLZDEZzBPT/KgtipiIzj1dgXloMt8AshBULra/1ebfzDNMpCnoSMweSSz
         XQboBgMWIXtbXGP33XAhAbaHyFVMlHcHXb4zCKoHzgxcjFHpEBCsr9tv7UZ5V3bNqEG5
         nDiWa7zD1rQNTAVu/c3QF6cJ6KF1pzs1RKB7cfgvz08USTrpzOYQXSI8xtKGDKvnhvDe
         iQrouz2rpx+jJ3CNYfMA0UtHvv0bppF/2IoRqOcr5RGYGha05tBTjPrlYF9oBBLUepo5
         p5R7RDJOOdVjKfhrB6pZ4aDfGuf1aQd+fHuojvZi8y9yr0Hnhhu9NjycxAEqh9OsMil6
         BUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5ENqevh88Ydsd2wEXZ9939rHOfrTJlZPKJrBfilDvI=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=JwBDs/fPDwM06J/LoR5N3dVfKLTwoVLybXK5qXNhjw+H3t+sEBe+9+F2B3mGjjrf47
         hthF2yXi+m0CFMvhIVZNdWzjE8dyZDP+5Zd/8cJNLzf88zLlvmatgF9GhOcubvhdRsxt
         ECm4HynBk7Ih3Tr+faYr21nfDKwANBCcIQdwVYxgZW17gjBMrxv3dYNNCeOlxCUX3T+1
         efIm3GbXqe/dDyNRXcn8Qs0W17yZK2CrUDvJKkz7p/qI5tBSck/PrXmVhu2K77wWnqaP
         j5EZEhP1i+SlBmxtQk68trMPWI8wRU7xJGWFcByLbtN+2Bq3iFHwOeg4sY3HHlzF/IBw
         DXmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770365020; x=1770969820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5ENqevh88Ydsd2wEXZ9939rHOfrTJlZPKJrBfilDvI=;
        b=GHBGmoRzxYYqQ7kA7GugVxP9xc1jL5lNM3pjPVmdq5tvgtsTGM2dCtU/laeFcJOON6
         bTqiwXleh3YF+kJnAvxpG96zAoU1258xFpE3WvXLShRF2jiilZZgPKBF/zSyiTOwAodZ
         klHk5sPZVxCZYahln9FoVxaXBR8jFsCfwEykBQj1ZY/+rrCwiERyTBm3bSZZM77PQE+l
         x60iYj8lDmR/QoXRq2kJmO51Qaw4zJVD4slEjnk3GdrIS945Pgecd81U5UiaXgE9TMDa
         Eamqx8cBf5EwgAYzzN2Lt9CIXvem8af5tV/wLXMKms4APiIgMF9giNNTDC73pfeCvazs
         5ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365020; x=1770969820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5ENqevh88Ydsd2wEXZ9939rHOfrTJlZPKJrBfilDvI=;
        b=Zy+m+p0+YN1mwFNYesxjvdzJi8fP5VXZEkfGGdXWyzm15a5Q6oZo03FMh/+oUOheDZ
         phQi7Pv8ZpikHxC0T/LcvQkMY8Ec/gkVz7yDFVI+LTqoO+QykfzLUpeOMj08DJx9c703
         uhFue1rkg/uvsK+fYmFsS44z/Kcf+1bAIAV8TZCXck6ieWTbXav9noBTuMHeHBNO+8+U
         UlsSvC2MMaWvVaMNTn2Nvm2XD4rrNtHtZhrh4zjUT7m2BBO1BWxUx1TuiMum3NUCY42a
         u7p7AoVfcyGLCXbp6sPvfhBgQYY+s1GKq8uUqvDx1aUUf5U6WJvpKVA6+UY44TCQl8KR
         RNIA==
X-Gm-Message-State: AOJu0YwPHbv8Q/q2JQMC6B7Gq4TIQZLVyerwsfTKo1kjLVApxliQLPL5
	QxeS0ewBOvLd/HVWdIZ/n5RObMIo4D/RP8gr6YrBcTdbbY2J+2XxJxD3bRvZiD58Swq4eSG73sn
	jykemZ68PB54n1utNyAyuvbfzWNZLV6E=
X-Gm-Gg: AZuq6aKB/1cWB/lFoW2HnvSoiLALT2WTHVxXBB9fcNWdtONEcVQqUJgVbFViowewsHS
	JEkkIwG3xs3GmbclW9N05oBACkJyDrGuKiaff3M/w7T8C7g0TOIhB8zpDs0osWS1Qo5URrmTXDC
	N3dabN9Jb/KcyHNFAMQ5/j8dgx6ZW+8CMBBvfB8GOxliX/ouQlbQOdpTqCmOkL+27wPlr1enciY
	BMSbypNMUxYv1t10N6MsmfSjFf7bd+YXhuzzXQJjpkj3XHzPlptBghFst5SgnK19qsKSfAsazEe
	IFWHe23+AZs5q/bX1v+nnTtOGOThtA==
X-Received: by 2002:ac2:4f04:0:b0:59d:d50b:aa8b with SMTP id
 2adb3069b0e04-59e4504cda9mr514236e87.15.1770365019362; Fri, 06 Feb 2026
 00:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143851.857060534@linuxfoundation.org>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 6 Feb 2026 13:33:27 +0530
X-Gm-Features: AZwV_QgTkF9QBheRUHy2upwkFWmU_UvU3JThLDwW5NlyLjdFl4wz8m3mJk4lOBY
Message-ID: <CAC-m1rov-iBcwJBkPaPPVHmENc31gAXYTZF=WCT90Son8JcirA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214615-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 27B75FB3A6
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
build and boot report for Linux 6.18.9-rc1.

The kernel was built and booted successfull on both arm64 and x86_64
architectures using the defconfig. Testing was performed in virtual
environments,
and the system ran as expected.

No dmesg regressions were found during testing.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.9
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 28a73c31d7f5d9d2276c92e1d4891c18a5631e6e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

