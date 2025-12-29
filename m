Return-Path: <stable+bounces-203616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD5CE7129
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE04301EF87
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD3323403;
	Mon, 29 Dec 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMsIe+3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67131ED89
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018570; cv=none; b=RzhAMd8hNVcUtF7R5Q2hT8fycy2QV2llr6HlTLiluJRFwo0WHo5VFtRya3I6pFSN4QgkGmwx8c5SWLkkyTdpOXUSWJfLa/4quVOmA7xa5+gAAEaREzgQOfZapmcqPmCmrMfEKvl/JKFt+uaODjhJ2uPhX6oz/2o1ODkSkn23Rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018570; c=relaxed/simple;
	bh=u9XVFHekSvy5961VDNy0iGArGWrVZ310dF07pBllTyI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cOz2Gkc76Y2lcQC8FrmkRVBam2IPCz1MDAr0bZV5eQikHcY75OcRQ8sFNSG3FNxskNGstc4TlSH3/ZKZ0qZv50urR/vRBjV8FRBK/AD7WlCn8rStH+VoDOsc/StSpgWxWkqqC7xmCRwGh6AfIwKEcmJff/PY7wpsy+2vRwTlqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMsIe+3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A8C4CEF7;
	Mon, 29 Dec 2025 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018570;
	bh=u9XVFHekSvy5961VDNy0iGArGWrVZ310dF07pBllTyI=;
	h=Subject:To:Cc:From:Date:From;
	b=hMsIe+3mZUVS9n02ykJ8e//c5SaXjD6USCJYu6HXGlWWunory3H9JBKeHWXz9b6Ru
	 L81P0nlosLbiizttdFTzgbzAEfQjI4F1xzPbxbmKuFBBjEuWIFHo7EVmDGv6c5VH/0
	 gcwOh7k+r6B4JExqoYABdwikLrrolh7qiFyYmba0=
Subject: FAILED: patch "[PATCH] xfs: fix a memory leak in xfs_buf_item_init()" failed to apply to 5.10-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:29:19 +0100
Message-ID: <2025122919-catty-unrated-e504@gregkh>
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
git cherry-pick -x fc40459de82543b565ebc839dca8f7987f16f62e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122919-catty-unrated-e504@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc40459de82543b565ebc839dca8f7987f16f62e Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Wed, 10 Dec 2025 17:06:01 +0800
Subject: [PATCH] xfs: fix a memory leak in xfs_buf_item_init()

xfs_buf_item_get_format() may allocate memory for bip->bli_formats,
free the memory in the error path.

Fixes: c3d5f0c2fb85 ("xfs: complain if anyone tries to create a too-large buffer log item")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 8d85b5eee444..f4c5be67826e 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -896,6 +896,7 @@ xfs_buf_item_init(
 		map_size = DIV_ROUND_UP(chunks, NBWORD);
 
 		if (map_size > XFS_BLF_DATAMAP_SIZE) {
+			xfs_buf_item_free_format(bip);
 			kmem_cache_free(xfs_buf_item_cache, bip);
 			xfs_err(mp,
 	"buffer item dirty bitmap (%u uints) too small to reflect %u bytes!",


