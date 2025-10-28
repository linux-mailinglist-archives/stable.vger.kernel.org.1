Return-Path: <stable+bounces-191489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D7C151D4
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43386445BD
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C33376B9;
	Tue, 28 Oct 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="Z8snaPvt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E466330B1F
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660565; cv=none; b=ZjexUVDBAjGYluC6T/OupvFDScYnUDJJtEm0CIP23J9UmSRVijOD5y9mjk20QDbdFiQxzeGshXt/rCrJUAphE1G7MuJY68ad2X31skGDDYr05kqs2sYPNRm2VzJmEqjlLQ3zw5BIr8sz/+hEj4B65Pctv9BhWT3UTEEjwtYW77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660565; c=relaxed/simple;
	bh=AdnRw7U11fEVAUyQ3c4ltusVoJvhyax3gV4Hxys3+Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJw5s+DmSbcBJrCjB7S3Lwg16qSkRnO8JZcKoAZTQhNppOUFDJ3uqttQeGHccbf1G4Rd91BIcgbm7FibSbhAmfhh00LnN2tQdq0qFnatINBbMRJci/gF3LIw3tMSVEGNo+G46ErLVf4faZ5RDVBqEj93khVUI6VM1X4+H8MwUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=Z8snaPvt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-891208f6185so548426885a.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1761660560; x=1762265360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zcU8dbk3YPaQpFZh0LEGbD8GL5cYg7PwFTIPigTrJM=;
        b=Z8snaPvtntUhFF81tpuJKrbRAija26SAyLnj8u9SKvi2gLZJIZKvbbcYtax9wCq8JT
         mle5zzxEoqiwfoPYDqMrSVerTR7OrkR4L/1IMJdjHjQ2MMGusC0iHIX2IySM/c8fyucg
         oCDYniXxQnUYt4uIaLsHnADB1OOKo9x6bGi/qXyOrF/83NCvmYVa0yvnad3vH8unsTby
         y8gC3VxEOFAxKISHWt2XO8fm5vTBPqYbgmT9b8w/j/VjnPLqJkiXgQ6LHI3epttxwasX
         xTCqE5vTXZ7HsuK27+4ojGmqIU/NFtupn3fbGvlltasgTeuGSvdo3CUyKej88psQI7nK
         IUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660560; x=1762265360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zcU8dbk3YPaQpFZh0LEGbD8GL5cYg7PwFTIPigTrJM=;
        b=UjTrPTlOPcBV1eIgtkkxav3uAp2hrrDkp49WuY45YepB4cQmoKQIPRyIBaTc8D0jBO
         FYSjF5Qf47NFCKsn1lUUgr5bKooxIgJte9RMGXcnRw9p6dNAp1cjzh/9jDG/CdabbbcE
         u8PYL5isquYfNoNLYHq1G1+gnOnzjNr6aaJlpB2RFkjeF+SMJ7OXQXAKiB41oX5RbjIa
         djYCGE+g/DiTwoZR0AatvctKLhc6mCn7R7c1N6RO2XrksZg/DdFhvewVCGtnHQ/7LaDJ
         5EGe5pH5xOgsJWce+gRjRBv2wjKtuWwzrlsQISoTmjgIMTf/yC2zom25iZp3A7Aj/Qds
         RmAg==
X-Gm-Message-State: AOJu0Yy7savQ/qmCwOER1YM5z2FetB+aLNA8q+JdQNmA+wQ9QYgpIu2G
	pNjXlywARjN7K10ghzp1Xr2SOlpD4dnaWem2XldA2iXjS0zqFfYzrLOblKWoSsfImYwwBSonNPb
	Nq7W/tfnKEoNoaJiWU2pa+d+ttqQPbzSKMrI49C4pYg==
X-Gm-Gg: ASbGnctGAusVCF/r1bfdzgFaq2+72aoGjf5AyBHSJfS7csD61BEON6neuz6rD0QPPcs
	YAz+ZYpuAyE9dTB0Xv2e2+K13WWgdHQMoRHR/5ayIC4NEHblLS0mVNQ+1/b3uPLXxMsWQOkvgDX
	ZZgmzuQulnTw4/fJLsDIHYfebnygn6+RPLCO9Oq1Q59ViaByLbsccjCgu+KqotlS+6seJgOQXo2
	SfGPzB4c9Dj77ISQGAK74q/06i14LpXe5dSzO0F6y2DRdQW6m5aBrOT1ocu7g==
X-Google-Smtp-Source: AGHT+IGeD0rlHtRDBvGxpdgqlidUafHqhsh8Ky9XoEDN3FLfwPUswXwdlMrdSNVbbnKnTlU7nlSS8qkTv9BYaTfYk5o=
X-Received: by 2002:a05:620a:4711:b0:856:60d8:3688 with SMTP id
 af79cd13be357-8a6f78fc5eemr447314685a.47.1761660560137; Tue, 28 Oct 2025
 07:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183453.919157109@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 28 Oct 2025 10:09:08 -0400
X-Gm-Features: AWmQ_bmdkmfhBJpXFY9QIg-9Nu9KvuWXlnvP1dY6QfRsnqg3ap99m04OvaHDYGk
Message-ID: <CAOBMUvjZR4OL0Ffq_yZq_-4nGNAQnicFP8mXqgc1tCtP0VvVsQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
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

On Mon, Oct 27, 2025 at 3:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.56-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

