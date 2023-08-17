Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81477F34C
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349618AbjHQJao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349620AbjHQJaX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 05:30:23 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 02:30:20 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F002D61
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 02:30:20 -0700 (PDT)
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Thu, 17 Aug 2023 11:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1692264150; bh=Mo5Ei4R9H2Ue8pYI5YtYwz+ROB9jat+95RQMycPkH/g=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=Zsv+kCeWMhAwVv3a6TMZctxs12lWiS9K7ifyGvPNNQpMSpgrfyovCUtoiagA9hI8k
         iWftEQ1eba2vahne61Q5UPjbKGjeVZIzVpT9qSkv5FkHsLw1055ia4x5J9a6EQkOkX
         m0L8J6YbaRrZGOg8Fj5pRel9rJkKDhnwM/ehh1Hw=
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: proc_lseek backport request
From:   t.martitz@avm.de
To:     stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 17 Aug 2023 11:22:30 +0200
Message-ID: <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
X-Mailer: Lotus Domino Web Server Release 12.0.2FP2 July 12, 2023
X-MIMETrack: Serialize by http on ANIS1/AVM(Release 12.0.2FP2|July 12, 2023) at
 17.08.2023 11:22:30,
        Serialize complete at 17.08.2023 11:22:30,
        Serialize by Router on ANIS1/AVM(Release 12.0.2FP2|July 12, 2023) at
 17.08.2023 11:22:30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 149429::1692264150-2E41C28E-C98C1539/0/0
X-purgate-type: clean
X-purgate-size: 1503
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear stable team,

I'm asking that=20

commit 3f61631d47f1 ("take care to handle NULL ->proc=5Flseek()")

gets backported to the stable and LTS kernels down to 5.10.

Background:
We are in the process of upgrading our kernels. One target kernel
is based on 5.15 LTS.

Here we found that, if proc file drivers do not implement proc=5Flseek,
user space crashes easily, because various library routines internally
perform lseek(2). The crash happens in proc=5Freg=5Fllseek, where it
wants to jump to a NULL pointer.

We could, arguably, fix these drivers to use ".proc=5Flseek =3D no=5Fllseek=
".
But this doesn't seem like a worthwhile path forward, considering that
latest Linux kernels (including 6.1 LTS) allow proc=5Flseek =3D=3D NULL aga=
in=20
and *remove* no=5Flseek. Essentially, on HEAD, it's best practice to leave =

proc=5Flseek =3D=3D NULL.
Therefore, I ask that the above procfs fix gets backported so that our
drivers can work across all kernel versions, including latest 6.x.

I checked that this commit applies and works as expected on a board that
runs Linux 5.15, and the observed crash goes away.

Furthermore, I investigated that the fix applies to older LTS kernels, down
to 5.10. The lseek(2) path uses vfs=5Fllseek() which checks for FMODE=5FLSE=
EK. This
has been like that forever since the initial git import. However, 5.4 LTS a=
nd=20
older kernels do not have "struct proc=5Fops".

Thank you in advance.

Best regards,
Thomas Martitz
