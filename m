Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E757F77ABCB
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjHMVZu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjHMVZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9B10D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 509F36296B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A371C433C7;
        Sun, 13 Aug 2023 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961950;
        bh=atJjrL+ptAlLAYKvgwmhLvnPFN82Hy/vBCI5lb6BTLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZM5AbDNpmweM3JUliu5HZpsYxJRy2A9wVba/xBxPKn1Fpv7mmUDj8E6LxLHE0dyH
         tVdipIeD2vMQXinILxic0cHYuSnCoIlADQcdIzH7GQtAV1G2LhtqKfK/JvAQXLd75B
         MOYj6rrPDgxxbs6ehiPZc3jxTm2woChPa4vg89bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 056/206] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions
Date:   Sun, 13 Aug 2023 23:17:06 +0200
Message-ID: <20230813211726.620901350@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit 17457784004c84178798432a029ab20e14f728b1 upstream.

Some architectures do not populate the entire range categorised by
KCORE_TEXT, so we must ensure that the kernel address we read from is
valid.

Unfortunately there is no solution currently available to do so with a
purely iterator solution so reinstate the bounce buffer in this instance
so we can use copy_from_kernel_nofault() in order to avoid page faults
when regions are unmapped.

This change partly reverts commit 2e1c0170771e ("fs/proc/kcore: avoid
bounce buffer for ktext data"), reinstating the bounce buffer, but adapts
the code to continue to use an iterator.

[lstoakes@gmail.com: correct comment to be strictly correct about reasoning]
  Link: https://lkml.kernel.org/r/525a3f14-74fa-4c22-9fca-9dab4de8a0c3@lucifer.local
Link: https://lkml.kernel.org/r/20230731215021.70911-1-lstoakes@gmail.com
Fixes: 2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Closes: https://lore.kernel.org/all/ZHc2fm+9daF6cgCE@krava
Tested-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/kcore.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 9cb32e1a78a0..23fc24d16b31 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -309,6 +309,8 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 
 static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
+	char *buf = file->private_data;
 	loff_t *fpos = &iocb->ki_pos;
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
@@ -555,10 +557,21 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
 			/*
-			 * We use _copy_to_iter() to bypass usermode hardening
-			 * which would otherwise prevent this operation.
+			 * Sadly we must use a bounce buffer here to be able to
+			 * make use of copy_from_kernel_nofault(), as these
+			 * memory regions might not always be mapped on all
+			 * architectures.
 			 */
-			if (_copy_to_iter((char *)start, tsz, iter) != tsz) {
+			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
+				if (iov_iter_zero(tsz, iter) != tsz) {
+					ret = -EFAULT;
+					goto out;
+				}
+			/*
+			 * We know the bounce buffer is safe to copy from, so
+			 * use _copy_to_iter() directly.
+			 */
+			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -595,6 +608,10 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
+	filp->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!filp->private_data)
+		return -ENOMEM;
+
 	if (kcore_need_update)
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
@@ -605,9 +622,16 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int release_kcore(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
 static const struct proc_ops kcore_proc_ops = {
 	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
+	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
 };
 
-- 
2.41.0



