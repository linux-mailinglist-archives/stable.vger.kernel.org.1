Return-Path: <stable+bounces-235338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKuTK0Rc12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 156023C75C8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7C1301052E
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FA388E49;
	Thu,  9 Apr 2026 07:58:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD038756A;
	Thu,  9 Apr 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721520; cv=none; b=G7ujpN5DfMGfg1M67ZY+z3u8GEHpiBQ5vwWy2bwzjha7+IcfIU+FQi0eqMNZn4c84LIRJqAoUphEx+1uBMB1w/8nwk15L75UiBXv3nfrhpg9Y8XRdSJM6vPDaSVvSu2dKY7cgJGMHSnWZ5Ga3M987I1ZTrA+W4oSji/3pai4US4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721520; c=relaxed/simple;
	bh=xR3BpzMxQUQWQmQQbb/dxdMBGhvi+ZesvUDNMqmNpyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOigabeM2amFNX6o08fs74CQ42CXWCFPSPH6eRluWgr01O4pR679F3oPxi4eZbJQGnOMlR3837kTb3ZEzy7w+c6MaCHUSkbPJv3ZZxVzEl7Ihdzwqt+ATNKDwaF66cUvP01Vhjp6rLe87+/AXlaLZQjJ2RTeIM4qJJVurO2+eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3CAwcXNdp9wwJDQ--.7625S2;
	Thu, 09 Apr 2026 15:58:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: peda@axentia.se
Cc: kees@kernel.org,
	thorsten.blum@linux.dev,
	vulab@iscas.ac.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mux: core: fix use-after-free in mux_get()
Date: Thu,  9 Apr 2026 07:58:09 +0000
Message-Id: <20260409075809.462431-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3CAwcXNdp9wwJDQ--.7625S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWDtFykuFy3GFW8Kw48JFb_yoW8Ww1rpr
	4DXrWSvF1rGrs7AF1F9ryUGFy3KF4fKFWfJ3s7Kw1IvrnxGa48AF1UZrZYkr45AFy8X3WD
	Ar18JF18AF4FyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUgL05UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwMA2nW92+qhQABsN
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235338-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid,args.np:url]
X-Rspamd-Queue-Id: 156023C75C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mux_get(), of_node_put(args.np) is called prematurely in error paths
before the last access to args.np, leading to a use-after-free if the
node is freed. Move the of_node_put() calls after the last use of args.np
to prevent this.

Fixes: 84564481bc45 ("mux: Add support for reading mux state from consumer DT node")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mux/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index f09ee8782e3d..113af77c3ee2 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -564,9 +564,10 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 	}
 
 	mux_chip = of_find_mux_chip_by_node(args.np);
-	of_node_put(args.np);
-	if (!mux_chip)
+	if (!mux_chip) {
+		of_node_put(args.np);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	controller = 0;
 	if (state) {
@@ -575,8 +576,10 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 			dev_err(dev, "%pOF: wrong #mux-state-cells for %pOF\n",
 				np, args.np);
 			put_device(&mux_chip->dev);
+			of_node_put(args.np);
 			return ERR_PTR(-EINVAL);
 		}
+		of_node_put(args.np);
 
 		if (args.args_count == 2) {
 			controller = args.args[0];
@@ -591,9 +594,11 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 			dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
 				np, args.np);
 			put_device(&mux_chip->dev);
+			of_node_put(args.np);
 			return ERR_PTR(-EINVAL);
 		}
 
+		of_node_put(args.np);
 		if (args.args_count)
 			controller = args.args[0];
 	}
-- 
2.34.1


