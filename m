Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A0703B27
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbjEOSAY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242980AbjEOR7k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0201183E0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F0A62F96
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7314CC433EF;
        Mon, 15 May 2023 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173079;
        bh=seTo6rnEzJEEbRaLBCkp5NrQZJTES0E23T48C1mA0gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ce7McnXdrj7wH1CwTHkap7j2UrGO2MrUYJOfEL6YMMVYVyYnVQuNPRa36/rboJVem
         h2ruv+N2czjL1kDITjiScdgVpK3Y6JQEjBUXjuiLrkw6ZK8k76iOLRdkfvhwlHteQd
         2V5nZlHlYkQu5o8wuo3+sJ7QnLH1YSAGNyqBSYgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com,
        Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 361/381] ext4: check iomap type only if ext4_iomap_begin() does not fail
Date:   Mon, 15 May 2023 18:30:12 +0200
Message-Id: <20230515161753.213155606@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

commit fa83c34e3e56b3c672af38059e066242655271b1 upstream.

When ext4_iomap_overwrite_begin() calls ext4_iomap_begin() map blocks may
fail for some reason (e.g. memory allocation failure, bare disk write), and
later because "iomap->type ! = IOMAP_MAPPED" triggers WARN_ON(). When ext4
iomap_begin() returns an error, it is normal that the type of iomap->type
may not match the expectation. Therefore, we only determine if iomap->type
is as expected when ext4_iomap_begin() is executed successfully.

Cc: stable@kernel.org
Reported-by: syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/00000000000015760b05f9b4eee9@google.com
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230505132429.714648-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3564,7 +3564,7 @@ static int ext4_iomap_overwrite_begin(st
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 


