Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB06F082C
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjD0PXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0PXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 11:23:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6303FF
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:23:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso5419360f8f.0
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682609024; x=1685201024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMxQAOHKT6YrNYtYKTZKnvvMnukg7nxAAffcY2Hry4g=;
        b=Tr8+HukoQv84gEq+0hG2DJbvwDfxHElOxLLH5Ir3mIvAMmWCCQt5vK8r7D0+OwjOcY
         ixl/McRST4eTCvCskqsOzB++AlqD9NPTrfi1NGEGRwRPbeYSPMd7wqB2RdA+3Ez9JMkB
         TQvJUB4fPcTkyPuma3WfcPzDiy0ophtF6HEfj68/5msM6UGhrYsdFZYMFuj7tmD/6pNg
         NdPpXLGGNHkMVGcGDbxtbcJNtbSlt0+TOOvhnZO01W/8nMVhZiII9vNAqeH9IJ5FdjsR
         5Z5U/fVt3mcjTUTewcUm3RlzD5bvaL8KDWTqBwB3wFYJoN4HFZsMsGAkuMa+72YK+3u/
         i8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609024; x=1685201024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMxQAOHKT6YrNYtYKTZKnvvMnukg7nxAAffcY2Hry4g=;
        b=RH9wasxOGJU/nsmKaOkQ1t1BHY0ZmDslKnsXE5KonItBpIyeiA/Q1Kg+WUsGjkybCQ
         Ysl7rgh9xvT3VocSoiTFNS0xR7qHCg1hNhRyvOiry4ZeBicnu07+x+Fj/yRs+OWQuzIX
         ZZIjVlBT4Ytnl7tRTEKtikuxIk1dpU9kBbamPktAuPNSTOxYMPAorSYY4Bd1YMlB+4yQ
         lD1Fxuf26Lfo/v4fqYLjZOWWFQgxiqc+7/rSxBFaLrpimoFlkDmGT3AhYzH/3jaEMQbs
         2Gv4Lna0sX6wUajqxPLZPpsPuTIUVrGiXv2TPDBM5WXRxzOBZWTDJfytOCW7bJEbOBy6
         g3IQ==
X-Gm-Message-State: AC+VfDyk7haNoTLeMfzpn3QVS5QkQGn0y1nui7vkvOXWwA+QCxJCB4YN
        WZPtwHQUzY7AORtSPQ8LToXiXS9WYuNq3wiC4w7iwA==
X-Google-Smtp-Source: ACHHUZ5HHbPr/vS2YMS7pW/m2sFip7lUIyGkHI55NCxlwA4+zTJbOKFOIxR6aAakTOV4gPcurY4EWw5tH8uNQVOS/IU=
X-Received: by 2002:adf:e68f:0:b0:2fb:6277:54a with SMTP id
 r15-20020adfe68f000000b002fb6277054amr1843120wrm.51.1682609024474; Thu, 27
 Apr 2023 08:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230424150354.195572-1-alexghiti@rivosinc.com>
 <20230424150354.195572-4-alexghiti@rivosinc.com> <2023042756-aggregate-distance-1d1a@gregkh>
In-Reply-To: <2023042756-aggregate-distance-1d1a@gregkh>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 27 Apr 2023 17:23:33 +0200
Message-ID: <CAHVXubgTt4K+Vp0jmd+KyjNYVYKJ+32EhPNbM=1ObxwSoyaKnQ@mail.gmail.com>
Subject: Re: [PATCH 6.2.11 3/3] riscv: No need to relocate the dtb as it lies
 in the fixmap region
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On Thu, Apr 27, 2023 at 11:53=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Apr 24, 2023 at 05:03:54PM +0200, Alexandre Ghiti wrote:
> > commit 1b50f956c8fe9082bdee4a9cfd798149c52f7043 upstream.
> >
> > We used to access the dtb via its linear mapping address but now that t=
he
> > dtb early mapping was moved in the fixmap region, we can keep using thi=
s
> > address since it is present in swapper_pg_dir, and remove the dtb
> > relocation.
> >
> > Note that the relocation was wrong anyway since early_memremap() is
> > restricted to 256K whereas the maximum fdt size is 2MB.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Cc: <stable@vger.kernel.org> # 6.2.x
>
> You dropped everyone else's s-o-b for this patch, why?

Sorry for that, I'll fix it. Should I add the s-o-b even for the
patches that I had to adapt?

>
> Please don't do that.  Please fix up all of these series and resend.
>
> thanks,
>
> greg k-h

Thanks,

Alex
