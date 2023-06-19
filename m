Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7065735247
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjFSKdJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjFSKdE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2768E62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 501A360B58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CAAC433C8;
        Mon, 19 Jun 2023 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170782;
        bh=e6FiqSpPzrIqBr4ifo3Fy2T912kqqu+DYRXAE8MmA+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEho+q9SgTJZCtSGavH9yvh7QaMnAn1/AZKzr8Cq4yTjyVJZWFVMeGQqv8hE/n9Cd
         VzrSTHW6xil8uun5+HLWq92GJPUaMpR4Prlp7+SJOrw7sJOXS4Nl3tOhcgPx7k3xXE
         88QBSJ45uVIc/g6QlJ58SUAVFUgYjWqptxom/2Ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yue Hu <huyue2@coolpad.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 033/187] erofs: use HIPRI by default if per-cpu kthreads are enabled
Date:   Mon, 19 Jun 2023 12:27:31 +0200
Message-ID: <20230619102159.249464371@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit cf7f2732b4b83026842832e7e4e04bf862108ac2 ]

As Sandeep shown [1], high priority RT per-cpu kthreads are
typically helpful for Android scenarios to minimize the scheduling
latencies.

Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
EROFS_FS_PCPU_KTHREAD.

Also clean up unneeded sched_set_normal().

[1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Sandeep Dhavale <dhavale@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230522092141.124290-1-hsiangkao@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/Kconfig | 1 +
 fs/erofs/zdata.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 704fb59577e09..f259d92c97207 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
 config EROFS_FS_PCPU_KTHREAD_HIPRI
 	bool "EROFS high priority per-CPU kthread workers"
 	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
+	default y
 	help
 	  This permits EROFS to configure per-CPU kthread workers to run
 	  at higher priority.
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f1708c77a9912..d7add72a09437 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -369,8 +369,6 @@ static struct kthread_worker *erofs_init_percpu_worker(int cpu)
 		return worker;
 	if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
 		sched_set_fifo_low(worker->task);
-	else
-		sched_set_normal(worker->task, 0);
 	return worker;
 }
 
-- 
2.39.2



