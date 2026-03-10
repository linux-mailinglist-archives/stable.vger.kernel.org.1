Return-Path: <stable+bounces-224521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7DCARPsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:04:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858025534F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDC0B30C45C0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE03CAE65;
	Tue, 10 Mar 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMc3vbs5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C83CBE60
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160901; cv=pass; b=g4aY5notUg5Pk+cG17XjFswkcnRyYQ6RcuXdg8THGCQnLQdZ3kYelyHyGfa7ItekEbGsfGHFyN72AIRFSgfEsARb1OicRp7iAg6P8aRk2k7c67mZYxZjcdQFdMaU6/laljpQeuNwcUxYXblS6DemBT57+qPCUCR1VhQsQQ+TGd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160901; c=relaxed/simple;
	bh=vixX6Dc3Q9WP7tV+fEqTxw8jj8V6gNxpqt7wigSUBhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rh1m1Dx+IlHksojBrDbMtGjq+T7PC2FIwSdPtRoMf1v9dtfZQp3xCbtMUjRJ9U9ktcjrW+bzxSLkavORKCp/Xv2fezKCW2lInpDmVOgrQ9WEircHyR7w85bbbOLDETP0o32LWXKKQt5bBxvPXVEXT22K3mcP00PeDuBylb8xG6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMc3vbs5; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a3fd333eeso678591fa.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160896; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0iaWeLcb/dCOoFpPQI5ooaWx+HMvKY5QyUbOq3OAKk6LRbJX/bqIUkHYMg+bL8Gut
         krO+uYA/DjaYi12YCDHizsLTY5N2gxMKu65UU9LkWqJpFmIUjV1vi/OKodbBTv7qGP2n
         WnX+M9ncJtuq//wm5Jocp0h9v9q2tIJbxD74w1NGKCpKVOjWEvhu7gLEl7Ll8lq0Hwny
         +XU0Om0wiUjWrc2mRjc9I70u7IBH4Q2fKMZV3+L1t6YsBhYb0hN4TlFP74AFFVnt/Eja
         E4pt45loAPVUHlU47lxw5sP2KfEmw7wviioOnLMl7flZRrnVb4aYuyHJDFrKEVFRxhEa
         bubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QG7J9WrHoi2w0LhiwMhBEiBaEQuED+1kWKvjB3SLjzQ=;
        fh=RICbkXRQyZrmkKubGhoF9daTGNbPaCOCkXAEW5AKnQ0=;
        b=TriV8jrWl2H094BErx2QAnysEaQRE/oP425/5UsQgH5/JZFXOVkvEV9SPI6W9sD9Oq
         w+5vABUPMXliV+FjCPN1vel2ijXCYg2oTpP87JrEiJiu3SYU/4IkI+W9HF9oyP8+powm
         AQhLM0JUZZN0eOS934AUBLGj6MmZ2MZLaCOGmaBkpCJ2eKlcacw7RxhIgWlJE/6PW0dU
         6DqQBRJMDczd+WQhE1PSe+WFOsoeFc5oKaMpRvPfmj0DMCY+EMkcPNEJRdfAQA8Qdm0z
         feu9QkjIh96256wK3QIE123/PL433imI7jUEoNPzwBRCKS8C4tyYZOrEBtg9NUCUF9cP
         PN/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160896; x=1773765696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG7J9WrHoi2w0LhiwMhBEiBaEQuED+1kWKvjB3SLjzQ=;
        b=aMc3vbs5sromxHw2RO9yTk/ea27TdvemYFL5qERr6RMBmtcmU0xMg5AwhebY2Or67D
         zBTwfBKZTes/qERxxhAwgwdLt8YVJWQtEkC1yCrOLmx4oYdV3r4aoIJ9sgq4GcFfaeHX
         QKsZD6eICFgvWgGbxXn2wh2cVtoDWeZRRHZEqYKAWVKZBGwFXVVL6SiQ+/C9CqXRyEjT
         Zmgt/bjgsLA63FK7kFWdviRjX5jlJwuTKKd+/YSPTup6zqJ74E2pD536283MkirPEktW
         rznmpC2TpEssbHWUFNSTasAw9IUuWitsEBaofB0vtcAZ/vxCS7Ptg4PhQFiOWd+OivHU
         7hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160896; x=1773765696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QG7J9WrHoi2w0LhiwMhBEiBaEQuED+1kWKvjB3SLjzQ=;
        b=Fn7SXsWuXrlssNj7hBh4jl/sf/v2ru882eiw16FYgPPvvwdD94EKSPKIJdM0KMnFYV
         9fY1/9yFYQvDXrGgo1HI7R2LCW+EJr1XJ27u84w+tbxojOarm4cfuMF3BVNgAqwTMv+N
         BiKeWnxMWtYzmPQrNuGqEIPGJbNzdM2RnVDMrKJbj2Q09FwkeIazlAViSAFBDvy58cwz
         ogvYV+1T2M8owQfNttvETOJ27mhv8Ok8Jz1pPQR3G8dG6Zxf+xTOsU6dywMRvnoIfXzq
         eZLs0qHhAca4UiRKRqpbni37ZR35yF7GLSn/7cNNl3d1oh188OTwzD6XgUX6zuqIq84f
         AXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWecGnKZ65/G3OZbl1IC25b7UFWHA3HV5umLGdBjagcfi4+8h7VkBEUnlRemp+MB0+OdRz5MWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQf+7kbXLcBU8RM1wGisYcNZEvT6lGjC3NkutkEImzqmZ+W+Dm
	NSY3t3/d16ftYX6im355gFUcKnIdjeHI7BMJ/fdmWii7qMGjaLq3kfXS9SshKSspaytZrgJaDoj
	fkWCyW2JHTNjN1ZlFqjDA2MNECCF5QXXq5+so
X-Gm-Gg: ATEYQzycRmTJyR/TlIhZ8zkNRPvm6E6UmTIP30P3j4fjfjvbOMhD22Jn1n13Nna3LCW
	iY17qCbtH5bQ9R2sBm9XMPUbc1tRfwVzxSVmONeNYsB9ZIL0mm0/w8XAjKjMWsuXErvXQYfJhBO
	dFkRQB3WEQM1Q5QOiwAZiQqTx9oZhMfClPmuiWKNvsjIEFO6opNapMSgueokaU/OCshJk0E0FFb
	C6ae49WnKbpW05bTcRpkV1tUa3oS+delLJosDe0oYJB4OIg/xpurpXbev43wXNvkEFsbBdzNl91
	9Ak7hpuMcn6K2byyBfZPBtYsE+AuiLEiQIpVl3Nz
X-Received: by 2002:a2e:a016:0:10b0:387:5ea:e298 with SMTP id
 38308e7fff4ca-38a5cfb94fcmr11677341fa.8.1773160895956; Tue, 10 Mar 2026
 09:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773141554.git.sashal@kernel.org>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 10 Mar 2026 22:11:24 +0530
X-Gm-Features: AaiRm50k5d5AU6rg9D6nREBVFSX-OWPx19IVJ3HYqjnlpdUhqroGZ-2iIL6qBcQ
Message-ID: <CAC-m1roD2ewNjDOAtTEfiWPKtz49D6R0knnQx340npZnsR3itA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2858025534F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224521-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 4:49=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:

> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 12 11:19:16 AM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/rawdiff/?id=3Dlinux-6.18.y&id2=3Dv6.18.16
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>
> -------------
built and boot-tested the linux-stable-rc 6.18.17  kernel using QEMU.

The kernel built and booted successfully in a virtual environment
on the tested architectures. No issues were observed during boot,
and no regressions were found in the dmesg output.

Build details:
Architectures : arm64, x86_64
Kernel version: 6.18.17-rc1
Configuration : defconfig
Source : https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Commit : c86e53b5f7797099e5c89a0c3f43de859d8ec1ec

