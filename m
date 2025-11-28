Return-Path: <stable+bounces-197597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98FC92242
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636354E16F7
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415B30AD10;
	Fri, 28 Nov 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="o/HJ1uzV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6632E156
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336853; cv=none; b=WTzztvR8TKPEy10rybM9LqmCzVMnpauhnr16u5k3QbuLjH2JMuj9yo5a9gI763B0hMXa95Bg83B6yHpI7aG7Iz/xLIzfWlfzujDfiKkwZpvBouEY9OaYamFzLujXfmirSVBc/652LWZY/B/40CSzxISSmgXpxw6+WP+OtP7nhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336853; c=relaxed/simple;
	bh=N7LVgPe4BHDfL/ikIaJUOBkx7jZTeSqHMuZCUFdGUVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZZZ3KSE0LE5zLtcwetspXIyfymWTR9Mjx7v/snmz1tC6ylIaJs/zJmKRAhFT5P84fYIfx9N05d/qKYJJytkfnAjOV9npPOyC3tkL+XtUyMdzsfn0w69eJiNE0XQ4VUF70ThuTtcOUVaMBA5HocNt3degtLGAzbbSTPcD88E9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=o/HJ1uzV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aad4823079so1652651b3a.0
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 05:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1764336847; x=1764941647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbtpa9RFO4JNYg5slDho7aqS22A5VSOruLlvcT1PDXc=;
        b=o/HJ1uzVZHaslFAuL3nUiCaf0nULLIKFBBT+HRPXbjZGvIkNPXGAjTMvqN1EQYOIU2
         5zBgEIYHqCC6OkgNeo2+BHZqP6O0WwZiaThsVgCx2bHUTn+IeSwihpgBN0zJs6GmIJpq
         0/NX33j4uTqEl4oKeXQSmfp7v/UQpStXHMWu5zGVXJ+4g/9OyiVg6jFXfga4Tjn8WT7Y
         gBtAjwEa4Uzq6MF/C8oFgDUFWmoX26kOPwLglSlBftZQJJQbrzmzkCOnSN6aQRPIpyAx
         McdQNGUs0O+BeRTcvAF/ljuJF14vn9BOYzsxwvaJ7xfhaGikPf+5p15Fu+G+U1d6DRth
         rg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336847; x=1764941647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rbtpa9RFO4JNYg5slDho7aqS22A5VSOruLlvcT1PDXc=;
        b=MNmMbIErXC96u2TkUi4ayrjWVvxvWxO5Lp7wvBNOpMRNtJn65Yd6mzzqx8/qR639Hx
         NHKtr9JX6+QghZQ3+Hl3CHbmpWICOfPQ+dQ9lmF9eLmyK3LvP5Y3mAYBsKIdTpRUM+pp
         RrHIVAhMES1EmCXo8PZUd94tjZFJYQxfcHkQAqktZAFxiCjE537zdJjgvmFyF6Fitv0v
         wCVW8Ij/Pii4HIq3tt0C2uOpl0tcbwDK7lLDRNYAWrcj7W6p8ssZpKEGTjHOZBo82wqb
         Vh2BWotZfOR3XUmcxqoUnK4smoNzHkSyykTHLtKd2ZoUh3oRKrVSsA3w6erDe4PoiIIX
         BFsg==
X-Gm-Message-State: AOJu0Yxqayvo7MorzP8rbZDHpJYKsAvycXPIEssXL/guA3tzo++beNvP
	wIwQ0gwI543vjIdmq4+0dyFEAIHmKiwiyCfUj1XBdcMZ5E+D032NVhijPDrD7uQ/8LgfX0laSI1
	TobtFIPZu2qq9sBl+y+WuTfc0rZgY6StjeHyfkQL0KQ==
X-Gm-Gg: ASbGncvnBTf339xq5120xCZlgHtAAx/1FZxwwKGw1iAGaWJusp3JmzpxN2Gcratj3KW
	6RhV0mOT5sHcMxRaF7J6Tzu8mW6UA/UV8uKbSCMYDNsOeRWx8hBwvSFMK/ttS0xYgbAMfpcZ+Sz
	vS6B6JfhX2k2HbqymdY3NmYEugQHZGmKFxTBX0/e8L6LROuOLl52IQv56zIoAU4/56IuMqpj5JI
	/NjLiZ9gGskcXEd3bBqb+utoBULECUmeVT2RI/0AN/JFFED7zyHGWdNiL1w/4q8svxEAWf63g==
X-Google-Smtp-Source: AGHT+IGwm0o8aZuZ2m48OS+/3z/RTZBRrJEcimyjk2nYCgxroIcwnBJ2VdDKGAGeyiVfZpRcwlYYJqHTeB6yDAU3MkY=
X-Received: by 2002:a05:7022:6382:b0:11b:9386:8254 with SMTP id
 a92af1059eb24-11c9d87056amr18623161c88.41.1764336847187; Fri, 28 Nov 2025
 05:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150348.216197881@linuxfoundation.org>
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 28 Nov 2025 22:33:50 +0900
X-Gm-Features: AWmQ_blvACtblrWoxRgJepaWWrl4iemJdPZsf-ll7gR5yH6QtKiNw8xHfLCkhLc
Message-ID: <CAKL4bV57MzMdQocXwJyuqjyrX88yufDLG0iXMDSfQBwVS5e9eQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
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

Hi Greg

On Fri, Nov 28, 2025 at 12:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.10-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.10-rc2rv-g6c8c6a34f518
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Fri Nov 28 21:50:43 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

