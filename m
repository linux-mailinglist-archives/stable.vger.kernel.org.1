Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40977AD06
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjHMVic (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMVic (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40568636CD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EC0C433C7;
        Sun, 13 Aug 2023 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962713;
        bh=sSTWRchjXAYWiknUjtPRtV8KpmFkWF6+TggGEWZ95hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bf10Ge5ngqnobkuZMZccVnqqeRqIttu+iUekdv098Ngvf3Rrqq1b9JdBngEQ9yqEI
         kMMZ+47iLFjDgo9IOPoG6RSIQ88FSM6A5AfwlCWBDFNKXWhA/5Q/GxxedE/lxdYp+T
         Ccj+BUMFv742PjunouSM9XYnLI9eHY/nX8piVttM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 128/149] btrfs: dont stop integrity writeback too early
Date:   Sun, 13 Aug 2023 23:19:33 +0200
Message-ID: <20230813211722.549824528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
@@ -3015,11 +3015,12 @@ retry:
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


