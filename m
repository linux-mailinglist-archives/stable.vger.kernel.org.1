Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF0713277
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjE0EIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 00:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjE0EIW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 00:08:22 -0400
X-Greylist: delayed 32874 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 21:08:14 PDT
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D513D
        for <stable@vger.kernel.org>; Fri, 26 May 2023 21:08:13 -0700 (PDT)
Date:   Sat, 27 May 2023 04:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=jszrlxa4gzh5bnhkd22xh7nmpi.protonmail; t=1685160491; x=1685419691;
        bh=xmCBZKa3oW/2MDrSFjMmMw1tLSxZ4M52/i7LPIG8qlY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eAxamXziwf1i2MmtvkA3Y+EBp9goOjRkfFNG7Io8CN16Ak2ZAr7YY55QliuEU9+nl
         auc7vbfWAoFKxXrKhWaVts6xa/2UJm9KETSMYDAmd6PNGA8OH8U6G57XdEr4ZHLxNh
         tDlx6bcQr1qw37hIMQo+t+OC7wXQXRVRi1nxsvAJ/QxvGwWACxTtKROj6DZCjw+U9J
         g15RWUl7Y0VOEAL3LBbVJMj97Tih4fCyL62uUHuSDCULg2B7th97JilMF8b8pq4b7d
         WpVgxhxJQwScJwk1nyjnEHtEjiC2/sJf0Ma5R3okXBG1MwlEwTPvpAwyP6RDHwHdh1
         E36a8gy2dPrQw==
To:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Message-ID: <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
In-Reply-To: <ZHFaFosKY24-L7tQ@debian.me>
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me> <ZHFaFosKY24-L7tQ@debian.me>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

>Where is SCSI info?

Right there, under the text (It was so short, that I thought to put it in t=
he message. Maybe I should have put that also in pastebin for consistency a=
nd clarity):

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: ATA      Model: KINGSTON SVP200S Rev: C4
Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
Vendor: hp       Model: CDDVDW TS-L633M  Rev: 0301
Type:   CD-ROM                           ANSI  SCSI revision: 05

>I think networking changes shouldn't cause this ACPI regression, right?
Yeah, beats me, but that's what I got by bisecting. My expertise ends about=
 here.
