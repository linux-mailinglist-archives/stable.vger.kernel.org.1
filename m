Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B66F98A1
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEGNXN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjEGNXN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272616344
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC8560F00
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE055C433D2;
        Sun,  7 May 2023 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683465791;
        bh=rqDqMcCvcw7nhHZJHIEP8oEF36HFOGpuIzPMiSNzITg=;
        h=Subject:To:Cc:From:Date:From;
        b=zoDlcOZWOmLnWvj60Z5wBJxLs9VtN9XctmAEqybqpx++7HFnv1esqGDY67JcJDTDd
         dOTMPra7ItR65G/iq3iL1BQ0s+YJCcb6hOm9B0AeLkxzAzVdr1OlJt/steSZ3Rd42X
         ayofRZj2q8Y5LI+fRLTQpIsCrPHASOHdybuaPqrA=
Subject: FAILED: patch "[PATCH] dm verity: fix error handling for check_at_most_once on FEC" failed to apply to 4.19-stable tree
To:     youngjin.gil@samsung.com, sj1557.seo@samsung.com,
        snitzer@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:23:08 +0200
Message-ID: <2023050708-verdict-proton-a5f0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e8c5d45f82ce0c238a4817739892fe8897a3dcc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050708-verdict-proton-a5f0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e8c5d45f82ce ("dm verity: fix error handling for check_at_most_once on FEC")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8c5d45f82ce0c238a4817739892fe8897a3dcc3 Mon Sep 17 00:00:00 2001
From: Yeongjin Gil <youngjin.gil@samsung.com>
Date: Mon, 20 Mar 2023 15:59:32 +0900
Subject: [PATCH] dm verity: fix error handling for check_at_most_once on FEC

In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
directly. But if FEC configured, it is desired to correct the data page
through verity_verify_io. And the return value will be converted to
blk_status and passed to verity_finish_io().

BTW, when a bit is set in v->validated_blocks, verity_verify_io() skips
verification regardless of I/O error for the corresponding bio. In this
case, the I/O error could not be returned properly, and as a result,
there is a problem that abnormal data could be read for the
corresponding block.

To fix this problem, when an I/O error occurs, do not skip verification
even if the bit related is set in v->validated_blocks.

Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
Cc: stable@vger.kernel.org
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index ade83ef3b439..9316399b920e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -523,7 +523,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, iter);
 			continue;

