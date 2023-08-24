Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007A78791C
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 22:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjHXUJx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbjHXUJU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 16:09:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE4E7F
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 13:09:17 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a8506f5b73so179649b6e.0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692907757; x=1693512557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMOVw9zI4qUYS4/6mGHk8c1zHfKQdWpaVAIEoa2cllQ=;
        b=1XdooHZArcSFuXTmOh9sPZwYlp4kCWdYOT7vO6LoqbY2xXDlTCUlu8qGoOksq147rC
         OJboyJqgCpMCDVuq1YDhZMDdoIAZI4cXwm9JRcqLdNOjsn2WFfgtBBsqGlk1ahVdSoMZ
         HNp7FaHppKxZU/4HTfXlRQgXtMTlHslUvujpvDY7qGyAhi/ZsW959L1eNGGijch8COA3
         seuj98d4zcUhMc+Prz+bm0MvnYtf+Mzmmn9xYj6wMyIMzskM585qT9SAKoqkrpQGOn6Q
         ztTATodcjPkppXE+CmcraIJFsuWXUq2klhRwnCbRBYecjnbwfqGW8FB+EWsOp7H+k7k1
         Q5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907757; x=1693512557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMOVw9zI4qUYS4/6mGHk8c1zHfKQdWpaVAIEoa2cllQ=;
        b=h9e+Brcc0AKFda7jBMVMosjVDL+f86qKNXqLu/aZrmSJbIKR7mgluK8dTBL6SO5U9f
         NSP1R7+6hHgDmq0w8tcCqFWef7+TBTCJoFlCY870b95QnyEWF9RvN1WFGChDAQtcDE2X
         NPN0bq7JX2b+EqhlMfLdv1mu4R62OAzVRIn4e4flDLazN1i8MwpPgndJS0TohllpqfLM
         CNwQKf0lK40jQFN7j8soq8TZydB0zJuos4xRx32YHCCQ8bW0L9Yqn2oU3+7X9wcQuqXW
         9zPKu8ZmlSL+ozNPfDaKheBIJtN2BM0lQzJZE4aWESrbmMqEGtUZAVUpH0J4Iokj3mDI
         pzSw==
X-Gm-Message-State: AOJu0YwvrwO1wkVw2EAh/ZDDAL75SQhjwt7MOdtR4eU5J2chrq+Sh99+
        dJwvrjtXcg/6Yzu7kB+PKZmZ4g==
X-Google-Smtp-Source: AGHT+IEXyd6Sd46IHd8WavbuIIHBZ5eX52cYSJmHLAQktkD6fWkrurbC+JmD+MlbPobmbuWKGaPQrg==
X-Received: by 2002:a05:6808:1a92:b0:3a3:6cb2:d5bf with SMTP id bm18-20020a0568081a9200b003a36cb2d5bfmr746696oib.4.1692907756760;
        Thu, 24 Aug 2023 13:09:16 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s9-20020a639e09000000b005657495b03bsm11637pgd.38.2023.08.24.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:09:16 -0700 (PDT)
In-Reply-To: <20230824190852.45470-1-xingmingzheng@iscas.ac.cn>
References: <20230824190852.45470-1-xingmingzheng@iscas.ac.cn>
Subject: Re: [PATCH] riscv: Fix build errors using binutils2.37 toolchains
Message-Id: <169290773187.26503.887642526521895016.b4-ty@rivosinc.com>
Date:   Thu, 24 Aug 2023 13:08:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Bin Meng <bmeng@tinylab.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Mingzheng Xing <xingmingzheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On Fri, 25 Aug 2023 03:08:52 +0800, Mingzheng Xing wrote:
> When building the kernel with binutils 2.37 and GCC-11.1.0/GCC-11.2.0,
> the following error occurs:
> 
>   Assembler messages:
>   Error: cannot find default versions of the ISA extension `zicsr'
>   Error: cannot find default versions of the ISA extension `zifencei'
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix build errors using binutils2.37 toolchains
      https://git.kernel.org/palmer/c/ef21fa7c198e

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

