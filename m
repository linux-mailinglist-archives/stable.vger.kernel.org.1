Return-Path: <stable+bounces-66433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353DF94EA40
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68BC28216B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6477916DC1A;
	Mon, 12 Aug 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0836zCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562616DC34
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456088; cv=none; b=DbtXbLhcciFlJhJFp0sA/wP0VnZpv6VGVDwZnXO9JxCWR9PTGCrZhmMyasryl9nWMWqAgk+cuL6s3fvSfhAfpUt5tPR11tq7SPnGjBi15jaCbWwzjfHEgtEmrNaW+Sk99dEW15UrUfcPBxMf/cOhu7V3xiGdcPP+L1sW0xKdVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456088; c=relaxed/simple;
	bh=PqqQxJaSDxGfJBbfe/WAHZpOYUeYpgVPMSopEzrPBfI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i88Whg2t86tqhObOy6Yy/DIX1P0jJSzqlOHT/ILzSWGBh27BmoQivFecrWNwMD2chSEBOoh5IPOGCQcucTgpZaY4OeFAERb2eUWzcGP3N9tc5f6jTj33qiWm70U3bv1fptuTXs2IiqbhpY9/yHNkcZKPnAYJvgnUN3WxwToOWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0836zCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB02C32782;
	Mon, 12 Aug 2024 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723456087;
	bh=PqqQxJaSDxGfJBbfe/WAHZpOYUeYpgVPMSopEzrPBfI=;
	h=Subject:To:Cc:From:Date:From;
	b=U0836zCsE41NlxPQN0klQEQTI/Eo3rmbxuSqSvIk5GbH6qSroziOwDlh/yWI9+Bth
	 6Dm7VXdZDEbHXsDpk8tAF75QTv++3WWhhsQ3ucwUCYzTPcRFfTzTGc0NknuPezR1j1
	 5ivUmJ/8YhTFRD0wHzadABriuNQ/izzbMxbltjzE=
Subject: FAILED: patch "[PATCH] vhost-vdpa: switch to use vmf_insert_pfn() in the fault" failed to apply to 5.10-stable tree
To: jasowang@redhat.com,dtatulea@nvidia.com,michal.kubiak@intel.com,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:48:04 +0200
Message-ID: <2024081204-fraction-from-52aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0823dc64586ba5ea13a7d200a5d33e4c5fa45950
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081204-fraction-from-52aa@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0823dc64586b ("vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler")
729ce5a5bd6f ("vdpa: Make use of PFN_PHYS/PFN_UP/PFN_DOWN helper macro")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0823dc64586ba5ea13a7d200a5d33e4c5fa45950 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Jul 2024 11:31:59 +0800
Subject: [PATCH] vhost-vdpa: switch to use vmf_insert_pfn() in the fault
 handler

remap_pfn_page() should not be called in the fault handler as it may
change the vma->flags which may trigger lockdep warning since the vma
write lock is not held. Actually there's no need to modify the
vma->flags as it has been set in the mmap(). So this patch switches to
use vmf_insert_pfn() instead.

Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240701033159.18133-1-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..6b9c12acf438 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1483,13 +1483,7 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	notify = ops->get_vq_notification(vdpa, index);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
-			    PFN_DOWN(notify.addr), PAGE_SIZE,
-			    vma->vm_page_prot))
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
 
 static const struct vm_operations_struct vhost_vdpa_vm_ops = {


