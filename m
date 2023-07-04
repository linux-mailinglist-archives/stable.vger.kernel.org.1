Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8F746AA3
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGDH2S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGDH2R (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 03:28:17 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54BE6A;
        Tue,  4 Jul 2023 00:28:12 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 6ACD772DA50;
        Tue,  4 Jul 2023 09:28:03 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Tue, 04 Jul 2023 09:28:02 +0200
Message-ID: <2897789.e9J7NaK4W3@lichtvoll.de>
In-Reply-To: <11cacce5-8252-c65f-0d41-8d7ad1c17d91@gmail.com>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <d81af6e5bf77d106e02ed2d50e58f6edf2cfed31.camel@physik.fu-berlin.de>
 <11cacce5-8252-c65f-0d41-8d7ad1c17d91@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Michael Schmitz - 04.07.23, 07:58:13 CEST:
> > OK, so using "-1" as an end-of-disk partition marker is fine, but it
> > was just the partition size recorded in Christian's RDB that was
> > incorrect, correct?
> No, the partition size in the RDB was correct (valid, end cylinder
> before end of disk). The partition size seen by user space tools when
> running the old kernels was incorrect. That lead to the filesystem
> size exceeding the partition size, which only came to light once the
> overflow fixes had gone in.
> 
> I know it does sound like semantic sophism, but we have to be clear
> that what the user put in the partition block is definite. I haven't
> had much luck with heuristics in kernel code lately...

Now I finally get this issue, I think. Thanks for this explanation.

I think something like this would do good in the patch description.

Best,
-- 
Martin


