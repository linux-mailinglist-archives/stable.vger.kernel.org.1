Return-Path: <stable+bounces-210030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8062D30015
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41A330B53F7
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1335FF54;
	Fri, 16 Jan 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aj8IYQkX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4434EF0C
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561042; cv=none; b=HThaV4fKi/zSMehHDookMo0G7rFz30qECk92lTtAk3jhYTWBh0R4XeRkl18uK1fDn60bJGeXYLGuxrs7sHd3uV3jBKItBh2YsE/3QCzBPed1g8NlEM07LSnwsZRw+u/YbVwQZGwrPFvNl8Wrv1krQk7d9HlKbami7t9j/pWRmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561042; c=relaxed/simple;
	bh=Q6KPtS8bMf1oIQyxx4s284r/Pyia3SrLlRaC8p0pSyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9Xv+KOj3a/+EsGCvY56YE+tBkQ5jv1/SNUAdGLu9M53XxvE52YAuThhTgGtTyvkacHrsyqIp5CdcvKGEHwFieEca5tg8i88rdQ4lM/JNaO472O8Dk4S7hsWN0n1xTW5PB2z28zSg4niKi2A2pKy/Kra10up4lg9O+6xYOlF+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aj8IYQkX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801bc328easo12506625e9.3
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 02:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768561030; x=1769165830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9CJ5lCqudHPL16t4ANvhZIDowXgIqEc1GchaTXvUDg=;
        b=aj8IYQkXgfrqC04lBV9gefos/MgCmz5TGl5WNpwX8de702nM5ZJM/UvGuyh3e7xr0g
         joYaVijuVUyQ4wZ9EAhdYuc0V/gjIepZ2sVtcFtWkeNv9ACZnPjgL6mEXXRzvHWikIJw
         i1GEie+W01oN79Pzqo16QwJ3MmbOwdZ2tIq/64HhnLzNTktQK7C/MNkeLyKzFifsIWxN
         FKeBDc0wBSnA23l5XIAe9h9+ezOdPM4cRbUvzf5doMUfystnWEufGsEoPAPmSpLIxta0
         HQrC0d2PP8JLXwVkwILn57fzWdl0VmGSNk2qRd+T2BaCzMt8mGW7XQ8Le6f+IWFm8Fz8
         vTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768561030; x=1769165830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9CJ5lCqudHPL16t4ANvhZIDowXgIqEc1GchaTXvUDg=;
        b=ZJ4Kn0wqpgTrLxCd2b/36YkDMjvtM8HBc2Bx423Q1ksDvI1YOsqpmZ3qIXg5KOrkod
         /5GJOG18nalKyHqioROFSHaoqWx71Bqqj/qngXo1000hauQTfczD85EP7bT4WvHq67jX
         7GcJqmyISBSs+T1aOiUEA03D1S6PvgJkCdAL1ZaKPivRdTMRvoOchokAc3fX8LJZ4+9K
         9Cq9er/ZiP1EoRi1Bernihuf2+EE7xuByT5P6zvkB7SWgpxw0/MOm8nZy263LdAccRQP
         tTBO/r+1hqYABrng/3mnH73TmupVvqtYbAZUEIqxftRX5yTnt9arSYjEtQKgHDnVQjMj
         6Ilw==
X-Forwarded-Encrypted: i=1; AJvYcCWTIfXkXsj8930Pqg6l3pzbV3qo3sgnE6ZM7dXW4I6Jvj3R10/rtVoGcWOf+hBvsYvJkTU0OGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMag3+112PEpEYSeRc1FRL/85mWsUJZlPB1shWXrQ8oKhfydjV
	djdLA3Ag4vVMzr9IGJMnQ62nlLpahGHTy6wjnP4/R56+cHzW5bDSCKE=
X-Gm-Gg: AY/fxX5gLlqSp+ZnpjZXakAYsgp/7UbMFxXEZ2s4PGMJGqeBpy1aajOi7Qua13qo17K
	F/2Vt9QYj0N8dvx+eQngb4q78ewL79z/EIqDsVI5O9N3nDlVp/cUyd802WLYbKZ+IkIPkE42t/8
	hJNa2BN3JrcVHWZuGitVY+hPYwonlD/aYxBDqSl7PZioU+5v5hCP2b++WZu82CRQzeJd4o89EbA
	SUm9EgdAH/22K1SpgF4W4dVc0kahw3dglgnpxEeKjRUvSsZk40HXwGfQRu5G3rddeAOz+n8qVrT
	+Pqberz18Ybe1xprCcVHBwcLmKWom8V2jHntpZiqM19YtmIMSnv1zoCkCeMUHx6VL6UgR9acXYS
	NJ7KFZWPibAGX+xMJLyWwjq4SFjSe4zZ50btab+hH4xzHVztNd/nE9+JM0VcczEaub+QxtnJVEy
	+ip11DKU6Wr3O7VjaJ4U/Uhxcd2KsJg+IrryHK1AKI0qfP8fgR68iJfXVDrgXT3HMQ
X-Received: by 2002:a05:600c:3acf:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-4801eabef96mr22225685e9.10.1768561029680;
        Fri, 16 Jan 2026 02:57:09 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac8bd.dip0.t-ipconnect.de. [91.42.200.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9432cdsm15436715e9.0.2026.01.16.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 02:57:09 -0800 (PST)
Message-ID: <5a12b63f-d518-4cb9-8ced-e3f70965e90d@googlemail.com>
Date: Fri, 16 Jan 2026 11:57:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164146.312481509@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2026 um 17:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.121 release.
> There are 88 patches in this series, all will be posted as a response
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

