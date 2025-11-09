Return-Path: <stable+bounces-192803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CEC437AA
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15E0188B0FD
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2A31B85FD;
	Sun,  9 Nov 2025 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWacPMDm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B699189906
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657849; cv=none; b=fJHJb8G7pmYBkUa3HY4z5b3Vz2Gw/7KPB/1NYoQz/YFhIWQ4S6uDzVUsks/cioEtNm9eQxVaptkZ4kZ2OpsbsAHhN3aTWqdmf4hXwwbmg2a/2RwkAsRFTfO5v9L3987ImIH7l1UwXq6czxhILEztv+TsDaF3bSL0fHw5kbM79fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657849; c=relaxed/simple;
	bh=0Bq/UhZYzka4W2xt74Z975/IY6UC/DFLzMumO9+cCSQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=avWv+jiINjpY8dhu6TBN5VwNZBN0QGAuCO90B+EzFirqk58UitoS7DeIv72/L/v49Anktnslwh3CQn5deM7Z1qVxHdauuzY+vrHQWFkoNZXWWqUva8BHoih6nU83LVel2jtBTXIL18cm1oxQ35sjhv9tpduyBkT4Y5Ntk4oTSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWacPMDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0479C4CEF7;
	Sun,  9 Nov 2025 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657849;
	bh=0Bq/UhZYzka4W2xt74Z975/IY6UC/DFLzMumO9+cCSQ=;
	h=Subject:To:Cc:From:Date:From;
	b=VWacPMDmzF0MT4S5VWdTsu/P5VTyQE9L88t2nhFWUL6rKH6PGOiQJ59PguIvYSYAA
	 Hn5NF68jsMXsGyZJ0WCnLqbSWVq9SrEVjySQoZvVxEQRoy5Ervsqxs0sMcKQ8geTgS
	 rEioZEnKzBF8D6Hxcpz8hqWDFvtvx8D+U6UgXR9I=
Subject: FAILED: patch "[PATCH] iommufd: Don't overflow during division for dirty tracking" failed to apply to 6.6-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com,joao.m.martins@oracle.com,kevin.tian@intel.com,nicolinc@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:10:38 +0900
Message-ID: <2025110937-numbing-unworthy-d5de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cb30dfa75d55eced379a42fd67bd5fb7ec38555e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110937-numbing-unworthy-d5de@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb30dfa75d55eced379a42fd67bd5fb7ec38555e Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Wed, 8 Oct 2025 15:17:18 -0300
Subject: [PATCH] iommufd: Don't overflow during division for dirty tracking

If pgshift is 63 then BITS_PER_TYPE(*bitmap->bitmap) * pgsize will overflow
to 0 and this triggers divide by 0.

In this case the index should just be 0, so reorganize things to divide
by shift and avoid hitting any overflows.

Link: https://patch.msgid.link/r/0-v1-663679b57226+172-iommufd_dirty_div0_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reported-by: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093a8a8b859472e6c257
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 4514575818fc..b5b67a9d3fb3 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -130,9 +130,8 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
-
-	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
+	return (iova >> bitmap->mapped.pgshift) /
+	       BITS_PER_TYPE(*bitmap->bitmap);
 }
 
 /*


