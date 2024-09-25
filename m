Return-Path: <stable+bounces-77509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBB985DEC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90691F24379
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4DD1B5826;
	Wed, 25 Sep 2024 12:07:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304B20696B;
	Wed, 25 Sep 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266075; cv=none; b=lf1jre837SX6eZLmIvW1M2snaSljTI4o3hTHxpUj/c11nOGeyNLHZLz9E1r21MVvStlFUxqqlMvB9eT8RceJA1IOAdbUAOq9esnH9MKbpJkMI1i/KnFTNXsf8dpTrVAgwA2jgEqnhjVu/m2CV5TzroeZed63LpMr0rUrrimdF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266075; c=relaxed/simple;
	bh=U2BaAsPAFoNW3AeU5zkWAXx7zAEy8mGFjk+qsS9Bnco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ped5rsvqp3T5jFz3l5sRe5dUbXCVPzgjtpc2ejINi/6GKUXntgyRSXg0dGQWrWfzcwrqt7LWOkHt66FqrCKeWQopGmhcQkG3CYGJnalhSow556a83zFK9aB3GVmMTU2vjh4JbErr/hUUCh9cIwZ6ZLT751pWBFh83DiS4z/c1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XDFnW6D1Dz1T7xP;
	Wed, 25 Sep 2024 20:06:23 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id DEC1A180AE8;
	Wed, 25 Sep 2024 20:07:48 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 25 Sep 2024 20:07:48 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<cuigaosheng1@huawei.com>, <wangweiyang2@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH -next 2/2] kobject: fix memory leak when kobject_add_varg() returns error
Date: Wed, 25 Sep 2024 20:07:47 +0800
Message-ID: <20240925120747.1930709-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
References: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Inject fault while loading module, kobject_add_varg() may fail.
If it fails, the kset.kobj.name allocated by kobject_set_name_vargs()
may be leaked, the call trace as follow:

unreferenced object 0xffff8884ef4fccc0 (size 32):
  comm "modprobe", pid 56721, jiffies 4304802933
  backtrace (crc 4b069391):
    [<ffffffff85e9fb2b>] kmemleak_alloc+0x4b/0x80
    [<ffffffff83664674>] __kmalloc_node_track_caller_noprof+0x3d4/0x510
    [<ffffffff83510656>] kstrdup+0x46/0x80
    [<ffffffff8351070f>] kstrdup_const+0x6f/0x90
    [<ffffffff84213842>] kvasprintf_const+0x112/0x190
    [<ffffffff85d8446b>] kobject_set_name_vargs+0x5b/0x160
    [<ffffffff85d85969>] kobject_init_and_add+0xc9/0x170
    [<ffffffff83661788>] sysfs_slab_add+0x188/0x230
    [<ffffffff83665e24>] do_kmem_cache_create+0x4d4/0x5a0
    [<ffffffff835343cd>] __kmem_cache_create_args+0x18d/0x310
    [<ffffffffc64a08b4>] 0xffffffffc64a08b4
    [<ffffffffc64a005f>] 0xffffffffc64a005f
    [<ffffffff82a04198>] do_one_initcall+0xb8/0x590
    [<ffffffff82f0c626>] do_init_module+0x256/0x7d0
    [<ffffffff82f12f73>] load_module+0x5953/0x7010
    [<ffffffff82f14b0a>] init_module_from_file+0xea/0x140

To mitigate this, we need to check return value of kobject_add_internal,
and free the name when an error is encountered.

Fixes: 244f6cee9a92 ("kobject: add kobject_add_ng function")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 lib/kobject.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index ecca72622933..365e2ad12cba 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -371,7 +371,13 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 		return retval;
 	}
 	kobj->parent = parent;
-	return kobject_add_internal(kobj);
+	retval = kobject_add_internal(kobj);
+	if (retval) {
+		kfree_const(kobj->name);
+		kobj->name = NULL;
+	}
+
+	return retval;
 }
 
 /**
-- 
2.25.1


