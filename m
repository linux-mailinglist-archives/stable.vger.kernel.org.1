Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C348C758349
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGRROp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjGRROm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 13:14:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A41CC
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 10:14:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so5306245e87.0
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689700477; x=1692292477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xNHCsUjJ+BCaFhxfsdRhPxQDWCt8nccDYWzAwStBOs=;
        b=g9HJBcoJWuyyNNZxrlugD/82G5MWrhffi3/Tlwy2l67Q6r4vxJpB/teOugaTpqIKW7
         4Z4irKQWJZpzcSm1XSDbgdbdsRHr9VhfTAqC4zgrY3zZ5v95S3JQS325Nt3/l0vctLBP
         eLPgF84PXlgNU2RHx/YCrK42JXq3dMjn5qfg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700477; x=1692292477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xNHCsUjJ+BCaFhxfsdRhPxQDWCt8nccDYWzAwStBOs=;
        b=CCdG1QoJfBGT537qjtufzRoNBvu5kS5b6tB3PsKg/mENkJaohwgKsostS2tI5JXDoQ
         7T5wnLxkQ3vqVRlXtxxAtaTX6gFbg+DETnk1GUkJyL+tA86F1BuzymBypQ80L0kohp86
         t0CaFPQkSpxpjGRSXKzME1ZmJ01cHaFSGpYz6B0v+MvjXRMnyYGS3sLECo/FVTIplTxj
         W2d90NSyx8vlqF4ZLlAjRJJzW2EF8eLmXRPEoYpjvfIPSBVCjB+h7T0Obv6vdUO6wdpE
         wP15NcVFGl+wcMgrqhF9EmOG3vLG6SXCdYR5GnEMCcCJJ870/gf42m5GPCLCtkPrMnhd
         p39Q==
X-Gm-Message-State: ABy/qLYlK+fWgsayuSTiCdX+nxUj/IcQht256zDEP9KIX0gufgvvqBbx
        fjjeiYpSPRHT3yj3du2nagTve9fGaphjgy2MvTWwyg==
X-Google-Smtp-Source: APBJJlFSigcLqqCWL1ZpytpwVJWinmpauU9gELfUDRDT4pMcEUKpkv8NIbETrbSjT8rL3SnoE5/y3eANE3oY+LXr3b0=
X-Received: by 2002:a05:6512:3f0a:b0:4f8:5d2d:4941 with SMTP id
 y10-20020a0565123f0a00b004f85d2d4941mr3824503lfa.34.1689700477285; Tue, 18
 Jul 2023 10:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com> <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
 <2023071625-parsnip-pursuable-b5c8@gregkh> <da595585-4929-2c21-7e48-f9f8cdad6cf7@joelfernandes.org>
 <2023071840-hatchling-fiction-65a8@gregkh>
In-Reply-To: <2023071840-hatchling-fiction-65a8@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Jul 2023 13:14:25 -0400
Message-ID: <CAEXW_YR801_BhsevD0UjbXpt47H82=uX2oqcLoCo9pdW2NYOjw@mail.gmail.com>
Subject: Re: Build failures / crashes in stable queue branches
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 18, 2023 at 10:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Jul 18, 2023 at 09:52:45AM -0400, Joel Fernandes wrote:
> > On 7/16/23 10:30, Greg KH wrote:
> > > On Sun, Jul 16, 2023 at 11:20:33AM +0800, Yu Kuai wrote:
> > > > Hi,
> > > >
> > > > =E5=9C=A8 2023/07/15 23:49, Joel Fernandes =E5=86=99=E9=81=93:
> > > > > Hi Yu,
> > > > >
> > > > > On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
> > > > > [..]
> > > > > > ---------
> > > > > > 6.1.y:
> > > > > >
> > > > > > Build reference: v6.1.38-393-gb6386e7314b4
> > > > > > Compiler version: alpha-linux-gcc (GCC) 11.4.0
> > > > > > Assembler version: GNU assembler (GNU Binutils) 2.40
> > > > > >
> > > > > > Building alpha:allmodconfig ... failed
> > > > > > Building m68k:allmodconfig ... failed
> > > > > > --------------
> > > > > > Error log:
> > > > > > <stdin>:1517:2: warning: #warning syscall clone3 not implemente=
d [-Wcpp]
> > > > > > In file included from block/genhd.c:28:
> > > > > > block/genhd.c: In function 'disk_release':
> > > > > > include/linux/blktrace_api.h:88:57: error: statement with no ef=
fect [-Werror=3Dunused-value]
> > > > > >      88 | # define blk_trace_remove(q)                         =
   (-ENOTTY)
> > > > > >         |                                                      =
   ^
> > > > > > block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_re=
move'
> > > > > >    1185 |         blk_trace_remove(disk->queue);
> > > > >
> > > > > 6.1 stable is broken and gives build warning without:
> > > > >
> > > > > cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove=
() while blktrace is disabled")
> > > > >
> > > > > Could you please submit it to stable for 6.1? (I could have done =
that but it
> > > > > looks like you already backported related patches so its best for=
 you to do
> > > > > it, thanks for your help!).
> > > >
> > > > Thanks for the notice, however, I'll suggest to revert this patch f=
or
> > > > now, because there are follow up fixes that is not applied yet.
> > >
> > > Which specific patch should be dropped?
> > >
> >
> > Yu: Ping? ;-). Are you suggesting the original set be reverted, or Greg
> > apply the above fix? Let us please keep 6.1 stable unbroken. ;-)
> >
> > Apologies for my noise if the issue has already been resolved.
>
> I think it has been resolved, but testing against the latest -rc release
> I sent out yesterday would be appreciated.

Great.  Sure, I am going to run it today.


 - Joel
