Return-Path: <stable+bounces-215775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAwvDLVVjGnblAAAu9opvQ
	(envelope-from <stable+bounces-215775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:11:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539D123337
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C9DE3089AE2
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4234366DC4;
	Wed, 11 Feb 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="ajjjAYYz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E75366DBB
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770804549; cv=pass; b=Zi97kw4DGj2NoYzKSnmRV5ZoQcxyJhTKZRG63eanbUuRqJsrrAdkr/ME+gf3UwXUAwIqb36SS4/wgxLH10Ycq6S+rc0SpT7C6VRXfQpXzmUZ98KkSCdmOglph/L72qFNZYtITxU7AVxfQLNAACAiorIMAnORkp1+g4PKArOrYc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770804549; c=relaxed/simple;
	bh=l1D8gw5i2W0/j8zDgRzT9uZ621ZVhzaysNHDR6kRh44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNesMlchzDnGZQ1UAchRFNcy7wNsmb8rTQrSh+Z7PSSYJkkaDID/U2Zu8bMJXAZPHoLK2kcJ0Ks6XjgWXFR5Ez9Q4D449VYRrkXBlFk3lUYNKWT58qOfMoRSBeZhKQ3rF5/BPsf/s9R6voGyGoApEzIzBlYw1WimQRhrlmsWwsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=ajjjAYYz; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8850aa5b56so1122302266b.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 02:09:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770804547; cv=none;
        d=google.com; s=arc-20240605;
        b=PsuLi2U/4p29fSAMIilVMZYxSZdeHTNzNfujO8W06opcORBPCGpFXZ2OPmBty92lLV
         1zOXdNdpTLB5LOqUkU8EkcFzIO4R+4PIozXYJXKTV1saLF3ZCcgmuOFhfg1h5E/YH/wV
         56H/iu19QTjqkOmdmhqTkah3kW1PXgrqDHt6/0IDMCrA3TiJPnwGTUG2MoFC0ksiI4q9
         fuB9dxXarFP7pSVcw5iEMnVIj+5MEuR8HzNCEM2njJKwrDo9cF4cBRo6Vzhilc3YNIrM
         N82K4SDA85SjXpqZdtAUNvPB1rq4VSlZPyTUc4xWd/BDYJSOS8GH4FtWKxdrQdRKsiZi
         qaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pru2SUTXC3VPuTIPcsJbrEeU7VXtLClZTOl0vZZxfiY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=JQu+hzZ+/LaYn/Nx3Dkj8BRd/XPGmJRYASpeZITNB4xWLz4Y/x+9MaBhOL/Ej7BC11
         6PK7aEmRpZ96ohCCyDer/Om3Sb+yJn0zaeCu7QPFq+Q7zInlIKKcBsSkhQSEHST7n/KB
         gJbJIOm8T596snWPPNWFaiDjdBxDrdHn5Rk5P3lgeZY+c+hvWM4UWT5MUP7ZbcDDicYq
         kzN0z20I2fyKeDrFCYB6gv1WqNuLUBR0V5YW7aeDWjqR0ALf1pCnfr3kSlkChmSK1eEg
         WOxqZp7DP038Vunyh2szGsmARR2ILY+O8FXy5NADPr8Q4g0pkboGVuunsyvQEpwef+Nw
         Ppvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770804547; x=1771409347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pru2SUTXC3VPuTIPcsJbrEeU7VXtLClZTOl0vZZxfiY=;
        b=ajjjAYYz/UobB+Kh03DulCy4FcLy/pZyUIwtTC3tjYNdI8bKs1Xew/6q6kBCmRTbZm
         VxzZ7jZOSVeZp9Oh2GgLxwfOYjMXsprUeKThvATYdVNHI2E+9u/aXXjwwnMmWxEbUyH0
         AnU7O68Va3KwxBCfiZAcTLxY2/2lOtqHqox7igigMpDUqXyHRimm5RjbbfY1NuBQIptL
         K6GK746pfaQqIRF1jmBS+Cop7V8EtALxt0ekqQ8ZZXiNi8In7fKqht18mvUW4J7dYM/h
         bx7gpDDBkYbT/7v5YBOeiJCo4hdJCfS2X7h83DQtcccwJbz9G4PHeLHPnJ+9rVoFe3Rk
         wfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770804547; x=1771409347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pru2SUTXC3VPuTIPcsJbrEeU7VXtLClZTOl0vZZxfiY=;
        b=FdhNXZ8b8SMdGMvEhgdED1WxgP+E0R3FNYmRLmTE5J9RvP86gRtzNxMAwjQZFf5xL7
         rdxfKCQ34A/h2GvnV96CU8np8lQ6ch5SJxOb/RH9ROgotr3IAR25Mszn2SGY3W3z9Mla
         5TL+xfZ5A3eO5igcmrNGvCP4E5SMr1ot0H3JUjjXtmipgYq+aQJcKK9xpnL1Xm/fF75A
         m30RY30gR6TUxMU9JBa3WYR9sFotMtJL0cx7ttqCp4N/Alj+ImIBg8RpGJCKRRxn95pS
         eotmB9F+tvMAuylDt8z35eUVpmjikHHoogTdAUZ7OfDv3kYqqEgU/cWWyxflv1GfVB+Q
         4mFA==
X-Gm-Message-State: AOJu0YyueG6svLby/ST/Kicxg5HJJEF9I1K51TJFDQd9e4cqYfatS9BP
	XPaV5rMfzY3B9PoA154hzZNaDBs7CMj04aZgQ2a0qBqQr/HG1dM/tc5NMb3gMMfdFZR3w4ThDnl
	8WoeWCcXDHZsvKLp09qWVR8nfRQtpQjJRreeFh+ee7g==
X-Gm-Gg: AZuq6aL3mAxIYHFeN5JwU9ygtw9qw+kWGuy9Jkiz3jzBQiip4/DoCeRjP4DrYqPU54l
	AkOmzLwQ5WBIv0nNMJo80QqauVYsDOXfYj8UdVrPtlAF9lVZB9wKPpH5X5QKMooHFF79FP0AnS5
	0zzUMVWeerJF5KwNKfU1HtZN7T8a0IXd7wBhHiKs3S7iBMhfr3aZtp1Q+2++ct5U796bCKib2QL
	2LBrRGzrMecZRv9JrLpXEcnTjDEKTbGVjd7O8GGBA4U7QrNVC6FmaFSFx5ifQCABhng7oE/dYPz
	ngHu8uhv40AqsqEe8vpYchjHtifpbWuADiKnGFsGT4kiv3lWDrVrvMQRB7gTUVE9vGKJ9A==
X-Received: by 2002:a17:907:1c83:b0:b8d:bf4d:7458 with SMTP id
 a640c23a62f3a-b8f715a7af8mr82185366b.24.1770804546772; Wed, 11 Feb 2026
 02:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142301.913348974@linuxfoundation.org>
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 11 Feb 2026 15:38:29 +0530
X-Gm-Features: AZwV_QiSl-YLGb3rIqTrwEAhC38cFxhqIeltHg-6NkIYrjTXQLV8imvIeyEw0RU
Message-ID: <CAG=yYwnY5cnTVpwNn3ECWSZdmSyayepkhSCZU8osg2kna1ihpA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/69] 6.1.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215775-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: 8539D123337
X-Rspamd-Action: no action

 hello ,

dmesg stuff...

-------------------------------error---------------------------------
$sudo dmesg -l err
[   11.536507] kfd kfd: amdgpu: GC IP 090100  not supported in kfd
$
-------------------------------error---------------------------------

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

