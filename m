Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FA73DC91
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFZK40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 06:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjFZK4X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 06:56:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB2DAB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 03:56:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687776977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZi28DDhrUJI1TI9Jrces+xN70OiZ3EYHY7JE6yMZ/Y=;
        b=GTdM8x6422IbFo7ATwUSlSGJg3MdCr6+hixIs/bhF5k/JnlCSSIfeNQvRisz+8xWBamIBf
        HotvCUEr1uqAAVqyB2qWG0FSqVDsVufeeThqReP9voAJD6AOSZ6V1eJWTGRWrjoilV6eEf
        DTZC3r6kqzLSsCiGcTeX4MX897K5cMGIzrTTpIQejlifYoaRoJIS/c0Gd3Ka1T6p8J1xU/
        MX/3/Ze7E35/FRVexUTQxqqu6macbSUqNyJoFXqhhrT5J6izw02vuo34HSp3uluREbDL5u
        d+35wnACCLbquIQwl2G51P1qu5z2aYpLGzd0EU7tGgbstuB6kdGtd8EEDf6xFg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83593E0007;
        Mon, 26 Jun 2023 10:56:14 +0000 (UTC)
Date:   Mon, 26 Jun 2023 12:56:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kegl Rohit <keglrohit@gmail.com>
Cc:     "han.xu" <han.xu@nxp.com>, linux-mtd@lists.infradead.org,
        stable@vger.kernel.org, s.hauer@pengutronix.de,
        tomasz.mon@camlingroup.com, gregkh@linuxfoundation.org
Subject: Re: mtd: raw: nand: gpmi-nand data corruption @ v5.10.184
Message-ID: <20230626125612.608d3943@xps-13>
In-Reply-To: <CAMeyCbjWSJChDatzwTCKhW9iU=E_+=BLXAmpgR4DnFLJ7koh2Q@mail.gmail.com>
References: <CAMeyCbi16i4mdkOnqYhbW1tnqNwPwg2FVYqbdyhXt1fT10EaUw@mail.gmail.com>
        <20230621152556.qcjarclgbagkygdt@umbrella>
        <CAMeyCbgmiNTpV5_sbP3dq0TNJBBxcW8j0SRM+dxbjQXWAShDBg@mail.gmail.com>
        <CAMeyCbhb2wV8-kmjaihjT3vQsFs-zzix77ztG7Z9E4VdEZOHOQ@mail.gmail.com>
        <CAMeyCbjWSJChDatzwTCKhW9iU=E_+=BLXAmpgR4DnFLJ7koh2Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Kegl,

keglrohit@gmail.com wrote on Sun, 25 Jun 2023 11:11:52 +0200:

> Hello!
>=20
> Following to the initial discussion
> https://lore.kernel.org/all/20220701110341.3094023-1-s.hauer@pengutronix.=
de
> which caused the revert commit:
> Are there any plans to fix this issue for 5.10.y (and maybe other
> stable branches)?

If the fixes tags are right, all relevant branches which are still
maintained should see the final fix applied. If that's not the case, it
means the stable maintainers could not apply the patch as-is and let it
aside. You are pleased in this case to adapt the official patch to
the branch(es) of interest and send it to the stable team by mentioning
the upstream commit (see the documentation about how to ask for
backporting patches on stable branches).

Thanks,
Miqu=C3=A8l

>=20
> Thanks in advance!
>=20
> On Thu, Jun 22, 2023 at 6:46=E2=80=AFAM Kegl Rohit <keglrohit@gmail.com> =
wrote:
> >
> > After reverting the revert :), the data corruption did not happen anymo=
re!
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/=
commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=3Dc=
c5ee0e0eed0bec2b7cc1d0feb9405e884eace7d
> >
> > On Wed, Jun 21, 2023 at 7:55=E2=80=AFPM Kegl Rohit <keglrohit@gmail.com=
> wrote: =20
> > >
> > > ok, looking at the 5.10.184 gpmi-nand.c:
> > >
> > > #define BF_GPMI_TIMING1_BUSY_TIMEOUT(v) \
> > > (((v) << BP_GPMI_TIMING1_BUSY_TIMEOUT) & BM_GPMI_TIMING1_BUSY_TIMEOUT)
> > >
> > > hw->timing1 =3D BF_GPMI_TIMING1_BUSY_TIMEOUT(busy_timeout_cycles * 40=
96);
> > >
> > > and then 5.19 (upstream patch source 0fddf9ad06fd9f439f13713986155667=
1673e31c)
> > > https://github.com/gregkh/linux/commit/0fddf9ad06fd9f439f137139861556=
671673e31c#diff-0dec2fa8640ea2067789c406ab1e42c9805d0d0fc9f70a3a29d17f9311e=
23ca2L893
> > >
> > > hw->timing1 =3D BF_GPMI_TIMING1_BUSY_TIMEOUT(DIV_ROUND_UP(busy_timeou=
t_cycles,
> > > 4096));
> > >
> > > could be the cause. DIV_ROUND_UP is most likely a division and
> > > busy_timeout_cycles * 4096 a multiplication!
> > >
> > > The backport is wrong, because on the 5.10 kernel tree commit
> > > cc5ee0e0eed0bec2b7cc1d0feb9405e884eace7d was reverted and on mainline
> > > not.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.gi=
t/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&id=
=3Dcc5ee0e0eed0bec2b7cc1d0feb9405e884eace7d
> > > =20
> > > =3D> now in 5.10.184 this line "hw->timing1 ..." is wrong! =20
> > >
> > >  I will test this tomorrow.
> > >
> > > On Wed, Jun 21, 2023 at 5:26=E2=80=AFPM han.xu <han.xu@nxp.com> wrote=
: =20
> > > >
> > > > On 23/06/21 04:27PM, Kegl Rohit wrote: =20
> > > > > Hello!
> > > > >
> > > > > Using imx7d and rt stable kernel tree.
> > > > >
> > > > > After upgrading to v5.10.184-rt90 the rootfs ubifs mtd partition =
got corrupted.
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-r=
t.git/tag/?h=3Dv5.10.184-rt90
> > > > >
> > > > > After reverting the latest patch
> > > > > (e4e4b24b42e710db058cc2a79a7cf16bf02b4915), the rootfs partition =
did
> > > > > not get corrupted.
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-r=
t.git/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&=
id=3De4e4b24b42e710db058cc2a79a7cf16bf02b4915
> > > > >
> > > > > The commit message states the timeout calculation was changed.
> > > > > Here are the calculated timeouts `busy_timeout_cycles` before (_o=
ld)
> > > > > and after the patch (_new):
> > > > >
> > > > > [    0.491534] busy_timeout_cycles_old 4353
> > > > > [    0.491604] busy_timeout_cycles_new 1424705
> > > > > [    0.492300] nand: device found, Manufacturer ID: 0xc2, Chip ID=
: 0xdc
> > > > > [    0.492310] nand: Macronix MX30LF4G28AC
> > > > > [    0.492316] nand: 512 MiB, SLC, erase size: 128 KiB, page size:
> > > > > 2048, OOB size: 112
> > > > > [    0.492488] busy_timeout_cycles_old 4353
> > > > > [    0.492493] busy_timeout_cycles_new 1424705
> > > > > [    0.492863] busy_timeout_cycles_old 2510
> > > > > [    0.492872] busy_timeout_cycles_new 350000
> > > > >
> > > > > The new timeouts are set a lot higher. Higher timeouts should not=
 be
> > > > > an issue. Lower timeouts could be an issue.
> > > > > But because of this high timeouts gpmi-nand is broken for us.
> > > > >
> > > > > For now we simple reverted the change.
> > > > > The new calculations seem to be flaky, a previous "fix backport" =
was
> > > > > already reverted because of data corruption.
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-r=
t.git/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=3Dv5.10.184-rt90&=
id=3Dcc5ee0e0eed0bec2b7cc1d0feb9405e884eace7d
> > > > >
> > > > > Any guesses why the high timeout causes issues? =20
> > > >
> > > > high timeout with wrong calculation may overflow and causes DEVICE_=
BUSY_TIMEOUT
> > > > register turns to be 0.
> > > > =20
> > > > >
> > > > >
> > > > > Thanks in advance!
> > > > >
> > > > > ______________________________________________________
> > > > > Linux MTD discussion mailing list
> > > > > http://lists.infradead.org/mailman/listinfo/linux-mtd/ =20
