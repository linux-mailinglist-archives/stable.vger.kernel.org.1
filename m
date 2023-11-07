Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D4F7E468D
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjKGRKX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 12:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGRKW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 12:10:22 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E8E8
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 09:10:20 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45f0e332d6bso1329135137.2
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699377019; x=1699981819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5B3xt+TAu4pFRHAyTC3xHUtVUIvM518CKJZsirqrIvg=;
        b=FDre5BUWMbluRkS5PkIPLL+JrLHjIUeMrJFUVMo6z/CCVU30QDCrUw7xrhA7ZPzZut
         8LxyAUEVihd9pKqBzTCVPDCt+G7SDUc3zk2p2QqkWGpZ1ycQiP7uy8uSF27sPOJ0uQtp
         1Jzb/woBSUrOmw/5LJuKHXCa+Vj5nfqd/axC3MXeLII+Zp3NmUu9Kalig4BclxvDwa6T
         SYJ3f+Y2J1uusbLuzbKSEA1Yiy3VORp5ynBPursCqI/ru/uHQn7qFTWgxo9poaE0ox3n
         N8ShfbHGxDzySfe11U75moThrad619mb1HQ/J3kccwyVVmgxuwd2kYlnrkALmQDoeHBC
         8Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377019; x=1699981819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5B3xt+TAu4pFRHAyTC3xHUtVUIvM518CKJZsirqrIvg=;
        b=RqndXLBRovlQWZaupBFb8Fp+Tlhnd0Ku6Q0Gv2IExrLH7HsnN8pftLn8e5gkbn73nf
         owy4B+bTt3LLGaeIVCMYi3JqhJnkv5IEhXRsso92S1sLVYulcL49uL6n83me/075z9JF
         Pmm/KbLMuHWoZy4SspoWn4Ep8rmHeXIkJh+OaxKdRrYxwHkybDh3H7v6iEHaMSRxsMWJ
         jvVukPajltDf2kJUvZOUw4/ycL3BHc03ESCNPOduiA0trNQlUoAcwZ9P1ESg5Cz36CAQ
         TgkJSczhUTbFOw+b4/YUM/oehq8ns9gJjkzDzD8YdvU5RkTbND9PojqZTyDW4123HpSo
         V6Ww==
X-Gm-Message-State: AOJu0Yz/fL5dIoT5p7LKp4ectMsdk97Y3a9Vw83e50hnQ7P2uJ5KW8IF
        RHVje+E2E+tSNTjEv8WPekSqmDkFaVgRR1SGEWb5vg==
X-Google-Smtp-Source: AGHT+IHHLjLZNx461l95CH5j88c0qIdP29a5XEHIywb0uRZjCTZu8h74GPpAYdKJVoKlL7K3lvtZ3zUex753wv62pcc=
X-Received: by 2002:a05:6102:20cc:b0:45f:8ceb:ce13 with SMTP id
 i12-20020a05610220cc00b0045f8cebce13mr1344535vsr.5.1699377019563; Tue, 07 Nov
 2023 09:10:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsrLTbFkz-LJmAY9efDyEr-8bHcxivBDPToPjBxjStoDg@mail.gmail.com>
 <ZUpH0FNTYAl9Z+L6@finisterre.sirena.org.uk> <CA+G9fYta5cUpFArGfON3R+HUGxJRyEsc9zdTwwk5Un+wHqLN8g@mail.gmail.com>
 <ZUpgZ65SYqKVeQoo@finisterre.sirena.org.uk>
In-Reply-To: <ZUpgZ65SYqKVeQoo@finisterre.sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Nov 2023 22:40:07 +0530
Message-ID: <CA+G9fYu=9qH+9f1bv0NqUTi-VTTzhBNUYiWjwSmrdDtuhAo69w@mail.gmail.com>
Subject: Re: selftests: arm64: fp-stress: Unable to handle kernel paging
 request at virtual address
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Mark,

On Tue, 7 Nov 2023 at 21:37, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 07, 2023 at 08:14:59PM +0530, Naresh Kamboju wrote:
> > On Tue, 7 Nov 2023 at 19:51, Mark Brown <broonie@kernel.org> wrote:
>
> > > This all seems very surprising, especially given that AFAICT there are
> > > no changes in stable-6.6-rc for arch/arm64.
>
> > We do not see on the mainline and next.
> > Is this reported problems on stable-rc 6.6 and 6.5 are due to running
> > latest kselftest on older kernels ?
>
> There's also no backports I can see in the selftests (at all, never mind
> just arm64).  There were a small number of selftest changes for arm64
> went in during the merge window but nothing that looks super relevant.

The Qemu version got updated from v8.0 to v8.1 and started getting these
test failures.

- Naresh
