Return-Path: <stable+bounces-169934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF824B29B90
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2C9620676
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1827145E;
	Mon, 18 Aug 2025 08:01:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558F2264B3
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504095; cv=none; b=jeqk6/4l1tWzcCE+rcyHuGgpTh4+J+Hpyzl7uw+QnVSKeCMQjFx0qTDZkbNHXsMjnrf7xcEMKQ0PPvuqbJk1IUVSG0biSzezxiT2p+DPkcGtXqoLStKNe+JMcoFfXlbDT5i/3xLTo/RAVGcastuHGspU+4nKnhv/jieMMsH/I3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504095; c=relaxed/simple;
	bh=+cFpcGeQConjr8a+kmfFcP67GLznb5B0YY19f2xzgck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJiBhU6jTcp/rblegmSj8REWEta+wfrnf3MILeaexJgsnhdeDC7K6SVTL+3W9yQekx7aDznh4eQjsKxh6X9iOs0LbfnLliKF0ajk4jj3KMZnpZ8whiASlygaBveoy9GkbIHcCcYY0wIe99ht7Hc2MtK6awTvcAmZTp4fe9rlHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c54sl1KxKzYl3cJ;
	Mon, 18 Aug 2025 16:01:15 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 16:01:25 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 16:01:25 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jirislaby@kernel.org>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<gregkh@linuxfoundation.org>, <kirill.shutemov@linux.intel.com>,
	<polynomial-c@gmx.de>, <regressions@lists.linux.dev>,
	<rick.p.edgecombe@intel.com>, <stable@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <wangzijie1@honor.com>
Subject: Re: [PATCH] proc: fix wrong behavior of FMODE_LSEEK clearing for net related proc file
Date: Mon, 18 Aug 2025 16:01:25 +0800
Message-ID: <20250818080125.843285-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f2ff00e6-a931-4c61-a43d-fb3e450f7ffd@kernel.org>
References: <f2ff00e6-a931-4c61-a43d-fb3e450f7ffd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

>Hi,
>
>On 18. 08. 25, 6:05, wangzijie wrote:
>> For avoiding pde->proc_ops->... dereference(which may cause UAF in rmmod race scene),
>> we call pde_set_flags() to save this kind of information in PDE itself before
>> proc_register() and call pde_has_proc_XXX() to replace pde->proc_ops->... dereference.
>> But there has omission of pde_set_flags() in net related proc file create, which cause
>> the wroing behavior of FMODE_LSEEK clearing in proc_reg_open() for net related proc file
>> after commit ff7ec8dc1b64("proc: use the same treatment to check proc_lseek as ones for
>> proc_read_iter et.al"). Lars reported it in this link[1]. So call pde_set_flags() when
>> create net related proc file to fix this bug.
>
>I wonder, why is pde_set_flags() not a part of proc_register()?

Not all proc_dir_entry have proc_ops, so you mean this will be a better modification?

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 76e800e38..d52197c35 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -367,6 +367,20 @@ static const struct inode_operations proc_dir_inode_operations = {
        .setattr        = proc_notify_change,
 };

+static void pde_set_flags(struct proc_dir_entry *pde)
+{
+       if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
+               pde->flags |= PROC_ENTRY_PERMANENT;
+       if (pde->proc_ops->proc_read_iter)
+               pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+       if (pde->proc_ops->proc_compat_ioctl)
+               pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
+       if (pde->proc_ops->proc_lseek)
+               pde->flags |= PROC_ENTRY_proc_lseek;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
                struct proc_dir_entry *dp)
@@ -374,6 +388,9 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
        if (proc_alloc_inum(&dp->low_ino))
                goto out_free_entry;

+       if (dp->proc_ops)
+               pde_set_flags(dp);
+
        write_lock(&proc_subdir_lock);
        dp->parent = dir;
        if (pde_subdir_insert(dir, dp) == false) {


>Could you also use some LLM to reformat the message into something 
>comprehensible?

English is not my native language, so using LLM to format message is
a good suggestion for me, Thank you.


>thanks,
>-- 
>js
>suse labs



