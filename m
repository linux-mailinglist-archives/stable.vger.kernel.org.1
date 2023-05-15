Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7070390B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbjEORi0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbjEORiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94015518
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A0462DD7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B2C433D2;
        Mon, 15 May 2023 17:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172117;
        bh=//c8dfAGvmdKHhBAXN1JTTTBJ0dDpiT2vV7bFnVQQqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhbE8YhU2ZgDwlmtinbjGZ8PlOKem8uy+3RvU4YeixKSM+ky2dPHob+zSg1iScxOs
         2kSobDVBiE8e5qYcf4otxN3rJWoNf3KR5T+r8XTKvCIFO6HYaayIBwIWSMOS2/ZOME
         g7R7gSPEZWimzi9IIiTnK6YuDSERjH8QW1IUKk1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.10 050/381] ubifs: Free memory for tmpfile name
Date:   Mon, 15 May 2023 18:25:01 +0200
Message-Id: <20230515161739.089529606@linuxfoundation.org>
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
@@ -425,6 +425,7 @@ static int do_tmpfile(struct inode *dir,
 	mutex_unlock(&dir_ui->ui_mutex);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return 0;
 


