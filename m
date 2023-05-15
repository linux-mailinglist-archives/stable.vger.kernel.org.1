Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918BB703871
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbjEORcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbjEORcS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0151163D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C71F62CF9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB49C433D2;
        Mon, 15 May 2023 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171748;
        bh=S1OI2djbRaB9GKqHShLKh3z1Ci1kMER4m43qABQQ05Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzjiZ7GA7rdb3jTx2aG/X9hskD2PRPP/tSxfAOZf1oyVLb5XvOZ+wmCGHd6JGxWxE
         Y4UiYH9WARcLITbwbH7qJ+GhQhcIWI+2wjvce8G0K9GX7IiMIcZJaRnPXMCl6zkteB
         AS5M6k9JI5q6Nh5BSVd8+LSJBay5ORIgVcpSajzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 065/134] btrfs: zero the buffer before marking it dirty in btrfs_redirty_list_add
Date:   Mon, 15 May 2023 18:29:02 +0200
Message-Id: <20230515161705.326776083@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit c83b56d1dd87cf67492bb770c26d6f87aee70ed6 upstream.

btrfs_redirty_list_add zeroes the buffer data and sets the
EXTENT_BUFFER_NO_CHECK to make sure writeback is fine with a bogus
header.  But it does that after already marking the buffer dirty, which
means that writeback could already be looking at the buffer.

Switch the order of operations around so that the buffer is only marked
dirty when we're ready to write it.

Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1347,11 +1347,11 @@ void btrfs_redirty_list_add(struct btrfs
 	    !list_empty(&eb->release_list))
 		return;
 
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 	set_extent_buffer_dirty(eb);
 	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
 			       eb->start + eb->len - 1, EXTENT_DIRTY);
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
 
 	spin_lock(&trans->releasing_ebs_lock);
 	list_add_tail(&eb->release_list, &trans->releasing_ebs);


