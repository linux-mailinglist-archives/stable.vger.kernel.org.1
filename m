Return-Path: <stable+bounces-216607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF+sOYiXkWm1kAEAu9opvQ
	(envelope-from <stable+bounces-216607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 10:53:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B613E6C1
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 10:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1B13013A53
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5DD2C15B8;
	Sun, 15 Feb 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeQSPNb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E36258CE5
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771149183; cv=pass; b=QGXddBWKRT8it8PIH6tIeSDpkkbIC28rxJcvu3JqTtHYI475v7cluXz5UyMvR+wVvRtsDf7nI8IUasupnwum0wnikGbvmKFR+UO4g/+ejlyDqs+lK2HL5+dvbrvHAJwPv0WrVmge2X/h1jJ8vWKkq7x3fnZxcnoaaQMDjvJ+zho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771149183; c=relaxed/simple;
	bh=kQikKF6juBdGKxuw8IzgwBn4/K2a8sJRjg4e9moexBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na46KqQQghqqD58245vNNduwuOyATZOg9FLQNZ9P8LABQ5N8o/dR4wAufjOIJodm5LNkvN5+V8DjEC0dR/PMbrJwN5SRZ0OkNvz2Sdpo+nc6OkJzZKDuqHFKQ8ASu3tiEQnom7nXUVpnOrN/n+oIYNFhPJ1S+JH8+7S1NVsXAnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeQSPNb6; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e6b7b11ebso2590745e87.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 01:53:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771149179; cv=none;
        d=google.com; s=arc-20240605;
        b=d3EY/v4QpKB5cwQYGBd8NrLYNWwEYZsil3JfPWOYX8hJ/c5LSqnR3gsjOmHgXYUmcn
         PKWNvz/yfYwrEbgET3CgaNmGZEqYr9hUokC0Akri5nOOhLYZrJnXjD1eCztnB/MO89zi
         VOozeQYXSOV0h4RKriK0JKeg1sd04cW2wOLQgTf9FJeRXf8+JoWiCyZX/JUUE8ZuzehT
         y/M0o64uFTB5h48kF1YhSInsrlegmJMV/RW9S0MoTgtx3hRxNZigkWnkAq/5gZf7rxn/
         y1qTT5hEjvFuJgUzT0hxjhZuu9Eyao+r49OzR4HjqCFoBnXaGSudZIrVbNUwg121D4oH
         lZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iZyRXh8wmezgi23bMQ+xFQaZsVQ+vGJeFePHICiWcJQ=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=lUNFPTOqi29PJuJO5a9nOB+7ucRyhJzhsrombaVNyapayhzC5tJqEwQP+HJEXWHWRL
         8CQOI212DROaJWkvLzwX0Bqx+hkPJA856GAhTBolOBAenPL73Uym3yD8pjFyhBZYPRMG
         QWUYlWukF6kweuVI9hdHxbrJuDhsTzaH/0Syq/8JwOkXGgDaPgPZFTf60R9Kduh0+BOI
         Y4MgRBvZPTk8H0bChvyT81L0bOjVaO9AVzDeTLpcsyE8V2ipLspwz9pfZ9JCPydNsJ+a
         zKP7O/ujFUMYgOAetvXQRzxApZt5SU1gKjnZMhsMce8+eXSHoU2CNJT+jQ3b95NC0m42
         JuUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771149179; x=1771753979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZyRXh8wmezgi23bMQ+xFQaZsVQ+vGJeFePHICiWcJQ=;
        b=UeQSPNb6PIdpbA1UhgFZMNeDl4RE6qnEV7DbsCneIjjN6tmUC5P8eUAQhkHEbU32LG
         rYx48H7e0uwkaZBcMjBs6C/wXNAnFq1Dd4dEbZV2yDZJ91Y/ND2pZWMGkvnoQQI70tGm
         GEz0wjcaZa62xUttmZx9rS3tZtPe6WgeIJ3iiRzW1I1El8+fawwiUbBcuXgyhFAwvm0r
         62v8YzQvmPBbrpkKHYfMTuLu66EGOUJejqIFQe683CL7N7Ty6HIRRVjki/8SBjU4t9bn
         AiEFApkEeVKYByUMZCdwTjm1mQvvVJE6DAhob1fhYZfgeryiBltZFAJvCRgvbIxsk3OM
         o10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771149179; x=1771753979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZyRXh8wmezgi23bMQ+xFQaZsVQ+vGJeFePHICiWcJQ=;
        b=Q0BBqjL08m1rFK+jiSFkrB4PxCBCuHmJc5MpZctiPhcrsGhhqDWPAvFM+bUhHBUFnH
         Cbdirkch2PMi0YI8pk16B7kP7U9OMNPKP9JMTy/SRJ3fzdsZSheiltrxvKh5fd4XOlan
         /5Rel8Job2Bw+jytfii6Afp7u6CxPsvZzBE5q9N/2Lz3RXJN30NQ79x3P/7tI6Rp0TvI
         9+IqY/t/JbiQthHD434AxOsYlkjSCo4HzL5WEwUUPXJvPNrSqF8l01XT8QoBBBFIEmyu
         mIGQ1ZBemr+nsyz+8UJFTCHqwZ6cHG3Z1FcjZDEa7A6Qo1Csm0THBTBrW8snpH87NXVk
         CxMA==
X-Gm-Message-State: AOJu0YxZmR1ID+t0gJ0N2HCpMLydxkM2fy6nIGw7crWBzkaN9YAvSlPf
	vbbIf1nf3C5BGjlY6N4gRt9w0G5TrUFm/7oFdVJOoVPxXWvCADWocwdJgu49oy8nFU6geBZcdZQ
	6VCd0D6Y86kAZSQ/VNWV8+dj+ZONA8wc=
X-Gm-Gg: AZuq6aLvL0FGa8/S3pWmu2PwtzssFfiPj4Qv+hJLuRY4n9BvuZ8tos6rdTKTeVV8Mw3
	CC+1oGj9eukaTBYYDzRA+X5vqYTi12pnCvLYaO8j+OWV63WRon1qP7ATENYPX9p0FVi4x2J3Og9
	8QTcGlpxmW/+N/xiCi+35uSqsxmGcRNGoJS/Ydz4t5uVEEzi9GVH8BHpmls4VWWXujMmcFLQmFl
	wuF+kXG2y4RCCk4V8pLSE06J3tM+mKbqeRT3PDhvi+1sPVJhCCm/1Wn8DmsybCV2piozj7xSqgg
	eXr8uxzxGpCyQ+r/51CKeqzhB/MV9V4damE6wM6U
X-Received: by 2002:a05:6512:3f0f:b0:59e:508b:c00d with SMTP id
 2adb3069b0e04-59f6d38d4c9mr1367158e87.51.1771149179242; Sun, 15 Feb 2026
 01:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.885500854@linuxfoundation.org>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 15 Feb 2026 15:22:47 +0530
X-Gm-Features: AaiRm5228V0C2EobLJmqGCpcjuPo_PX51gEoGd8XHRSjnUrUWBkc7U1Y2kcKbNQ
Message-ID: <CAC-m1rrHNiCp1sKgE_V3++fHBe7nAtMKmMneZmQ48MBDBRA4ig@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216607-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5B6B613E6C1
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:22=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.11-rc1.gz
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
Build and Boot Report of linux-6.18.11-rc-1

Build and boot tested on 6.18.11 using qemu. The Kernel
was successfully Build and booted in virtual environment without
any issue.

Build details:
Architectures: arm64, x86_64
Kernel version: 6.18.11
Configuration: defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit: 1dd43fd284b6ab499dac1355db7b07d12669f73b

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

