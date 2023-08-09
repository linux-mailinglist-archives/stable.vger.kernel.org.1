Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D90775987
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHILBT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjHILBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7332FED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F4562496
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22410C433C8;
        Wed,  9 Aug 2023 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578877;
        bh=34IZI6J+9VCtP2DJwMSfurinIzc9SPD1ACQoE9wPedw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kz81zBBVGgPAO9DGykUupr54k57J7x0a+c1DSy+6Rso5nPsP4zTXUdD3dbOpBpbK5
         eZdNXVtOVsBVBWS6ykGbBJj9oY/pRlnYKnpJtw1N10pmAYqbtEqlJgTa3Wp3gN8K0O
         lOnNFyccGKmHHCn7J2Ebdko3WSryCr/Jkv8jj28Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, gaoming <gaoming20@hihonor.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15 60/92] exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree
Date:   Wed,  9 Aug 2023 12:41:36 +0200
Message-ID: <20230809103635.663586380@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: gaoming <gaoming20@hihonor.com>

commit daf60d6cca26e50d65dac374db92e58de745ad26 upstream.

The call stack shown below is a scenario in the Linux 4.19 kernel.
Allocating memory failed where exfat fs use kmalloc_array due to
system memory fragmentation, while the u-disk was inserted without
recognition.
Devices such as u-disk using the exfat file system are pluggable and
may be insert into the system at any time.
However, long-term running systems cannot guarantee the continuity of
physical memory. Therefore, it's necessary to address this issue.

Binder:2632_6: page allocation failure: order:4,
 mode:0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Call trace:
[242178.097582]  dump_backtrace+0x0/0x4
[242178.097589]  dump_stack+0xf4/0x134
[242178.097598]  warn_alloc+0xd8/0x144
[242178.097603]  __alloc_pages_nodemask+0x1364/0x1384
[242178.097608]  kmalloc_order+0x2c/0x510
[242178.097612]  kmalloc_order_trace+0x40/0x16c
[242178.097618]  __kmalloc+0x360/0x408
[242178.097624]  load_alloc_bitmap+0x160/0x284
[242178.097628]  exfat_fill_super+0xa3c/0xe7c
[242178.097635]  mount_bdev+0x2e8/0x3a0
[242178.097638]  exfat_fs_mount+0x40/0x50
[242178.097643]  mount_fs+0x138/0x2e8
[242178.097649]  vfs_kern_mount+0x90/0x270
[242178.097655]  do_mount+0x798/0x173c
[242178.097659]  ksys_mount+0x114/0x1ac
[242178.097665]  __arm64_sys_mount+0x24/0x34
[242178.097671]  el0_svc_common+0xb8/0x1b8
[242178.097676]  el0_svc_handler+0x74/0x90
[242178.097681]  el0_svc+0x8/0x340

By analyzing the exfat code,we found that continuous physical memory
is not required here,so kvmalloc_array is used can solve this problem.

Cc: stable@vger.kernel.org
Signed-off-by: gaoming <gaoming20@hihonor.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exfat/balloc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -69,7 +69,7 @@ static int exfat_allocate_bitmap(struct
 	}
 	sbi->map_sectors = ((need_map_size - 1) >>
 			(sb->s_blocksize_bits)) + 1;
-	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
+	sbi->vol_amap = kvmalloc_array(sbi->map_sectors,
 				sizeof(struct buffer_head *), GFP_KERNEL);
 	if (!sbi->vol_amap)
 		return -ENOMEM;
@@ -84,7 +84,7 @@ static int exfat_allocate_bitmap(struct
 			while (j < i)
 				brelse(sbi->vol_amap[j++]);
 
-			kfree(sbi->vol_amap);
+			kvfree(sbi->vol_amap);
 			sbi->vol_amap = NULL;
 			return -EIO;
 		}
@@ -138,7 +138,7 @@ void exfat_free_bitmap(struct exfat_sb_i
 	for (i = 0; i < sbi->map_sectors; i++)
 		__brelse(sbi->vol_amap[i]);
 
-	kfree(sbi->vol_amap);
+	kvfree(sbi->vol_amap);
 }
 
 int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)


