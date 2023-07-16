Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED58755452
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGPU3J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGPU3I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453CD3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A6760EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3EEC433C8;
        Sun, 16 Jul 2023 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539346;
        bh=cqySQXH39UEEVd+jB/HCVb8rs7KaLg8eqv6QL1OR6sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWkQFhS7nx/n/NGL3cH+rsg5Vv9JlBrC5z/pIv76CpC1EKK4V2VIgVBJOd3eTjEZZ
         2CrCVIFmejoAsGUhz2uvvlRyX/nii0wjMq7vGsm5AjRNFYEutCCVa5minnG2vfiwdl
         rWWOxB8RR9UXJRvZsKYC/RsM/CYp371LHuls+RZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>
Subject: [PATCH 6.4 775/800] md/raid1-10: fix casting from randomized structure in raid1_submit_write()
Date:   Sun, 16 Jul 2023 21:50:28 +0200
Message-ID: <20230716195007.150552042@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit b5a99602b74bbfa655be509c615181dd95b0719e upstream.

Following build error triggered while build with clang version 17.0.0
with W=1(this can't be reporduced with gcc 13.1.0):

drivers/md/raid1-10.c:117:25: error: casting from randomized structure
pointer type 'struct block_device *' to 'struct md_rdev *'
     117 |         struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
         |                                ^

Fix this by casting 'bio->bi_bdev' to 'void *', as it used to be.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306142042.fmjfmTF8-lkp@intel.com/
Fixes: 8295efbe68c0 ("md/raid1-10: factor out a helper to submit normal write")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230616012136.3047071-1-yukuai1@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid1-10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -113,7 +113,7 @@ static void md_bio_reset_resync_pages(st
 
 static inline void raid1_submit_write(struct bio *bio)
 {
-	struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
+	struct md_rdev *rdev = (void *)bio->bi_bdev;
 
 	bio->bi_next = NULL;
 	bio_set_dev(bio, rdev->bdev);


