Return-Path: <stable+bounces-215690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPmSIJGPi2nYWAAAu9opvQ
	(envelope-from <stable+bounces-215690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 21:05:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5F11EE19
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0981D300BE06
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF132FA32;
	Tue, 10 Feb 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqI1+982"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7032C33C
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753930; cv=pass; b=CCy3KqhAvJ36JPzAoBT5JX2uWdDhgkguWVdp96WGHCWMUnZy4rXRKs+F73Znp/3cEST310yheeGhl7SbBKgy/Rw+U3P+oNrr4/9VyzXiG10be+6v27zLPlzhGd5i8zpuBWibSmrHLH8q8CiLQ5L7Wnb5gizzVbcZSoqLmVCzIY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753930; c=relaxed/simple;
	bh=GM4WvX4k1hhlZ7z6g7fakRrj3LuWO11ON9bb3kfHd+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9N+vMHIIvP602hUuZ9En48/IL/kbsW8dNxq07z8ByKM/Bd6WMYcZmIExF/kLWrAfjbFPax6MzAiAe5HekKpUxDGTIU0V+GhPEYhdM+l9P4ErtkHlKYsgTHjgtckJ1liUQVDLfSd5n++rVv0WpAJba6mCudmaYj2CGvTzmAYKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqI1+982; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59dd263bf42so6182017e87.0
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 12:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770753927; cv=none;
        d=google.com; s=arc-20240605;
        b=EJrJPJ1KEpIeqwzWxHWLGWVj+FglzlSWwe4mMGK+Lr+PLHPIU3JBoeesjHBjDIrRNQ
         OvtKg+CWovh42VAW6kzI0QR2zBZoIuGscDgSclHNj8MvnMMzNk6CLemhDwUWvHuG/eUH
         t4EKRNhCJ6uj6Ygykmrf4od1xwTikx/LlQIXJyMEZNOZ11WrO+RmOWsPD8N2t0IdOoGf
         IE6Y4ThFa0FZEpAQaq19Jx0z6pj+BEL+LoBpfYeStDRqA6No3TGxB85s3H4HTvK/0P1G
         vYA8E1mIr1ceWy1HWvMgfY6bMBB2nIpSIKBpzHR9DWsQakc/X8+MbbPTep0lp2iQCnrM
         kn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjAwjDJ/ezfg/0BqYaNJZsTIN6huCN0MNW7yeqUs+0Y=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Smu+Mbo7qTDtHEe3Dzg6TgimrfhFsBCJPJCWQwJJIjQRKwoIFO1DJ2iKl5DcC3FCev
         5cXG10dCQuU7+ZTsL/AMxGif2fV1Rvp76Ray/0Ogo1txbVRXUmyE2emgP0/EOgkzCMnW
         Tohw1B0aLc5RjDiha9Hy49/mCuhBhTKJYq+fniE3QJlc53V3xc9QtwKpVDbdOFmyHbq3
         GZ4tL7mtjPVeUTbwp6tmJy+BT6667aMQpHEl2rSfDThXtif1qYi2PZ6lAcGrb3T5B6zI
         2OE5odd0BcUvxm+5m/bwNnmw5x5bSbuldOzArJ+QrRd+oiiYilFoXu6TrluIu05PsGzi
         rLVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770753927; x=1771358727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjAwjDJ/ezfg/0BqYaNJZsTIN6huCN0MNW7yeqUs+0Y=;
        b=AqI1+982lKdYuv0S2qTx2sblqES9qwhECVpvLJgfUUkjUGu7fIt2ZdLwtu0Og21N9g
         WFGBmNHDPTHW/DD1igvbPYmCTbF9BPP0WyMkooBfxH5ChooPZEgpAKWYYSk4kgJCCCjF
         3ak6m6+SSS8uK5o955pgkrZpPO/w1vK9UBaKKUIdVRK1mGtwx9izzrduwmBEiugYCsAz
         qyZ0IGRvrX6dwae4N0+9hIwAteKXsFXAvuUg3rRozRI047AEUXsQFg61ckbHZIVWwPwG
         slrWiOlkAxcoaGKwCvaC1TF+Oriu7hVw7eTDdQtNNJNGQ8KEYQIdRnNSrjwWqCPEnQsB
         fUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753927; x=1771358727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjAwjDJ/ezfg/0BqYaNJZsTIN6huCN0MNW7yeqUs+0Y=;
        b=WLIjt6O3Z3BvfextLQ3iTad6RbnHbFipE+vaxNCMM9Euocso5KJ+fzosYq3Al4zQco
         MyI0ST2LT4f62t3HDSMWFvOhPmKolO41QtvgaWGX1jI4DUdC39wcArzvVDk+J0cAqD8S
         9NFJ8umNhbug24i3DDFqKWbGP99EpuXjPh6oXukSQ12+bax+jx7ZIrd/CE9Z8JSjfVtq
         hF4rmvxMVsRSKEPQ2CcNE1WWA6vJv8CjbErxOWCBkj5wipz12GU0GvpIp2mT2F2eHU0N
         zTmQWebotVXGXThGw29rBzPzbNz8cmw6rNbPrQKgEq+4uL7/PBqezw5PP8Q4tnL4MBoW
         cXuw==
X-Gm-Message-State: AOJu0YwWAv+hdVema2hcsCvmb/aw8MAgG3aEIzav8cAmzHQtte6e563b
	XwObJatSSsFqj+1OVum1nS1iap/0ewuX7i/i3BP19n7kxuGXUHHBX0b8VdvgqYG71O6WOeXaQpH
	jYczjN0IjUqufLhNSSE2dbRJm7cletCY=
X-Gm-Gg: AZuq6aKASy7v4/EUEbe+x1LFYwmPszEBrC2/chLLRTf9MH2CYqLR1B41YwLO22heb5c
	NUmr5g295Tl8oRFU4h+9THUGg9UZOHawuGsYNC3zx62RHKkLpbFECslMiOXPd1JyF+OkS9gc6h8
	HLY78lxHr5/VNPLUWBsoBN7nbX1ESp0dcyHj5utl12cJCWy83WP6nmsZsUbobjl95FNVaUZaN8Y
	XqQ7eMD55EgNNBGqZYlaARsfgAkRGSpvKzmqFkt3ejHPdRLQtDVKZer2hbUhH63pUsgrS/NK2cH
	LcqyvscK9hYgt+vyOfZLO3j8lWa180Agqklq
X-Received: by 2002:a05:6512:4014:b0:59e:3e25:d19d with SMTP id
 2adb3069b0e04-59e55b8a76emr1172197e87.23.1770753926546; Tue, 10 Feb 2026
 12:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org>
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 11 Feb 2026 01:35:14 +0530
X-Gm-Features: AZwV_Qhf2pJdbrO0mXxW3oDwJCN30EpqwylKm7th8zjy4lrr9gMnIWft0g25CLw
Message-ID: <CAC-m1rqZ14nPC7zmGo8dguHRQUf0b7CbUSN2V0ADKk7krCdgkw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 98D5F11EE19
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 7:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.10-rc1.gz
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
build and boot report for Linux 6.18.10-rc1.

The kernel was built and booted successfully on both arm64 and x86_64
architectures using the defconfig. Testing was performed in virtual
environments,
and the system ran as expected.

No dmesg regressions were found during testing.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.10
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 0aa40b8da17f82a0c1a41b57be6e920434a2a78d

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

