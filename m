Return-Path: <stable+bounces-202950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB291CCB04F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3751230115F5
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4B261B91;
	Thu, 18 Dec 2025 08:53:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C719D071;
	Thu, 18 Dec 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047986; cv=none; b=WSs5D2JHmS5YOTYosKRzDzCcmlw1+AOBzaXiRi/nwP2gIeDlO51HhO5kmyHx/J/hgMgD11e+FtpEZW4WAl9sLcYh/bZmuI1lSTDC0lowozvu4QH8OmBUtXEiV1xXJk9C+fmv0vqKcbXU4v4gSizt2BzOd0Nq/zrszrCSo20fKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047986; c=relaxed/simple;
	bh=jDC2f7fSMCqZlhsxRcVwu9MVDd0mKfBCfe3KxOqwvJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jijbq2wJW4KrMzithC5fN6Cp23llGfgiK2BY7ep/LEcBxSExRAg9oALMo6aXy83wTWEwCjMRyQUs5j6ZNz7LxTL4BhKPz6p9LkF03sqO+przrQ8o/WSd4bvWl8Wf1+fzExgE3P+ZwafkOpmiSozyB/cmu15pVFr7gaEmIVJDnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowACnOQ3kwENpAUcQAQ--.6037S2;
	Thu, 18 Dec 2025 16:52:52 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	Jonathan.Cameron@huawei.com,
	kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] node: fix a api misuse in node_init_node_access()
Date: Thu, 18 Dec 2025 16:52:51 +0800
Message-Id: <20251218085251.555749-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnOQ3kwENpAUcQAQ--.6037S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF17uF1kCF1kKFyktF43Jrb_yoWDurX_CF
	4rZ34xGFy5GFs5CFZ8ZF15ZryvkF1kWr1vyFnrKryft3y3JFWDKryYvFn8JrWjgr42vryD
	C34UtF1xGw1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkAE2lDlnOvMgAAsP

If device_register() fails, put_device() is the correct way to
cleanup the resource.
And free the dev name is unnecessary.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/base/node.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 00cf4532f121..28c89ad67d0b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -170,14 +170,15 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	if (dev_set_name(dev, "access%u", access))
 		goto free;
 
-	if (device_register(dev))
-		goto free_name;
+	if (device_register(dev)) {
+		put_device(dev);
+		return NULL;
+	}
 
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
-free_name:
-	kfree_const(dev->kobj.name);
+
 free:
 	kfree(access_node);
 	return NULL;
-- 
2.25.1


