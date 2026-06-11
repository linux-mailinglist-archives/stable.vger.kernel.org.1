Return-Path: <stable+bounces-262742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIHPAKTOKmoMxQMAu9opvQ
	(envelope-from <stable+bounces-262742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FD672EA1
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:05:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=LpBZI8u2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262742-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262742-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34A91310ED3A
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1F23EFD14;
	Thu, 11 Jun 2026 15:02:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767343EE1D3;
	Thu, 11 Jun 2026 15:01:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190124; cv=none; b=G5PVZyewpDntiWpNcM0m60qNWjgXE3NbyJNqACYm2IH+IPrz2iHr1B7mNNzsIUnwHP7mVxyVgcrlQBLbDTx+LZDEe//vc0eYFmga6bGhTca7zoUtwGm3biO4IdYb45sJOemATnLIKl0AeuPwUo8e5jdgec1HV2q5WY8VYHOvo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190124; c=relaxed/simple;
	bh=ZmVmNuX65Goph8N6UbyxibTsBhOkF5GkFPBUbhd/DWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+BsAsnvkmtEbEQvLuy9eizfaI/mHDvXdBvsfFc7rHN+xRhOLk5pucKY7UDww167jp1vPgJc1eWNahpg7af0C5OxY5B2+PTq6GLslLQixa0nTX5wGPsYLFU+/i3V0b0oK4rKmMshIWyPwOCfPg8xTqqukTjge/Z5QYkSiidLJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=LpBZI8u2; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4205c505f;
	Thu, 11 Jun 2026 22:56:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: lee@kernel.org
Cc: jpanis@baylibre.com,
	bhargav.r@ltts.com,
	mwalle@kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] mfd: tps6594: copy regmap IRQ chip descriptors per probe
Date: Thu, 11 Jun 2026 22:56:32 +0800
Message-Id: <20260611145632.2219430-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb72f711903a1kunmc0dd0bed169173
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEtMVhgZSk5NQkpOTE9DSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LpBZI8u2xYt3z0+wCF2/FfO1GT1UH5PKQDlX7OyzpiIHfmu/zOCzYty5xATdmMOphSGi/XcwbhaVVqQEnZ1wyDN5fr6R5ptpbVf+kwaS8d8xxvVHnYo+ZhzsQzdqisw2sIzeI4nWR6W5O2ADlhQgTy2JW1bPKG1X0gfFgRWOlkE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=vAXX1FWY7d0pKj0hRNMAuE1UO3M7K8roEjMfQO+m2CE=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:jpanis@baylibre.com,m:bhargav.r@ltts.com,m:mwalle@kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,irq_chip_copy.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C29FD672EA1

tps6594_device_init() selects one of several shared static
struct regmap_irq_chip templates and then writes the current probe's
irq_drv_data and generated name into that shared descriptor before
passing it to devm_regmap_add_irq_chip().

On a running system this is reachable whenever another TPS6594,
TPS65224, or TPS652G1 instance probes through the same descriptor
family. regmap-irq keeps the raw chip pointer, so the later probe
overwrites the earlier instance's callback context. A later IRQ can
then run tps6594_handle_post_irq() with the wrong struct tps6594,
name, chip_id, regmap, and CRC handling path.

The issue was found on Linux v6.18.21 during manual auditing of drivers
that reuse shared regmap_irq_chip descriptors while filling probe-local
irq_drv_data and name fields before devm_regmap_add_irq_chip(), and was
confirmed with a focused QEMU no-device validation harness. That test
showed a later probe could overwrite the earlier registration's saved
callback context through the shared chip descriptor, while per-probe
descriptor copies preserved callback ownership for both registrations.

Copy the selected descriptor with devm_kmemdup(), mutate only the
copy, and pass that copy to devm_regmap_add_irq_chip(). Also mark the
static descriptors const so probe-local state cannot be written back
into shared templates again.

Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
Fixes: 9d855b8144e6 ("mfd: tps6594-core: Add TI TPS65224 PMIC core")
Fixes: 626bb0a45584 ("mfd: tps6594: Add TI TPS652G1 support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/mfd/tps6594-core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 8b26c4127472..36904979b6b0 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -531,7 +531,7 @@ static int tps6594_handle_post_irq(void *irq_drv_data)
 	return ret;
 };
 
-static struct regmap_irq_chip tps6594_irq_chip = {
+static const struct regmap_irq_chip tps6594_irq_chip = {
 	.ack_base = TPS6594_REG_INT_BUCK1_2,
 	.ack_invert = 1,
 	.clear_ack = 1,
@@ -543,7 +543,7 @@ static struct regmap_irq_chip tps6594_irq_chip = {
 	.handle_post_irq = tps6594_handle_post_irq,
 };
 
-static struct regmap_irq_chip tps65224_irq_chip = {
+static const struct regmap_irq_chip tps65224_irq_chip = {
 	.ack_base = TPS6594_REG_INT_BUCK,
 	.ack_invert = 1,
 	.clear_ack = 1,
@@ -555,7 +555,7 @@ static struct regmap_irq_chip tps65224_irq_chip = {
 	.handle_post_irq = tps6594_handle_post_irq,
 };
 
-static struct regmap_irq_chip tps652g1_irq_chip = {
+static const struct regmap_irq_chip tps652g1_irq_chip = {
 	.ack_base = TPS6594_REG_INT_BUCK,
 	.ack_invert = 1,
 	.clear_ack = 1,
@@ -707,7 +707,10 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 {
 	struct device *dev = tps->dev;
 	int ret;
-	struct regmap_irq_chip *irq_chip;
+	const struct regmap_irq_chip *irq_chip;
+	struct regmap_irq_chip irq_chip_copy;
+	const char *irq_chip_name;
+	void *irq_chip_desc;
 	unsigned int pwr_on, gpio3_cfg;
 	const struct mfd_cell *cells;
 	int n_cells;
@@ -738,15 +741,22 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 		cells = tps6594_common_cells;
 	}
 
-	irq_chip->irq_drv_data = tps;
-	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
-					dev->driver->name, tps->chip_id, tps->reg);
+	irq_chip_name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
+				       dev->driver->name, tps->chip_id, tps->reg);
+	if (!irq_chip_name)
+		return -ENOMEM;
+
+	irq_chip_copy = *irq_chip;
+	irq_chip_copy.irq_drv_data = tps;
+	irq_chip_copy.name = irq_chip_name;
 
-	if (!irq_chip->name)
+	irq_chip_desc = devm_kmemdup(dev, &irq_chip_copy, sizeof(irq_chip_copy),
+				     GFP_KERNEL);
+	if (!irq_chip_desc)
 		return -ENOMEM;
 
 	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
-				       0, irq_chip, &tps->irq_data);
+				       0, irq_chip_desc, &tps->irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add regmap IRQ\n");
 
-- 
2.34.1

