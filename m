Return-Path: <stable+bounces-230214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCQWLMLfwmmPnAQAu9opvQ
	(envelope-from <stable+bounces-230214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:02:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF031B282
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF52D300A753
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40463A5459;
	Tue, 24 Mar 2026 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKvvJxYJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A837A48B
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378702; cv=pass; b=hT3/FFcCMLL+m00+VobqiAGTG9Db4YV/1oc5sFhjR69abFWSH2wwi8YUyN+LPRSzPBwe9F6GgY7/u1rqo0rRzvBt1HcpzA4iimssFy/n8IJE4qxrNMhJkYOQyQciEH9WUa4QRw/c54QKFJ56V2nUkdyUfnIH2NbmcEd/9ylJCAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378702; c=relaxed/simple;
	bh=2iXPRWZSJC6WzIlggftcRWzcicMPT/WOw7wXj0KhMEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOncSi9Of+B+/QwjsZmFHTEtTHKms/1k4K/CTGToT6Kkma2s6gJnuhacBuZnqbN63j8khyhBrlZQYP4B+0fhCYxqtHA3VXZo8OG9YdDooZCFbXKG3IQ2ryRy6+v769b42zgn1ab6WCViNHojNV3hZUMYwHqgqZWioau/++DzrXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKvvJxYJ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a133b686f7so1825989e87.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774378699; cv=none;
        d=google.com; s=arc-20240605;
        b=eRWlHbiEcBZpVNPZ4HpaXA1VZYXMur48fI3G2auEWnQJkufZBFz4ekb3/nXllbDCvR
         /tX4QI/HyWEMj3iahfkRIrKppO43TxBfDc5S13rXSm983YARBGLXDT4BHcJjH26hnPOs
         ndpMexHNFn+wbxOW/Hpzj4D7zWrEBiEX8e7UjK5pFVKZWQLyb0wSD3kZqwst97dHnpwC
         m63Nsxh4w08m4mpyqoCWGgQONPwR1rC0f8Y40XfEsV+tKaE1YHGlX7exnL4fsXEYN23w
         +8kyNX08v4eMGdVDXph6ibQXUvXoowbSUMwHB1b0tNcaX7prqsdliKERkHV1YHE2w/Pe
         MJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FjZ6lxukDkmg6wVk2rmcoTc2DBbvTaAH3QRjijoBVmw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=YFvEpYais4QpbHXmRuUjTxWMbe6AEDNcoTX13v+Xp+WzYTmTDLeO5lWjhG8TSSpxPq
         T/vM+NHS9+sY8XA0E3Z5mw4dTZFxX/jmkp9XB8RgXK1vrGnjab4hmlQQbt+R5HBxprmr
         f/5eaRxllLI879na4A5wxAEG+igAyXejbBmNeVe2aTKkqQtnN7A63SILSXp3P39v8JAD
         D0C4XNA1DacZRUoUxJRWU656nMh4IsgZZo49Cj8cntT+HqUYOqWk4HEkTsDZtKt23N41
         z0MWwyUEAMK1kyME7fUSkPO7CC0MMOyiqvLhN9gIetUGetvHv61gfmOiwXn0GPKqHQkd
         zekQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378699; x=1774983499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjZ6lxukDkmg6wVk2rmcoTc2DBbvTaAH3QRjijoBVmw=;
        b=hKvvJxYJdH3uXKamWvmAKDUoeJsSd+4atiMo57WHOi4BRqWM3auwNcZdDvnqD65zmz
         qOdBdtdkCBFJJWqD+JWOMFsjyANAxaOCna6MnV5LRI/IJ9E3gFCm4o5mKVJ4HUyC9AVJ
         wswHDHl3Xo66o6AGhI519psZSEIhNz7xKLSXD9HD3ZKOleKGl2zcDl6Z5mPf8ckwEzEC
         EQrDUZQH2lBrpYISPaVdm7lrjWxXH1DM3+BRAt7P4vxB1OzIysytOlTRrCMBtQCGiLZg
         d5jmN0NeHJ8/W3xtB6C9eVJx9SGcYfd5Eo8HXZTo/8X+ASNAse/AIOs8dv53C9FXdpZC
         6klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378699; x=1774983499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FjZ6lxukDkmg6wVk2rmcoTc2DBbvTaAH3QRjijoBVmw=;
        b=NoUoZMy01xYFNdhXLpJM19r8ezGByX0+HoAKpU6ZYCcnCCYbxGKI/GKhpTFokbaMxL
         YEz2gczJDUjxirSs6SdYS6yRB0BJozID5jWrSuu97JVFYjNQ6fy9cZ4wv+Kxy8TdOpYs
         sizosC/sK7kNNZriiXbPXLfVYlmKMK71UJcbv2lslBGE1U/F3PtBjtGuTKBdlpJGQmvm
         XcaBrByhA0LbpLFQxM+YM2nY4jt6iN7uMCL2QIvwje+kZeP6fQVo8/QrU5VzeuQbpGCD
         hpmhctUX2lR7LhsBH8ZkeOvNvG4ljtHxxjOc9VkJBMc+F4OS2SZPWIHk1qiTu1yDbfgT
         vfDw==
X-Gm-Message-State: AOJu0Yxy0P2UFnATH88rd6YRPQdtTDy8EYEmKeyuNcv1mpyRHaalmgA9
	GCTYuTZPcw5JrDas85LYmVBn6hlPEcDOYXT/vutqYY2Zm7fcyTr1A9Vwns5Z2AUhNCEhWmdwhhu
	MbPIPxR4UTCValkdIo4ZwE/eWbSUkLVk=
X-Gm-Gg: ATEYQzwvS77FSExZQ2Vi884js2kIPMN+wQi977fs0FkiXtYkV3awxmVyl5gXOXk8wD4
	yXFFyV3CvuOaDPu1L1QiB74T3ok96auYcUkXQws5XM8Hi7AYp49bphGuDnHAvympWrKbsDB03z5
	CQjBSlL4MFcUUcl7uakgI3+euQZJmIG6CwinIr5blMtsYwTAGac71GNtKGdys8kyvkNK3Dqwk8f
	NmprcKbH9O+zIzWzOYRLtkHrPT/4/cuFVQAm8+2rHlTX0pAkUnnohNEa1HqMCWjwtasioy0Qph9
	AEwPwa5D3u8eZ1E2hUWhIoi0zj0YIvD9LNJd3O299md6GJ79r6Y=
X-Received: by 2002:a05:6512:2244:b0:5a1:5762:4cfa with SMTP id
 2adb3069b0e04-5a29b98a8d5mr239198e87.21.1774378699217; Tue, 24 Mar 2026
 11:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323134503.770111826@linuxfoundation.org>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 25 Mar 2026 00:28:07 +0530
X-Gm-Features: AQROBzAQg5jx7m2vmyOnwSzeZOEDkYEtQdW4GU4jGqIkkzOhnv-cdm0plaBec_4
Message-ID: <CAC-m1roz+Z_abZ=0_sQpf6Mnm7D1TvaZ+4Q47-mdu2QM=Ek0zw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
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
	TAGGED_FROM(0.00)[bounces-230214-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: C5BF031B282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 7:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.20-rc1.gz
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
Build and Boot Report for 6.18.20-rc1

Build and boot testing was performed on version 6.18.20-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.18.29-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 81b464548274640c3c68993f4bc8d17369263096

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

