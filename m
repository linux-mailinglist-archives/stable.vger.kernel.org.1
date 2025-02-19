Return-Path: <stable+bounces-118288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFDA3C1B9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9EB7A775A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48C1E5B65;
	Wed, 19 Feb 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UfCb+LZ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBF1E00BF;
	Wed, 19 Feb 2025 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974473; cv=none; b=nqF87Uf+wklhvRzPjm9XIhFoSDyg7kqPnD+PQ2dbcWr7BYf8WiGJcjCHIARmWJKypEeNKGmSwsmXnPLZkL3o0Efbtnj2CAk5FNde6JJQ/x2BfP/NjTlan0hdKt9X8f6bRv54YIGsOh4L0rr6hbrolmTUjhFkoq5bSnOHgD86lx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974473; c=relaxed/simple;
	bh=K2GkpiSmwUXetakePEBxwJPUY3CyQYChySFJcaeeUw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNevF0NoS+M/fp1Mw3Cm0yJOY8OBx/4i8qXPNBw3pOSi0j8WDElh+u8oe4JvoaHxQPilcydWOolbGIxg2dQ0I/bTYkwtSgo9RYYKt3aVbe68u40+OGVhP4inl5FgBeXB5HoMD5bCrPi/CY92A+WUpNq6nclzdnd2JXcyWKd7x0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UfCb+LZ0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso3669091f8f.0;
        Wed, 19 Feb 2025 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739974469; x=1740579269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf2RXYvA/APdQSyRpEenuian9qv6Fytwij/nbZajby0=;
        b=UfCb+LZ0qLtIfXT+zmpgCdJvVCf0k15YSIuiWkKoYFBi4jH3t5TKwtnKO8601eyojG
         XpgbI8vqp3QngGze8LYQKODE/pFk8uUvoG89WtuoqmIY3IhW1xsXDPKgQv60J2GhTshp
         niLDjH0N8SEmvJ9JLe1/17hgBwCk+X3FGuZjRu33Xpn8u/et4YU7+E9hmGjUiKmPqKQ5
         Ipq5gW0Pl9zs+3le8o83R/heS5VTfgyst3kf6oBU3lgzlhXerPTfyKPTPN1E8PgXDRpj
         pp9PdcHiSJjblQNIh+/b/KXw2iyntP2SMzGiHRqHjfA7aGUJCL62Hp4Dal3Kj4u0kaUP
         cW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739974469; x=1740579269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf2RXYvA/APdQSyRpEenuian9qv6Fytwij/nbZajby0=;
        b=NOFZ3I3sYyfjNafoPjTkvxcww/WMOmUQG5rhbbn3PlPgWU4XJDdOMCZ322hH8qwXOP
         bd8GXePF8ebmACGPvyiLVLDnA4DqIrGvm16slguOmINEiqzaK2aG8B7XFyuQ4iAODVky
         GIlYYj//VUHQE4eQO0sipuRWaBs6pHmBxDz2OZU0lE7qmqoRO/sZO6uPTmiShge1CxDu
         w7IuapBTsQ7KJHpC+YxVh3bY2M26c6MoHNGQCOh5biW+mJphs60WCe0oDRA4bsjhcS++
         nEi0HdQTK9HPRHpjnQpolZR5QdO9FZdDJjUbKsg77sO7dg2DLRfI3y+Ul0z/idp2bqpT
         riNg==
X-Forwarded-Encrypted: i=1; AJvYcCW3D5U3Ui1BJbA7WKq14upB44xD0tkNQzp/V83O1ACn6DHyAAQCc0UuDcwjLV/yzJR0CJhyDdUmfKy8Ppk=@vger.kernel.org, AJvYcCWWq1+Yg9AysSyy7/6pAMMX34YZqQW6pdcOiC/XATOA2BxAPH7qR9jgH5YLo8RoQnnIKNZs0xwf@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlMN5yZYhFgVoH+vm8FXWLBt9pZbOLk2ylBI9+ma4koJkSJqM
	7PVXEaePgVbTb9n5zv0ZG+BzJsRfeMl41y8w+E7bqSO3QFSl5FA=
X-Gm-Gg: ASbGncslbOnBPW5ZGojR2/7EU+OsBFmFX6GIEpyJKRqd5e1IPsd/cEXoxtlJc6+rsAB
	NIFd5irPcm+nIPqYJeYuuv/+J9hbX7GmDvNpLSMuT1r0MlkJlN+X7uxmw2ldPr2O03Szq10DYk5
	TuJ/JVik8CUBjDH89FPnwFbE3J/2gjHfrl/i0tt3ICZhyO+X9gDiBlitvt502BDvnHMSb4zTWaL
	eu2tKZaRkI9RAHmv7zmShr/e0ZQBvp7+TmCOGyLzfPgIOnMOwLni0t0zuhm1mN5py4SnwJkoSAU
	o+9y+K8woGLBzjN1R5B0V9VOvbZ0m1RFSTP8falLnlEmJyiRAykJeD/txByf5XeqWRmF
X-Google-Smtp-Source: AGHT+IGJCZjLQcnPr2FENPcGiOBYdO/PPeKRrRs/BHzgL5OQKx8IJ/h/Nhze42GLkLBaoXpzjjssEw==
X-Received: by 2002:a5d:6daa:0:b0:38f:394f:d83 with SMTP id ffacd0b85a97d-38f394f9d8fmr16805665f8f.48.1739974469096;
        Wed, 19 Feb 2025 06:14:29 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e7c.dip0.t-ipconnect.de. [91.43.78.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915719sm18171435f8f.60.2025.02.19.06.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:14:28 -0800 (PST)
Message-ID: <9354d8a0-e264-4675-abc2-c0940d814437@googlemail.com>
Date: Wed, 19 Feb 2025 15:14:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/274] 6.13.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082609.533585153@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.02.2025 um 09:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 274 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

