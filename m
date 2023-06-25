Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA773CFA3
	for <lists+stable@lfdr.de>; Sun, 25 Jun 2023 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFYJML (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 25 Jun 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYJMK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Jun 2023 05:12:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F65E7E
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 02:12:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo1031561fa.1
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687684324; x=1690276324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kppE/1aeZz73sSj584qwbxqHiJbo+GK5PP0QhEK9lPs=;
        b=X6vjvdRUWOoDKNEOxsMIRf0LlUv2MBVLMiSIW4+HZKxaqplikdZhdeN1+shXxkde5Z
         Ujq007RKCoQ0ymqc4k8vsmxUIZqcJE05gKc+liQ/yq5ZumMSRFUssjex5UyeywmKAN7A
         ytYKIJzJULiPZ02f0y/IpWFZqimrfAihXc8u1TTPEAt53rncVHtPedj6+Ymuw6CYx9JM
         pDtK4JitaiBEpvU5Z1WH3lC5H6/H8/B3Xsfu6aJdow1hgBU+I/P95WFDagMHmgp/4YyH
         wHoW49IeM2ZdKHxHqqTuZl5adFvFcfFtBAe4t0kbM0b37TPlYrq2CkZiEjfbRue9C/kT
         zqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687684324; x=1690276324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kppE/1aeZz73sSj584qwbxqHiJbo+GK5PP0QhEK9lPs=;
        b=gjp5XchuvxYbLT+ncH7heV02xNyxGmiMJCu6bUm50C9Esfc/hH9OzHgfgXhTl1xVsM
         gpp0xvBqLfnb65l3B0KUfLKqqhSho9aKhJjAorvNeSUzvhGEfRqKo36L3ZU+1t+1KmyW
         RMGqD6rRv6X1c5xdiMqfnBePiJowMNaGh7t78VB0Q0lglHgvril7XGg8wOtgrfeDgwdf
         i0FFr1nFEWVoRXoBX1lTIF66RFiJVmb5+lDQYBeGSaXYa0CbxvLmUmk/HY9hSlIKvbRG
         By+NubwWA9UzBmfFdM2bhrjmWp0Src3BJF6tH4bgWbzxcwn+40OP+ImayXQlaM227AgA
         cTgw==
X-Gm-Message-State: AC+VfDyCMKeTA78dXXYzkSpA1vnMJlBlzIj+Q6VgluOEZREcj91pVmVk
        dsDPK5lmJEonxyMmXmBVbpauJceIfJrWx1eV45Y=
X-Google-Smtp-Source: ACHHUZ7NeeVbEhQyhlAtClXP+KKnObAPnXzqWhDhWldSrMLAqtfVqaCSEqzKkFTdgtshoznsAnZxVQzmh9h0D1uGQhs=
X-Received: by 2002:a2e:95d7:0:b0:2b4:65bf:d7b with SMTP id
 y23-20020a2e95d7000000b002b465bf0d7bmr13715273ljh.2.1687684324041; Sun, 25
 Jun 2023 02:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMeyCbi16i4mdkOnqYhbW1tnqNwPwg2FVYqbdyhXt1fT10EaUw@mail.gmail.com>
 <20230621152556.qcjarclgbagkygdt@umbrella> <CAMeyCbgmiNTpV5_sbP3dq0TNJBBxcW8j0SRM+dxbjQXWAShDBg@mail.gmail.com>
 <CAMeyCbhb2wV8-kmjaihjT3vQsFs-zzix77ztG7Z9E4VdEZOHOQ@mail.gmail.com>
In-Reply-To: <CAMeyCbhb2wV8-kmjaihjT3vQsFs-zzix77ztG7Z9E4VdEZOHOQ@mail.gmail.com>
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Sun, 25 Jun 2023 11:11:52 +0200
Message-ID: <CAMeyCbjWSJChDatzwTCKhW9iU=E_+=BLXAmpgR4DnFLJ7koh2Q@mail.gmail.com>
Subject: Re: mtd: raw: nand: gpmi-nand data corruption @ v5.10.184
To:     "han.xu" <han.xu@nxp.com>
Cc:     linux-mtd@lists.infradead.org, stable@vger.kernel.org,
        s.hauer@pengutronix.de, miquel.raynal@bootlin.com,
        tomasz.mon@camlingroup.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

Following to the initial discussion
https://lore.kernel.org/all/20220701110341.3094023-1-s.hauer@pengutronix.de
which caused the revert commit:
Are there any plans to fix this issue for 5.10.y (and maybe other
stable branches)?

Thanks in advance!

On Thu, Jun 22, 2023 at 6:46=E2=80=AFAM Kegl Rohit <keglrohit@gmail.com> wr=
ote:
>
> After reverting the revert :), the data corruption did not happen anymore=
!
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co=
mmit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=3Dcc5=
ee0e0eed0bec2b7cc1d0feb9405e884eace7d
>
> On Wed, Jun 21, 2023 at 7:55=E2=80=AFPM Kegl Rohit <keglrohit@gmail.com> =
wrote:
> >
> > ok, looking at the 5.10.184 gpmi-nand.c:
> >
> > #define BF_GPMI_TIMING1_BUSY_TIMEOUT(v) \
> > (((v) << BP_GPMI_TIMING1_BUSY_TIMEOUT) & BM_GPMI_TIMING1_BUSY_TIMEOUT)
> >
> > hw->timing1 =3D BF_GPMI_TIMING1_BUSY_TIMEOUT(busy_timeout_cycles * 4096=
);
> >
> > and then 5.19 (upstream patch source 0fddf9ad06fd9f439f1371398615566716=
73e31c)
> > https://github.com/gregkh/linux/commit/0fddf9ad06fd9f439f13713986155667=
1673e31c#diff-0dec2fa8640ea2067789c406ab1e42c9805d0d0fc9f70a3a29d17f9311e23=
ca2L893
> >
> > hw->timing1 =3D BF_GPMI_TIMING1_BUSY_TIMEOUT(DIV_ROUND_UP(busy_timeout_=
cycles,
> > 4096));
> >
> > could be the cause. DIV_ROUND_UP is most likely a division and
> > busy_timeout_cycles * 4096 a multiplication!
> >
> > The backport is wrong, because on the 5.10 kernel tree commit
> > cc5ee0e0eed0bec2b7cc1d0feb9405e884eace7d was reverted and on mainline
> > not.
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=3Dc=
c5ee0e0eed0bec2b7cc1d0feb9405e884eace7d
> >
> > =3D> now in 5.10.184 this line "hw->timing1 ..." is wrong!
> >
> >  I will test this tomorrow.
> >
> > On Wed, Jun 21, 2023 at 5:26=E2=80=AFPM han.xu <han.xu@nxp.com> wrote:
> > >
> > > On 23/06/21 04:27PM, Kegl Rohit wrote:
> > > > Hello!
> > > >
> > > > Using imx7d and rt stable kernel tree.
> > > >
> > > > After upgrading to v5.10.184-rt90 the rootfs ubifs mtd partition go=
t corrupted.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.=
git/tag/?h=3Dv5.10.184-rt90
> > > >
> > > > After reverting the latest patch
> > > > (e4e4b24b42e710db058cc2a79a7cf16bf02b4915), the rootfs partition di=
d
> > > > not get corrupted.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.=
git/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=
=3De4e4b24b42e710db058cc2a79a7cf16bf02b4915
> > > >
> > > > The commit message states the timeout calculation was changed.
> > > > Here are the calculated timeouts `busy_timeout_cycles` before (_old=
)
> > > > and after the patch (_new):
> > > >
> > > > [    0.491534] busy_timeout_cycles_old 4353
> > > > [    0.491604] busy_timeout_cycles_new 1424705
> > > > [    0.492300] nand: device found, Manufacturer ID: 0xc2, Chip ID: =
0xdc
> > > > [    0.492310] nand: Macronix MX30LF4G28AC
> > > > [    0.492316] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
> > > > 2048, OOB size: 112
> > > > [    0.492488] busy_timeout_cycles_old 4353
> > > > [    0.492493] busy_timeout_cycles_new 1424705
> > > > [    0.492863] busy_timeout_cycles_old 2510
> > > > [    0.492872] busy_timeout_cycles_new 350000
> > > >
> > > > The new timeouts are set a lot higher. Higher timeouts should not b=
e
> > > > an issue. Lower timeouts could be an issue.
> > > > But because of this high timeouts gpmi-nand is broken for us.
> > > >
> > > > For now we simple reverted the change.
> > > > The new calculations seem to be flaky, a previous "fix backport" wa=
s
> > > > already reverted because of data corruption.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.=
git/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=
=3Dcc5ee0e0eed0bec2b7cc1d0feb9405e884eace7d
> > > >
> > > > Any guesses why the high timeout causes issues?
> > >
> > > high timeout with wrong calculation may overflow and causes DEVICE_BU=
SY_TIMEOUT
> > > register turns to be 0.
> > >
> > > >
> > > >
> > > > Thanks in advance!
> > > >
> > > > ______________________________________________________
> > > > Linux MTD discussion mailing list
> > > > http://lists.infradead.org/mailman/listinfo/linux-mtd/
