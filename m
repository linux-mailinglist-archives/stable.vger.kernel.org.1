Return-Path: <stable+bounces-92725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4769C57CB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B98B43775
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7F21A4A9;
	Tue, 12 Nov 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6+DXAZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3372144A4;
	Tue, 12 Nov 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408387; cv=none; b=OuZnVPkxqfsmm8kPylcAWHDE748SUTaqczyb6Hq2t9+LuxY3ZrRtjJXqLf0aqKLiEreXgqv+KGIfcdRHB0mLWtf6kaZGuTbop7o3uuq4E4vn5MTi+vMC/Vwla0whQo9r1vrst8iwdeRDqJeTjaPf2/pIN/uO+EU+RiBr69fY9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408387; c=relaxed/simple;
	bh=eGQ/P2gitOiLZ3MSquTzsdHenwC/d1X/7yp6DHsKdq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE8LalsuDLsnWb4qt6jDaR0AVR6gabbHa7eGfxp/9oydMP1k1rRKuYaC3svXkz9/SxnBuVzC/Y3R+RNHJGkQgEehqCB/VZIX8/yN1jEdzyyo3SX8RDMYFTDezpWDuO7ZGaSm4J6vZ4lQ+TVdtHq6BGl9AALSQvXT/vVhqiNkqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6+DXAZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6035CC4CED4;
	Tue, 12 Nov 2024 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408386;
	bh=eGQ/P2gitOiLZ3MSquTzsdHenwC/d1X/7yp6DHsKdq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6+DXAZxJ/rY/Rg7ZC4CQl+FOdzvE5d64VSnOLWuIu95Jwq4EDbwDkO77pKVGsr9v
	 Uec3Nqz6QWnDwwQEo4rAM9hmB2lREUBKsn4sCMtj6FVoYPPGFHKVZz6J5sScVlsjo0
	 0q8IUW49ZN4NPt7EIyIxmXwQLy0Ki34jbcjqawng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qi Xi <xiqi2@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.11 147/184] fs/proc: fix compile warning about variable vmcore_mmap_ops
Date: Tue, 12 Nov 2024 11:21:45 +0100
Message-ID: <20241112101906.512985124@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Xi <xiqi2@huawei.com>

commit b8ee299855f08539e04d6c1a6acb3dc9e5423c00 upstream.

When build with !CONFIG_MMU, the variable 'vmcore_mmap_ops'
is defined but not used:

>> fs/proc/vmcore.c:458:42: warning: unused variable 'vmcore_mmap_ops'
     458 | static const struct vm_operations_struct vmcore_mmap_ops = {

Fix this by only defining it when CONFIG_MMU is enabled.

Link: https://lkml.kernel.org/r/20241101034803.9298-1-xiqi2@huawei.com
Fixes: 9cb218131de1 ("vmcore: introduce remap_oldmem_pfn_range()")
Signed-off-by: Qi Xi <xiqi2@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410301936.GcE8yUos-lkp@intel.com/
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/vmcore.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -457,10 +457,6 @@ static vm_fault_t mmap_vmcore_fault(stru
 #endif
 }
 
-static const struct vm_operations_struct vmcore_mmap_ops = {
-	.fault = mmap_vmcore_fault,
-};
-
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
  * @size: size of buffer
@@ -488,6 +484,11 @@ static inline char *vmcore_alloc_buf(siz
  * virtually contiguous user-space in ELF layout.
  */
 #ifdef CONFIG_MMU
+
+static const struct vm_operations_struct vmcore_mmap_ops = {
+	.fault = mmap_vmcore_fault,
+};
+
 /*
  * remap_oldmem_pfn_checked - do remap_oldmem_pfn_range replacing all pages
  * reported as not being ram with the zero page.



