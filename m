Return-Path: <stable+bounces-219714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJKYJbBnn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:20:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C29819DC52
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B591B301379D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016B2F2607;
	Wed, 25 Feb 2026 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgvSRpXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5C3002BB
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054444; cv=pass; b=nj/s8Hzcq9snARGxOV6NcvrWUIncPPuLwFPryh31kP55XBMu4c1e2egenwm3F4UlhcE1KP+TmrhpFu1Be5e/gr0cWCaa6r2z/AmGVSW0GGX2fO181gw1dtYGkPMNFnpA8KNA0R1FAmHucLmMRx8uu9KjR5w8bdPT2ArZHu32P20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054444; c=relaxed/simple;
	bh=gqh7LaKXnAfJDOtS/Zh1U3t6CmJncsDIgOQhs0lFnp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHC7u1HQTNrjGKnezUvgmVT6ChkdvZAtqp0tCPrkRtU71BW7mWutkIpAiyKVAAXuWtyXFFioG5Agyz9haGsG6unaLb7UDEphbmR3O+fi5291FHN+MO49k2ys5M1K7Ki7KNmhNnpmrKXp46EpZd0YPuA+0kDstDrvpuHLHjQvl3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgvSRpXf; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1273349c56bso146110c88.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772054443; cv=none;
        d=google.com; s=arc-20240605;
        b=QGX0hNcp9lkbmbFw8Moxi4kgyErAJbQfRJksP0iclYRj0eiGHGIIdMi/JFHocYPFIv
         RMqZO+GnOTZDic3tcKntTtB5TvHLfXOgaWSxjGuJ/xZqtVmLAO5S8BZSl82mbzABEMd0
         aIFv+nDlg2yyroEdubIZsLY3XdGpHGroSAkvEyTutiP4dnk9WYgsTZ1FTWWj4Re46hBg
         dELjceLAL6Fy4UsdghZL3se22GHUo/bnA0nmcgDjSzL4HB9r3Y7FOqnKgkrMax0QRwM8
         tr1jznl+rWrZi08ySbGHBrrC5lDsdeUUGd5nnGaiLAZpiBEu+XcE3i3m1Er2vL7M05Hx
         k9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z9xYNDb1k9HYT72bcp8xiSrnUXl9XAY8qv9TtjCrloc=;
        fh=azRQ26aub6yogWgKb1KPAhInpHohD3iXt08NWAY9Bu4=;
        b=FZ3fkjUM34dJPx/iUyK2gzsY9dOkw6JkAEPaaawDLx91zUdScnpLkiWzMhwFGEJwEq
         iAJM2Qw6KGc7wwev9Haq3MDFi/7X/9fRE/f003A4hx3SzV7pmrwMKiF0Zmkd4AIl+FA3
         xNFHLBe30LxY/m0G/Wq7q5NBaSa8n+0Ul+No79HugoSzeNQRMztPPVMyLV6tk5XvPXzE
         iGlFr8eg3/ETWRPpNb2Ep7KmjNsqnl4Lm2uwazNL4RTyoplapjxyPw+jf0YNKePehWMJ
         Q+5h34xwuRQYzVvi//Gr/tfjyUrItpAHrMbiVS731bdy7h9n4O2vh1/2bsMyDiUvUdEj
         3l5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772054443; x=1772659243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9xYNDb1k9HYT72bcp8xiSrnUXl9XAY8qv9TtjCrloc=;
        b=MgvSRpXfTrFmPuudzk4ik9G6T0KYmTaNTg66+26UMZRa2DrBNZov0KPbIWDbVkTL5n
         oIpJDuUNW48tiRluKVK2KwqTm0787gwcjmoEHsorN6mZERPMHzA0NxP7mpcFWf5MHVrk
         aw3IZvGVpApn3qaNwuuRogiWxoRvnz+iWoHp2eRsU2P0qrA0+fS+4US8XcCR6dFPgjK9
         Z/DcTord+3T/6XbsfowZifOp1j/R7eokYFMRizXlkcXOMBFdTCzuNmZL1jpWN58C1KXQ
         fo7VlOZMvFleS3z9fB3m3RC/p1DGiWcee4mzuXJ/AFjJL+Xl63ASQxR9GMiG+U2G3C1X
         WmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054443; x=1772659243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9xYNDb1k9HYT72bcp8xiSrnUXl9XAY8qv9TtjCrloc=;
        b=r8Dl68Edvq3Q+FI+Z0XuoXZE4YoT+y5ACLcuLD3/rbxoxL29SPIK0gQsf5aknEjuof
         jPNIY22pJQhcMut2bDQf/wN0pE83bsj4awgg/85sNzv5tgASoGAT4XYPCWuQ6wPpndOs
         cjplXuv23vv5OHwShzdeRvC4NjsBbT1bvEifUrxL+NzmDbSPlgDtPzI4UfTwa/TziZ69
         Dy7KVPhIrwu/mPPL3SmcQDQcDaMBYTUcVPp8TEPDLTazqv/pDnwdoxxKIM5WL7VsF2Ln
         QCd52vRi7F0Qoj+D/rR0Q23UwCBExAF9pKZSEZigEh72YQj4ftvZqLLyXLaZ0tMcUr43
         MQJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwfTDzvbP3H5FsHZ8BlVqnmAR4Whxrp/h0O7deGtlL325ak78srtl9zQ60ExO9nn3Cm8FwJmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIueFk6hdLSNd99UpfG0j/bQA7O7wYBdnEuwocZpqFBcnBJRlz
	zihDPjztOXTVKBrNCWUOvG9XdJGhNp3EVnt5XAzd2bEv8Trjy/4ACiexLuVnUT1jbqRInT9bFfd
	qn8+WVtY0j1qNqD0b5lCIxQ0phxpkRf4=
X-Gm-Gg: ATEYQzxTdOW1/abj3jblrRFbFFaZhOctRZwX159bRg40Kww2HufvOWUNeo9a1doxaNI
	5LE2QQ+ZFjAD1WplOHPNgl+T6IfTNlqgN7eUzEsAF2IiWaIV/L3XNHXCEz1Ombr/D73UpUStnOA
	TNaXYlVHUBz4XtDt6P1q6wycZfBULkTyDQiPGpQkLKWgJUC8S3hzAdDNJkz9+dIt3jew0uI1Nsm
	TVFcd9YYWPEYnQyxsXQYFD8pA/CAUXwUB95pFNooOBhvGQKRhdTzQaw1ceZoZwdcWEmNTUPFXu8
	hi4w1pjCtjJK47qocizqOxKAur7OKTZczXr58GUNto2spazG16O5NRcS48cnxxoVISvPJMpwdlL
	RJkS5Y6fNQYjvLs6teoVGNP87TQrFovPlRScZxEofmmfYdAbvtnk7/CLUTt28hEMjFRY8bXLkk4
	wuVPHY9XsLwHY3rZiw4+HiLbZUuX+HdmNJ+ZMh4GM=
X-Received: by 2002:a05:7300:d50f:b0:2b7:f809:9c31 with SMTP id
 5a478bee46e88-2bdcc09065bmr801391eec.34.1772054442739; Wed, 25 Feb 2026
 13:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225151847.709818960@linuxfoundation.org> <7a610f1c-8748-4361-b5dd-86de80c95aae@gmail.com>
In-Reply-To: <7a610f1c-8748-4361-b5dd-86de80c95aae@gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 25 Feb 2026 22:20:30 +0100
X-Gm-Features: AaiRm509DewnfxN1Iw36Pza98eN_H6imKyRFAQGHNVdZVizhudjl4ggf12hcOyg
Message-ID: <CADo9pHi+BM5mzAEv3=sV0Oeqk+O2gyBzwAVdRz1tH9ZyiNYgRQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
To: Florian Fainelli <f.fainelli@gmail.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219714-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0C29819DC52
X-Rspamd-Action: no action

Tested on: Arch Linux Machine a Dell Micro 3050 with a
model name    : Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
and works as it should


Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 25 feb. 2026 kl 21:41 skrev Florian Fainelli <f.fainelli@gmail.com>:
>
> On 2/25/26 07:51, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.18.14 release.
> > There are 641 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 27 Feb 2026 15:17:08 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.14-rc2.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on
> BMIPS_GENERIC:
>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> --
> Florian
>

