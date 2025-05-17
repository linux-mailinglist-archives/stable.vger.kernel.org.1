Return-Path: <stable+bounces-144687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710FABAAA2
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC8F1B60AEC
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237A12CDBE;
	Sat, 17 May 2025 14:16:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759294B1E7B;
	Sat, 17 May 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747491368; cv=none; b=JISDn5y9dP3xW/TALH30a9nTQdjakF3xivYA7SjIFoIXd7kVrhbY6mzGGC2g9ExAMFM9VOh+j/eiGQvaVN8u0kukGyrI7OBu//w11lry6KGv/rkW8X1xQjSpO7ZgJriI9cdiFhd4lC8OJtHuaPE+8OXS4xT9ClvonHiM+lBhyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747491368; c=relaxed/simple;
	bh=Cyi55f33TFKrdJ0x00404yQgvTjATGCAR4OmnV93Qes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbt7b6nCCvGA7AswhiPZ7gJeLmaFQEJo7AnUJzMt/+D8iZEj1gRQMf08J+mU6nyMJBhVf132C3DZpFNzqnZfJG2pKpGjyi1fkBf+14FJ45f54iHW2HEJDNKTnHJnwSGO0O3H15b3E90N7q5VSzLqxVdQBNYBjIYPWy8GXTAw/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.201.46.250])
	by APP-03 (Coremail) with SMTP id rQCowABXa_YFmihouPCZAA--.37394S2;
	Sat, 17 May 2025 22:15:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	lanhao@huawei.com,
	wangpeiyang1@huawei.com,
	rosenp@gmail.com,
	liuyonglong@huawei.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: hns3: Add error handling for VLAN filter hardware configuration
Date: Sat, 17 May 2025 22:15:14 +0800
Message-ID: <20250517141514.800-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXa_YFmihouPCZAA--.37394S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fCw4ruF43tFy5KrykKrg_yoW8Aw47pa
	15Wa98trZ3XF4fJr18GF4SyFy5Zaykt34qqF1DA3WFv3Z8Kr4Dur47W3s2vFyDJrZrGr42
	gr12yFyruw1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsFA2goVCuNrQAAsV

The hclge_rm_vport_vlan_table() calls hclge_set_vlan_filter_hw() but does
not check the return value. This could lead to execution with potentially
invalid data. A proper implementation can be found in
hclge_add_vport_all_vlan_table().

Add error handling after calling hclge_set_vlan_filter_hw(). If
hclge_set_vlan_filter_hw() fails, log an error message via dev_err() and
return.

Fixes: c6075b193462 ("net: hns3: Record VF vlan tables")
Cc: stable@vger.kernel.org # v5.1
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index db7845009252..5ab4c7f63766 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10141,15 +10141,23 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 {
 	struct hclge_vport_vlan_cfg *vlan, *tmp;
 	struct hclge_dev *hdev = vport->back;
+	int ret;
 
 	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
 		if (vlan->vlan_id == vlan_id) {
-			if (is_write_tbl && vlan->hd_tbl_status)
-				hclge_set_vlan_filter_hw(hdev,
-							 htons(ETH_P_8021Q),
-							 vport->vport_id,
-							 vlan_id,
-							 true);
+			if (is_write_tbl && vlan->hd_tbl_status) {
+				ret = hclge_set_vlan_filter_hw(hdev,
+							       htons(ETH_P_8021Q),
+							       vport->vport_id,
+							       vlan_id,
+							       true);
+				if (ret) {
+					dev_err(&hdev->pdev->dev,
+						"restore vport vlan list failed, ret=%d\n",
+						ret);
+					return;
+				}
+			}
 
 			list_del(&vlan->node);
 			kfree(vlan);
-- 
2.42.0.windows.2


