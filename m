Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1A6F9201
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjEFMdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEFMdZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 08:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51429156AA
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B9460A70
        for <stable@vger.kernel.org>; Sat,  6 May 2023 12:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B50C433D2
        for <stable@vger.kernel.org>; Sat,  6 May 2023 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683376403;
        bh=OUt+WPPKwkEEAeNC6JQqlbiamxZ4XN7vNEIq5l/42Bc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QZ1sy2zTv0z4shAMJn9PF2iTLJmiWEWelqBNL8sm2co6/R7KHADSNMhOK8rtLkcN3
         f+1IAsQyEH/avNjTDfbNPP1gEoqVC5LTPWQVtACLWc8lJFAlAxDVH/7htlyFlqQhpl
         SndFbuNVrdaBdt+AorCJeSLD3lGrhcvaHuu+yZggbPtiNQHxUZLsl2LNNwvlczL03d
         EFg0K1+uhXvT7/806rFnQdSbPLqXT1OUQk06apabyyuIozRDxN5B4Vjc/hFP5CSepO
         DSpowxqniqoVazXGBB9DZ7wnuWHX2gSSyC4sqfmZ5g9Dhrs9OFPJlyH4dofCZYAQbA
         I3qyuBQlovugw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4ec8149907aso3214600e87.1
        for <stable@vger.kernel.org>; Sat, 06 May 2023 05:33:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDx5peSlomZFI05JBr+FdZ4ACXAIK8X4RnafSHJsB1OltztcM5Fr
        eGDdkHzuNf/Y22DO3kKO2nJqc2452EFZtQLrMcE=
X-Google-Smtp-Source: ACHHUZ5/+YamPheHxsHyRGKQQZTqrHJ9IQ16JTPs2OsmK/HnuEpP1KN3kmjLYowP4m7I41Fd4kZKXQmggsMn7U6XkJo=
X-Received: by 2002:ac2:52b9:0:b0:4f0:e35:cf2 with SMTP id r25-20020ac252b9000000b004f00e350cf2mr1249146lfm.40.1683376401337;
 Sat, 06 May 2023 05:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHCN0CuB86RpE_y=2KOo=KR80KjBzEMTPkmxxn8=D4uaA@mail.gmail.com>
 <2023050636-had-crabgrass-e9c4@gregkh>
In-Reply-To: <2023050636-had-crabgrass-e9c4@gregkh>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 6 May 2023 14:33:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuVFw+YunDi1tKMDf-u_Jsg0ehj8uO=MLxujp8VPRh8Q@mail.gmail.com>
Message-ID: <CAMj1kXGuVFw+YunDi1tKMDf-u_Jsg0ehj8uO=MLxujp8VPRh8Q@mail.gmail.com>
Subject: Re: stable backports for arm64 shadow call stack pointer hardening patches
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 6 May 2023 at 07:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 02, 2023 at 11:57:38AM +0200, Ard Biesheuvel wrote:
> > Please backport the following changes to stable kernels v5.10 and newer:
> >
> > 2198d07c509f1db4 arm64: Always load shadow stack pointer directly from
> > the task struct
> > 59b37fe52f499557 arm64: Stash shadow stack pointer in the task struct
> > on interrupt
>
> These did not apply to 5.10.y, but they applied to newer kernels.
>

Thanks - I will send a v5.10 backport separately.
