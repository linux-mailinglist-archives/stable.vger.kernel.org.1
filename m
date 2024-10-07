Return-Path: <stable+bounces-81373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8999332E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851D2828BF
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD01DACB1;
	Mon,  7 Oct 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkwcDuBK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133A1DA62C
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318431; cv=none; b=pcjbqvcZBfPX09qgFHoQxhkiFHziUuTNDCniD5nvx9tUDO9hPVcRdjkIUNfEz+YnUt4AuNhdt0R6kPH5fGtVRt2p+qT4Qsuksy68DBcQOZvkLkBNaN1+xhclt0PMZBdmySacpT09X8jTS5HBhpfkLEZAEejpiBZu5nW3jxYbSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318431; c=relaxed/simple;
	bh=ocFMsmuwoFupOzeI6EW9u3P570ZJ7IUVLDguYQ40Yzw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f8wiLgUGbLBXKHgcPVNSlgiP2JHwvRZssHAOc5eENW38VIeHbhUlGPLJgova5KVzNSSWyP+nP4Y0CaaZBNUq4mCC7wnSsrUErGmOOF4JdRR7y5AEFCByJTors14htkoNvZJTQlnOYBkTNNV7IOTczZMJaiblyttsQCj1MHoHGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkwcDuBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71662C4CEC6;
	Mon,  7 Oct 2024 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728318430;
	bh=ocFMsmuwoFupOzeI6EW9u3P570ZJ7IUVLDguYQ40Yzw=;
	h=Subject:To:Cc:From:Date:From;
	b=BkwcDuBKapLcFwqzit9y1DFsBFRkctnfClj2i14z4vRA0a9ncoFy/ARUAGTTW22kD
	 v8hvUDV776jz7kEPa1z4/kHSbnNKWvucn48B09vhzyHqj/UVO4n/3qbOqhT5LFyZqY
	 Il7HZJfo1pXtj/zwdrRZprBS/2Z2JN1OMCeswe/U=
Subject: FAILED: patch "[PATCH] RDMA/mana_ib: use the correct page table index based on" failed to apply to 6.10-stable tree
To: longli@microsoft.com,leon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:26:59 +0200
Message-ID: <2024100759-plunging-siesta-d577@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9e517a8e9d9a303bf9bde35e5c5374795544c152
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100759-plunging-siesta-d577@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

9e517a8e9d9a ("RDMA/mana_ib: use the correct page table index based on hardware page size")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e517a8e9d9a303bf9bde35e5c5374795544c152 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Fri, 30 Aug 2024 08:16:32 -0700
Subject: [PATCH] RDMA/mana_ib: use the correct page table index based on
 hardware page size

MANA hardware uses 4k page size. When calculating the page table index,
it should use the hardware page size, not the system page size.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://patch.msgid.link/1725030993-16213-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index d13abc954d2a..f68f54aea820 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -383,7 +383,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
 
 	create_req->length = umem->length;
 	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
-	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
+	create_req->gdma_page_type = order_base_2(page_sz) - MANA_PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
 	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",


