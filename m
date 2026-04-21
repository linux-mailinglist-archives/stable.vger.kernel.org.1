Return-Path: <stable+bounces-240191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAgTDGKa52kV+QEAu9opvQ
	(envelope-from <stable+bounces-240191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:40:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A235A43CDA4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6D1301486E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BE2EA754;
	Tue, 21 Apr 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0yDNTZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4E2E8DEB
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785838; cv=pass; b=Yv14GCcJ/og53sc6L9NF2eybErzNOW7/CSiCZQW85ueLfIcMAa4pYGmXORzXVl77sVXxSMnOEQgh4pSIMkgz3RPXd0ohvhNV4OCBRozfT/7VUfDTJP/cFOVwr9A2XRPI1i8eR/mATyUQ5beJ+fLjBckX5UWMNX2iA9g79pRqKPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785838; c=relaxed/simple;
	bh=ZJNM/DhpwGHejaKlgQebXATtZUhpDf4eVwHFv2Xw1PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP74qwRKP9rVBh8Ri3G/SsOoqmfvZIoYuOjEgAqEWeMNcR7hL8YRjDHSOAmOEHOEbaRPv5oJAdmA2oGypIsvDeL60CMQoOUIhMjNvmO2mpwpBKZQaucKH6yKLTjkKl+TspKh2MWiRWwer0J4yAANIIRxNZKhEdvJoE5bo3C8ZbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0yDNTZK; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so4606706e87.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776785833; cv=none;
        d=google.com; s=arc-20240605;
        b=MGAqyRtjC5kiMIDTrlu4WRITLPWSenf34oag9ejlJQ4bkG2HvbC2NkOLcGlQP/k0tS
         8uo3LxCroC49V5v/6rrCCcaeyh+Q350T3sN3hk0LMPKkT1BuaGX4vS4Saq6BcBnRrd0U
         PvJcukzB+tJwu3AOi8KIs+HbrvTAaPsDQEN1AQ+V2SV05zkPSE0AY3XjPsiiGyB54dCQ
         IWSoGWecneG9HyyjH6Lq9k6CK5D9LsUhZLPsPItCLsBQSTv+DlDEym9RcVmhRginrOb9
         Brr7aGrjIATNJThw79+GcDIOD4l1u3InqHr2LNoN6SVoTEDRVdinH6YxAGKf6UCAqmgW
         GuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7TkNfinPruH6soCVp/2Lcir3uulDXSVd0kmYifurIw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=QWQYoWWKoHdncApoe/m5DHHWaLSWhQ5VDpXotSJX4XmInwb443xdr77tYFEJGMr6jY
         ii3ISoVVl/mFtJvuNKBQ/5OU0czjJx/boMUZc047V6yOI471PrSZdDOzCXEhnDeB3Mt2
         93HrlMi1PMT7SaLTKG8x9gkqFYIkVVusf19z1GmM2+DBe6VDaLXj0teybAgpwSeippGp
         sivVHi1niA9+bNNuWiqgx6Eq1G8VPT9yXfQGYAT4IwumECtPwSIka8RCp/Hw+IApnkRw
         x1TuTiQoGnJWDaeBD6JLn/+mjYY81cgx3g83SMNOaVAs/gkbukrubVg4zqJo2E++ivIs
         kFeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776785833; x=1777390633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7TkNfinPruH6soCVp/2Lcir3uulDXSVd0kmYifurIw=;
        b=p0yDNTZKoCh9uwgKHSHxHi+8R+d+OKwUNzd04TL5Lx0sAqEIMtKQPz82SC8N7lZsu+
         z61u/EfbR/dsVKbCFrZpQNWysw2CulUdbhtcfk+rpkj+M+06bvYHOEkr+hWH8X5zmyZj
         1TF54u9N7iXQXWh5ZHexRavLlqLgXyY562f1ITU2ij+p2d8QWco9alJTcT6DFvaHAhIL
         s7U9XPLjAtwxNBluBrpx2AHuAiVyuFoz594yCN0POxdTyyApydGnvGUyubfM1V+u/g6N
         cYIOHqbS4mTFyRvpJ6gEfK0b2ZwVfY1DIVbvFZdC/ayGMIOUpadwLlBYcB7G35VFS4ab
         oQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785833; x=1777390633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7TkNfinPruH6soCVp/2Lcir3uulDXSVd0kmYifurIw=;
        b=eNrcRrPu0WIi2eBJBU1wLwCXIkuPYFvjbMpgPtLwt/cAC99+gIT6GNDhbiZzYz04kn
         qQ60oWcx92AnqBjrzFwLMkblwUSIzhXAEXrbxxMi6/tidn5HaTnc2Ft5XdsN0YKnd4Et
         Y/sjRJNomG4HSezW57tj9Q3j63huZutK/8XY5A8r6AOd/qQXa1PjM5068jcP2mhU0uVG
         RnR6my9VGeUju9GCj8wPyJ5VGdfFchjjJbCtRwQbbW12LeE2KWrO0bYGJ3tDzFPmhnTN
         /l0/bR1M/lLWVnTb2Eu15GGq5W+ghOOExaH+aNKTER1J1mF6qyXJauu6g0VPKhLi4CB8
         J55A==
X-Gm-Message-State: AOJu0YwsMMN5zIEaFp8Y6K4/VfFVhZEhs3MNymmipcm/LUZYgsiEumMI
	aNibD07c8zQ+b4l0c25Ct3/BJ2Lw83POncRNbmvJ3Bc7jTV91YoYSCnrXwlGk8xOPpca8pCSwjr
	WV8dJO4jgTTNquyZarLUnwG9ppLRk0HBrKm/l
X-Gm-Gg: AeBDieu0S97ZrKBUgdDWDePh0xP5/LBxDPxn1K6Zd4fGQKX8HcqbfrrLUP/CNQoUOtV
	JBJyUDXE+VGN+jtyHXi1rmPSoGA7kMC1BWyDx8OLhgjfkvb+hYLdKFceTinUCYPtwesOodetC3h
	KjfMVEiyX41aMedFF+/OJqlazePb5NUR8EPEnF52eVfkRYpa581cn2rvzLWTOgNv1MZ4C2vfLSX
	Wtc4u7LxJveQOSqwJb21/dtVisCw8ZNgHmfzSVPW7GIyqu4VlorOBLYHTOM0Qhqs+1z0+jNPtpB
	/AWxz5/Eek+jaueSwYeuLRazg5XVANXbCB9suGNgPOQRYJ0Gabc=
X-Received: by 2002:a05:6512:230d:b0:5a4:7ec:145a with SMTP id
 2adb3069b0e04-5a4172c7577mr6697398e87.10.1776785832528; Tue, 21 Apr 2026
 08:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153935.605963767@linuxfoundation.org>
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 21 Apr 2026 21:07:00 +0530
X-Gm-Features: AQROBzCqCimJhZglqtBgcwb9PGh2rhWT2ikrhu2AMY7rmFw4u65lxWLJ1o13eqI
Message-ID: <CAC-m1rpBw=gofkzAOZQ2CnK7uVYF=w5MLuvQHWYR291JbY-xvA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240191-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A235A43CDA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 9:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.24 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Apr 2026 15:38:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.24-rc1.gz
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

tested kernel version 6.18.24-rc1 by building and booting it in a virtual
environment on both x86_64 and arm64 architectures.

Build:
The kernel was built using the default configurations:

x86_64_defconfig for x86_64
defconfig for arm64

The build completed successfully on both architectures without any errors.

Boot:
The generated kernel images were booted in a QEMU-based virtual
environment. The system booted successfully to userspace on both
x86_64 and arm64.

Post-boot checks:

No kernel panics were observed.
No obvious errors or regressions were seen in dmesg.
Basic system functionality appears to be working as expected.

Overall, 6.18.24-rc1 builds and boots successfully on x86_64 and arm64
in a virtual setup.

Regards,
Dileep Malepu.

