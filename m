Return-Path: <stable+bounces-59325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF9931242
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239C51C224C4
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95218784D;
	Mon, 15 Jul 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A62GneK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A5187561
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039284; cv=none; b=VKEDVsGFWmxvLMF3CwGebfYy7eKR6zFMRzRXaLiI95OYiG8AN9BbHU6pCG6QmoZab0QpFSJMuQnxX17zdfKauv/t1oLcJLgBMPb9+9zh8y9NPLoycUbI9gG2JaODmbiAv/34XKs1eeIbL9RrSAWyF6oaPxRAjk7JKZbg8/pYZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039284; c=relaxed/simple;
	bh=m0Dzygpan4X/CCrq8Efh0z4JxuKGcwXonAXwVB203Ss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pZ4FTPRsEHr0yg/uuXmzVaMfzxJRJ3ytc1sLynqkbfV7df9vfLz1QdU3QNd7tNbXfyPPKoZAk+iGrPo8oLXf0WWdw/DKGVSD1MkNengfuSKW74Xar53MY7FlMN259xjmtCkq8AqfSmPYmrjImjGdP8yWiA27ZZB8XDgtPJbN4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A62GneK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598DBC32782;
	Mon, 15 Jul 2024 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721039284;
	bh=m0Dzygpan4X/CCrq8Efh0z4JxuKGcwXonAXwVB203Ss=;
	h=Subject:To:Cc:From:Date:From;
	b=A62GneK13m1PhJd6XinhD3dVMMgp9f/xwvzPlecFoWtYzkC4EVcL3A0N/sKlqjGXt
	 E0FnP8SvW/OUo3T/2e2MeS8QT4tHUHS6WKXdZt9YJt6Ip6NR2mfoN8mbT3Rm969V2n
	 OUklgGyxZNfg2hcEb35SWHOCkiwQDMuL2GigqLyo=
Subject: FAILED: patch "[PATCH] Fix userfaultfd_api to return EINVAL as expected" failed to apply to 5.10-stable tree
To: audra@redhat.com,aarcange@redhat.com,akpm@linux-foundation.org,brauner@kernel.org,jack@suse.cz,peterx@redhat.com,raquini@redhat.com,rppt@linux.vnet.ibm.com,shli@fb.com,shuah@kernel.org,stable@vger.kernel.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:27:40 +0200
Message-ID: <2024071539-magnetize-nimble-15ba@gregkh>
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
git cherry-pick -x 1723f04caacb32cadc4e063725d836a0c4450694
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071539-magnetize-nimble-15ba@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1723f04caacb ("Fix userfaultfd_api to return EINVAL as expected")
2ff559f31a5d ("Revert "userfaultfd: don't fail on unrecognized features"")
914eedcb9ba0 ("userfaultfd: don't fail on unrecognized features")
b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
824ddc601adc ("userfaultfd: provide unmasked address on page-fault")
964ab0040ff9 ("userfaultfd/shmem: advertise shmem minor fault support")
c949b097ef2e ("userfaultfd/shmem: support minor fault registration for shmem")
00b151f21f39 ("mm/userfaultfd: fail uffd-wp registration if not supported")
b8da5cd4e5f1 ("userfaultfd: update documentation to describe minor fault handling")
f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
44835d20b2a0 ("mm: add FGP_ENTRY")
8f251a3d5ce3 ("hugetlb: convert page_huge_active() HPageMigratable flag")
d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
99ca0edb41aa ("Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1723f04caacb32cadc4e063725d836a0c4450694 Mon Sep 17 00:00:00 2001
From: Audra Mitchell <audra@redhat.com>
Date: Wed, 26 Jun 2024 09:05:11 -0400
Subject: [PATCH] Fix userfaultfd_api to return EINVAL as expected

Currently if we request a feature that is not set in the Kernel config we
fail silently and return all the available features.  However, the man
page indicates we should return an EINVAL.

We need to fix this issue since we can end up with a Kernel warning should
a program request the feature UFFD_FEATURE_WP_UNPOPULATED on a kernel with
the config not set with this feature.

 [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
 [  200.820738] Modules linked in:
 [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
 [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
 [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660

Link: https://lkml.kernel.org/r/20240626130513.120193-1-audra@redhat.com
Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
Signed-off-by: Audra Mitchell <audra@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rafael Aquini <raquini@redhat.com>
Cc: Shaohua Li <shli@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index eee7320ab0b0..17e409ceaa33 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2057,7 +2057,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto out;
 	features = uffdio_api.features;
 	ret = -EINVAL;
-	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+	if (uffdio_api.api != UFFD_API)
 		goto err_out;
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
@@ -2081,6 +2081,11 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
 	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 #endif
+
+	ret = -EINVAL;
+	if (features & ~uffdio_api.features)
+		goto err_out;
+
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))


