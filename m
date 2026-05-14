Return-Path: <stable+bounces-247090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L8sOTM1BWonTQIAu9opvQ
	(envelope-from <stable+bounces-247090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:36:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AC53D14A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612EC300CC00
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5D2BDC16;
	Thu, 14 May 2026 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="ttLWQitJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF1246766
	for <stable@vger.kernel.org>; Thu, 14 May 2026 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726169; cv=pass; b=Rwa8NX+wimswN1gWIEOLkSPD7AyaoUjFjeRZAxULw8VRK9+8uNyxp290gTO1q8iGOy2Ls+xS3CnnNUF3Un3DL77ygrXbQ+HqbbKkUsmSDi80Slyadgqy9+JPG7Z/2qGo12t5FEMjVuBOyGx4DaqO0zCoFFDfEYAzeAEb3beF4yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726169; c=relaxed/simple;
	bh=/S4pNOK9ZTUwwQrfTOSuEuNZqSXkfOdYiCR3+Cmc9ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo8UlwnvvohIBmPcklBYtnpp5tT/iYerOD4Q6+U2QsvdVYqqDQSlODMiwKh+LdpgA3zeNf2JgIqapfU/NQ/o/XXDbsri0X4TkenZlXdsRkOM9zqEu7T1pynCdHCZhgJukmf9n3Ia/JTLeCUmg7lYZdOYm9xVG8PSdYmsrN80RT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=ttLWQitJ; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1329fc4bf77so275899c88.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 19:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778726167; cv=none;
        d=google.com; s=arc-20240605;
        b=Ha9Gn/rEkA6eV6wSXmnj+9VNTpNP3+/FNa+b6ikI9YfjgwT7QsAwbyNPFIKvsG09mS
         Z27v1vCQCLWk3YuV+1ycSTlyJMJFm0SRl+X+IoYU0mRWBsUEUW9wDeTRt0d+yuNa2Xsp
         p8UXZb8igR1s3a0nCWITBu2quk9mxeCiv1lsvPsD5ey4ZO/6XwG8FtOJe4FWUdUn6mR3
         Veid1LsIKl/Jqu+Vi+gSfyjxhsTsFeMmWSv91wPJ583swZSuzlrLErb02bXft9sLIBvm
         KE7C4qCNBwr0XY/QY0+/EFmEw+DayVPvxJODmryBw1pQp9ENYaRw+nKT/TcZBjB+a16X
         6xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CX/4nfidpY7spvmYHR1FF2hkssN0Pztqm5DLcQd8foA=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=GtaNXnp6pRBMCpLxkKrNzNqYH3IL6JTwRKdpaHJlr4abaMbyzB9kXboKMwCLkxXGBR
         NxigsX1P3twWRk6RTDSjsy7KmTIDUganxsZ7EZckUvp3B2S1oMt1gl+Zvt4CnwX7GW1y
         lUaJH6EGgEcgsPsb9YkZyorM5C2J5lMVEMIQ2XmZPt/ZgRrCYXNnXv5dMIfZD+rTvM/v
         0ruQ8lij2SoTzSTwB810a3WN7ez0kjWvdep28Dq20kF6nxQUqftJ/woiiM5bxDUhdQEH
         HmVyPQzD2wbHLdbZLdKEkJy7QX57b8a8wGR55awz3NDt3LrXImrGps+Mt9ZVhPR+Ey3k
         PRSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1778726167; x=1779330967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX/4nfidpY7spvmYHR1FF2hkssN0Pztqm5DLcQd8foA=;
        b=ttLWQitJHQ9SHvQmmYYQfpPLg+f8G5PnIzV+Ohx4C2Z1ebrQSs5ssGYSR90DsM0yMr
         OMMgi+bwPB12tKfbKSK6TrNQ0FgnUg8s5sQQih4t3S81wupryP8EhwAZ0XaNbCWFTkKG
         jBFZsWRnqwRU1TOKVZLSnPiPSa4tTMWD51mTGcX6ArXjFpjobeZVLep0WzS/bawmP/zV
         IjGyube1V6I/fvJXAB6hzjSBQM2P/KLyomQx9L/2lIjjTfnQyzN2h+zL6gtM/G4/Z+zu
         Cz8NuKSc8mNrrZ/U3RHE/mU750tScrSHqK3oLmVoE7eAkw4DO7IlTm5BijWzNEtxs/w/
         WDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778726167; x=1779330967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CX/4nfidpY7spvmYHR1FF2hkssN0Pztqm5DLcQd8foA=;
        b=RwnIS8uTNGwZHE7Iy6RPJEfaSjMTExjqp2NIMCB9tBZ0+xv+VLzyXJ/QUme80su9WU
         nxQZryqvr9EhFfWR4nEa1+QOhTpBYLhTV4Ovhq37LolyKokzlscIduPGT2X7NS4TucBK
         vGw9oeqWo1eSGunU5xC6X++mR8pLaOTNQzNdBQrqu+L6o9dKm8GqMi6hSdIygDe5CoQS
         +a3WWRRQmExknX6nGXpKA/yDza6TNZ7JcFA8vzc5rGFFUMZYz26MCtezezkN61ktefKP
         sI5uw1f15Xj2Rx33XgBtz5Z5tHobe3AueEafgBEPML5sr3WWQUfaJ4gNJbMAp43StOjX
         t52g==
X-Gm-Message-State: AOJu0YxUrvZqXyDp/jQ2WdDcFAkZcT4MXt8rLFjnbnj9lFkPhKUy4gCG
	ArgNMU+ySJVorYRMexqedcRy6PNI0jWD1ng9v+EOhb4fKAJ8eZ9QugHKUashHa+nl5eaNxw5h4h
	oTivLZARjoBT/tXvKnPmfcxJLO9GPF7Qx2m3nfjT3Lw==
X-Gm-Gg: Acq92OHiTRY1NotzbbeoG6wdBcQCTpnqyQKxfNrBpmVKKKUL1/hL3mKuLwSd12avVR1
	IKrc5qSynOkUdyxzBwywllMjA3OKZynqIhJC4DeXIYWXBqNEuuy7mJi/w+AfQTPLsWtRd27IsKr
	hN0B4CSgN7OgYyGw4gI5lfyIZbU3eYGR+QyKRCq7CGKgvhG2h8o4nzBkn2ipzKsLTDasSX8pb+4
	6SIUxK4wVkRscrZrdYPD3+CqCuGWMHfCXpi1HAXwBu/tkCiJyanKL8FT14tz1bSW0XhQNh1+D8p
	ISDVc47Y
X-Received: by 2002:a05:7022:698b:b0:12d:de3e:cbfc with SMTP id
 a92af1059eb24-13436ba6059mr3895572c88.35.1778726167325; Wed, 13 May 2026
 19:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513153754.934923793@linuxfoundation.org>
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 14 May 2026 11:35:51 +0900
X-Gm-Features: AVHnY4JunfS3BeW5mea46ZACslI7MPeKye9NNuNsT0xP_tKJk8T8IDCSXcYJGvM
Message-ID: <CAKL4bV49y49EG76oCvmfmSLguFWy9Gu_krNjWUHubY0_D_8SaA@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/305] 7.0.7-rc2 review
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
X-Rspamd-Queue-Id: 655AC53D14A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247090-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Action: no action

Hi Greg

On Thu, May 14, 2026 at 1:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 305 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 15 May 2026 15:37:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.7-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen 10 (Intel i7-1260P, x86_64, Arch Linux)

[    0.000000] Linux version 7.0.7-rc2rv-g5cf0eea3bd76
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Thu May 14 10:32:52 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

