Return-Path: <stable+bounces-233748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFE0ASTI1WnA9wcAu9opvQ
	(envelope-from <stable+bounces-233748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 05:14:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA723B685A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 05:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D08573029795
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 03:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2329346F;
	Wed,  8 Apr 2026 03:11:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E002882B4;
	Wed,  8 Apr 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617860; cv=none; b=t2OEGO+Q7UbRssNpw7y46hOODi36fqTg+ULFfDpmnjulM55GXgmK+OgfD6gGX6Cr4+gYf3wGDuMnnVCn2GenyYSuKXoF3EdgV5m4AmFT9M9XRzIF2Urtf54jFbbyZCf1TFEFS/FplfaxFjjnoZtK/LgGe+i43RVIcfu3Yu2OElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617860; c=relaxed/simple;
	bh=VaBGZ1QXqRg76zaGf8gaHSUdkNpNvxf0g9jxhu1rBco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNjNZ8HYwvgqhkDDBR31+Yu0Z0JHtRbDlIBeKFm73icv88zGyiW2q8pWqPlfz40zyWNadJ4ByuO08hB+PwvO6MNTF945WuMvWXXG8bqvrO/8AHXwsx+SpgobKzsGPCxaAsivP9GYxVWVD1jEd5DnQBvZOKSVdrNQu4flD74GIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACXQm4yx9Vp3iqWDA--.31904S2;
	Wed, 08 Apr 2026 11:10:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Georgi Djakov <djakov@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] interconnect: imx: fix use-after-free in imx_icc_node_init_qos()
Date: Wed,  8 Apr 2026 03:10:04 +0000
Message-Id: <20260408031004.309483-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXQm4yx9Vp3iqWDA--.31904S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1UZr4rGr18Cw4kWrW8tFb_yoWkJwc_uF
	18uFZrXF48CF40gwsIyr1fZFyqyw1I9ws3ZF1jqF93t34qvrsxXrsIqw4DZ3y8Xr4Ut34U
	Grn0vFn8Zry7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-a9-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwLA2nVmXqrYwAAsV
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233748-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,iscas.ac.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.825];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4FA723B685A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move of_node_put(dn) after the last use of dn, and add a missing put
in the error path to avoid both use-after-free and reference leak.

Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/interconnect/imx/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 9511f80cf041..75431b5ccef8 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -143,15 +143,16 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 		}
 
 		pdev = of_find_device_by_node(dn);
-		of_node_put(dn);
 		if (!pdev) {
 			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
 				 node->name, node->id, dn);
+			of_node_put(dn);
 			return -EPROBE_DEFER;
 		}
 		node_data->qos_dev = &pdev->dev;
 		dev_dbg(dev, "node %s[%d] has device node %pOF\n",
 			node->name, node->id, dn);
+		of_node_put(dn);
 	}
 
 	return dev_pm_qos_add_request(node_data->qos_dev,
-- 
2.34.1


