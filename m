Return-Path: <stable+bounces-123207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6EA5C1A6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229BF3AA6F4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F979256C8F;
	Tue, 11 Mar 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="U3VQe8xV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A001EA7FD
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697464; cv=none; b=slLpqfZweDG4aZsoXRWfoHuCMZ4ayX5/aCUT+9xF3JOMYy53bHE5dqZtZILt45xuRu3WWgZ8EUoOqX7wJBrvsP5j97a+NeIpXs3BUPqYyY/PniL8ZqBy8gfmJ7Zo3MDZMQaeJnkq79tXgRpUDorowIbEvaJdVvuYotgOeKn5GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697464; c=relaxed/simple;
	bh=+TAU5vCBRg1301biu5ak8wIgH0pgOx3eRwTmb9b6WP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RS8w4uzJBX+P9uONK/0cQRIG6bhoE/rNeZBf4+9o0rbVGUuOTjZv1PfuKALMVYcgRSIWn5xBKQMoeygbb+TUb68HPcSCkLGqhmthwAPSuBdEe8k4VBhcQAW5qiEibSeVTseTqzW57bNfK/YjR1/DKx+3yymHXDQPOpHssXFiv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=U3VQe8xV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso8334664a91.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741697461; x=1742302261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM6S/I+r/Ly1JBEFG+Hw1zWZq5rloLNf5UiOb6Ru1Lo=;
        b=U3VQe8xVJoAaKF8W1RRy1PySMCSJINVxgnEJ/KmL3ovo7aeRR27fvxdE55E6ZJjJ1F
         2h4AOO1RGtGMZGhXlqS9hjVFjq++KchjwdpziVTCEvMJKsXPKeP/z19J+cfw9+3b3dW9
         HqPzTahLDUwQAWKRD+CAujQgULBGby3J3NM6Skr9QlIhVveYgCaK9Frdmrc2vwQ8zUpO
         Cykk9ZcgBQJ/0gApckSICDXP/Jf+ICmndF0zzX9jYrD4kHTxFZDObsaWbzeLoRiW3Yi1
         y2m+OKE3+o98ueKnjIAokrE7dQsASfPVzAXt3W6DfEPGt46gmOCgF6riGg6XhdpuxD5c
         54XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741697461; x=1742302261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM6S/I+r/Ly1JBEFG+Hw1zWZq5rloLNf5UiOb6Ru1Lo=;
        b=ScRYFYx1hNoY0CQCyZn+ZosyMUahUy6ctE2MSfDsh2VTwDHsw/v9iyUCtutjS8//4E
         jXuGvWec/AAUnfSmLsV2CWdHYHBwZybgDaePDBgVbjKnG6zOfqvulwnwDkUhZNu4UbSg
         cJmA6qaoIZWJ2X2HqL0Pnsdja+7Ii/D4UP3A/Nb13Yidd7X0XgEhL87mMerx2IvkfhEx
         V7bDT23jtFZEK1HdBdD+Q9ONrdP/QxbZygQalABuuca8vGir7yE77OS48/XuE+JMkeM+
         xoOLdaQt7du1PerRQX6sXctr2XlCdhBz56xHJw9osRHV84Hqvq4CJHIJCCxw+cL7Ue3+
         WwLA==
X-Gm-Message-State: AOJu0YzmLtrHMc6hkp7ij/wW9XsO6B/SHOIphzSAICq+idtMGCtexTGa
	jMJL3GfaRSOawzW996H+qCPRhW9BECnrw68d1nxnQWKmEDb1lUdoHhgikq7OBhITLqWsIND9hnU
	IKBoOQg65O+/mKYL3DfMnKnFCVcRab1TWa5vXJg==
X-Gm-Gg: ASbGncusA82dTBME79iZhBO3hQ/QGvCdwAaf6aX20Phgk5eKc4lsvjAZ+k0VNTlBRi4
	NTsfcjSf7OxfbtpCQ0p4ssTVqm08jiFHX61F/ejt3DdtA5NTC2oy6iJtQUKDJAg0giDpEZC2KYA
	Hq8BdQziLlMLb045+CVeP5jRikEw==
X-Google-Smtp-Source: AGHT+IFinsjUmVMQLT2zwdJ4SFAabPxwf+IIVy37I6UpJF8Ii/4h255n8As1DyOfJHUeM9IApQ+FMpbagJsAZpctEOM=
X-Received: by 2002:a17:90b:2e42:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-300ff0a4593mr4513741a91.6.1741697460991; Tue, 11 Mar 2025
 05:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170447.729440535@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 11 Mar 2025 21:50:44 +0900
X-Gm-Features: AQ5f1JqE5Y78tUwLtePj2OHVcXEnFp4En8VZ49aac9Rm2u-wJhTW-_RzlHHxcMo
Message-ID: <CAKL4bV4MCTujqjkg5A4DYR5UoOUjYQ9zKpQsvrcGJQcbfznSDw@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Mar 11, 2025 at 2:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.7-rc1rv-g2fe515e18cba
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Tue Mar 11 18:49:13 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

