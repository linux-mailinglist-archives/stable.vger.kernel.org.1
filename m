Return-Path: <stable+bounces-233931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLh2DKl01mkWFggAu9opvQ
	(envelope-from <stable+bounces-233931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:30:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EFD3BE36C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF8C5300621F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28626E165;
	Wed,  8 Apr 2026 15:30:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9B24B28;
	Wed,  8 Apr 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662241; cv=none; b=a2afNoSEuh7mqRtyKbZgEvF8M/iv5qmOxyp7X/BLMsdq4Gj2ZBKHP2Cvx+9AVlRiAU8sK/akg0sq5J1+C1EgHoVRRt3izZ9s+R5S7NygI2816E1gMxw2Af0DiYn999REGmEx3+pMA/9kf/rcmXBQraf2dnmjoX+bNdvRA1OB0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662241; c=relaxed/simple;
	bh=EqGQQ7hv5YLeBJksfSko2YUPrBgfkPRyP0dPm3UegGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pq5t3rXFqyPzarWCTI1Wp4uoz7DUUqM89fhcBgPz9bjIRLkwk+9pfeNNXbGMozVH4iuZ3YvoqjgonKerRp7+VzA00uCNkLhfB2jBxcwdQbKJ6Pu6RaB5GJsjse817yvoNFdXmfhGmHFubiOCY3VpqDq/dUST6DDy4Ur8mQeOHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAAntwqVdNZprBT1DA--.63068S2;
	Wed, 08 Apr 2026 23:30:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Georgi Djakov <djakov@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] interconnect: imx: fix use-after-free in imx_icc_node_init_qos()
Date: Wed,  8 Apr 2026 15:30:22 +0000
Message-Id: <20260408153022.401123-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntwqVdNZprBT1DA--.63068S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur45WFyUuw4UuFWUXry5Jwb_yoW8Zw1fpF
	W5GFWakry7WF4Ig3yvyw1q9Fyay342krZYgrW8G39Ig3s5tryrXry0y34rC3WrGryxAryF
	yrWUtw1j9a15CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3HUDUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkLA2nWbuALQwAAs-
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-233931-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,iscas.ac.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.802];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3EFD3BE36C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function imx_icc_node_init_qos() manually manages the reference count
of struct device_node *dn using of_node_put(). However, some error paths
use dn after the put, leading to use-after-free. Convert to automatic
cleanup using __free(device_node) to ensure the reference is always
released when dn goes out of scope.

Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Use auto cheanup to fix the problem.
---
 drivers/interconnect/imx/imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 9511f80cf041..e5fcdcb88cfb 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -120,7 +120,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 	struct imx_icc_node *node_data = node->data;
 	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
 	struct device *dev = provider->dev;
-	struct device_node *dn = NULL;
+	struct device_node *__free(device_nod) dn = of_parse_phandle(dev->of_node,
+			adj->phandle_name, 0);
 	struct platform_device *pdev;
 
 	if (adj->main_noc) {
@@ -128,7 +129,6 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 		dev_dbg(dev, "icc node %s[%d] is main noc itself\n",
 			node->name, node->id);
 	} else {
-		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
 		if (!dn) {
 			dev_warn(dev, "Failed to parse %s\n",
 				 adj->phandle_name);
@@ -138,12 +138,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 		if (!of_device_is_available(dn)) {
 			dev_warn(dev, "Missing property %s, skip scaling %s\n",
 				 adj->phandle_name, node->name);
-			of_node_put(dn);
 			return 0;
 		}
 
 		pdev = of_find_device_by_node(dn);
-		of_node_put(dn);
 		if (!pdev) {
 			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
 				 node->name, node->id, dn);
-- 
2.34.1


