Return-Path: <stable+bounces-233827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAllLLot1mkUBggAu9opvQ
	(envelope-from <stable+bounces-233827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:28:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5833BA837
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80543011C7A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A43314D0;
	Wed,  8 Apr 2026 10:25:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E93B4E88;
	Wed,  8 Apr 2026 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643931; cv=none; b=nbV+5DA8lo0/gugygi2QKfS14l7ATENcfoNxwQPihJ6euEW93vSZJLnwtzXVYB2IfUcNX3vAysJCv271OYXe1pwK/pk0XxiAul0wTJa6Ycu174ma2dk0pry20AuqIzLfWclKheuDyit1JVCCwZG2/8NEJvikO0vCmpnzXIYQ0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643931; c=relaxed/simple;
	bh=AOUKX/Kpqxmge+VcST9+k1v1uMnqhVqVyIHwQEbIztQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSnVrnuaTXtCjMA+Ao/XnT0pjCyDX9fJ7cqgaEZ1I2C3OTtIrn8zNkSyubBEW42kfJyIHCXw5jNu8iGL2utq/YlasvbdVUuwh4vhKaykXNYNBTawWRsLY/Sofa7ecFx195dUzFdaRYKqPw3CCIkGbsyh2eQ/hMBAuoMGfuwlcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADXZQkNLdZp36DuDA--.59696S2;
	Wed, 08 Apr 2026 18:25:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: kabel@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bus: moxtet: fix use-after-free in of_register_moxtet_devices()
Date: Wed,  8 Apr 2026 10:25:16 +0000
Message-Id: <20260408102516.360357-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXZQkNLdZp36DuDA--.59696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xWrWUuw1DCFykCryxuFg_yoW5CFyfpa
	1rWasxtrW8Wa18ur4qyayrJa4Fqrn5tw48Cr1xGwnak3s0yry8t34UJFy7C3sYyFyrZa43
	tF1Utr1jka1UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgiSdUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkLA2nWHcA6NAAAsq
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233827-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.904];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 0D5833BA837
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In of_register_moxtet_device(), one error paths release the device
node via of_node_put(nc) before returning an error pointer. However,
the caller of_register_moxtet_devices() continues to access the node
when it clears the OF_POPULATED flag on error, leading to a
use-after-free condition.

Fix this by moving the OF_POPULATED flag clearing into the callee's
error paths, before the of_node_put() is performed. Remove the
redundant error handling and warning in the caller, which is no longer
needed after the change.

Fixes: 5bc7f990cd98 ("bus: Add support for Moxtet bus")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/bus/moxtet.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 0d68c1a9f493..dc6b41cb4e2f 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -212,6 +212,7 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 	if (!dev) {
 		dev_err(moxtet->dev,
 			"Moxtet device alloc error for %pOF\n", nc);
+		of_node_clear_flag(nc, OF_POPULATED);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -219,7 +220,7 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 	if (ret) {
 		dev_err(moxtet->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, ret);
-		goto err_put;
+		goto err_clean;
 	}
 
 	dev->idx = val;
@@ -228,7 +229,7 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x out of range\n",
 			nc, dev->idx);
 		ret = -EINVAL;
-		goto err_put;
+		goto err_clean;
 	}
 
 	dev->id = moxtet->modules[dev->idx];
@@ -237,7 +238,7 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 		dev_err(moxtet->dev, "%pOF Moxtet address 0x%x is empty\n", nc,
 			dev->idx);
 		ret = -ENODEV;
-		goto err_put;
+		goto err_clean;
 	}
 
 	of_node_get(nc);
@@ -247,12 +248,15 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 	if (ret) {
 		dev_err(moxtet->dev,
 			"Moxtet device register error for %pOF\n", nc);
+		of_node_clear_flag(nc, OF_POPULATED);
 		of_node_put(nc);
 		goto err_put;
 	}
 
 	return dev;
 
+err_clean:
+	of_node_clear_flag(nc, OF_POPULATED);
 err_put:
 	put_device(&dev->dev);
 	return ERR_PTR(ret);
@@ -260,7 +264,6 @@ of_register_moxtet_device(struct moxtet *moxtet, struct device_node *nc)
 
 static void of_register_moxtet_devices(struct moxtet *moxtet)
 {
-	struct moxtet_device *dev;
 	struct device_node *nc;
 
 	if (!moxtet->dev->of_node)
@@ -269,13 +272,7 @@ static void of_register_moxtet_devices(struct moxtet *moxtet)
 	for_each_available_child_of_node(moxtet->dev->of_node, nc) {
 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
 			continue;
-		dev = of_register_moxtet_device(moxtet, nc);
-		if (IS_ERR(dev)) {
-			dev_warn(moxtet->dev,
-				 "Failed to create Moxtet device for %pOF\n",
-				 nc);
-			of_node_clear_flag(nc, OF_POPULATED);
-		}
+		of_register_moxtet_device(moxtet, nc);
 	}
 }
 
-- 
2.34.1


