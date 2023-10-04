Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD307B883C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbjJDSOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbjJDSOG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D61BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA82C433C9;
        Wed,  4 Oct 2023 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443242;
        bh=WEgdjAAPWr9+3uCeuZOtsT6Oa+NJP1Y6kitxFpZTEwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRwjEdpwQQDPL3zAyyk4HNFxX9ncPrr6zpHbfEeYpbQDnWyWgMOyCDYsfT7b/3MF0
         gApimScBk8wNmVrZS3GIu2UW/zkHDSgvUIlT+cGgQKZSBqJtARB8vQ7ADp61MGOfjl
         vAtDA35jeN6aeRONhGLPDXBa+/RuJ0mrbxxAzE/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 086/259] proc: nommu: fix empty /proc/<pid>/maps
Date:   Wed,  4 Oct 2023 19:54:19 +0200
Message-ID: <20231004175221.314595783@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit fe4419801617514765974f3e796269bc512ad146 ]

On no-MMU, /proc/<pid>/maps reads as an empty file.  This happens because
find_vma(mm, 0) always returns NULL (assuming no vma actually contains the
zero address, which is normally the case).

To fix this bug and improve the maintainability in the future, this patch
makes the no-MMU implementation as similar as possible to the MMU
implementation.

The only remaining differences are the lack of hold/release_task_mempolicy
and the extra code to shoehorn the gate vma into the iterator.

This has been tested on top of 6.5.3 on an STM32F746.

Link: https://lkml.kernel.org/r/20230915160055.971059-2-ben.wolsieffer@hefring.com
Fixes: 0c563f148043 ("proc: remove VMA rbtree use from nommu")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/internal.h   |  2 --
 fs/proc/task_nommu.c | 37 ++++++++++++++++++++++---------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b701d0207edf0..6b921826d85b6 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -289,9 +289,7 @@ struct proc_maps_private {
 	struct inode *inode;
 	struct task_struct *task;
 	struct mm_struct *mm;
-#ifdef CONFIG_MMU
 	struct vma_iterator iter;
-#endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bfcf17f75ed50..dc05780f93e13 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -188,15 +188,28 @@ static int show_map(struct seq_file *m, void *_p)
 	return nommu_vma_show(m, _p);
 }
 
-static void *m_start(struct seq_file *m, loff_t *pos)
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma = vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos = vma->vm_start;
+	} else {
+		*ppos = -1UL;
+	}
+
+	return vma;
+}
+
+static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
+	unsigned long last_addr = *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	unsigned long addr = *pos;
 
-	/* See m_next(). Zero at the start or after lseek. */
-	if (addr == -1UL)
+	/* See proc_get_vma(). Zero at the start or after lseek. */
+	if (last_addr == -1UL)
 		return NULL;
 
 	/* pin the task and mm whilst we play with them */
@@ -218,12 +231,9 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
 
-	/* start the next element from addr */
-	vma = find_vma(mm, addr);
-	if (vma)
-		return vma;
+	vma_iter_init(&priv->iter, mm, last_addr);
 
-	return NULL;
+	return proc_get_vma(priv, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -240,12 +250,9 @@ static void m_stop(struct seq_file *m, void *v)
 	priv->task = NULL;
 }
 
-static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
+static void *m_next(struct seq_file *m, void *_p, loff_t *ppos)
 {
-	struct vm_area_struct *vma = _p;
-
-	*pos = vma->vm_end;
-	return find_vma(vma->vm_mm, vma->vm_end);
+	return proc_get_vma(m->private, ppos);
 }
 
 static const struct seq_operations proc_pid_maps_ops = {
-- 
2.40.1



