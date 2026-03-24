Return-Path: <stable+bounces-230212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLgRO1Lcwmm0mwQAu9opvQ
	(envelope-from <stable+bounces-230212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:47:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EAD31B0A2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB3830989DC
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7793F65FD;
	Tue, 24 Mar 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owWV3YyU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7C3F076E
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377830; cv=pass; b=W6HBy3e9k4GE3Sq9O3y2PuLkq1/6AC2Ygu20Na+tUgJBGdp0S0z5FbTHQpsCtTM8y/N143MnhSCgNJbxy7jqyGNrmcjUixbdGYrY1wpP6SwHCPjMcD6YaMK3lUgQf6hnb9VdSyUskwLKyVHNXTROASUGJL0UAREtsKGWLJZrNic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377830; c=relaxed/simple;
	bh=nZxOQ4beMWV/08ZiDnYmzsFd2k0Dz2IBEN+PHtEgCy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvf0Bam/skWhnYRwEtcU14jMiDMf9lkfoHDYkgTB2KxiVb/kPhzVLiRqvCtUo2UIbXYRDXAfH3D5ZR9KjYAZlpaifxHCqJYDOYI7VulNmMGfn0rrBVgdnjmNpsFw1iIsJZpxW8h8HsV8K+SfbhS6ozX0jOjI0E1DKKDHOTTrVuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owWV3YyU; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a27c329e98so5505297e87.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377827; cv=none;
        d=google.com; s=arc-20240605;
        b=TIBjc+REE5UCq6xHeBySYO+tuciwfJFkySsZ7hCXb9uIE0mV+eX172sFUOoWmabsk3
         R8A5B0OH8KbWoRr7wt3YgoRN7soogCqdJ8JAuBGr/hyWcReIZ2dEAtnbb5MovEEhuN80
         GHLhe1MN6qR8DJGMjcf4VmemE5h4Yhsf/L9FbDYvLiamiENDwil2ensbS6ZoCBcN+KAG
         KSv2+ccl17r5FDtc4LLpzXcyZCUOr9jTvrvg1EkXMjlyO2SbK3ebhTh0Yo4lRf949ffH
         h7afbK+D9VYXLOq/h3vI/bbNUBZatLp6P1r1aj4SJoCW7Iop2i67iNNYQtVOfMYAd4PM
         0/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/G8eO0YKOV2qmE7vVQSycQc0H5lXwUfvvW9jfDbQN5w=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=kaM7S+pMFlxIMBqwGPYKZH1VQhcC4OIcikxpQ8mtIKGMgIz6SHo19nvx4Jev0Pgx0n
         1U/5RLyrSwqinD4+CloNDFuN9/Z2LSakGup4cByWoZ+Sewaf31FQO9d2AjuhRVa1ZoI9
         VrGerLN5oYhhvS+zZYxp3Laro6RHNsu6zOaOgx2coYmc+Pc8laWH03lJjRWR5TFK7Iup
         VdtUgV8p4DfgaG0DS4Nk8PwA207cA6gIrBcBI4dspq+anC7n0vrI/4dii/q8PQSweqtA
         Es3Wftbwrb0jMTmWqcvTHW0s2gMitazrJkcFLb1ve0F/Y1LxIL2vXYAmm1PQh5G/rw5g
         MN5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774377827; x=1774982627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G8eO0YKOV2qmE7vVQSycQc0H5lXwUfvvW9jfDbQN5w=;
        b=owWV3YyUkqwa6IblqabcvkoUiEDjQAPcb4ge9+CeiUQpI2DQ/70nnGLeRPbJt6H1xU
         VBgDuovHCULCchzUrPFkW9pe/aCsUa0LGbYbqmUOt31gMPn4BXrt1x6GfWscfmSfv1lh
         MIWmw94SgODdt2nqdKSjauuxRN2vRhsRrlklEEsc+nNhjoRMkzOulzZ0SBkx/MWhajPf
         xKvLNL7GdlLjknNRSZQfjAksvx4LuEPax2bc+q41fhk9LIq0jR+9p779PRvLeNwSROS9
         +HEshfmIoVIesufaQZAItL4VI3cLB4rnp6pSqum0Ygm+hbFi+q4OlJh3WWonH2+jfIkg
         +Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377827; x=1774982627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/G8eO0YKOV2qmE7vVQSycQc0H5lXwUfvvW9jfDbQN5w=;
        b=R/TFnAfQ2oumWLawLkSW6x/Dcnmw3lDdj/c/t9p1AUvHIcD3V2cQ8RJ8mCmrxqA+//
         uQZUPUv9DC9p2ALEPt78yWls4XOAEqDovbg3W/4/YW+nxv0J4EQFm5ryJNWg//pC2G8Q
         4WyZ36LdZesEancnWwm3bFV829eBa8CFpzXJqaF8gtk7nh76+N4A3GgXPM7vUyLNvHh1
         gFTfariScsNCDVXsAlH96hASdDz60ob+csCSWPj5jzjFQrz7VY6UECpKABryBw0MlXJg
         y5KaiqMv474C5CArTL55PzcqjudniuTjwenG19CNPzeBcu3Dv4VgWuzImxVi1JjnjplB
         XyKA==
X-Gm-Message-State: AOJu0Yzjo+UeL7k3K2nQ943jL55fOw6sbsdwStBxbZqqVT7Eshq9DH93
	0UYapzi6a59KECj6uaN5WA8zC7rKfUywFEMRZybFDlFioUInJ/CIfMIXlzkRLIB/qmSHyFH0yMh
	tgsL7DBxko3kLvm5ozr/YwaNhsRoGjZE=
X-Gm-Gg: ATEYQzxFjC6+QV8KhgmoaaxAbnlmpQf3A3EGI42kls9mLCYiqQ6MAE3IVviopwjbsT5
	9LmAMbBQxMWBLu6Ybxtil/Fc5rmlILt0lLjpPrIUwkjJUXiqzYUByDh6SBBneYZidZrLL979PNZ
	YzTrDBUj2ouBBbN1DcH/Ct6aRjvQRvoGhe1uY323ZlHtQL2URrr+36Z40OvXK71h+lByjiNGeRp
	t+kUbahnNhgQh+ftVJzYB4Rt71HQeN8NT7Wgu8O0cZeuJ4uUZWJRC13HNOHABbd8TxzrHR42ebQ
	nrL4QIMBcNLmU77AvElY41sUblNI5RtM+fSU29SUgJC1vCLPIvU=
X-Received: by 2002:a05:6512:2313:b0:59e:1954:1d3f with SMTP id
 2adb3069b0e04-5a29b9a5930mr234603e87.44.1774377827112; Tue, 24 Mar 2026
 11:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323134504.575022936@linuxfoundation.org>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 25 Mar 2026 00:13:34 +0530
X-Gm-Features: AQROBzAAPqxjXSoph6rC11Skwz2i81O33ecaHqPAj2L0yvVXiZNBGvv6Tkk4uq4
Message-ID: <CAC-m1rrD7ff5KMjtnXfAZkm1+ucc2iHUkXEvHeXHWduz8q+MYw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
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
	TAGGED_FROM(0.00)[bounces-230212-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 58EAD31B0A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 7:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and Boot Report for 6.19.10-rc1

Build and boot testing was performed on version 6.19.10-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 5cf3b8242cca1247b6b278b778152b5e343e7d62

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

