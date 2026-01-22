Return-Path: <stable+bounces-211193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEkoBKajcWmgKQAAu9opvQ
	(envelope-from <stable+bounces-211193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:12:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A740E61A0F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2236D4E3091
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C20410D1A;
	Thu, 22 Jan 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="QVBkw0z6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6A38A721
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054878; cv=pass; b=f+Ck+rCeMVsWUfVZmdyI6kLPdHDkSnV066+/l1ZA9LlXzq/NksRmJCLfhjKTdUbrwDbn0uGXVBhG5UqA+u/04PgxEJccOTJzDmv7rotCHg3/XeGBJ3xJAVtxF64g/sD74ZLiaN/v95yMOoGkFhJZZGYv0opHan2hY9fMKyaAtY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054878; c=relaxed/simple;
	bh=zOEKbmOpIJoYf0QX2Nc01sHC/57YLEFU0c56dT9X9Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlpF/rTsWTv3BBWvIH0s/vVdtZTfxPo568c6Qy5HozyXlT6+VzvvTyA6tVz7FPQEbztzX+r2DVIiN5RWdo0NKLqlrwgqZVnp7++VUQMj22lPax75h6RbBRHBOredX+dFXT/GAmPCd+vHEIktvXlfO420ZRYvdn15nJR6TMtYpqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=QVBkw0z6; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12336c0a8b6so1364751c88.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 20:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769054875; cv=none;
        d=google.com; s=arc-20240605;
        b=B/x8zF+Fjft3btasbk4k/JzUGYWw/4IL8GYpKnGOxTNxk4cCIs3UuLT6MGUHSMJl9p
         fQ2mhab33B62EMrdcjKzMyQYFF+a7YTasfuYI7F8MwTe4K29bo/0tg0Ze5f+dRhPBbTS
         oEkpgDbkaeZXcaa+x2Gx7BY8UgP/gRf/nYx6dHc7KYzmE7do/sQ4Uu7/PZJLn/Wjp8Gc
         7+5ka8KAmpZbLgeqelcAeC65T5sIV/gHibG1ZVIuRQrqwRDrH73NJJtTzDxtkwyicQyu
         XpAUo5IyJ2Ayy1Sg9bWF0k1eu9kik+/ayHeYKGWGGko2zvyRAhtRy36WprXp+7+KF2Jg
         tlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9pCTvGEnBVVPW1tjjQf5zQXP0S6Qi4+0eKihAsvxNO4=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=ddAeU3Hg7ogiqrOUMonD45Lj+IJsrBkcpSyrjdIKGcJ8hVmgjI2JVYS353nUCODAAe
         K/xkUZmFftIDfqPqVEqwPeHgAmsv72Ut4KbdzjiWG6Z2s3k1a28YEf3+jn20AOhJ5l4j
         FW+eyPxtlVC5S69v75/t1gLy0N3s0Kn9x5uA0IwALUbBm764MekKVBqTAJUwWtdEX1wj
         hoeJiUyGlafvEgxbeq3k60/99By+MT8tyX6NTPtVLHrfnhiAZNWxKETMhPBYQDw/FXpd
         ghtHtD7+kVwW1OFqfZIMzyM7AQ1yA9ILUXwpAcZ0v0xoJTkdrEJMQhiY6UmIOUNMwsmY
         Pr/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1769054875; x=1769659675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pCTvGEnBVVPW1tjjQf5zQXP0S6Qi4+0eKihAsvxNO4=;
        b=QVBkw0z6Lb3Gp3ls69RjyPR6VZnnyC3mmrIKuWblXCa728T8kI4k1BlIre4qfvaF9Q
         j/NUupcmBl3duwbXmmDpI7bZ/g7uj9KmLCx3m6rHaW7VbXNVHQybclRW/JRbcYxqFrB9
         9XHfA3CWBnkKKKd2CwK2y9/hNplYbjAdKraeWBp+NwKvt3HMhED50hgVxU/nyTlY3F0W
         UHBE6FJAhGort2CefGjJ60MfInpKXtoMbGrFyE5V32bQSiW6yHMUAPFUG8pjN201V8Vj
         MNbCFNNQw1PfP9rjuEMrmox9avENDdOvMfXu2ZAEspgQ79/WmmIPusDeeK2Jkh2T6Ecm
         duWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769054875; x=1769659675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9pCTvGEnBVVPW1tjjQf5zQXP0S6Qi4+0eKihAsvxNO4=;
        b=gawdD8e0UPc+a0HRSpRIjfxXKy58yES4sSmjTay5ltR/amdHu4/FeH6GIawJEoffro
         GjFinj+MSbPQDmlwgCuPrM9dQ07Y/LDqFdGIwWuWQk5GOX74/vfLBpcAO9vF6eLYEZF+
         xCvkorDwOR2jBlBl7VMs/HbV6U0euIv1yPx7wudE7DPfXUSqJrRhAhUpdirdEJzAaf3v
         7jklHVs6KMiPkurd5vry/eL0MFy0bDvVhHpIjQ7bLtpeMrmWZ3IXFQ0OxkRBW6jSNfa7
         LXBXbaWo7PfPrEmr4ul/F4cjSA/MeIAs/+mkm1Xch+woKxdSoSXsV2A8b5c9p2K1f6p7
         63QQ==
X-Gm-Message-State: AOJu0YwA8LKzzRu/q30HLlkRECkQtKz5YMldGxDUfjsWzzgpz17B4OaB
	LEpGr0Ar/G2WDgrKrPPc2RHiN3YhWwf0yD8rhrWi0Nw1mJUK+yIpsMrHRjPsx1QVu3BplmCOb2u
	151yUT0wrlICTPafYBW+MHw2NWHmvA2XBZbKX+1ibYA==
X-Gm-Gg: AZuq6aJHo2QI66ukOreJ5Dbw/Sydc+jBCvCa+Wiu0BXu+jH2qH9GaVqCcaPzQG04kCt
	1FXTLkgDPihy2O2XWDTWGMb7AOrkiEI4f2RrbS52fN29XeI4tWylSzHq/unEjkgNmqknCBKmuw6
	q8N81E1nCEiG3/66639ZZrvBeAsjnMiQDkN+CWic/w1hGB0yaHUWGO/2MFArpYCFcWU4DG9oPYV
	gkwUNDjTyLUkkakYnOAIaFkay4GH/LdzyhNQgMx2acDuQeerJtk1VCn0sFTmPFTJ0FpYIq2
X-Received: by 2002:a05:7022:225:b0:11b:9386:a3cf with SMTP id
 a92af1059eb24-1244a782252mr15839946c88.48.1769054874920; Wed, 21 Jan 2026
 20:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121181418.537774329@linuxfoundation.org>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 22 Jan 2026 13:07:39 +0900
X-Gm-Features: AZwV_QjtMtKm1PVMKEeE5bHzzO7zM89c8bLtGqGiKQEvR53QgYUn7BkMdlg5ymI
Message-ID: <CAKL4bV4S-jaGVJ+TkyabzWWraUyJ+-5b1pAwZfB4s1UxRuBh1g@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
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
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211193-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[futuring-girl.com,reject];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,futuring-girl.com:email,futuring-girl.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,thinkpadx1gen10j0764:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A740E61A0F
X-Rspamd-Action: no action

Hi Greg

On Thu, Jan 22, 2026 at 4:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.7-rc1rv-g28a73c31d7f5
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260103, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Thu Jan 22 11:47:11 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

