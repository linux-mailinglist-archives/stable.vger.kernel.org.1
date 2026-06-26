Return-Path: <stable+bounces-268973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c3mbNyWaPmpvIwkAu9opvQ
	(envelope-from <stable+bounces-268973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:26:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6BE6CE768
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268973-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268973-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E79B2303E075
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501D379C55;
	Fri, 26 Jun 2026 15:14:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200F3803F4;
	Fri, 26 Jun 2026 15:14:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486849; cv=none; b=Wk1MpEK0YHXCihYTYe9Rs4l5ihdr8sZuoSj14bbCjYmvN39ccuB3564UG2iWRx7Bbjb8g6rdBlASwv6CfRD+uYQbKSuIafpEiHkVpT13CCvFowgl7Pn8FQ30qwV8m7vn4agTRvtquqtLRbwdVJM3DSvb/MGPptwW87J9Pm3BLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486849; c=relaxed/simple;
	bh=0JBfbjU+Cjz8KXQEvDUmHnWYb6aQ53yQyfWFDCbrkEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZQjej50KWdP34HFRn8H/VFAkrtEW2GN5zCGQgbsvBn/FIySK4Iorbxpl/lyMdysC0aofkC/KoFhbT06hxbA/zlAzKnDPbOfkkT1vk9A7oIu4AVBch6uqBrfa51I2XlXSEJVY8zhiClN9LViQ63Kp3hZSTrZNdSnxbyxDxi9cA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHoMgtlz5qlbRrAw--.16713S2;
	Fri, 26 Jun 2026 23:13:50 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: mtd: mtd_device_parse_register: fix refcount imbalance on   add_mtd_device failure and multi-call scenarios
Date: Fri, 26 Jun 2026 23:13:49 +0800
Message-Id: <20260626151349.50859-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHoMgtlz5qlbRrAw--.16713S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43GrW3JrWUJrykAF15CFg_yoW8tF48p3
	98Wa95A34jgr4j9w4DW3WDWFWUWF92y3yrur47Gw12kws5G34YqFZ8KFy7Ww1UtrWxCF4j
	qF4xXws5Ca18A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjd-PU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMKA2o+h0EucAACsC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268973-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:richard@nod.at,m:linux-mtd@lists.infradead.org,m:vigneshr@ti.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC6BE6CE768

add_mtd_device initializes mtd->refcnt via kref_init unconditionally. The
  cleanup in the out label only calls del_mtd_device when
  device_is_registered is true. When add_mtd_device fails before
  device_register, the refcnt is left at 1 (leak). Conversely, when
  CONFIG_MTD_PARTITIONED_MASTER is disabled and the device was already
  registered by a prior call, the error path incorrectly calls
  del_mtd_device without a matching add_mtd_device in this invocation,
  causing a refcount underflow.

Track whether add_mtd_device succeeded in this invocation with a
  registered flag, and only call del_mtd_device on error when registered is
  true.

Cc: stable@vger.kernel.org
Fixes: 1c4c215cbdcb ("mtd: add new API for handling MTD registration")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/mtdcore.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 576537774628..59d8a6c61f55 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1108,6 +1108,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 			      int nr_parts)
 {
 	int ret, err;
+	bool registered = false;
 
 	mtd_set_dev_defaults(mtd);
 
@@ -1119,6 +1120,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		ret = add_mtd_device(mtd);
 		if (ret)
 			goto out;
+		registered = true;
 	}
 
 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
@@ -1136,9 +1138,11 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		ret = 0;
 	else if (nr_parts)
 		ret = add_mtd_partitions(mtd, parts, nr_parts);
-	else if (!device_is_registered(&mtd->dev))
+	else if (!device_is_registered(&mtd->dev)) {
 		ret = add_mtd_device(mtd);
-	else
+		if (!ret)
+			registered = true;
+	} else
 		ret = 0;
 
 	if (ret)
@@ -1170,7 +1174,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		nvmem_unregister(mtd->otp_factory_nvmem);
 	}
 
-	if (ret && device_is_registered(&mtd->dev)) {
+	if (ret && registered) {
 		err = del_mtd_device(mtd);
 		if (err)
 			pr_err("Error when deleting MTD device (%d)\n", err);
-- 
2.39.5 (Apple Git-154)


