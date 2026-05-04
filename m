Return-Path: <stable+bounces-243909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMdxBuwC+WlK4QIAu9opvQ
	(envelope-from <stable+bounces-243909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:34:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B74C3935
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9D0301A2AB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5B31716B;
	Mon,  4 May 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="k2hvQuBO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19599318EF6
	for <stable@vger.kernel.org>; Mon,  4 May 2026 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926886; cv=pass; b=Ao1rMtW7mVC1oCSJmMoqVIBLIaM4oz7nI1AWG9PkOxegtLaiYppRfr7NZxcPmA2/UPqx6mBzb0LzRtjfIiJHiZ1q287YJpPrql+RDvMVLy2I6gah7dN6T1d6QOzQkD0Xc/PP+rZkbhso+A4/XZcxtPCszB/QBnGVs9SlLcgTgkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926886; c=relaxed/simple;
	bh=zc23Ai/g7qOzZn+OqhUZ9eBKciOW0aLKEEjJkHYkKxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5fT/qd0gn3xuijV6f8Xr/wYF3F7zg3fS/HL0eSikKlWRP49d3//zWCu0QRUBc8WQIZQU3FhLpZl+aQrzzWF+kRgbrJ7DpvH8HfxdIwuF+SS3lWbuyOypN8lj6gayWKRH95lHItC3PDnxOK8S1iQsJbuutOcxlqT9DDr2ZwfhPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=k2hvQuBO; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12ddbe104ccso4650695c88.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 13:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926883; cv=none;
        d=google.com; s=arc-20240605;
        b=d8+lWKbWWrHECAiSNDbDFGt6rkwNDl8da3uKlANrKAktgXQxThJabqX2fWyk+wNkQg
         unP85yGp1BQKaQ/KCAb2g60siFSvER4TxUfRt1HKCgjimnqIpcDyo3oJvE0XgL5mw6gC
         OYler8Jkt3GPVFgFlavDSNKfEjROMm0VPKKmQwVjZzaS/Ckfv+lx5TQ/yKX1qBGFxVHW
         k+DomRKvOb0oEXuUeTGeo2eSCGBr/LuHsvsuT88yhGw1lS8oh0K81QDvXKZCvu5Bi4m6
         GLwGiru9/WOuUHKq7IDZmDlg+IPDj8Gko7HdxeEfJQT+l5nmCC5EQdLxc8zkGX+3v1JA
         Pc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V7yjXvpFCXjsqwMrVbmmZqjOgfflxDjwoJvK+IyEgF8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=JNitL3KejAydNYiv8YgCgk4qckG5B9TW0/WhpxzvZmbAl+KpdWd2gf1kIsnws9+svT
         k+jWYMzzieTspaz4/3V5t5R+Dh6ftngOu1t/+j/52UIENo9c/QE7mVfWSM957ZkDeU5O
         BeOBTn+vNJAsPQ6IFRlzKuojGPvLhekWlvh9StnncTbwNZMxgrp0pZYIf0Fxhh1eT7hx
         1gQAEOA7AA36obOtG8+MVb6AYIhHge7koAt1Y9OaQbwhoOXYHwaXE/RJ7x/vA1HLuiN3
         sbvmqjju8gnomC3VsVNb5WatXCveXDrZsetgI3WUFxfWTa9wvjhhJC8AscJ+U5gyvLUE
         qS3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1777926883; x=1778531683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7yjXvpFCXjsqwMrVbmmZqjOgfflxDjwoJvK+IyEgF8=;
        b=k2hvQuBOnPXLjZFSM3DTuX1rljYJHGUyjTI3rrqB0ogyCDCSThkTtd+Ws+VvWZsPaV
         em0s+CBkUiWwLXIsB5IgJYgYM0R+NIAXD6SFro3H1CT6MsiGAZNzAoBS5N9ZN7Wh6sxO
         +LNBNTwK+AqdUIsSVfgaFEOY6hhPE7X5ZUqHMfsIiJ6R24PujVMO7d1oU1o6ayrh+u5K
         WLdbqIcpRxaaaeT1SjJWwJYYq2dV0a5LJi9NLrhHs2AqdL7zxPZPIwRyt1HitWJc6c9b
         BilR4whWGV6LA6GzDd3Sr+0M1FbaQIL0OoNSbWC0ZMGCZf4k3OVvwoX3j7PVlUtRxLUw
         9XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926883; x=1778531683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7yjXvpFCXjsqwMrVbmmZqjOgfflxDjwoJvK+IyEgF8=;
        b=OeCBiRx7d4uP3Q91za0GaJQNg341hXwTL27fh93KDZqgoQPrQrrib/nuqqZbaTORc6
         kRpO4q9XDjRzQKGR/1heDDwEIBWqyK7UBjNS6gkZdwSzmMFY9Ew8v2YVMkROj4C+6QXt
         ipWRbC0yRmJSSWwSC1cnzWlbjY8y+q+qKsi6P3LJXc/sH29UBUnb41QltzwEwM1RuOtD
         ZJsSDAOvFVmAnw+dCv8RFJzP8y994vacJEotOAtoSZOIqLQln67oDujhUn88UwdeCJff
         b83axnuLpuGcHF6f95FHrFgqBEVvOvZuEiW/+tRoCFW6VxjEpEFflctJg+7xEmpqYOFi
         y2fQ==
X-Gm-Message-State: AOJu0Yz7JK7YfLmA+2jFyxkm0v/7/+D3pYQmuP2P5RkJNQw7iomUyvzB
	S2OFB2dKFwB8zd24SIdXADjBJ1V4Xh6IhkimfIkOnz2Cj6lT6jRza13PwT+JKluVsfCliyFXjCJ
	MMP3nb4iuWT7NgmMIigDhi0hQUZi+zBFiBImIQ7bBrg==
X-Gm-Gg: AeBDieuiwdWb2Rs3twWmVMBBEkWLeA1Xtn2FMX2rHDT4EkSJ2/vz17lCczZedUvIVzT
	DKu19yQ38vrzsQSeaH4zRLqkyJuDOgd88y7NU53PwRTI2FQHMoNrPN0wtQaFGCyMksBGHWtwsC+
	KwEDMNp3bDgtbDJLBq+3m/d4rViZvfCxUxxiAjNhz3CbSjgG7YK8JR3YaNB1/LhB6xxTpNvkh9u
	dg09YXEEx2w/NiOqHlwIX9jDWvqRB9Zi+Qq5hmFI175jWAKF7sNzZBXtP+aJQHKTsi4QKoDtIMl
	R5GMKImOwH/DrC3qcAyGhLCTpJENVq8IIYLOrFF9pQDpsaqEYLQ=
X-Received: by 2002:a05:7022:eac1:b0:127:3b1e:7e0e with SMTP id
 a92af1059eb24-130b1b684c6mr257945c88.20.1777926882493; Mon, 04 May 2026
 13:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135142.814938198@linuxfoundation.org>
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 5 May 2026 05:34:26 +0900
X-Gm-Features: AVHnY4IhSogUT7gkCWq24CBG0BjeQxCpCg-6MU6hcgqj8FmOf-pFhIM0WA7VmhY
Message-ID: <CAKL4bV7+x9k49_BZBxSuWXQra1YLporsU0amLQtZPaz=866RoA@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
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
X-Rspamd-Queue-Id: 837B74C3935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243909-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,futuring-girl.com:dkim,futuring-girl.com:email]

Hi Greg

On Mon, May 4, 2026 at 10:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 May 2026 13:50:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.4-rc1rv-g4a299534048e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Tue May  5 05:03:52 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

