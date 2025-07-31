Return-Path: <stable+bounces-165669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7EFB172ED
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A4D1883CB7
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301DD2D2390;
	Thu, 31 Jul 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b="Ei5u/Kud"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A332C1594
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971171; cv=none; b=b4oNmqTDLKvntPdgbQO+WHd8pSa6za9XUm3uTcWmRWUPHJT/m6KTjurrd2Y5JSiGws94+oyUUbvXNIjizuMjT1NCcHPpAWEXw/ER0tyROaQcd2Uy27Fy8+5N1BpOqqO9Re8tnbQ8JZ+kNu15xMGmHh3t2P7JK40p69xMTRKxA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971171; c=relaxed/simple;
	bh=Idh9foYlobnkqdDD9TDu5/SpFZZrciK/ewtMb2geQbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIwrXqa4/bbx7afJy+Dx+sgTC/V4D4SbuR/+FZc6d8jJ+wEJoz2fJnexuFez9+7BD7HmLZkZj09rhPSY7RXPtHkf/WxP5xYCzVjTshjH0yzOoeb/JNqQE8Ez/wI1QAAp3pXso6owiAj7wkojA2XgOdfWBogLMDPROfn8u3ncJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b=Ei5u/Kud; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e6783335a2so43479085a.1
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1753971167; x=1754575967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilfwqsoaQ9met52S7qm5b2+HGaecgZb3Z6l9hEzitcs=;
        b=Ei5u/Kud8RVzgsD5BKdAMIIh4rLkBDjLf9CMR1mg5yyrnpCrpLvFamIwJGf7Gi0fsF
         X4Sd4vizJhgr5RRHPN/ph6pP54y0HM116zl5TU+j/GLn+iwO8pkIBBOzmAQCJshl8hBA
         e/HKweTgOFrRg+avHiPYfervT/BGyoZcitDy67db7VYLrNwfMssDHKz44pLqla3i8BnC
         CFPNf6auWCxcjs49oAYrE4gtQstipy5TedSkGQnMW6hLyfDOzIR7WbMbQJ9URRZL091u
         drRFITzHvxpDGCUlSFD83IicR/fVJhqJGrndjJBuf4t85/RoZZxrMcnZQs0omKjIPs+W
         vYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971167; x=1754575967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilfwqsoaQ9met52S7qm5b2+HGaecgZb3Z6l9hEzitcs=;
        b=eAtiv/42n+Epzn3zHehN6SsRxHvT+RwvfU48/BzazbVrU2VH6lWAAHkuEzMbJACLsl
         Qh/xg3RYpa6gk1SfVCcKQmp6XN3TZVqTSndW+9820xv9uKyn40J+KXulAVcRe4HAIVL4
         kGs25LAPi2+G1wHT3WeRFjoIRboVsQLNadYcGMrcAwowBIoOOQH6P5d3mjOY1kVvs7yU
         jh3WFruacwVkC0RVO6UTL04H+E52xC1byDlBLRTTlGCfY3Hf+ms870zJaL5Il9oQWmhy
         b/vkCTfmuy9VHcLsv2DkRUCx8eFIMraaqFTYqaueIQqXHJC5VN8JQAsPm9pDJ+/3vwll
         4xLA==
X-Gm-Message-State: AOJu0YxlyN6616t+EJkFeSyYXsLqxhfz4uGZcGM4DISretowHjBBmXr4
	VAJ/a+NRWp+Qk1OPOWOUWGRbitHSoeoivwwlW7wlKlHcXNYBlhHNaUmuF6Ls+REuoVTNqfDyNvN
	rC725YNqqg7At9yw9ly91700zGNcMp3BEJwTpPdPqWw==
X-Gm-Gg: ASbGncvrhtizlj2v1t+St/Sr0NDdCs7YUgNyDNufJhUQq/F3mgTGgT7guxOCWH0jBNG
	8ChaFqI4c3VQzYmtY8hrwJfmuWqQg3NrsD4GqXPbTI8UeU+1Kzqhtd26pbOqXF1SdaUnA/Bzt9M
	+OzY5sy2ufNp514ZCeOXc03CfMQdhlD3iaVj0DAO3Cqqd6Cjdb76V0s7qTc4VPDJUE8nLp502Ia
	MAv7qsd
X-Google-Smtp-Source: AGHT+IEZGZAjJ6oTT/y0eC5XEJAwdjFNArop3uSkBDdCtmPqSMYvdMHeSgLNTUW+1pljPGLH32dL1zf5CykkNJQ/IMQ=
X-Received: by 2002:a05:620a:1997:b0:7e1:31ca:954d with SMTP id
 af79cd13be357-7e66ef7923emr1043723185a.13.1753971167480; Thu, 31 Jul 2025
 07:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093233.592541778@linuxfoundation.org>
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 31 Jul 2025 10:12:36 -0400
X-Gm-Features: Ac12FXyV2Urw95nrCpp0mmTC6H-HCM7BEoKwi79mPFC-PVRxatkeHBA1vjTgd5s
Message-ID: <CAOBMUvh13vSvX4m7x=AvW1zrXTYfyF9J0JMsAwECY9gku1+=RQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
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

On Wed, Jul 30, 2025 at 5:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.41-rc1.gz
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

