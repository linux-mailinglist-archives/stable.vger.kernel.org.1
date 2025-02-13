Return-Path: <stable+bounces-115095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060AA3369A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 05:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7D1886B45
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C920550B;
	Thu, 13 Feb 2025 04:08:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155D204C21;
	Thu, 13 Feb 2025 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419716; cv=none; b=W1Gf39aH8uSiVZKckMcViQJvsiycQRp32E9RLlLgFgBAu1UoOpLlkrnnRmbznx3v1v1piwIgQTr/pg70RhhwNCXTO9aTEcT9vgpZYcpyxo+wm6BIVmTnHRwEDNqM8ZoaMDYwB9hcG2zlon9EeF67FaMNAbfeUJ811m3qQDLFrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419716; c=relaxed/simple;
	bh=qskS6cXyZce5mqRax3SC9fW74H3DglHCMhSAZY7Cv4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4xAbn9nJrEoMv6L4cRpxG44FQ73xfXO+SKJSL231cQC32LnPdZT7wpWAT8a5ci3kkgKwUCKZ52qknHvTi420uVgSh35nnpoz+lZTRDfVor7ksbQ1jqnq5YOZgsD0E/MhXVhxU5NwIbHzvN3kWnCEAGAXimTPTkjjDl5T0QVFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABHT6MqcK1nC5CdDA--.51126S2;
	Thu, 13 Feb 2025 12:08:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: felix:  Add NULL check for outer_tagging_rule()
Date: Thu, 13 Feb 2025 12:07:54 +0800
Message-ID: <20250213040754.1473-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHT6MqcK1nC5CdDA--.51126S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWUGw18Kw4rCFyrXryDGFg_yoWkZFg_Ga
	s2vF93W34Yv3WYyrnxArs5Xryjkw409Fn3W3ZF9ry3J3yDXr1xtF48Zr13JrsrCFy09a9x
	Arn5Wry0g342gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUca9-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwMA2etbr8D4wAAs+

In felix_update_tag_8021q_rx_rules(), the return value of
ocelot_vcap_block_find_filter_by_id() is not checked, which could
lead to a NULL pointer dereference if the filter is not found.

Add the necessary check and use `continue` to skip the current CPU
port if the filter is not found, ensuring that all CPU ports are
processed.

Fixes: f1288fd7293b ("net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/dsa/ocelot/felix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 3aa9c997018a..10ad43108b88 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -348,6 +348,8 @@ static int felix_update_tag_8021q_rx_rules(struct dsa_switch *ds, int port,
 
 		outer_tagging_rule = ocelot_vcap_block_find_filter_by_id(block_vcap_es0,
 									 cookie, false);
+		if (!outer_tagging_rule)
+			continue;
 
 		felix_update_tag_8021q_rx_rule(outer_tagging_rule, vlan_filtering);
 
-- 
2.42.0.windows.2


