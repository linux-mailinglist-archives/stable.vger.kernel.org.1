Return-Path: <stable+bounces-219734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOhYIseKn2nYcgQAu9opvQ
	(envelope-from <stable+bounces-219734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:50:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DA19F1DA
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BC9307F217
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4233859C9;
	Wed, 25 Feb 2026 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="iIjvSAhv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CB3859C1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063389; cv=pass; b=FsIax/Iil9CIJkzkFuJlauAos224TJ/AFgTeckvtNLZRwE2PES7p7HSf+SwE3+E8QVXyNdcUYNzB4MaY1IUHeTaCED+zi6t5Ei1opt0rFVxlSscjxNQLVX30/XqdVRzfcmQAwnBp25rzwYm0onYY/hTHypnbQEtAdJH641A5wtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063389; c=relaxed/simple;
	bh=O34avBaODu+8VDGPBSXMcJ3k14OqcHx2ReLTo7Qqoys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPAmS/ovX3XTrrL/WRbsDjjsM2r9IH/JXeBP6KBOpBZuGO/vCENqZBx9NGwIRIoCuhdoiW3ztefWTRiHKbEl0FgvJuB0gLXCmK/jTI3j1MN9OYpK1KSjSyKC17wdWzVYhOSW0xeUzgM3974q8ttEy1HHCymgKy6trcQH3RIjFuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=iIjvSAhv; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899b08be919so2957626d6.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772063386; cv=none;
        d=google.com; s=arc-20240605;
        b=ZhNybc70xzmM6kr763M2CrKlHgG0t5pJoCl1nJ5lhkewxZg1s1eeNv4ZncZXBxn3t2
         kC6P5tZbNp0ar2HMMgVRTjAtf2ythcVLH5VPIWQw2rDavRa4pRQcApcQcXRR20dQ8clJ
         v07c7oEeYHh7ZpZxedWRMQMJ5s68iTb2XM+iyYRjPLgnPEjhB6JaMLLNTZI4fCuSALqU
         N2peCDd874Nf7M4jXQwj5KuxXAeWoLs2GzNGGeS62oA0AvqrDUx5pnqSi7xZpZUiwomB
         EaeQ6WinI+mXfkqaKotfiFfoVlh+F9eygH72PgmIIt/K+IqSMjvSMYzEtYjK1viEK7RZ
         dRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/VkhlzMD6DGWoME1jale0+nAQrLb0QhvAu1GVkq1EU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Bcai3TghHWXQ0YF5IyZsmehDf1H/WhpIPYDCM7FfBha4ZBmLlBWaLnqaLv7MZUJPqY
         HR3Jf6mfZqaZG9CDDLonpusNJg36VDFQNz9fq1nNX9ZAjNbwx7OdYWizSMPtD/f40Yah
         cs9m/E1jU93i1g1SwEy0zVs9RWpDnd6tOPZf83dwcOYRP9SYzwZYAUM3+y0Q3llEK0Ac
         g19TPxyk8VWbYajGYObVCi/BUszhuXtDx+QMlDeV4H4rmQzr9xUCKBuHhSrqs9vHuELj
         Rmb3w+zu2EQrneOpSMNDVwmRX4pjRykF674xV8z+SHpRUwCpNymX7pNV61KkSRJRrm5m
         Zqyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1772063386; x=1772668186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/VkhlzMD6DGWoME1jale0+nAQrLb0QhvAu1GVkq1EU=;
        b=iIjvSAhvxfQG9MukCfu+GEN+0OKMvZ63BXGpgYoA0D1e28lHgIGaEW9qB6kMmClEFo
         UYYTOgF6hUc51RKKwgHoMCp1EzVHuNtx7fmkbTTnRP0SGCKVnrzlJOcPCCh4qsWN+Tbp
         psB8LG7ubZoY3TuL7DomXwlOoXSEf+nZtd8WMVteslFjSuhlFijtjQbdK2KoV1QbEhTK
         gCw3Falcs80kicOBzdakIoyX0aYltZz5nhlJ4KOz82vQzVvdOP+4jQQL5AEeOZ4zDECp
         6uwXwhi0lIXXT+EaBRIW5EO9OklGPAhevwjIVNXfkLK4NUs/MpQ486CIJGkAZ+T0xpk2
         WmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063386; x=1772668186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/VkhlzMD6DGWoME1jale0+nAQrLb0QhvAu1GVkq1EU=;
        b=NaHGNcsJ1sR9ikLRMHWmNSAPmeeP8fiHTXxPsiqWrQP3d5GlodhaULZXxv5vqWYJKW
         G0xFrcUPdUATbb+ZN2O0XMuyycyI/zPZYv2EIKBhLA/jtfRZg6Hb/6azSfFY1zRjbs9y
         dCO6AKr7vcuN1kOB2auPVGBvy0H/PTRCJqEnoKMKwKrb2lgQLgepfcWXMmpSEGKZJdWL
         1MIFMLxZgMSKXLv+XRvydNcIlB7EmlaLkCZB3S/wTQRst/gk1IExqKXpBe0Lf/VJ28nB
         lmpGoeQVu9//TBIaQcZvIvmcI+XQccA8G3TOTT6Ictf6jip7mQ23wUzDk8H3NgOARYsQ
         fn9A==
X-Gm-Message-State: AOJu0YygcubDV2cG6Nvx4H1jIDV8BMy9ml1pPnRsNep2Ua4xj0lQiKFo
	c0GHXdWEVzqXA6FoW2t37VtdDkR6Z4SK939YdwmjNg/JIeY98hQ4BFvIQv2gBx1C4nR11yaIDCg
	eseDeGwPGwNCsg4fwup4mb8kDtf2UTIpJWD384kGcDw==
X-Gm-Gg: ATEYQzw6et9JcFL55h8v5fqBb+AMXun3Ur1bi095kkGH5iUD9TQ+KD+I69a/bfrGZuZ
	UAc0wsbGylVS9wCvdeM6rw5YDAsBib0xg/J0zrBornR0jJfcA1TryOdvE4Mc+ERmVwnC8Ymr2bL
	65axwcz4Npn/KbubSZebrG8GFToDb/sqe5vn5GzxR2PSDNm02IjyNeeGZRmuD52ki3gxbvgiwK7
	Z3HEV1dKMPNuqkQUuGfTskxGOV8v5Fn+UXOf12/QhoSC15ORdacZTcey5e8yVZhwVi5qIjPZ43b
	1BDXueA+DC/CHqmYD1wDJ84SmoGX6Wh/dmWgkPl5hA==
X-Received: by 2002:a05:6214:508a:b0:88a:589b:5db5 with SMTP id
 6a1803df08f44-899c12613a3mr32829836d6.0.1772063386278; Wed, 25 Feb 2026
 15:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 25 Feb 2026 18:49:33 -0500
X-Gm-Features: AaiRm525TY0ZiOc_VdSE2OAeJjHmYCRhHh9Jcqrsk89dOJ1vpmn9GB-Cf-ZsvrE
Message-ID: <CAOBMUviRRVom_5fvqacAzkqBHsXz1gDa5-2a3HnT2nE_rhu5KA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219734-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ciq.com:email,ciq.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: DA9DA19F1DA
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Feb 2026 15:52:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

