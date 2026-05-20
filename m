Return-Path: <stable+bounces-253404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO2FFxI9Dmqr9AUAu9opvQ
	(envelope-from <stable+bounces-253404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:00:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5659C7A3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6A403008993
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329893502A3;
	Wed, 20 May 2026 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="OdfJRX4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CA38F24C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779318029; cv=pass; b=X5ug9a0dwlVdtwK3FYMBdTWw/hGmepkZfWtmDf+2/yYgTI/zWLbaVWPkKSuHiZs0GaPc4MrwlLAwK5PQVig5EareRpFO3mxk9oEBmWk0UejRn7p/QLDF5jW+EXJSWfqT1awtj4tZIi//4WehlzjuazmTGfRSe6vedRb+b/ZEO94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779318029; c=relaxed/simple;
	bh=614fTFQKMh8YkUQJporSJa4C9EzmMxvSXaHnbeRrJvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmUS6cZOs4HW+9LF9vEVXperF0shmDGwN//LBcsFDcKAnhPjetG4ZxzEpEbPQmVpdRgWINmUDWyYV6e3Hk/VzCpyqbIrIVF6PIhTn/P9eKfZgnmq+kaYEVACngo3YASGY8JKuFoVNWW7ETaHjHMwg/ys5e7ew1xAS7vTFEZE0HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=OdfJRX4O; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1353c2f35cfso16958806c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 16:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779318027; cv=none;
        d=google.com; s=arc-20240605;
        b=X0oS2rjrt7IEKCK6GzxEikZPJKpirqLqDhhFlOK/O1B0J1zSsftnig++8l1hoVmYt3
         z/p9ExlO0FIzl6n3ckJmlIFdDvJBnQ3KO4IM4GpVrqRR8nYN9KttovwXXBEKSIoUb0fD
         egKSRc0ZctWbQ+6xFovFt7MXuaynjSSIQWGz629kGSBhdPMfOLBaX12mazJnHp647qUV
         a5EtDoW8LUGbYitmGIh7miS4+ghscL5kKjm+jk1lvZWMjmf6pgtyqooGeTHU3sdzCPS7
         YFDRZxY7o+kEvIjTt3kiXov0guNUHmorRzqtBZfMHA5TB8hUqv0cjeQRgUR7iHpk3/ox
         8jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FzWSbtMbs/5rD9VopnxxhT2ewZruVU4fd2L/VTX8OMI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Lx/jxJp47zeIQ7vSuZjN5LMwuCy3X8g3kxvKVGVIWcMymMmRKfyIWwzyqUF9oQs0og
         PUNfK8o7v/xtMWxRtN0OgKRkXuh1ERg7VgN5YGGkqLSjwl1DqULrtpebzPj+lB4wSStV
         Knu/mVSFotxC5VEpDdiMynNBp2YJMlgLNlZq+JbnGVfjpkjZ3hOvI5V65SBleVn5HUw3
         L6V7WzA4Li+7Xd3MCk7FZi8WH3YsPnRDYLrDp7Wz/mS+eGZxFyjFCDfMQo7RMBOK14RW
         LgWXUrfLKMv5/SHXwADP3s3sBAGth/cJoS6YIw1QSFpW24TIQ4h5aICW1+wtSBiS5IvC
         D5ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1779318027; x=1779922827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzWSbtMbs/5rD9VopnxxhT2ewZruVU4fd2L/VTX8OMI=;
        b=OdfJRX4OxWHs84ABwY3oFScCcMwQ0g+cYcRYqipECHhSICZao6498Flp/SmerkK1I4
         YjgBqVm2bP8ieAyTPXOluZX8VorSNQdchMk2Lcl+U+BE+TptJW8qP6d8u6pY9ohrISxJ
         T6z7gmHwOpa9xQIrITXiAKqFRIuw+F5+a+lx4ec/VGc/qapaO19/dONm1PjpjzIWJdce
         orqTnvBwGGSAwpEC2FZwkOpGSCsuBM/Zya3oTdBxPXMG2qwzyq72hWbeFnQXHrVeNPGu
         Yj08nXK1TS7BgzAY8Ouvm98ESXuwi7tKnOxUzpRt1JErdk9NTWHCYfUCJMWOeusnWVP9
         YSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779318027; x=1779922827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzWSbtMbs/5rD9VopnxxhT2ewZruVU4fd2L/VTX8OMI=;
        b=r6nIBCq+WTRmJ3arX65ayNxe3LcfvAmCUolgkjtfDUPhLx2MMOySSrzA9BYe6lJLxm
         1xay4CC2LB6QKrP7fsM9+xzEO3fjI9nyyU3siBqbDdxve4gsJAGfKA4MCMaZMMXz1yHT
         1r79GY5cKlb4EGYR0onV7174MmdLgBNzLdyWT/jaVyi8JGnzxIJOrPUd8J+C0IMyUgrH
         Q742+jE6NuLO5q+31PtCGBVVlj3d5dX/i9e2F5raPH2UZ/jvrvOOD73rPSJgnXSyDaaU
         qVnpPdeV9MQ+ZkUdmaAingAsSoazTJHcqgBShAUxSz9fY6Xn4r2AfhmHZa/y5CJFt677
         lMpw==
X-Gm-Message-State: AOJu0Yw20cyw5HbL3zW/UEIuK6xZtvF4Jqp0NI3NMT6wYzRVXbPE2U+v
	9ekC1A0O8gQG6H9yrjgoftaRY895dCeRklocskLgwUYsI+rS5GxiEtk8C4+VJJvmur8lTkWqfqA
	+ZgODBtJ07kQAj4bw+TIo9ofEsgG9CLUoNk0K7r9P5w==
X-Gm-Gg: Acq92OFFj6sKWMhm/+DFMqh6V0otz2FDgIKJvqyPxXoO4XdGwXc82UpnIOr8YyRHFwW
	l4hYeiroFJprI2Skxips7zuZTdzITchHG0D/R88YVHEFsrnNhQ5lAxaSOIN5o9Rb8b7T8vUJkxm
	b5XFpddwmH/nNxbLarZid57qvYExbORMgt5Stsz+ZNbtIC54ghfKBLMwU2ZfUo8jdHgJ5CsZoRn
	vTnkS26yNVbmSwrDUIPw9vq8UQ1N74jCgw0l9ywSIX6+nojyBAJshJ2X8gxDAK9eCYOG4YlFvox
	VWZIhet/
X-Received: by 2002:a05:7022:384b:b0:12d:de3f:d847 with SMTP id
 a92af1059eb24-13632f66f3amr300041c88.42.1779318026411; Wed, 20 May 2026
 16:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org>
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 21 May 2026 08:00:10 +0900
X-Gm-Features: AVHnY4Kou7S6azCDntKaOx_vvWEoQZvCdyzixfwzekOTIzvk_9rCESAy9KkHu4Q
Message-ID: <CAKL4bV5O+tbdXhjZmX=+F3tNMkpxf336koAOGFi35vUhz2Pgog@mail.gmail.com>
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253404-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,futuring-girl.com:email,futuring-girl.com:dkim]
X-Rspamd-Queue-Id: F3E5659C7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Thu, May 21, 2026 at 2:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.10 release.
> There are 1146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.0.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.10-rc1rv-ge79d5c5d57c0
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Thu May 21 07:16:22 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

