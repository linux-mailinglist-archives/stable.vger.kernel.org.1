Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8537B8575
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 18:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjJDQjW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJDQjV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 12:39:21 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 09:39:16 PDT
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAAD7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=8T0PGx2dNJlnTyxCzlVq4bOxn0w4Q9z3eZpQdiPzdRU=;
 b=G60Gta9gOZ/E3LGGrRm3EShbs4AV8X9tq3dH6Z+O5z2vbG5lIYIEZSoQE1RkFxmXWH0LdrILaUnK
   46u89YI1+bQ57txxV4T0bynE8rY4GNrlwC6IU9QjpWknLsvMjzhRoLJUne0OEYn84H0jOPqekKZj
   IB/TcWFDvljcNOgDpiRFciFzOdYMliaiDnI9tl8W787A6G0cYXWywO/ku+vCUBymGjBg7c93m7ig
   1QCKQOLlZ4/+9zsWzOy2EEq7+z6ILmE032yruVwTHUv5ONdmQjaBK2IEemtc/0WRNKbfw3vYVsj3
   IXFphRVOwl/y+C8nF8YGQRQYoryypFsUZIwJvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=8T0PGx2dNJlnTyxCzlVq4bOxn0w4Q9z3eZpQdiPzdRU=;
 b=N30DlDb52o7ps8zoqhHRYRQgz1K9YK3GEIAIb0DOJDifUhUN1dd9uRpFRsxDYonthnV/OhRlY8PQ
   Pgfre6sfotICob5A1gtyLkRUiPhbaG2v7Yd4+J6W/S7mCrTYGRd1PINx1Nw5QxR+xosEfv13opWX
   +qgarbJAtwINpxFXBf+2TIJg9ztn75cZ3MJtcSvkXPuSJ8N2Bakf8Gnft6HvvySXPQXEG5mA4x0P
   +TWQrQbe7peIbarusaT7ojsGJYBPV9uOG6BIvX0jHogK9Y5XbQrVM1mBQW/l4za3VljAyHxCrTjR
   RF2vBkf+zqwhlsqxyOoJZ6mE6/YbJPE68Xc30A==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230808 64bit (built Aug  8
 2023))
 with ESMTPS id <0S20002VBJCYDZ30@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for stable@vger.kernel.org; Wed, 04 Oct 2023 16:34:10 +0000 (GMT)
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
From:   August Wikerfors <git@augustwikerfors.se>
MIME-version: 1.0
Subject: Re: Patch
 "ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG" has been added
 to the 6.1-stable tree
Message-id: <B48DED01-5B50-4EF7-B0AC-2DC742D07890@augustwikerfors.se>
Date:   Wed, 4 Oct 2023 18:33:55 +0200
Cc:     broonie@kernel.org, stable-commits@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        regressions@lists.linux.dev
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Reporting-Meta: AAEHWQsg/CM5M6X2tVhNU4NXmxPo0N7v07ec6PufRpyTJI3MyRZ78LZwL2o/Wwp9
 FHmUjMf8uxnMCWG7lXdTqo7w80jiK9yzPzjGfivUx2LMb8jxKABeqpqNv/MZor2M
 1vfV018llLGbqwQNDM2y9Bqe0O6AGc+VPJ7opf2glA0FkmxPtJ4yofMrUX/Hj1dK
 t+GHwhllcqIMMkcFciFVsSVLDuFFm2x2HLH0kzN+kapjFaqGv7DUrAsjf3579Gn7
 Uj0rNW50QalW3kz1MFcIWU/v2UxBTX14sSeCq7g5Jk0AI1Eu2GqbHKEFIBWU8GPc
 /qpktqjUiLEp134i1zPqzlPc3MxKG4aJezh+4cfqnP5DKuDaBAsBUTk5CzONxnfX
 vioaq3MunEfKzTn18Pu8ahnv58o9RZG2ABNSEcfLL5EN65kmHoQkCEPHlHWiGbsI 1w==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

> On 4 Oct 2023, at 16:58, gregkh@linuxfoundation.org wrote:
>=20
> =EF=BB=BF
> This is a note to let you know that I've just added the patch titled
>=20
>  ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
>=20
> to the 6.1-stable tree which can be found at:
>  http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git;a=
=3Dsummary
>=20
> The filename of the patch is:
>   asoc-amd-yc-fix-non-functional-mic-on-lenovo-82qf-and-82ug.patch
> and it can be found in the queue-6.1 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
> =46rom 1263cc0f414d212129c0f1289b49b7df77f92084 Mon Sep 17 00:00:00 2001
> From: August Wikerfors <git@augustwikerfors.se>
> Date: Mon, 11 Sep 2023 23:34:09 +0200
> Subject: ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
>=20
> From: August Wikerfors <git@augustwikerfors.se>
>=20
> commit 1263cc0f414d212129c0f1289b49b7df77f92084 upstream.
>=20
> Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
> (Legion S7 16ARHA7) both need a quirk entry for the internal microphone to=

> function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on=

> Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",=

> breaking microphone functionality on these devices. Fix this by adding
> specific quirks for these models, as was done for the Lenovo 82TL.
>=20
> Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82=
SJ")
> Closes: https://github.com/tomsom/yoga-linux/issues/51
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D208555#c780
> Cc: stable@vger.kernel.org
> Signed-off-by: August Wikerfors <git@augustwikerfors.se>
> Link: https://lore.kernel.org/r/20230911213409.6106-1-git@augustwikerfors.=
se
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please also add commit cfff2a7794d2 ("ASoC: amd: yc: Fix a non-functional mi=
c on Lenovo 82TL") to 6.1+ as it fixed the same regression for another model=
 (but wasn=E2=80=99t tagged for stable).

Regards,
August Wikerfors=
