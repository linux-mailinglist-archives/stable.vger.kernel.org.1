Return-Path: <stable+bounces-77512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5F985DF4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B00B1F24F5D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6E20850F;
	Wed, 25 Sep 2024 12:07:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2D1B5829;
	Wed, 25 Sep 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266079; cv=none; b=oiE3FcAqfXn1L7SSU6lzk8BmWCipY0jcJ6W1quqRVz9LLvRb/UAT9QG9sWrNZGo0meoB9IQUHXf9Zld1L52Xtv42AdOnehzxMsoftP8cLyrwDh1BzqtuasUIORjYbkhkDTlD//iZ85dHuxqW7DBSmR+nRFdhHBO84cpr1zKxlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266079; c=relaxed/simple;
	bh=cdhkjTe9uFvt2/UW/vfC2+D1KZldNIpOdMEaT30Az7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw6u6woYDbiXXDDcqVaEM517yOLnSnBarjJQOiLTG7avIJB4Ne/zs6U+g/hLqRFISq+OVH2j4iL4caT6AuD/LCI85VopTR+wFbfDM7q72j/MOaHuyXupL30ZQsZ96Xsgc+RHyScFPi+3RORGrbnQLSIzNtXBS85eSGZnTc2AlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XDFpl1Jh6z20pKZ;
	Wed, 25 Sep 2024 20:07:27 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 843231A0188;
	Wed, 25 Sep 2024 20:07:48 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 25 Sep 2024 20:07:47 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<akpm@linux-foundation.org>, <thunder.leizhen@huawei.com>,
	<cuigaosheng1@huawei.com>, <wangweiyang2@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH -next 1/2] kobject: fix memory leak in kset_register() due to uninitialized kset->kobj.ktype
Date: Wed, 25 Sep 2024 20:07:46 +0800
Message-ID: <20240925120747.1930709-2-cuigaosheng1@huawei.com>
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

If a kset with uninitialized kset->kobj.ktype be registered,
kset_register() will return error, and the kset.kobj.name allocated
by kobject_set_name() will be leaked.

To mitigate this, we free the name in kset_register() when an error
is encountered due to uninitialized kset->kobj.ktype.

Fixes: 4d0fe8c52bb3 ("kobject: Add sanity check for kset->kobj.ktype in kset_register()")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 lib/kobject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 72fa20f405f1..ecca72622933 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -862,6 +862,8 @@ int kset_register(struct kset *k)
 		return -EINVAL;
 
 	if (!k->kobj.ktype) {
+		kfree_const(k->kobj.name);
+		k->kobj.name = NULL;
 		pr_err("must have a ktype to be initialized properly!\n");
 		return -EINVAL;
 	}
-- 
2.25.1


