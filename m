Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952577AD20
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHMVsI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHMVps (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B212D55
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB1AB60B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482AC433C7;
        Sun, 13 Aug 2023 21:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963146;
        bh=yVtBtjc2/Gl6vXzQkj3ss8qaL8gSWhhXI5GBJvIeEc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAXTyhZ460XxRbDKntD8+rlNccLn3NO6wLp4G54jCxzKcLGw9lHVyje/PnOgXHB7K
         vdB/I0ucEO6v+R1kvsN+jmqW+mufX4MLpnWI7GNwtxZcSzo5FKFAO/D7daDS5o+ZPy
         B6BaKarP2c///TOAHYhBG6Ee6cvsL6VyZdDBjoiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 70/89] btrfs: dont stop integrity writeback too early
Date:   Sun, 13 Aug 2023 23:20:01 +0200
Message-ID: <20230813211712.875974424@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit effa24f689ce0948f68c754991a445a8d697d3a8 upstream.

extent_write_cache_pages stops writing pages as soon as nr_to_write hits
zero.  That is the right thing for opportunistic writeback, but incorrect
for data integrity writeback, which needs to ensure that no dirty pages
are left in the range.  Thus only stop the writeback for WB_SYNC_NONE
if nr_to_write hits 0.

This is a port of write_cache_pages changes in commit 05fe478dd04e
("mm: write_cache_pages integrity fix").

Note that I've only trigger the problem with other changes to the btrfs
writeback code, but this condition seems worthwhile fixing anyway.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
[ updated comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4844,11 +4844,12 @@ retry:
 			}
 
 			/*
-			 * the filesystem may choose to bump up nr_to_write.
+			 * The filesystem may choose to bump up nr_to_write.
 			 * We have to make sure to honor the new nr_to_write
-			 * at any time
+			 * at any time.
 			 */
-			nr_to_write_done = wbc->nr_to_write <= 0;
+			nr_to_write_done = (wbc->sync_mode == WB_SYNC_NONE &&
+					    wbc->nr_to_write <= 0);
 		}
 		pagevec_release(&pvec);
 		cond_resched();


