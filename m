Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D836FA6D0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjEHKYZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjEHKXg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48830451
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDD66257B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CA9C433EF;
        Mon,  8 May 2023 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541408;
        bh=iqzJxMCoDWFS2cMLhNtb4ZYORu0PCokX+vciUYk5c4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfnRZhHLbo6hscW7hQpFaNyQnlmDFzFHKYZNHR/XGEzAeW9T/h8AVbVOhJiK18/Am
         iQDbBkpCDw+mNyMA9a/umGG9FULXHByv5WNvOhKJgc8+jap+DugYxzo0vtCy4wkkv0
         4jo5Xd+FzDcrpPlDINcpXD0R5OyJvcf9u9WxspGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6.2 106/663] ubifs: Free memory for tmpfile name
Date:   Mon,  8 May 2023 11:38:52 +0200
Message-Id: <20230508094431.924265063@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Mårten Lindahl <marten.lindahl@axis.com>

commit 1fb815b38bb31d6af9bd0540b8652a0d6fe6cfd3 upstream.

When opening a ubifs tmpfile on an encrypted directory, function
fscrypt_setup_filename allocates memory for the name that is to be
stored in the directory entry, but after the name has been copied to the
directory entry inode, the memory is not freed.

When running kmemleak on it we see that it is registered as a leak. The
report below is triggered by a simple program 'tmpfile' just opening a
tmpfile:

  unreferenced object 0xffff88810178f380 (size 32):
    comm "tmpfile", pid 509, jiffies 4294934744 (age 1524.742s)
    backtrace:
      __kmem_cache_alloc_node
      __kmalloc
      fscrypt_setup_filename
      ubifs_tmpfile
      vfs_tmpfile
      path_openat

Free this memory after it has been copied to the inode.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ubifs/dir.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -492,6 +492,7 @@ static int ubifs_tmpfile(struct user_nam
 	unlock_2_inodes(dir, inode);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return finish_open_simple(file, 0);
 


