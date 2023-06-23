Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693A73BE8C
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFWSjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWSjM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 14:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AEA83
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 11:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE9CE61AF9
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 18:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02AC433CA
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687545551;
        bh=3UowwxFSn70DlgDYyW0skic5HR5RMWOVAExiS2/BiBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sjsr3dWDt9+IkJJxBVqH6M7uc5J+1Wp3Ebb3g2r237NKfhmzLqn26tUuMzCFJ0oK3
         WALxpL7MdnoAVhKZLEDJrJxnqC0wmXeEGaEaTRuVkNfkoHHNR+7F7UyThS/mqIvzws
         WvKaGdCbatnZKhoShhDpe/Pd26o+UNBv/Swrntc8IAuRZ+oAR+XzHL4ktxoYAGNExl
         QtWrMLwMDFNYaPu83zQl6ZCyx7CrrNLF0pZDyr5xsnJVfWcIiss3p+isG4FqR+2PtV
         NLacNADTekkNB+gpH4Y/sZdI9cWNaKsupcRKgbrYkOSASi2RSmJMRmHwqI9n8/pQBv
         AEVHtk6mAsi6Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b4745834f3so15994951fa.2
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 11:39:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDwzGGxzcUVGzzsYST0RkVIEZ1td2tvfxzrEQyDwDKz3IgAc9i0C
        QUlo2FEjgAe7HdRZv1uYS0g5PrHkef586apE/vk=
X-Google-Smtp-Source: ACHHUZ4SR6zSznmoBTp36ac9MGQldmAXgPQHqZoG/f+maEMbFY6jZGzu6nSxJ3ZgdkpMMyE7MNmogB2EHwXOIi8ea/k=
X-Received: by 2002:a19:5e42:0:b0:4f7:5e8b:2acf with SMTP id
 z2-20020a195e42000000b004f75e8b2acfmr13562679lfi.44.1687545549131; Fri, 23
 Jun 2023 11:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com> <CzNbNfn7R2cqLMD6_jp11Dku0OoXYJhx2AMfk8JXeQVP2EGdt7tqeYD4HH0COhp2o_yj5kN6Ao7oObSelRi8yiz-5ltbQ2xtjBvplvgcZjo=@proton.me>
In-Reply-To: <CzNbNfn7R2cqLMD6_jp11Dku0OoXYJhx2AMfk8JXeQVP2EGdt7tqeYD4HH0COhp2o_yj5kN6Ao7oObSelRi8yiz-5ltbQ2xtjBvplvgcZjo=@proton.me>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Jun 2023 20:38:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGb+RfMQeOui8uzXBFRchfWhpnEsxOo84Y-LLBqk=z5Uw@mail.gmail.com>
Message-ID: <CAMj1kXGb+RfMQeOui8uzXBFRchfWhpnEsxOo84Y-LLBqk=z5Uw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, regressions@leemhuis.info,
        Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 23 Jun 2023 at 20:20, Sami Korkalainen
<sami.korkalainen@proton.me> wrote:
>

Please don't send me encrypted emails.
