Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C393755706
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjGPU4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGPU4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9650E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4727060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55322C433C9;
        Sun, 16 Jul 2023 20:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540985;
        bh=RCYAsltuHJui4rgkb4cVJaFY4XqvAe5byByXsawD33Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJFIhNRhd3LyhlH0JvhSu/32ehmahacErKxh8vkG+aNa1MXYDaAUr+GshrFVMY7Ne
         UrOnlOkw+t/DncihcVFCicVllWpgjPHJ7sKgyv/5j7kDEEEe07F7e6WhMEHD3Jpkv1
         j81TScFQS9ZRncy3SM9i6HPI7EYK4vFqUEf8UPXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 559/591] btrfs: reinsert BGs failed to reclaim
Date:   Sun, 16 Jul 2023 21:51:38 +0200
Message-ID: <20230716194938.318680723@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Naohiro Aota <naota@elisp.net>

commit 7e27180994383b7c741ad87749db01e4989a02ba upstream.

The reclaim process can temporarily fail. For example, if the space is
getting tight, it fails to make the block group read-only. If there are no
further writes on that block group, the block group will never get back to
the reclaim list, and the BG never gets reclaimed. In a certain workload,
we can leave many such block groups never reclaimed.

So, let's get it back to the list and give it a chance to be reclaimed.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1642,6 +1642,8 @@ void btrfs_reclaim_bgs_work(struct work_
 		}
 
 next:
+		if (ret)
+			btrfs_mark_bg_to_reclaim(bg);
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);


