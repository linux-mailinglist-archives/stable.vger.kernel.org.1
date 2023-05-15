Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71B70354D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjEOQ5k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbjEOQ52 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11D5278
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1842629F5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDBC433EF;
        Mon, 15 May 2023 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169847;
        bh=q4w0+U513VitpwFD4lMi/QpdKyHY0TOfvVAnetzZqeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojjVJmf1zgJSpy/NaWPJl3AoajMCtYVg/LRUNecO23MfW54vDyIBkdJbceztf513X
         4uD96/Y2UwJbJeBIVTOoLXDXPDoyCBwUp+4b+dDph2P1GVehuNswdUCsSluzdxCE3Z
         x9Wctbn6+XtbtNCAkLEs0qkImzyqsNbMT9n1EdDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.3 182/246] f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
Date:   Mon, 15 May 2023 18:26:34 +0200
Message-Id: <20230515161728.087770326@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit da6ea0b050fa720302b56fbb59307e7c7531a342 upstream.

We got a kernel panic if old_addr is NULL.

https://bugzilla.kernel.org/show_bug.cgi?id=217266

BUG: kernel NULL pointer dereference, address: 0000000000000000
 Call Trace:
  <TASK>
  f2fs_commit_atomic_write+0x619/0x990 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
  __f2fs_ioctl+0xd8e/0x4080 [f2fs a1b985b80f5babd6f3ea778384908880812bfa43]
  ? vfs_write+0x2ae/0x3f0
  ? vfs_write+0x2ae/0x3f0
  __x64_sys_ioctl+0x91/0xd0
  do_syscall_64+0x5c/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f69095fe53f

Fixes: 2f3a9ae990a7 ("f2fs: introduce trace_f2fs_replace_atomic_write_block")
Cc: <stable@vger.kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -263,7 +263,7 @@ retry:
 	f2fs_put_dnode(&dn);
 
 	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
-					index, *old_addr, new_addr, recover);
+			index, old_addr ? *old_addr : 0, new_addr, recover);
 	return 0;
 }
 


