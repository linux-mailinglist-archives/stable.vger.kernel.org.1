Return-Path: <stable+bounces-214369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI8nGXDRg2m5ugMAu9opvQ
	(envelope-from <stable+bounces-214369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:08:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B963ED2B3
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C374B3004C99
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206536E472;
	Wed,  4 Feb 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="teOU+UBd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2727A465
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246506; cv=pass; b=lGXLdJBMDSCo/b9F4ptSXvxl6e/YKjUGW8Ed1CxsDE8tGBwS/YVKAx5YZuz3f/gUWBZpYwiYiFEU8ThG8LkxO5CQD98RY4iyu8lwYXlmItE/I8/3Y5iKYbJS0jkToDa3Tm7HEB/wmgZ8FVcgOG98U/LhWJgG3WBs8TtQA+EyS2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246506; c=relaxed/simple;
	bh=/jze4YelSplwIAptM7myBAJGYPMZZ95HC1pBPuOrmVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfW4eUuGVd1+orskoqjL8BCSFYkmtNm/v47+BiL2S2MiK8rbELsg6gCaDZ1ujoZ8LCdYpz5DWbhHbZGRoJ+PPvFmq56eWcXiOqW2ogs/XyZL0qmQK7iosqAfwjvzVnpeGPD8dY4BrofkgN/zX0gpjjUQ/Kd0SR3f0DNS2kb9IwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=teOU+UBd; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so757298c88.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 15:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770246506; cv=none;
        d=google.com; s=arc-20240605;
        b=g9YWZEvj0fkrLhMhoppPHfUjOrYRKL3CjrDN8iHW8fTNnXRH01oT1bBIGVuJuM0oM5
         CDSxT8qCrlkI3qE8uUjQ8ust1P/akcDCjNwB7BsY2J9UM4+GCIE+zq4xyMnrnVhLTx5G
         cmCRPELjb6Mmz7Y3MK5farzEP/u9VzxE2RmgnnZZJjEMRiq7Y5Pt/2SctSSKx9LMc7/c
         wk2FOZ70I1g4mnjvhfk1wQs5ci3cykXHD/JYRySkogXwlHZ+hvzz/Y7I2aEMzwz1D2b0
         U0npxEK2WIyl2lQNlK5cZUmrASpaxhsebcQzI1ci2gWbS5IzSTLH3PxXFR66LYzXHP1w
         bEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGc6TK+a60aLQyzCLxWYX+tErzFSQGXPE5dNkGcSckY=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=DATSXNllVELVNqOkQPoihSsfINwukTln6c+QNo7VUlhZYW8AOArsLOzUo+jPYwHPKv
         dlgNNhwuwROU4GwjZ1dYZf81uPx2jqBiqXvuIDodtpkPg9scDrY7e+dxRvtT6v055F3k
         ospBFj4gmRL3eSbZsiCQVA+tTAmwot5maVx+oQPQQDHdnNYxSLozy7SK+uHNjv+TOd8G
         5zwKM096+fnRU/y3/nLOd9RE+3/viSUf0Knj/J2HsvMMPSiR8N/IX5MOdfH4fEdsq/PC
         Cm4CN6ktcWjvXogefwTnuoRUkVL3mofYjAqU+WJ0LgmWwOVuRjKVSXJ40pdSBJKXgamx
         m0Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1770246506; x=1770851306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGc6TK+a60aLQyzCLxWYX+tErzFSQGXPE5dNkGcSckY=;
        b=teOU+UBd0SnavRkV1z/nufwXb8PX02R+h1TFJ1wEqEIu1EPSWUbazfdF/TaTbRtJih
         c0AbdTEWlkylun6oskzobjpAcTSqZeGRYlnY8CGanjBiobJEAUmChCpOaAgbFPo97pkT
         grIihf3sGhhKWK9z7VLytVWy6irQX3z3dQrMRq80CaF2h+Di8hR1t7j5Pp24SR0mJ0hV
         xwvMllisY1FUrBgKlYHqK4Jlk3zfWbsjrENDY4lDC9776hkREz7tcMhfCxMeczXdeNpl
         XIH4BUMNBGSQyH2zGZ3FkVexYcQXM7orgeMaaU3Z0tuetXwChPxdR2Ogs/OBKxy9JX2q
         EFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770246506; x=1770851306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGc6TK+a60aLQyzCLxWYX+tErzFSQGXPE5dNkGcSckY=;
        b=FyVGnTAbFuPvZJKrMMOqIAmY9SETx2XGp2dcELMuCJGrgGJohQN8lVnCGvqps5pLfM
         UI0iq4NS+YMsU5gSAMDkV36bWALUrSFYtxaxZnnWhnOCtTkhT9RKBlSLQISt8uaHXijc
         MMK+bKGkxCt/9WeQt8BGYHVji6wGWgjUvBI7WR3skUESXM03qhuXxZrh8f4oIyiXjw4B
         fja2X8qU8fHklfamB29307qqHwvB2nV6DIsj7h+l21LC0cvjlL+DG6+s5H0uUpyYulsm
         NpSt9e0PE+Yj7Ej2oC5aEVxwOiYneQfdXErrU7lPz0i8QdjS785T2beiwTk6sTQhnaeT
         TDwg==
X-Gm-Message-State: AOJu0YwlLV1nLgzY8YmeXHda7NV8JjyI4MgAD2N1zNbnWJFWRmuGl0cs
	UwXyg/gqnWenVS0Yas5Ear90VQmtAIGjHiphH7J3OgVeYN/jAcw3hzFh+3k9bIW4wNgNXiM0p/s
	p4MOhcGnX+50XT0tsxOE6wFCzlOYyGfu1cK7cbXYZRA==
X-Gm-Gg: AZuq6aIrefjjcRpSKKwP9waIeveKWDseqs0XjcIP0wLfgQXNDcCzu34G5OHrO/XKRib
	52yPTJS3D5LYCkjkUumrliMk0Hj4fyz5FUC8fop3BXnew8QP+VwsitIn1UsA00SutGtV01pl0ts
	xZe1/1SgHuNy2p2FaZlwOWUlXFOC07UNx+OCKAThOnvQXfVzh52/vpO0st7DsECHX2icZwC9gMD
	bh/Y1bEGuYl8S/ZWokoh3vOY6y3gdY/4Ydq2Gbgxyj2xGlVxXDZwdm80Mnpn4zRlJV/KmG0
X-Received: by 2002:a05:7022:f103:b0:119:e56b:9596 with SMTP id
 a92af1059eb24-126f47bae4dmr1623242c88.27.1770246505667; Wed, 04 Feb 2026
 15:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143851.857060534@linuxfoundation.org>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 5 Feb 2026 08:08:08 +0900
X-Gm-Features: AZwV_QjfYF-TNpEGyxA7aGUSXEEIF-p5Hlr1boxvB4P3x0qFA7pSZm3cljg_uAk
Message-ID: <CAKL4bV5z-tbCjjj73vowb4jiy-mYN2qPMa6phLfXD-S4KV3Orw@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214369-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 8B963ED2B3
X-Rspamd-Action: no action

Hi Greg

On Thu, Feb 5, 2026 at 12:50=E2=80=AFAM Greg Kroah-Hartman
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

6.18.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.9-rc1rv-gcc6f56fd087b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260103, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Thu Feb  5 07:21:27 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

