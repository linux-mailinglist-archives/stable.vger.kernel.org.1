Return-Path: <stable+bounces-266713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p74RFk6AMmrk0wUAu9opvQ
	(envelope-from <stable+bounces-266713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:09:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E05698D53
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=futuring-girl.com header.s=google header.b=QKn7iowa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266713-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266713-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=futuring-girl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D534328DA2F
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36E3B7750;
	Wed, 17 Jun 2026 10:44:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F13A3821
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:44:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693063; cv=pass; b=ardn8nFDbZ1I20MGH+xGIFCMySNXOIcqmO69uTVOpre6POkD7SoJR00ogedoFyloFsmvbVY/MyKK1g/XMAiIlSFiCE49KxdayRsBrjfE3p01JhPoPPV9ehTs6YF/9evoZCKe0v/Bfzq5N8SK4N/HwnrTgY4xDDAxJOywVUUhkN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693063; c=relaxed/simple;
	bh=/NxpPjIzg+geXrODdaoCxyqEtoHwKoKr101StU+oJ0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9BdBEurfxyKHAv2X7rVqxfWiqQiZSMGH75ZqtTwFL3b2ENuKdEnRIM4w0I3zverMo03VI/zgIIpCRGk4oCFu4aN053kDcbvG9Cs7uJGSY7NHSYesjXYAQ3Z43IclbAl1NXqLF0SYzWB9G/8uynPm1/Rne0Ovrxs+3BSbRRjUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=QKn7iowa; arc=pass smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1390f75d8bbso1301251c88.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781693061; cv=none;
        d=google.com; s=arc-20240605;
        b=k8N7drNuiT53nqS4R+/Qi9iRWJKUuLLGXNJG7WAvyieauQ3ec2gtXwLJDRBQ7NrcwI
         4GBFV7lfoWYXIvW053Cdh1/DTZfED4mEv6HIpsEX7P/Vx68Ky0bdgIMmrFA9PxeEkMat
         uzIgxvONO4SSRFYNJMmowIck7k6OPGVmuObPo8MEWrSLTB4R5HnKMBdbeb0zGawE3Ffp
         RPd2iavgJW1+tE+YwYcgYqcdd7GObT2cVGKTPCJDtf43Umf2A5Xr9IADzqqkWQl8Yu7e
         vTQc42dhOj3XdH4oTc5CQbOhvRh9eKev6hq7Yh2sgd5qHoXfggMkp2ziF778NrLVr5a2
         aRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i9O0NN3TVK+XDaLnZjglwVnb1NmeX9L1ao27QadoHB0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=IeI1beTnX5gQ4efA/K2+JzT2YT6OlAbM3vt440nBITs7eKa34ycYvSQxg2Kn0tZuY5
         tbedw1Mh4XEk8dpS6cs2/SZsL4Z8xoA83tEPJKJBLIW2TQZokCwWwEGJ9NSQALooF5DE
         VTC373iUU98O3yU34pfTKfVRanEEtPg0K5lHizyo8vwqELL7LXDyEj5mksxFBzoxlpzp
         XxG5xQuSAPSbiD4suNXQ92w5KQmF4wMZaLJNpw9epHJtSLL4AkKwsHtQX+S1U3a1g1xd
         0FbIIxYTB5kxiAOzHDVRlK9Z1QZZ07/LnLn0bVohsaGdQl3nfCmOBMPkCQN4nzIb89Cq
         g4ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1781693061; x=1782297861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9O0NN3TVK+XDaLnZjglwVnb1NmeX9L1ao27QadoHB0=;
        b=QKn7iowaQm/o12RhSmhot5OvlkOohbHB4gC91gHBNyogDB3RYQDQbNMlbsFUGWxOAF
         1PNT85fxbzeBEtI2h1LW251FvZQfQeqKWY8XHDUVDzJmmX2CY+EX4yeUM4f3B3PAoj/0
         izrCvT/9udHoKeeFeHJcvJkuOd2NygcV4UKUyDldjOcEAqKNbAAKnCfdIgyd/NueDJu9
         Yh114pkxiX10xYKRg/OZWmMvZsMkNJ8uQUBjHif3UVA+yxg0XlBIzMTuEzVvOpH+XlVq
         R0XnZS+tTwYXwA8yDF/H5X7TIlNwYQbMSHXOQBPErtiGxpNnTtVf+E8JnS4fOCtPUpSS
         OqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693061; x=1782297861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9O0NN3TVK+XDaLnZjglwVnb1NmeX9L1ao27QadoHB0=;
        b=U+8+9afXDtAaCMQm/ktjKRrd++Mt9ScuTP9dHYIkjQBgQ7/pkl2u873Pv2oD6mAvXX
         EfBPuNeLuZZsC1VrMiQPvi1uajljf6FUlr+RmxNW8R9Up6jOViIhdWmkCZMsUtiX9L0e
         /4bl5cDDhlbIVmsyFEei3k32/Vu71O0vUj0Av47H1r8dxPcK6rWH/4GEI7QM7CSFfkbD
         zVUs6Pb0SUQ0iwCenGmiNWr6hovmsA43OTze5YD8rrSZ1fTupkjETbX1bXEn93Itblj3
         N7Y8T2AI8Wumgy/S0yAlAVE6WdMRJRuuceQxPcUPHcebdCv1WAyDlPmp+koIiBnhRh8J
         hZ+g==
X-Gm-Message-State: AOJu0YyjUqSrRy+ag/gNU0yqvkaX29F9pDgsQF8f3larBc7Lbv+InzBR
	qjWHSLaG61YJC5dImlKfVJtCEqfnjdfMHfZ0kQYCftJ/KBljbKcRAsihcJdxhjn7tGuZYaAxZk6
	lMgCSfXPuYS5LneEkVkPnNUbjKzNxZVnenMICX/6UUw==
X-Gm-Gg: Acq92OHskRMFkX5idjV+mOX2gvXN2RGETwbTBG+L6BKmfBg+qvupXvjH10g5i2dkFik
	2Gvh29tO6Fg6PV/4LURfCZguZWrDqvWYImYl+J5FQPlLsJcCHbjwktfm1SKy1PVKlTYmUEOtmBM
	lR+Ro+C3T3B+WwJVcOjqUJN11TTc1KK/TRA35dqyW+RUR/bSKN9UA5ol7FKFj33FsPX7kdkVUhD
	rvqb2/s7dOOAVxI9gDV9jiwwfeza0UN6appzsi31WHzETg4stPPBv8ncil3pivNfeD0nrEwQ336
	EUcyLqaW
X-Received: by 2002:a05:7023:b0b:b0:137:ee9a:2ad1 with SMTP id
 a92af1059eb24-1398f6f32bemr1208632c88.35.1781693061286; Wed, 17 Jun 2026
 03:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616145523.335696673@linuxfoundation.org>
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 17 Jun 2026 19:44:05 +0900
X-Gm-Features: AVVi8CdY2K1fR7miHU9HYoa5ohvrQsQtDnjjTgBsQWfNlb2XoGbDHsNacHlBrrA
Message-ID: <CAKL4bV5qmt_v3zQZvvFXRs3YpUeZtvFBt+_sko7eAuqcgUZSdw@mail.gmail.com>
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,futuring-girl.com:dkim,futuring-girl.com:email,futuring-girl.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6E05698D53

Hi Greg

On Wed, Jun 17, 2026 at 12:01=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:55:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.1.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.1-rc1rv-g281f1e815287
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Wed Jun 17 19:15:41 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

