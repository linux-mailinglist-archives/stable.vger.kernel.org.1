Return-Path: <stable+bounces-54709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38001910357
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB22928436B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525B1AC768;
	Thu, 20 Jun 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="f6QDoBce"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01221AC769
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884047; cv=none; b=LzNIoxjV8Yvclquj2oO44VAYG7xv5nh4uCyw7bTlqVIMtD4tXTiuzSGgyLOOqBUOE1+ype+iuI4slqY0MxqS7Gr0lI59hVVCcmx+BhJf0EH7BrgqcEsk+mgIBsoaIqYt1j3l23umtfXuJ/JybkI9HQ0suAHhWbHsBhQDulhSiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884047; c=relaxed/simple;
	bh=/1HS+rQtTslNAHKJd3uK2CeEl+AXFRv821YL7VlRfKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUC0A6Z273QcIpGI3je+TjtNNQNV0OQgAUgmUtVij9/L22KoLs2haShnRuyJVurvg0GwgQ6QO3Edo7Iq2e/3QBSRpJrKizaqdLahwMd+7AC+yUEUtIV2VlPfSR3YZ1GPr4BC9sHjAjMrNRX1pDpYnKtbhZ3B/OVtNv2B6JF0DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=f6QDoBce; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-705e9e193caso624783b3a.2
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1718884045; x=1719488845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDbQvMs5FZ0E2LKJR9+/mbKWM6Cdi78nFokQhVSGaxc=;
        b=f6QDoBceKagjVKYp31PNbIgtdvApZjGf3bO2bSqJWwPfyRIwvphAvVXdmav++NK50u
         QiECGJrvi9qKyTYrPw5oqCRrd39elF3PKboioUskE3v2wq7OaGiH49RlAsIaJ+Psw/ii
         cJh0fzwIpQeZ6zaLw9/oI4DL26p77hDGP2ad+YQYmS9JcczAeQwqGfg7BdVAnwv1u7cx
         kgp9mQr8ITQGOw62a2L65kItp3POss4H2bksaderUKBKUBdhe+6+I5J2lG+5+KgCO4K+
         Yep4tmrZknZDf20ZQQdqjBxkQ4D6WWARtbpROMxKrywIfASY/lYmkkuDGyYa/7X9bNaP
         w4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884045; x=1719488845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDbQvMs5FZ0E2LKJR9+/mbKWM6Cdi78nFokQhVSGaxc=;
        b=ffLO44IU5SVIAhZhmark5bQwx+w8bLmaB/TkcSmIw42AsUDh0FVA/OGoSKgJMBEaPy
         pE0mq++DotBdPySVsgejOcEI7UnexQPe4ViEhebXjxKMFfyIF6qOIiCnrWHdELw4lrie
         1H9B9oQESX8SwlvPmv206cG85myaukS65pEqhYkw2fhjlJ1952IXL+SjW4WzXiLLoggz
         fZJ7H/sP9hAuyr+TBqXliDwWHBcSORHvFmW12k75mzZdgfKD5tcUl1s4hG9eZ3dxHzD1
         3SanDzAxI25AMDciuzn5+kZza8/ChnjUpSKSgALymPerpFqVC0YKrpXpZm49yN1YTabN
         6oVw==
X-Gm-Message-State: AOJu0YzkM/VwFfwj92C1pbPB82jmYSVgzEXV7xlW/E+SCNA/WUrgz+Lm
	m0r8mDPd3LEbpx8t7gbMuZ9n6n6u4C93dn/dtPRj5DT3XhB7zcDhiXMDOFiftcH8salIW8BYnwR
	8M6przZ2TrrVyyDxJduLa3SMwHg9MIcr2Jf5M5A==
X-Google-Smtp-Source: AGHT+IFH9K37gIw/JKx90Qnlyho5R03GHOY6Z/ykjRvo/B5y1YXbTFndIQjJKqj0qsSX4d+stSE44xU0DYi3Wyrzj2Y=
X-Received: by 2002:a17:90a:ff11:b0:2c4:b495:49a2 with SMTP id
 98e67ed59e1d1-2c7b5d97dbemr4859556a91.39.1718884044893; Thu, 20 Jun 2024
 04:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125606.345939659@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 20 Jun 2024 20:47:14 +0900
Message-ID: <CAKL4bV52_bZjWk7_JdaHAzf6eSG4-8V77zj5YzwJH98Mz9P1vA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jun 19, 2024 at 9:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.35-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.35-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Jun 20 19:16:30 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

