Return-Path: <stable+bounces-268319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gvYGBbD2PGpavAgAu9opvQ
	(envelope-from <stable+bounces-268319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:36:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D06C44B4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:36:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268319-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268319-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C42E301D4EB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55423A9611;
	Thu, 25 Jun 2026 09:36:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903563806D0;
	Thu, 25 Jun 2026 09:36:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380196; cv=none; b=lMwKL0O14bjSo7AAs9ClKIkoNKcZ1wY5DE1TiQlK9azhhAFIdkWLC36phQUMwiADrvpXLZHy4ByKnjDf7ojoyZl+Vkn11vgvZtWULIOBPei/sf+dYxgMpKthmtt0BXWxNa5so0D2zBl5Zy2Y7xxJbs1hppuX6UBdtcsx+uHBRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380196; c=relaxed/simple;
	bh=r75Y193apzjEpbDsuC3Hz8LTWSRwFRebQwv5lOBl9Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dke99j9vakxv2Eo7ADKhlVeS7WpfWmnSpwdlQ5zLpfv37yVwTV9MwIWWr9u4egLmOKDSKzTePl2bN4pD9gq2k7/3YaPtHh5iaVFEgoVAQUhwjgLiApSuvdrrzFaiYEex/DJsEwsJAAmgmoc6QXuIJlzAuot2CBvY+lzjX5fwxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowACXjbSY9jxqRVDNFQ--.7735S2;
	Thu, 25 Jun 2026 17:36:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: axboe@kernel.dk
Cc: kees@kernel.org,
	objecting@objecting.org,
	vulab@iscas.ac.cn,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] block/partitions/of: Fix of_node reference leak in of_partition()
Date: Thu, 25 Jun 2026 17:36:22 +0800
Message-Id: <20260625093622.48308-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXjbSY9jxqRVDNFQ--.7735S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13Jr48ur4DXF43KF45Wrg_yoW8CFykpr
	sxK3yYyrWUGr1fC348XF1xuw4Ygan7JrWDtr17t34Syr1DXwsrtFWj93yjvws0qFZ5G3y7
	Za4jgFykX3W7Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUJA2o83vNmrwAAsx
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-268319-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:kees@kernel.org,m:objecting@objecting.org,m:vulab@iscas.ac.cn,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F4D06C44B4

of_partition() calls of_node_get(ddev->of_node) at entry to take a
reference on the device node, but only releases it on the validation
error path. On three other exit paths the reference is leaked:

  - When the device node is not compatible with "fixed-partitions",
    the function returns 0 without calling of_node_put().
  - On normal success (return 1), partitions_np is never released.
  - When the partition slot limit is reached in the second child
    loop (break followed by return 1), partitions_np is also leaked.

Fix by splitting the NULL check from the compatible check so that
of_node_put() can be called before the early return on incompatibility,
and add of_node_put(partitions_np) before the final return 1 to cover
both the normal and the break paths.

The NULL case is safe because of_node_get(NULL) is a no-op.

Cc: stable@vger.kernel.org
Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/partitions/of.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b60661098..afaaae5e72a1 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -73,9 +73,12 @@ int of_partition(struct parsed_partitions *state)
 
 	struct device_node *partitions_np = of_node_get(ddev->of_node);
 
-	if (!partitions_np ||
-	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+	if (!partitions_np)
 		return 0;
+	if (!of_device_is_compatible(partitions_np, "fixed-partitions")) {
+		of_node_put(partitions_np);
+		return 0;
+	}
 
 	slot = 1;
 	/* Validate parition offset and size */
@@ -104,5 +107,7 @@ int of_partition(struct parsed_partitions *state)
 
 	seq_buf_puts(&state->pp_buf, "\n");
 
+	of_node_put(partitions_np);
+
 	return 1;
 }
-- 
2.39.5 (Apple Git-154)


