Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B47611A7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjGYKyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjGYKxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129D359C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF38C61680
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE3C433C7;
        Tue, 25 Jul 2023 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282313;
        bh=ukGA1Vff2vSyrYcpTgOyWEON3Kp/HGerFiKFo+6iV8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCIimUr1WQVvboClzuNss1IQ8JEOtl8Q+l5NPfXpWY4n+GlpYoUTHSVyMUS81u+M9
         6+cJ+qMGcoVnQh71uJfqIYXu8ZmxI7M4VYs1ShwR6Pcl47W3VTSpwzQVX4uMc1Maf4
         xtKOhJDLWoYlkUuRjSSvrDbTnLZx0+er4AGr7FQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com,
        Yogesh <yogi.kernel@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 084/227] [PATCH AUTOSEL 5.4 09/12] fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev
Date:   Tue, 25 Jul 2023 12:44:11 +0200
Message-ID: <20230725104518.234792129@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

[ Upstream commit 4e302336d5ca1767a06beee7596a72d3bdc8d983 ]

Syzkaller reported the following issue:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1965:6
index -84 is out of range for type 's8[341]' (aka 'signed char[341]')
CPU: 1 PID: 4995 Comm: syz-executor146 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 dbAllocDmapLev+0x3e5/0x430 fs/jfs/jfs_dmap.c:1965
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1809
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1350
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:874
 dtSplitUp fs/jfs/jfs_dtree.c:974 [inline]
 dtInsert+0xda7/0x6b00 fs/jfs/jfs_dtree.c:863
 jfs_create+0x7b6/0xbb0 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1f4e33f7e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc21129578 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1f4e33f7e9
RDX: 000000000000275a RSI: 0000000020000040 RDI: 00000000ffffff9c
RBP: 00007f1f4e2ff080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1f4e2ff110
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The bug occurs when the dbAllocDmapLev()function attempts to access
dp->tree.stree[leafidx + LEAFIND] while the leafidx value is negative.

To rectify this, the patch introduces a safeguard within the
dbAllocDmapLev() function. A check has been added to verify if leafidx is
negative. If it is, the function immediately returns an I/O error, preventing
any further execution that could potentially cause harm.

Tested via syzbot.

Reported-by: syzbot+853a6f4dfa3cf37d3aea@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
Signed-off-by: Yogesh <yogi.kernel@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1959,6 +1959,9 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
+
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */


