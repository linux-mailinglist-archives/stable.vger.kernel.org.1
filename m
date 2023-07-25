Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0AD76126C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjGYLCX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjGYLCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E4212B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10C461656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6412C433C8;
        Tue, 25 Jul 2023 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282748;
        bh=V2E1yaDRAtPOpjNM7WZILrb3OaP2T3zqvhU5ZmIAevQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFgVMER8HClh+ajnhj4IzpkN5hskh1aVbX4eQGwOJEUENVKz1pzIs8H576qFtflL7
         84n7Izu3ovhCMi8CXv5liSW1WtKnv+1XcxHAoctByteWCyB6v9Z8BQ2vR5DRizj7Dn
         q4WCLTZd+la2cpJAt0Rykhtm9tJPP33U0pu05NTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 013/183] btrfs: zoned: fix memory leak after finding block group with super blocks
Date:   Tue, 25 Jul 2023 12:44:01 +0200
Message-ID: <20230725104508.318395254@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit f1a07c2b4e2c473ec322b8b9ece071b8c88a3512 upstream.

At exclude_super_stripes(), if we happen to find a block group that has
super blocks mapped to it and we are on a zoned filesystem, we error out
as this is not supposed to happen, indicating either a bug or maybe some
memory corruption for example. However we are exiting the function without
freeing the memory allocated for the logical address of the super blocks.
Fix this by freeing the logical address.

Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1894,6 +1894,7 @@ static int exclude_super_stripes(struct
 
 		/* Shouldn't have super stripes in sequential zones */
 		if (zoned && nr) {
+			kfree(logical);
 			btrfs_err(fs_info,
 			"zoned: block group %llu must not contain super block",
 				  cache->start);


