Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD8755111
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGPTfv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGPTfu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:35:50 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 12:35:49 PDT
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D39E1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=hhYQHeWeU3tWLwkcoWUkS7C8RqLLTN6gdAl5d6RHOsD6mFDYNN8KTBTyAWR1eU5dwokmiavsFfW3
   vaVh+c1pvIKb0/s449uLlfHT75ASed294nTe6MVD72MtEHaIUizStnmLW2MMRLDGQaOOYbTZRfdx
   4TG6s9sGdM1hM7dXn/dvWh0YijIczoFWwn+0CR0uRS5EsoUOBGipTodMsYTCzc4OXH1UeQSSspC/
   gL57Z5mEtHYUIjERn1ZS7VYl6DQUgwMoM94eezODEqvOMNDYxRjbPt/BK+qPiZNXd2ZCL8D/MCJz
   tGab/fg6WDylUfGRsWgR1YD0Ns8z2bMUR9lz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=1X2J9Yn20F/BEmGq9y/x0FBrrb96P1AoI6JRoNuLx48=;
 b=MTAHRUN67jyzpHcQ1EHcYebCrL+Zrea6rPHGTQrZrZydIfK3QTKJUkEdwF/jYpwcsSLEzv4ndYAy
   oNGWRfebaxV6iVN23mJ2mWABO6rDERU7zT81tw7cEHeVILT0oqndir+WvHhjf25x9rzdqd0FYMe0
   oR/PUQlQ7NRn6jcXvDR6MuPaC8PYjMHGsU79z+go/9wHjSqf0ku2vqKsDXTQXG9A8B45KrinkjVt
   aTmxrs0AnN21QifSEZfaH58rgBxE7PbDE6Ycp8ifPWiF5r7oCFuAliujU1ivrOT2xH8XWwV6CK9/
   BOCgtNbV7xdiyA/SnSWn6kQIB2wROYijXjCZLg==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RXW009O2M78R1D0@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for stable@vger.kernel.org; Sun, 16 Jul 2023 19:30:44 +0000 (GMT)
Message-id: <0206e2ce-ff33-6017-15ab-cc89f1eb7485@augustwikerfors.se>
Date:   Sun, 16 Jul 2023 21:30:41 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
To:     Nils Kruse <nilskruse97@gmail.com>
Cc:     stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-language: en-US
In-reply-to: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEqHmCrKsOnH195OEdwrfg9FTxZzACbRkpk03nDz2o7ewDk7A9Vjq6UenQjGOdN
 kAaYT+day+D9LnofH23zmNDd3QZ5lX8jc6r3qUXZ6ySVXD/J0XFfaS/xyGB21swF
 KB/Qn5xSXzPvekOFXBEa/z1APrL5Oqn7gz8E3cqwTMdzmQuxHPruj+m4j8yN7dPC
 pnJvaTFCAptzzSI3ic1Uo/U7oXybGWoZXcb/9Po3ZTq+EEIMdBm723wEA/S0qxw6
 lcPst2QBkG2eqp4f9T3ARjsL2gCKKXopQZ9xl2ggPqdHLDlyDBId/iaheQyBKZSy
 bbUQ01/zk9b5O0HIUlv9YUkVKA6ZRo9NadBU5/OYpNPnXC9NG4Ex2ykHIKmiCk5r
 YSxq/mz+Es1mL0VLo8GsE1eWl+GLK34QinEuajla1Y3HPKmlKZmL4QbjGkTYMcOF AA==
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-06-11 13:41, Nils Kruse wrote:
> Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids 
> for disk.

Is this the same issue with suspend as [1], [2] and [3] or is it a
different case?

[1] https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
[2] https://github.com/tomsom/yoga-linux/issues/9
[3] https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/
