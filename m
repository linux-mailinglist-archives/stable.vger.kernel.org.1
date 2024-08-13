Return-Path: <stable+bounces-67419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4594FD66
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 07:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB11283F27
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 05:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA22C6B6;
	Tue, 13 Aug 2024 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSHXZ/aq"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A82C694
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527943; cv=none; b=SQFl0PjFMWCB0oVQEekoUeGo2t9buyDQjPBh0usaDzvzoGTMp6V/0Hirn0KrS0XTrJy+f/vfdAGo6Zux0qbjNEY3D1E2aXBXmuZf6PF0NOlD8lKwan1UhuWyHZVtnk/gjnIIhmKYPu8sPhXaRrjYqjsici2bOUWtFi5wMVzwYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527943; c=relaxed/simple;
	bh=cdoNnInjoIDLOcYyF3TpIBPak0pH9QVzrl2rJ1+P1j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxGNX2bk0hWwHDlXXuTScoZOrAEbp8yedgTpBj9gLE8yL50xIfF8B8hR9j8TyxGdNe6fLDu0BYcRow9S6Sb3oUrPgNJP0Ap6B7Khgg4Uvy+htXmnWktCnzb8zAd57LgdhmVr8vRpU4nvhON5iOxiMPLy6CHVR1qUEQS3s4ljjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSHXZ/aq; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f524fa193aso3478747e0c.0
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 22:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723527940; x=1724132740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WT/CbsEouBetlgF7QeJxWQVQU9e4IrXwmq96Le/w1ag=;
        b=YSHXZ/aqwQbZ5SxkyRVfpGIbaXEBnIp07Xpap03j0yaqwkO90vG9NYqTtp/Ibbqv2t
         kRZChUwhaH8rpFAavT7/47Q8j9omduWDzaXI3t6Oj2vqliZhMgwkpC8lv9QjUXqz8E4J
         EEJ26Y0HxjVae4Wndx2RQHO8r2pzezYQIhHGO+K0a1qKBbopl+UnW2HWxD/rad9QlWns
         fCGl0DJEA50aaCTaMN9WwTNbrkItwiPgLOVv3teF7uHGo1rQWk6u72OpHRaqkQlRS+L8
         CTcVpAwXr4LjNnKp1duMhta4aW67wi2vwpVbiKLQBtaFCog07QsiWn1VqVgB0xKcsQFo
         4G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723527940; x=1724132740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT/CbsEouBetlgF7QeJxWQVQU9e4IrXwmq96Le/w1ag=;
        b=IgyC2T2Yc/PrrTr58q/9KhPKvJUarloJs7G8RfgDKM4NEYdPFUjk5gTcVx562lgogW
         fOTHFBuLHTUL8H2fD5Yw0BdGN+Fzo9+1d8U7E1miQlz3ukxuN4wDHdaohw4WwzmMtEXC
         4lFYtwLqjvhHmylL6EajJT4rMcl9mBzdn6Mjy4WhciRW7ytzBC8LTsmqRBa7nK4iKAIu
         Z8uC9ymkI2TQkIWG+fqoueAsnnTr6cjIEngN9MQuwkF2D3GuAIGyu69JyMaZUxPdgGru
         Ghlu0weJcSMXvGqrySgEZM6+vasMyxUDUlpE7QT0ujzifZaS41/Wr1FaCeAIreJnFzvP
         T3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2sUc0Jp872PT0luHmnoYh6zj8H46G47dheCDOhfom7sEOA6Yl9tD+LPrK/yoMa1YFvzGwYnM1OknW1iv33VySDHw7h5dL
X-Gm-Message-State: AOJu0YwEzmhht8BCEp8+g99n3k5SmIkeuS3AU1y5j75HqtKj1ES3dsGW
	+JAvQrQKtecY1uwIAJwyIANHeI2LQtBdba86D1dVwPHk5Z446UDLN8gIDNwHNkBWGGh18vzeqVF
	8md+iP9/EcTlOI3uVe0EN91a9ZYhzxgIYjhuyuQ==
X-Google-Smtp-Source: AGHT+IENesLG4K4Ju9cg8WUlmWLdmGq9gf869Rf3CwWmTmy3QIsoXCSMZMN0dJOClRuFlKsU5XQeLs3bBYpB5bHdlnw=
X-Received: by 2002:a05:6122:3b1a:b0:4ef:54dd:c806 with SMTP id
 71dfb90a1353d-4fac1a87d45mr1092536e0c.7.1723527940317; Mon, 12 Aug 2024
 22:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160125.139701076@linuxfoundation.org> <f514502a-0e89-4fcb-95c4-986a3cba2342@roeck-us.net>
In-Reply-To: <f514502a-0e89-4fcb-95c4-986a3cba2342@roeck-us.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Aug 2024 11:15:28 +0530
Message-ID: <CA+G9fYt5DQbDEEtC8Oq+ja+vbTRxQVcabsoxfz35nSQDS27KRw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/150] 6.1.105-rc1 review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 03:13, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/12/24 09:01, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.105 release.
> > There are 150 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> > Anything received after that time might be too late.
> >
>
> Building parisc64:C3700:smp:net=pcnet:initrd ... failed

As Guenter reported,
Parisc builds failed.

* parisc, build
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-tinyconfig

> ------------
> Error log:
> In file included from /home/groeck/src/linux-stable/include/linux/fs.h:45,
>                   from /home/groeck/src/linux-stable/include/linux/huge_mm.h:8,
>                   from /home/groeck/src/linux-stable/include/linux/mm.h:745,
>                   from /home/groeck/src/linux-stable/include/linux/pid_namespace.h:7,
>                   from /home/groeck/src/linux-stable/include/linux/ptrace.h:10,
>                   from /home/groeck/src/linux-stable/arch/parisc/kernel/asm-offsets.c:20:
> /home/groeck/src/linux-stable/include/linux/slab.h:228: warning: "ARCH_KMALLOC_MINALIGN" redefined
>    228 | #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
>
> In file included from /home/groeck/src/linux-stable/arch/parisc/include/asm/atomic.h:23,
>                   from /home/groeck/src/linux-stable/include/linux/atomic.h:7,
>                   from /home/groeck/src/linux-stable/include/linux/rcupdate.h:25,
>                   from /home/groeck/src/linux-stable/include/linux/rculist.h:11,
>                   from /home/groeck/src/linux-stable/include/linux/pid.h:5,
>                   from /home/groeck/src/linux-stable/include/linux/sched.h:14,
>                   from /home/groeck/src/linux-stable/arch/parisc/kernel/asm-offsets.c:18:
> /home/groeck/src/linux-stable/arch/parisc/include/asm/cache.h:28: note: this is the location of the previous definition
>     28 | #define ARCH_KMALLOC_MINALIGN   16      /* ldcw requires 16-byte alignment */
>

Thanks for the report.

> Guenter
>

