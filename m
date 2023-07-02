Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD0744C9A
	for <lists+stable@lfdr.de>; Sun,  2 Jul 2023 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGBIF4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Sun, 2 Jul 2023 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBIFz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 04:05:55 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 01:05:55 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDAE4D
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 01:05:54 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 669AD72A8CE;
        Sun,  2 Jul 2023 09:55:55 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 02 Jul 2023 09:55:54 +0200
Message-ID: <1885875.tdWV9SEqCh@lichtvoll.de>
In-Reply-To: <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
 <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Christian Zigotzky - 02.07.23, 06:37:50 CEST:
> On 02 July 2023 at 04:17 am, Michael Schmitz wrote:
> >  I'm sorry to say I cannot see a new RDB partition bug her, just the
> > result of undefined behaviour due to overflowing a 32 bit nr_sect
> > size calculation in the old RDB code.
[…]
> Thanks a lot for your explanation!
> 
> Actually, we need your patch because there is a very old bug but there
> are some endusers with RDB disks with Linux partitions. If I apply
> your patch to our kernels, then I need an enduser friendly solution
> for fixing the issue with their file systems.

I have read through the last mails without commenting. I admit: I do not 
yet get what is wrong here? A checksum was miscalculated? Is this a 
regular thing to happen when using RDB disks with Linux partitions?

I do not yet get how this issue happens. What are the steps to reproduce 
it? And how likely is it to run into it?

> Do you have a solution for the enduser (consumer)? How can they fix
> their file systems? The next issue is, if an enduser uses an old
> unpatched kernel with a partition, created with a new patched kernel.
> I don't know how can I handle this issue in the consumer support.
> 
> I can't help all endusers and some are not active in forums etc.

How many end users are you speaking of?

Back then I thought I was the only one using a hard disk with mixed 
Amiga/Linux RDB setup.

Best,
-- 
Martin


