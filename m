Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550E726C25
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFGUbD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjFGUav (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148A1721
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 737FB644E3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8477EC433D2;
        Wed,  7 Jun 2023 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169849;
        bh=l9k4Ba504JrgNcKDbap2cFVJnlwBTOvIBPAi0WF8Q9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+MNaF+wBjtiRw6PbiiVu+nJ+kqCl61U7/fuMMO6Aq4jbyZ+tBinzmkfIsqlbRC6R
         WLoHeWhhKb4HU7KRh7YAXBExwTl9kNF7PKb/5SC3DvfOxFZKkrv15AVOWUodXT8dhv
         55VOpnr6b233kyoj1R9kctXZOZsGds73jmixcvG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 238/286] btrfs: call btrfs_orig_bbio_end_io in btrfs_end_bio_work
Date:   Wed,  7 Jun 2023 22:15:37 +0200
Message-ID: <20230607200931.070368575@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 45c2f36871955b51b4ce083c447388d8c72d6b91 ]

When I implemented the storage layer bio splitting, I was under the
assumption that we'll never split metadata bios.  But Qu reminded me that
this can actually happen with very old file systems with unaligned
metadata chunks and RAID0.

I still haven't seen such a case in practice, but we better handled this
case, especially as it is fairly easily to do not calling the ->end_іo
method directly in btrfs_end_io_work, and using the proper
btrfs_orig_bbio_end_io helper instead.

In addition to the old file system with unaligned metadata chunks case
documented in the commit log, the combination of the new scrub code
with Johannes pending raid-stripe-tree also triggers this case.  We
spent some time debugging it and found that this patch solves
the problem.

Fixes: 103c19723c80 ("btrfs: split the bio submission path into a separate file")
CC: stable@vger.kernel.org # 6.3+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 726592868e9c5..ada899613486a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -307,7 +307,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 
 	/* Metadata reads are checked and repaired by the submitter. */
 	if (bbio->bio.bi_opf & REQ_META)
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 	else
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 }
-- 
2.39.2



