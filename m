Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02171761712
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGYLpA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGYLoq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADB7E3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345B861654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CEBC433C9;
        Tue, 25 Jul 2023 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285484;
        bh=JOBqvreBkPZZXH+UM3zMwnm/bxLFSOdZi/7lCzFrSYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=at6BL+QPOsw9ZegNr/aoDTpQCRXXcErlb5Ca8LlwJzXYOieFW/G1LR31U4U77+Atd
         xG92fMzcc3MLH6HF1oxI8Zcx+9mNQYJlBmboByDofe4YIDeKnFBeFkVNmABcmpOoLP
         9lmTup6vXKkYvjrD5M8KijmKX/lt9r7UACZ8kdnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 192/313] block/partition: fix signedness issue for Amiga partitions
Date:   Tue, 25 Jul 2023 12:45:45 +0200
Message-ID: <20230725104529.301759612@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michael Schmitz <schmitzmic@gmail.com>

commit 7eb1e47696aa231b1a567846bbe3a1e1befe1854 upstream.

Making 'blk' sector_t (i.e. 64 bit if LBD support is active) fails the
'blk>0' test in the partition block loop if a value of (signed int) -1 is
used to mark the end of the partition block list.

Explicitly cast 'blk' to signed int to allow use of -1 to terminate the
partition block linked list.

Fixes: b6f3f28f604b ("block: add overflow checks for Amiga partition support")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Martin Steigerwald <martin@lichtvoll.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partitions/amiga.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -93,7 +93,7 @@ int amiga_partition(struct parsed_partit
 	}
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
-	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
+	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
 		/* Read in terms partition table understands */
 		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
 			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",


