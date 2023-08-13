Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D577ADB3
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjHMVw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHMVua (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D21997
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C653063F09
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD7C433C8;
        Sun, 13 Aug 2023 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963313;
        bh=wu5YlgdflatvhWqqwHRrh3+ChpzUqewkexHXrF5pZy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdPjdreWZ4sKjxvIxKqY2/2LYaR/mDtt4gFz6tcURtPBP/6E9AKD2NARG7gFtY9e6
         TJB7o7rPYRkaPOdVFTJGtYQIDhgNddHWSMBD6URGb1/4NEkJlg2ixbSbiQietMlPsx
         41ZcxULEoSSiDEjsh8b4Uq5hRkFOEmlQqJ1JWqSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 29/39] btrfs: set cache_block_group_error if we find an error
Date:   Sun, 13 Aug 2023 23:20:20 +0200
Message-ID: <20230813211705.801302111@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

commit 92fb94b69c6accf1e49fff699640fa0ce03dc910 upstream.

We set cache_block_group_error if btrfs_cache_block_group() returns an
error, this is because we could end up not finding space to allocate and
mistakenly return -ENOSPC, and which could then abort the transaction
with the incorrect errno, and in the case of ENOSPC result in a
WARN_ON() that will trip up tests like generic/475.

However there's the case where multiple threads can be racing, one
thread gets the proper error, and the other thread doesn't actually call
btrfs_cache_block_group(), it instead sees ->cached ==
BTRFS_CACHE_ERROR.  Again the result is the same, we fail to allocate
our space and return -ENOSPC.  Instead we need to set
cache_block_group_error to -EIO in this case to make sure that if we do
not make our allocation we get the appropriate error returned back to
the caller.

CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3989,8 +3989,11 @@ have_block_group:
 			ret = 0;
 		}
 
-		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
+		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			if (!cache_block_group_error)
+				cache_block_group_error = -EIO;
 			goto loop;
+		}
 
 		/*
 		 * Ok we want to try and use the cluster allocator, so


