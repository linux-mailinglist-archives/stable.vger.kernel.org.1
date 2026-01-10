Return-Path: <stable+bounces-207942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3DD0D2A4
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6983C3015949
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1524EF8C;
	Sat, 10 Jan 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D5NTsYR3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89122097
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768029456; cv=none; b=Bko+6kvozlmNPV8K2tkqq2DqgzFHTc38noxsGcoZt0Gel5oevuHQYhTiztstWJhuDSbg8XPw5d1brMfgawd/U7iKQxkmsWYP/lX4geXn2/Cx4k8sSTYq/9I7pN7kVOt7EsHTNGFByw03WBF6xsOpQKLAKMBvqsbWYvUzLwWoKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768029456; c=relaxed/simple;
	bh=ZRbLxZqJzAxtg/FPbWfw5gS95DSw9Y7wa5SX+g9CA0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLcFVX5IPMs1suy5mR+oJYN810Xx2Tk7XKNLX55W5wpqrO6ZrcM+b3v69gtNJKzvpU3MjTmIgaAefljkfbGzDYZ8qUg0IyrXANw3XhZ26fhGKWqlvoE0PSSOUenmbiOR5QeBpyVIFN39J2OgcwCcQQiCL1sYB6/VIrr9LzLirp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D5NTsYR3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso31354725e9.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 23:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768029454; x=1768634254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2We1YT8B8LvSN1lj9wbGm9Offrxdm4PUs+LKbXNl9A=;
        b=D5NTsYR3Dj6rUL59XWvNKAwrqrXfok/IJ2YKkaFllgEo1Dg0ULJfZax3ILgcTpeH5Q
         /J2XpJ/HeIczVC+v3TKrZgMcG056WM1OYRIBqretsQq357ewhCse0MJjtgb/tXRWixbs
         4HTEmeCtVMcaJjn0enTPg3LR/6zxZyiASA2vzfaUT836eXheiIN32XM9r8dpCxUTUETB
         Ke7IMRmTeoJiF2hRoGxKi7C7Yi375Eu68I+LsIV1Q6qHCEd4DcsFiJe4APtnLtTrFi/H
         QLpTxfpG9Yg6evFAR06T1XKEXfxZH3K0jPgG1FH/N33kZmJ1q2F07LBg2DIHD1x74crj
         Fl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768029454; x=1768634254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2We1YT8B8LvSN1lj9wbGm9Offrxdm4PUs+LKbXNl9A=;
        b=pZtRf+ygEQj3JN6MwiL+qXGajDTE1HxchM54c4Sn8+ou6EZCUVAKFHN8+oG0NHiqwi
         GxELK1VGnhup0rJyhMYWwztzeR06xyoG5v5RQhrDN0K0/HDQ+TReMChnewll+1RRUtAD
         PDQOEQ/IKzi6jEGG9Ho5dBZKy8Z6Gv65ULPUQcS1NYI09l8SYRqeqIOtktBFBdGC79bF
         BtRBwjNQ4r2edHeGtMlBUIg/yKfhmEesYcsWBgITWH3ZI5U5o8YLP+ttqmqslzu9o+A+
         Oq7nVlSaCa7rHf9M1Rp6qe9fm0obu4l99K5nL0YDfEiAm62wj1HGeKREndf+oe4Rygdo
         a5SA==
X-Forwarded-Encrypted: i=1; AJvYcCXfenXp53Ah0QGnJtOUsRSp904RUhSYU7PI6rDiCJUxcLLY9+5vaCqe3LMPwPbAbq4bhG/rY9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhU2LubQfG9iOUM2xekopr/XorlR+/cy6LgHHFQHFIRvpkSIBI
	EH1PDO4jQXntXZhxgBk1CMPfvYGxJ6/uXkJrMIt8tiXz24fZz5MsF+c=
X-Gm-Gg: AY/fxX5QG2XxbPYpWYh/JbLqQTZC+fl6keeOGIHYc0HxKiFY02wgjJDZDvZiRGHyhD3
	bfTcPr1dt8sjQ0Ku0j3p87way1DG61k/WNllvfO4DCrAf4/JemdmwqLAiCyUxnFrdyjxW4W7Hmo
	0wYVCdCoCtqIDzSIR6BAWtwtq8AeWr0wmEWFUCfexqh1PfYBBfLU04MP2+rI47nvLhSuyHLlebm
	1XbcQMqBm2gI4MlO3LxCtuc5hR0cPekZlF7yOjW7hutPsIO3EvkH2jQkX0X9KQMv7yqYOtpca4p
	fB8RPklKO8d9DsaH/nrUbSjPgxSLzYx5OTEpxjsuy4CIGO4JZbNVwpxdB4fQgnr2XZ7nahaWRO7
	ExvdD3zRWLuJH+R8hsSwEI/mZSSQpLTBLvlLjItaICTDYyekDw/jb7Yg0Ze5y9aok5uHdb8JdAP
	ZbdUCPj/bWpSz+kFMXxK8wZzOqvqXHZFEIpzWy/o54g+HVQs+rSlUb0YXN6Lr/QWs=
X-Google-Smtp-Source: AGHT+IHrcnHp4O0WLmnSxynBGk6R74ASSMyDXIY+R0b/oomYF5XBwohUX6UCnaO+bSRXp6ACnKV9MQ==
X-Received: by 2002:a05:600c:698e:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-47d84b52c67mr116346535e9.33.1768029453667;
        Fri, 09 Jan 2026 23:17:33 -0800 (PST)
Received: from [192.168.1.3] (p5b057af3.dip0.t-ipconnect.de. [91.5.122.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f4184e1sm237681125e9.4.2026.01.09.23.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 23:17:33 -0800 (PST)
Message-ID: <9cf79cbf-76db-42ee-9084-9e2adaf8b35e@googlemail.com>
Date: Sat, 10 Jan 2026 08:17:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/634] 6.1.160-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260109112117.407257400@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.2026 um 12:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.160 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

