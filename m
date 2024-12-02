Return-Path: <stable+bounces-96102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2C9E0710
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6706B287195
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115B204F6D;
	Mon,  2 Dec 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bf+G/ylJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1631D63FC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153296; cv=none; b=SgKOe33gGQsJB5yk3+Wlx0j37n+zcJSegEr5kE/94qLVLloXmSJebqXxYq3uEp1Gm7bw5VeyjsuDxSWxDqRPNIc1Z+syNk+O6qKSleVQyk+KsGjOW7oDWqKagVFCrMpO52k/UqeX9vZViribb1YqeDcHjiFCuBGAjjzkVHHd4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153296; c=relaxed/simple;
	bh=21Bamfs5lCCgEW8Saw22Bo7jI1GMa8xxomLPxoaYFAk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LB52jtz6rhfk/Bv1YKHHFcGtXLrn2uevKhH0jt+a3M84hCfWYE/yD6Q7nYhiRcl5E+CNy+LwLG524WIqeW/yjGSYLzxzOKOmlebTQUaqS7Ptw73wVtSAbTkzsm6dMpQGR3Z4ApWOWIpTczrUsi7XC4hfP4z9RcurMY1tpSIYv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bf+G/ylJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D4AC4CED2;
	Mon,  2 Dec 2024 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733153295;
	bh=21Bamfs5lCCgEW8Saw22Bo7jI1GMa8xxomLPxoaYFAk=;
	h=Subject:To:Cc:From:Date:From;
	b=bf+G/ylJBK49ZPvknQ1wqF9MkWW5OFxGKGICMPB77SUeuXz1aV7AIprIPQr54UEW8
	 PlcxCHDjoYpiavDfF0o+DRJsxKZWxKffdKzwRP2ZcGxirIgsmFw7FnGU4px9wMqKfk
	 1XrF/8hSZE3m8CTAJvHQNUtReTPbzxObKnFHAc2g=
Subject: FAILED: patch "[PATCH] comedi: Flush partial mappings in error case" failed to apply to 4.19-stable tree
To: jannh@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:28:12 +0100
Message-ID: <2024120212-germless-strongly-3499@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ce8f9fb651fac95dd41f69afe54d935420b945bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120212-germless-strongly-3499@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce8f9fb651fac95dd41f69afe54d935420b945bd Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 21:07:45 +0200
Subject: [PATCH] comedi: Flush partial mappings in error case

If some remap_pfn_range() calls succeeded before one failed, we still have
buffer pages mapped into the userspace page tables when we drop the buffer
reference with comedi_buf_map_put(bm). The userspace mappings are only
cleaned up later in the mmap error path.

Fix it by explicitly flushing all mappings in our VMA on the error path.

See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
error case").

Cc: stable@vger.kernel.org
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20241017-comedi-tlb-v3-1-16b82f9372ce@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1b481731df96..b9df9b19d4bd 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2407,6 +2407,18 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
 
 			start += PAGE_SIZE;
 		}
+
+#ifdef CONFIG_MMU
+		/*
+		 * Leaving behind a partial mapping of a buffer we're about to
+		 * drop is unsafe, see remap_pfn_range_notrack().
+		 * We need to zap the range here ourselves instead of relying
+		 * on the automatic zapping in remap_pfn_range() because we call
+		 * remap_pfn_range() in a loop.
+		 */
+		if (retval)
+			zap_vma_ptes(vma, vma->vm_start, size);
+#endif
 	}
 
 	if (retval == 0) {


