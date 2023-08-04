Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F900770010
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHDMSe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHDMSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:18:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7787D46AA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:18:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1c285690so3328604e87.3
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691151506; x=1691756306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ds04wfg4NjNpt0ZeS5IMh0XoZ+Tm7JkGNeYu663YgAQ=;
        b=IRF7U90hNzQsC5taVgeiOBy+UsYr1iqTICpn75O6K3D45yHniV6MC4W8ygb5DF6GEB
         2YyPNggHt6AzTr3fErhcFoZ00b98Asf+A3QhGJ1oFeTptAmPNFMuFghrjh2xCa++flYw
         Eo7jPDd0cY2r2IpDGxXGHB1wOuR+Qt7a4EBIjpocfbgDFIvvUdH0Xy3lcbZHdZFJS0+R
         ELLP5tlIrNlhEDrm/JYsu8tY0yr9J8HZb0eqapytRlnhXXaruDnHsBCnb7Og30R6iujo
         vI5WxXeBcTyIVMziozUm8ZUzcHw1tiesPpX9bRoc8btFFVZgiv0r5YcsiOb7/vqn5qGH
         j8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151506; x=1691756306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds04wfg4NjNpt0ZeS5IMh0XoZ+Tm7JkGNeYu663YgAQ=;
        b=gI7xJMY7zRn2iuSLaOUnS0Kn7mmJU0dUFYWsKhd6VLLaLSW7UGsFY/caG0R6GpAZ4C
         cMLUPGsrb30YR+q+DbwqzrZ1Ccl+ooS4nQK8tKXDTIsytNKAKcUbZ2YKKAvzrST1vWrk
         iVSYd+QfnK9LiAFX36Tagpx4DCa9EPPJJH9WffAP3M4Ehi1bUfNrtjTTeTBJoeGnZotS
         R5UDV7p7JBA2GJfGgzCg8yoQkMtxlxff+ARM6pstYYxImjCJ6eaGY1Op53bo200j1cMP
         GoPmZd+agBmFWTSQD5Pw1Bimhq3jA5Er1qIWyds2B9FTZJHP7jku3/fp8gJrd1naV6Kq
         5MeA==
X-Gm-Message-State: AOJu0Yw16my/PU5cNC43Gb9dR4N0jSZ2MmZqAUAd6S1IDTiKEDuwpHge
        az4A5YI/jc7UYC+G+TPjjaldt22ALR4=
X-Google-Smtp-Source: AGHT+IEdS7XGJmjV/nuGEWsfeQj/Aw+/QX7UC4uvg8Yu2JUFpuJNfYix4DyUl3PUDtzNfaQ9wEEwwQ==
X-Received: by 2002:a19:5e4c:0:b0:4f8:5472:7307 with SMTP id z12-20020a195e4c000000b004f854727307mr1003641lfi.31.1691151506183;
        Fri, 04 Aug 2023 05:18:26 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u12-20020ac248ac000000b004fe3a8a9a0bsm352604lfg.202.2023.08.04.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 05:18:25 -0700 (PDT)
Message-ID: <54d66dfa06580420383aefe4d43e8a7ce2bb4c2a.camel@gmail.com>
Subject: Re: [PATCH 5.10 1/6] bpf: allow precision tracking for programs
 with subprogs
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Pu Lehui <pulehui@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pu Lehui <pulehui@huaweicloud.com>
Cc:     stable@vger.kernel.org, Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Date:   Fri, 04 Aug 2023 15:18:24 +0300
In-Reply-To: <412cc31a-0891-6c96-bc94-2e84cc0f57d7@huawei.com>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
         <20230801143700.1012887-2-pulehui@huaweicloud.com>
         <2023080425-decline-chitchat-2075@gregkh>
         <412cc31a-0891-6c96-bc94-2e84cc0f57d7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 2023-08-04 at 20:15 +0800, Pu Lehui wrote:
>=20
> On 2023/8/4 18:33, Greg KH wrote:
> > On Tue, Aug 01, 2023 at 10:36:55PM +0800, Pu Lehui wrote:
> > > From: Andrii Nakryiko <andrii@kernel.org>
> > >=20
> > > [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]
> >=20
> > For obvious reasons, I can't take this series only for 5.10 and not for
> > 5.15, otherwise you would update your kernel and have a regression.
> >=20
> > So please, create a 5.15.y series also, and resend both of these, and
> > then we will be glad to apply them.  For this series, I've dropped them
> > from my review queue now.
> >=20
>=20
> alright, it's fine for me. will send them soon.

Hi Pu,

I tried backporting to 5.15 and was unable to get all test_progs* green,
because of necessity to pull in other conflicting commits.
So, you strategy on backporting only sub-set relevant for this specific
failure seems reasonable to me.

Thanks,
Eduard.=20

>=20
> > thanks,
> >=20
> > greg k-h

