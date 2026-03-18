Return-Path: <stable+bounces-227031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNNrFdqQumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:47:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 087042BB0D3
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C34B3301BAAC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215F3D3332;
	Wed, 18 Mar 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="uj6V/u+k"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AC3976AF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834451; cv=pass; b=Z03+Kyy/vy+i9h0ci3JryRVdOI43ln5OV/Tgw8/pDDc6eeo83dy4BSltrtdPRxY+BgGoTqW2A2RHrIwIqwdFwNH6qEM/SA82EeR/hcvg0HMyFf5O6vOSED/FRugKznGKIaQClpUfFwVCtphdG7x23459MPc4qHEnlaq8fPopzrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834451; c=relaxed/simple;
	bh=E3qBqwU/8UNmYPfmpxGyTaDCcrX1OikSY3bBJrMOiHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSiHhZDpOCYjE3yMKwVpWnlEpZB6uax8GS3ksPIHOSWKu5nXlbUVvtqc8HUcLeCW2UvzZySNvRsDZyBh2LwKmzzY1S0IhKN52NDJAcNouH/fFCrBlC2c4AtGfXV9s7UtuJ97K3Vr1CDHOBoF/nm4fjkHnZKvdt+C+Bhmg7Uw/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=uj6V/u+k; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128ebee22caso4764889c88.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 04:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773834450; cv=none;
        d=google.com; s=arc-20240605;
        b=fCIlin3AowWTu9+rfBmFWFf2IrgMnDIaeso09ti5s15jIlVRk2ASwH4ZPFXyESnT+O
         mzhOaJNyDB0FYBkfKud5azagGUujKvoPYmSsu8ZVptnGn0x0oeudasuTq2v+Drrsgs08
         /xeuafUgOi5MyV49o0uMP8zqacW8nwnFoXk24iUa0mKFACpA1VlHdqivKzjYoky2osnl
         nD+9Cons1iGvpH+ohmnGcC9nDVrKPvEWz3PQyHvyA8lyURBKILyVVGnDd+LVln0lIcv7
         LZ0fPM5qyWR3K7C4f8NOkZA8zeOEZHj9+B8y68dH5quPM9296NsqB8RIu2u8BN0MLdz7
         /HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6EYF2SOiO0US3pkVoquFF4wX9nbAh0s9J5OFZoHyp6Y=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=NnZGCsoQ1GuSfukHnbUdkG76tpeV+K+ZEFpfZ2vhiFiwyuCIXYvhT3LM6T2/asIcnj
         VNX9Ttpdrh9VZlhCZ2kfwky8LT8I0wWo/TrTIEERBWwUb/MCEj6r8lUfdtAmyKxpJ0je
         LszRbmxWSTbCLRvRo5IC5IwDtaXtd8A/M39YYe3eSDW1iIDmaW88gEhLQSx/U3ro4hzN
         f1wGygX1X2WB5zX4VpSnZuthfJJmJ9nCofJbgJgDvN2cQC6MNOZY+vAPlkK7krTgwLCw
         f7bBsPpsqjNcdtwMLnC7GaHis6OpyQTsEAttA1A0hwrr3P3tPS5puiwkPUacFlh1cfeP
         vAPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1773834450; x=1774439250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EYF2SOiO0US3pkVoquFF4wX9nbAh0s9J5OFZoHyp6Y=;
        b=uj6V/u+ku0lQB8IrETXVZdfLE0CJORc4h8O1PusTr/pMqW4wqV/6LsaZPbuh0rOoTQ
         5C8eBBxK810uA1JbRDNGYJHS/yn0ujfXGIWC58PA9Ggu2iGGp2/mwOCCOlDYyHup3pvS
         Vdwdv3x+GMPKTrEBRmHkenxfUBlS0PVgM3qWZpNnu2Jw20MzFi9X0bIlbaMvcFqLypYd
         g1zP+GWfOr20tFnnosJqueTYd7lpvPUnIfmL7qTnDhhzBDoibA0V7wT/PVbekQLygJsg
         zZmPd7OrTu3FFph5NTUwHwDnhUFR/jAJ/9P0mh2fZTJ6EN4z+9ePqrMcNe70GILZaAB3
         bNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773834450; x=1774439250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6EYF2SOiO0US3pkVoquFF4wX9nbAh0s9J5OFZoHyp6Y=;
        b=i5eAQy9w5cKhmkFcYbXSRbjItRsddtOF60eigN5EtRsU6K+AIEPISo5ayCX8892j4I
         RzL6X/9x4giZ5cnYVffY7hdC9x+0bycObe/d0ibtBFVdVC00/YDAvI7wDvRg4zBCpRAV
         sbHbad6jlxDHsI5rtAWs2fahrFwtKEwI2eFr2J5IHbA+qOQC8KaLBnnPers/+kyq7Fho
         nhxei8KiOTS3vEh4TtcZ4rbiocagwxwL32p49F6nlk4Kao8H4qlQblmHHR5Bvc1PwoDZ
         F68En5fbw72IsACq9+wykOx1ArCPQvs5qsPcXC8VEwtxWXIe8SMzqk2HP4rz2V3XQuVo
         wMoQ==
X-Gm-Message-State: AOJu0YwMGCzTQZZIt9rz6qJF+5SDeApIBqGxF1se6M9EXdFKOurAzOw3
	LGh8QR1pncPjxFHQGk+EMkGfft+bPSV02ZyTT8MZ5vLxCqr5Ii822sXQ/tIVvcfWXjeXxVPXKhi
	LCpOx/DjJdkoN/BIWDSwSC+yIRsrzUV/Nw5U2g/wb6w==
X-Gm-Gg: ATEYQzxGh6iPnPOMjha4OQKmmliF2HVlqET8iXLEvK9bOFPUEKCSPBfjw0xAp51RT7u
	4WSvAzhAbif+n7bKEkVfN26oDUszR7Gz+wMFFDOibawVLRk1TZQKLimcHX7dSDbv7ugFhUAtKVl
	TTM/yqSXaZ6pOUlzzMNnl7cHSrZ74LiddKyXVJvv5oHudvkL4JGHcV8I7Au2O+r4CFY+xAxxThz
	ZuTrA8izEv7k3xuzgD/+di1Ozkweq+uyv2OXKyoGtPDngHRL0f8RZX5GMabmPP8yKo0odtMITKt
	EE6jt3aO
X-Received: by 2002:a05:7022:6a1:b0:128:d752:e076 with SMTP id
 a92af1059eb24-129a70d21fdmr1617987c88.3.1773834449597; Wed, 18 Mar 2026
 04:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317163006.959177102@linuxfoundation.org>
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 18 Mar 2026 20:47:12 +0900
X-Gm-Features: AaiRm50NjHuUz3mp4Te1JOKZG2_t_c9Y_gOPCaKImhLf1IGNd0hvRcwLZ5jowZ0
Message-ID: <CAKL4bV6scXrnea-QFxNm-2p5UcpBAg=VOy4UJZhmh8guyydGRw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/378] 6.19.9-rc1 review
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
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227031-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: 087042BB0D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Wed, Mar 18, 2026 at 1:43=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Mar 2026 16:28:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.9-rc1rv-g4f987e117969
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Wed Mar 18 18:51:42 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

