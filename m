Return-Path: <stable+bounces-71556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409E9656A9
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 07:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98191C22B92
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 05:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777D14D44F;
	Fri, 30 Aug 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hCFnixCw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D712C486
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994314; cv=none; b=oowKKO80GPdGx6Ma1Pr7hQ7j5fwILRsDbpO3+jYbGdE2sKCd1ZCUdeshNoJLBxsDLO+C0cYmu1pGON4zn4+eFvxkdaR+plV40GiuP0bHQsuVkz3OZm4VTKwsPxJi5jGKquacPstm9klGlVTK1OYWZ6J0FrOnP4eyeruYjxYSH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994314; c=relaxed/simple;
	bh=0EFniWYpHhsJb8FrdPLeExLhBz8HAE5CjvnzkalyGtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nL1B15Kf2Tx5wEnqY9JZ/KrxRAJ/Ysi9tO9XSe3EZaeio46Zfs6LQaEIzuzP0yov+IH13lswAj5peGJQduF2aOKWE0oSRKUJpWhiO6EFvVnknb6+qEMnh+UDyGuJSMZN5K8a9H9v6JsZ1ERwPjCTXyLOQ2ySajFSfVo+/u+/y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hCFnixCw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053525bd90so208595ad.0
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 22:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724994311; x=1725599111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZPZfZqC3mBdycoYdenoJPylLkOydS6FcokJngh3hNI=;
        b=hCFnixCwqPHmW/i0ReTzzoxks59j8qXOKlDLMJ+uw1JjTni1C7LNzOgXuN1faCEyGr
         nEZPgRT/rSo2nGQL/23FwqNuWg7PKvntJrGSR+4259N4kj6jrWjUO0xFX8ZKXeO+duZg
         zCTJIHTKawusxqUrca300h0Se/Io/SvHnxmtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724994311; x=1725599111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZPZfZqC3mBdycoYdenoJPylLkOydS6FcokJngh3hNI=;
        b=q9qOg5dZViCJAXRwJgWbyb03EhPHkdJQjGI+6PospEuErb5Qaql05cq16g4krUZftQ
         r+avka6IPbVDaLCUVVBd/SsoTGabXat27DtQI1UBVAlqGiGZ7Ok+H9a9SOmM+C0BzG8A
         ZIzY73+6qe68G1vg/o19OzkASUxae7FATwTxe6yloWKi2rP9O/wyUE3uy5eikab4zVha
         DCQ1KzFarNcZq6R1EamEq6ueGxoWLlK9Wz4ywo/qQuj2NPFwgQiL+0X5ZA+5L+/ViOc8
         gUYAnPjsmBIvJUPjcAfCUv2bleFTYSoMm0D5e2Al6hppe6rihwCapLk7Hut8+fQoJzpT
         tb4g==
X-Gm-Message-State: AOJu0Ywe5lw65baO44/5H8lCkgGwUJvQV3TEEqbbqwOJRrGTENV089ej
	RKxzrHcdtm4q+xEcOb8yZKvxhCazITmq80D4W5rxmvTCTBifDszMe6sykiK00l0YGMWPIXpDTQ2
	8ncJjdOItzYgbzGjhWe7cxh6Ko47woFhOZo2+0CBnOICe8qq4H5mC0Z91b8rd+6RHjXXwKdrjIM
	XrrvUOUlpuyP20Tm7eN3Nai17paUEramhmfTcBr3HxqHxF2zNBKQ==
X-Google-Smtp-Source: AGHT+IG2ZpIcJB8JEhz863I2jzVyW6qGkIBXIGHqgGsA6ZZSbaBGKttZ3ypFGMQeN7yasOjia2SZnQ==
X-Received: by 2002:a17:902:f54e:b0:202:3324:68bd with SMTP id d9443c01a7336-2050c4ba585mr53368965ad.43.1724994310725;
        Thu, 29 Aug 2024 22:05:10 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515566c03sm19280095ad.300.2024.08.29.22.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 22:05:10 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	adityakali@google.com,
	sergeh@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Chen Ridong <chenridong@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v5.15] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Date: Thu, 29 Aug 2024 22:04:53 -0700
Message-Id: <20240830050453.692795-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 1be59c97c83ccd67a519d8a49486b3a8a73ca28a ]

An UAF can happen when /proc/cpuset is read as reported in [1].

This can be reproduced by the following methods:
1.add an mdelay(1000) before acquiring the cgroup_lock In the
 cgroup_path_ns function.
2.$cat /proc/<pid>/cpuset   repeatly.
3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
$umount /sys/fs/cgroup/cpuset/   repeatly.

The race that cause this bug can be shown as below:

(umount)		|	(cat /proc/<pid>/cpuset)
css_release		|	proc_cpuset_show
css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
rebind_subsystems	|
cgroup_free_root	|
			|	// cgrp was freed, UAF
			|	cgroup_path_ns_locked(cgrp,..);

When the cpuset is initialized, the root node top_cpuset.css.cgrp
will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
&cgroup_root.cgrp. When the umount operation is executed,
top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.

The problem is that when rebinding to cgrp_dfl_root, there are cases
where the cgroup_root allocated by setting up the root for cgroup v1
is cached. This could lead to a Use-After-Free (UAF) if it is
subsequently freed. The descendant cgroups of cgroup v1 can only be
freed after the css is released. However, the css of the root will never
be released, yet the cgroup_root should be freed when it is unmounted.
This means that obtaining a reference to the css of the root does
not guarantee that css.cgrp->root will not be freed.

Fix this problem by using rcu_read_lock in proc_cpuset_show().
As cgroup_root is kfree_rcu after commit d23b5c577715
("cgroup: Make operations on the cgroup root_list RCU safe"),
css->cgroup won't be freed during the critical section.
To call cgroup_path_ns_locked, css_set_lock is needed, so it is safe to
replace task_get_css with task_css.

[1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd

Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 kernel/cgroup/cpuset.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9f2a93c82..731547a0d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -22,6 +22,7 @@
  *  distribution for more details.
  */
 
+#include "cgroup-internal.h"
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
@@ -3725,10 +3726,14 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	css = task_get_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-				current->nsproxy->cgroup_ns);
-	css_put(css);
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	css = task_css(tsk, cpuset_cgrp_id);
+	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+				       current->nsproxy->cgroup_ns);
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
+
 	if (retval >= PATH_MAX)
 		retval = -ENAMETOOLONG;
 	if (retval < 0)
-- 
2.39.4


