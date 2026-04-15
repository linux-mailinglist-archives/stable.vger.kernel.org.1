Return-Path: <stable+bounces-238187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPzrAoPd32nXZgAAu9opvQ
	(envelope-from <stable+bounces-238187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:48:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCF0407321
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179A130226B0
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAD292B2E;
	Wed, 15 Apr 2026 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s46wYTHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97A23183C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278764; cv=pass; b=iFk71iSpqq8Aq/AQ3unW2ZV5uRSz+xYlKGHp+vYtD+yLZtwAYQE8p5WhYBOoMwa/EbRCNZ1/VA2YFGxwFpbLzm7MNf8r58OxGmiPoWmI8ra1KiWyFJ+okjxXhPi4Ybx9IcxtU6r3e+HGHjeiMDi/p6sYC8Z/YERtYHj2ZqafWYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278764; c=relaxed/simple;
	bh=tiVxsaCqWWNVXpTWfTarr3wP5tbbpKx//jfudX8htKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpvtC/X+9bf5zd1LqnotCWahKWfmBke7njEPKFxIU+ahL4A9AyHLo1nzMUs+jBLjpRXwiFh3oJOs14+g/lRtqmQZlpszpekJcvW1VVKqvUvpyZs6H2tsFuZZppHYH2F1MVHt4h/4Cir9zVLGnzJhclI7SPG5qIRfARLktnTm7qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s46wYTHz; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a40b2d268bso774148e87.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776278760; cv=none;
        d=google.com; s=arc-20240605;
        b=aNoVgPswRox2qGaWIIwZoRaVfXN41/egjpRRqEdDMoWCiHePlbOemsrMSsEkXRRppe
         6HgPnhwOyujzLZyqHy5ni/7mpV94ezLvrfZe6oK7plmTPnid40+1LX4pGXAqgcFHoNCC
         5DMuVJKxaRdHQwyMFUudMLfwFF0ZStavC7nAlt6tptVsaFloSH7/7byWDDzDyfFQbn+l
         I7ktZbz334nRR05dvad4mTPXtq+3Fn0nWnbnLB8W/WUZnLYYW5gEqVS/xkVWGTyvGnKQ
         hKlJOBlpOLhMQmN8Ut0iC1rvTJGhVzI80HZUQ1r+BoeK4dAI7kqs8CDZeXozib9iQOe7
         9Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F9g437KW9i1Y5CVsW3NswmQ5hVUE5gVydtz7VdJHyHk=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=MBcDGBt0Xn1+XoF/jod2C7Fk7kSqbGfKoUwculDzgQrlqbbB8J2EkTj6acignJ015a
         ZDDLFYQEBEAcy+Nuloutxvm5ikVrl0MWlozvyBSgqxA42uIf3MY6Dlbmm04oE9dZFUte
         m6LxvDxIn4a9ncPx/dwjdTS4aHisOyaJITZ0IYfDDOncvPmkhwW9CkMT5STKEJto1nki
         sTnbbPFWiZ1fRnEvx3ZYGBSK3Q/iohONPQi0j2bg/U1K8q83UIB5COSBBJwE8+Qe5fcW
         NvtwmcWCrANNn6Z0NSwhLP15egUAvI3FMvUATG+ytoAqOygc6fq5hBqfXXp9kBYYS0hd
         LuGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278760; x=1776883560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9g437KW9i1Y5CVsW3NswmQ5hVUE5gVydtz7VdJHyHk=;
        b=s46wYTHzrk7q36lUIHZRpPrn/q6zgC8VmAJPYXszughxipjl2F8z44UZdBMpIejXVR
         gbl1EwcfLiywrOq5jrp8uDkkv2DmGLFL9NgGKx0HLYm6gSfaZopiom8H1WlL9QDAOdrL
         eKJb8Rb9TTcThh9jWA7ozHJDq1O4mvf5McoTmAvjMjw4OVgOt8iqRTi0h/o2HrkyLA7e
         r7lo3IeoYivNUw0QGOY0rDTz9LB7Y9t44km48DDcpy8auOBEdgGPKcPg9PrIVSiw0AOt
         aQc5PJCxSrCkaFhaTGy9xLRPNLT+BXLFt2pbwHHOdJM46pU6pKvvoCUBpUJsLFxZcdag
         1G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278760; x=1776883560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9g437KW9i1Y5CVsW3NswmQ5hVUE5gVydtz7VdJHyHk=;
        b=dCFTHVLKmKYF4lk+a5JcOVbNDBCTwqqCJrV1rZte+BaWb1vvPCQoItFs4oEBtVRlIa
         3Q8ji4gWjMFe9k90RwxF3hPgQwema5b21vVUV67+oFx/eCS6066buNhrkIA27oy6RGL8
         Y9fmyX7QoGOWgj5gip8ATrSqihRU5z5cbHc3q9Q6aCp4c29+0o9pGbcsf8HSaxx8jYTl
         CswbgKYmie6fnwYCU8idSiOVOErIaBuVKtxmf6W9ADbFA7JrUHFxuzcYXtK21lQtzujn
         e6dM48AzH69k/E8H6XhtZB9LTQd2Mpt3mf4fAsJVMrtj2MVMaWHh8tZIj20adaqdX1b8
         cT+Q==
X-Gm-Message-State: AOJu0YzYxvONY/UzWj7yR6iBqB5S79GHkw/YwjopjnHhRepV9NhYQxVN
	FcAd2wwe15DogGeli1D2EhHH+vE9QkaOCo/N5JIRaW75dz7J/Z1QmhwZvE0RP/UoamTwOTWKcLw
	tGQXjyot7nODqEMDtFl8Ks3oXOQ7zPHyDQtOK
X-Gm-Gg: AeBDiesww9BS8hiW3UqtVZtEsYYs26bcDnmIvvEviS4/dqYvkjlcT2KCau4s1A/LhXM
	h0x9JbXnKGL9G/Z1bZoom8nX1Bo+xKCGZTzCzX5qElKdIaf2+23x77Wmojec/Ub5iDCqkuIYh49
	JQ1ThF278Bzd9a+ZNZvoH2/d2Oa8kepgiAxlEWIa8XMbWkAwngh7TOdgJN8FnqKllcJ8UUEx8Md
	oJ1AAr+UoOfPz8JTmq2i/t2iPfCZ45OHr2yPozP8kK0X65owNB0chExFRZqmnkaEur94NIi/fSh
	jGbLMNKI+YkBrePR5XqoOj5+u9yffkL6WTs0BR/h
X-Received: by 2002:a05:6512:401f:b0:5a4:3b6:94ea with SMTP id
 2adb3069b0e04-5a403b695fbmr3569578e87.23.1776278760065; Wed, 15 Apr 2026
 11:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155728.181580293@linuxfoundation.org>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 16 Apr 2026 00:15:48 +0530
X-Gm-Features: AQROBzDNmmvUj0bf_HHHuzj1RxKBrvQQTZsJ5hhR7f3hm9lmYe2rHCu3RAhKov8
Message-ID: <CAC-m1rpkx4eDitQ=F7r=5JEJ+FxHaw3ONP-6rmuzs-KzjNwCcw@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238187-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BCF0407321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 9:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.82-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report  6.12.82-rc1

I built and tested Linux kernel version 6.12.82 using the default configura=
tions
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 6.12.82-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: f4ef43b0a8c401bcd6d40e3eefd2ac504f23fd00


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

