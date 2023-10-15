Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458B7C9C07
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOVzp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVzo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 17:55:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75052AD
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 14:55:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so5780a12.1
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697406941; x=1698011741; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMeo/GWII06uBBsg8+k6+SsZErZW3w1ij7yjTrmocF0=;
        b=VahPtpw5imK/B+sNNp52mpFQ033w5oufgcJfj25VnUb7mHRiMLjHasI1MziRc8u4H1
         2Gv4qXBuUrT0LNuxkRT+0oCRFS06B3MbGExvQ/hruaI4T2o2YXvCNocY98o83ria/wjt
         aC2YCqeraxngWsLFJEetZxP61f3mIELI2QnLBoh2iPaeKe3x68Olw1PS1LpsVAlEmVrr
         PkSh3lXfFAozlYTYcMfbfhBSFySUVuHA6iRXUFY9+PhVDHAPWCSafnd2wVWzu/WqMvmp
         NNxlWrml3YARWPDKYas1yW8mu0fCzDnNCVdDMys+5JF2l87xXYunTquqDLvh2DH3QYMR
         qChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697406941; x=1698011741;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMeo/GWII06uBBsg8+k6+SsZErZW3w1ij7yjTrmocF0=;
        b=I7WYxc/BAG+TyHFEVoO32Vuldj/jV9Wul/Lwb9fiYWfTFc5P7Blul5rzcjcFuG/Sj1
         kCCG7eYTc01Izg2iMzfjKybt3gUDkiaL4th2Udf1fSO1deIqwSYcR/qFJVjvwssQfQ7I
         iAyLNPmCK8iSTjybpToeQpfrUkknE7zepAgf+Csawgi//cv+Cb3yftY/dQJiACkc62Bs
         G5DB/z6TPX9cvDTMXGT/JoGGmYxWsdjmOgmUQNTQU5tlbJwOikUoF9VISJfgxL7PiQHF
         ydlrGosKDzhJDe2QD+cJbUZoFJ+MSiIvYBdbiMv879mocruJj8aOsEgVeIK1ja7gqeUY
         ux8g==
X-Gm-Message-State: AOJu0YwXxQjooLu5D+VRE31vAY3pEEDUSKpR5fzpLIcd1EIZwsabLCO9
        z9lgm+HT8odo8YBVbF+fXFUEU0bDb9m2O2fbqPo9PRT3WgcAk5PHp89Hhw==
X-Google-Smtp-Source: AGHT+IFKvVPrHmt+gHHcQ/YZR+S6tLQflliBgWaPVoFHsA92QWo+eEahVJczMR20JrMD4v8/KoZ5/s9O6qYreQ9Py/0=
X-Received: by 2002:a50:d781:0:b0:53d:a40e:bed1 with SMTP id
 w1-20020a50d781000000b0053da40ebed1mr102437edi.3.1697406941247; Sun, 15 Oct
 2023 14:55:41 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Sun, 15 Oct 2023 14:55:29 -0700
Message-ID: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
Subject: USB_NET_AX8817X dependency on AX88796B_PHY
To:     stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I've received reports that an ethernet usb dongle doesn't work (google
internal bug 304028301)...

Investigation shows that we have 5.10 (GKI) with USB_NET_AX8817X=y and
AX88796B_PHY not set.
I *think* this configuration combination makes no sense?
[note: I'm unsure how many different phy's this driver supports...]

Obviously, we could simply turn it on 'manually'... but:

commit dde25846925765a88df8964080098174495c1f10
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Mon Jun 7 10:27:22 2021 +0200

    net: usb/phy: asix: add support for ax88772A/C PHYs

    Add support for build-in x88772A/C PHYs

    Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>

includes (as a side effect):

drivers/net/usb/Kconfig
@@ -164,6 +164,7 @@ config USB_NET_AX8817X
        depends on USB_USBNET
        select CRC32
        select PHYLIB
+       select AX88796B_PHY
        default y

which presumably makes this (particular problem) a non issue on 5.15+

I'm guessing the above fix (ie. commit dde25846925765a88df8964080098174495c1f10)
could (should?) simply be backported to older stable kernels?

I've verified it cherrypicks cleanly and builds (on x86_64 5.10 gki),
ie.
$ git checkout android/kernel/common/android13-5.10
$ git cherry-pick -x dde25846925765a88df8964080098174495c1f10
$ make ARCH=x86_64 gki_defconfig
$ egrep -i ax88796b < .config
CONFIG_AX88796B_PHY=y
$ make -j50
./drivers/net/phy/ax88796b.o gets built

I've sourced a copy of the problematic hardware, but I'm hitting
problems where on at least two (both my chromebook and 1 of the 2
usb-c ports on my lenovo laptop) totally different usb
controllers/ports it doesn't even usb enumerate (ie. nothing in dmesg,
no show on lsusb), which is making testing difficult (unsure if I just
got a bad sample)...

- Maciej
