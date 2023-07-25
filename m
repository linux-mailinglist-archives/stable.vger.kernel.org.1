Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E879761443
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjGYLRi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjGYLRZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DAFE69
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA596168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB3AC433C8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690283843;
        bh=/W/9GJDQ9gFS7dB9fUNuS0m4Qz/JcUlmSVIpwrBoK9o=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Zr8D4XlFsl2qX2e0CxYvQqXtQYJXMxHeaDT009b5Ehi3xbgudxcIfYJx61FnXXBna
         A1W4xD+iyngsC4TTtYoPxXJQdIvNe54T0/SH8WEML2ok/ggCnerzhuScj+xFSgmulv
         TXSY0TBceZfzLvE1Xyfkgqhz5Uyu60jWIKLLvpWN2K6Hpsv1Bl0q/aK8Xw5RtqgZOO
         FpZeDceLOqHfXJHIa10VUrgBx1cJXRM5rhQfjIbxKy5OdCbPfATeI7ucooKzUi//R2
         L6NDtRqYNHRHgIm7os7QYzPD3F5dswZxlFmGKn3xrrl1seCOQcpQgDvUZKuglw32vl
         PLFXzSBxPcPVg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b97f34239cso46929021fa.3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:23 -0700 (PDT)
X-Gm-Message-State: ABy/qLaab5pJcC/TyEdO2E0XWYZxzm70UO22u2sAp5XIbKBd/DxgwnnW
        uJ+GmIpqXa1oSntc9nvFmPnMKqo8RBAH/MOqx7A=
X-Google-Smtp-Source: APBJJlHEb9Qral6xLMEEdz9hGFkrUAIPnq2m5ma+uH8CPs09gL671gq68Zr22dyLlOY3WqSGmK/KF43rsjBPssTua6M=
X-Received: by 2002:a2e:98d3:0:b0:2b9:601d:2ce with SMTP id
 s19-20020a2e98d3000000b002b9601d02cemr8448119ljj.35.1690283841491; Tue, 25
 Jul 2023 04:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jul 2023 13:17:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFe89ScVNy-MdBQjC2-CPVut+Mw7FjwmKztzwm7yOsC3w@mail.gmail.com>
Message-ID: <CAMj1kXFe89ScVNy-MdBQjC2-CPVut+Mw7FjwmKztzwm7yOsC3w@mail.gmail.com>
Subject: Re: backport request
To:     "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 25 Jul 2023 at 13:13, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Please backport commit
>
> commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Tue Aug 2 11:00:16 2022 +0200
>
>     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
>
> to all active stable trees all the way back to v5.15. I will provide a
> separate backport for v5.10,

Actually, v5.10 just needs the following patch to be applied first

commit 8a81b6bbdccae98d751644723c67bb6aa9a79571
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Mon Jul 26 16:24:01 2021 +0200

    efi/libstub: arm64: Warn when efi_random_alloc() fails

so please backport that one to v5.10 as well.

Thanks,
Ard.
