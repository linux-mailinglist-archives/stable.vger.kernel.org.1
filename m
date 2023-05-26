Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94904712D26
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEZTRx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 15:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEZTRx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 15:17:53 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF631AC
        for <stable@vger.kernel.org>; Fri, 26 May 2023 12:17:45 -0700 (PDT)
Date:   Fri, 26 May 2023 19:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1685128663; x=1685387863;
        bh=ouyMl9M9cSUH2UQgqLg6lIvNByY/RpMzp93S8ww1rHE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=FxhNaYQpBAjre98qGOJ3mmZtroYCiKv8f3DO2T4iKe3MvTdlnT53Vd+Y6W5G4xvwo
         6taxXJBdxQsAm8NWopinu+v0IkMZu+Pd+q2ZyqS2FnN3gSaCinfIddWd/tIANJM6Z5
         Wc7F3LSKvYUb/hP6G45EOgeN/zFjPgz8BHI8hdhD3Rk/QTstyoiUyvnGYm5UBxj9zp
         qSLR/4Ef5Pmr+QxSpx4JFROApO5O3+5QvjySdpjqlCoDo7XiUDQ/Bwaa0IXWsLNkcQ
         xjPzmTS/uQwAY+/ll/osMETZgoty/h1f3b8/mqoFLW+YSdec8nGJvZ4sZVhPxyzNxU
         3HVWofPNcR39g==
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Sami Korkalainen <sami.korkalainen@proton.me>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
Message-ID: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
Feedback-ID: 45678890:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Linux 6.2 and newer are (mostly) unbootable on my old HP 6730b laptop, the =
6.1.30 works still fine.
The weirdest thing is that newer kernels (like 6.3.4 and 6.4-rc3) may boot =
ok on the first try, but when rebooting, the very same version doesn't boot=
.
      =20
Some times, when trying to boot, I get this message repeated forever:
ACPI Error: No handler or method for GPE [XX], disabling event (20221020/ev=
gpe-839)
On newer kernels, the date is 20230331 instead of 20221020. There is also s=
ome other error, but I can't read it as it gets overwritten by the other AC=
PI error, see image linked at the end.

And some times, the screen will just stay completely blank.

I tried booting with acpi=3Doff, but it does not help.
      =20
I bisected and this is the first bad commit 7e68dd7d07a2
"Merge tag 'net-next-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/=
netdev/net-next"
      =20
As the later kernels had the seemingly random booting behaviour (mentioned =
above), I retested the last good one 7c4a6309e27f by booting it several tim=
es and it boots every time.

I tried getting some boot logs, but the boot process does not go far enough=
 to make any logs.

Kernel .config file: https://0x0.st/Hqt1.txt
    =20
Environment (outputs of a working Linux 6.1 build):
Software (output of the ver_linux script): https://0x0.st/Hqte.txt
Processor information (from /proc/cpuinfo): https://0x0.st/Hqt2.txt
Module information (from /proc/modules): https://0x0.st/HqtL.txt
/proc/ioports: https://0x0.st/Hqt9.txt
/proc/iomem:   https://0x0.st/Hqtf.txt
PCI information ('lspci -vvv' as root): https://0x0.st/HqtO.txt
SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: ATA      Model: KINGSTON SVP200S Rev: C4
Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
Vendor: hp       Model: CDDVDW TS-L633M  Rev: 0301
Type:   CD-ROM                           ANSI  SCSI revision: 05
      =20
Distribution: Arch Linux
Boot manager: systemd-boot (UEFI)

git bisect log: https://0x0.st/Hqgx.txt
ACPI Error (sorry for the dusty screen): https://0x0.st/HqEk.jpeg

#regzbot ^introduced 7e68dd7d07a2

Best regards
Sami Korkalainen 
