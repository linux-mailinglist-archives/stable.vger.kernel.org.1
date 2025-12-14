Return-Path: <stable+bounces-200966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF860CBBB08
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 14:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BE23008E8F
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C8215F5C;
	Sun, 14 Dec 2025 13:12:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189D1DFE09;
	Sun, 14 Dec 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765717965; cv=none; b=dXCkPu+pDUM8+KjCDvniZ2iNaxkXSl9eqKPXCYBA628lURJDJtB0/AucpDhAlyKtq1MfJiXC7Eij+IKN+7Jomt1Zx4WfXcr/cy1Nrery3wQ+VImg+nNKrkZ5Bsr1U+WsP8o4ydjbcJ0Lwi71cGZuePz2W7iquL08wfW9zj62jAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765717965; c=relaxed/simple;
	bh=D3xlDu2Mc6qc8GNmXFXfJJtfIGj+yfrW6Y9EkS49e9o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Lqc8r0O6SYI5l6tpnMgRt7+sxGYKEMM4/VjrxT7tDw9sK68LQSzyvXv+5TtUw0yH0aGD1Om6eBkuctFiFLj+4gBcpXVeJ+J7m8A5fDLKbCZojuVG7w0JsRlxCbuUM/kBv3REgcKs3W47ysljkAXSt+mr//x2aAV6sG2GxqoN+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACHquGmtz5ppT+zAA--.47783S2;
	Sun, 14 Dec 2025 21:12:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tobias@waldekranz.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Date: Sun, 14 Dec 2025 21:12:04 +0800
Message-Id: <20251214131204.4684-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACHquGmtz5ppT+zAA--.47783S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7uFWkAryrGr4UCrWDXFb_yoW8WF4fpa
	13Gay5KrWDGrZFkr40v3W8C3y2kw4Fk3yfK3yxCw1Skwn3Jr15ZFyjkF1Y9w15ArZ7Cry8
	JFW2qF95AF4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3uc_UUUUU
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

When of_find_net_device_by_node() successfully acquires a reference to
a network device but the subsequent call to dsa_port_parse_cpu()
fails, dsa_port_parse_of() returns without releasing the reference
count on the network device.

of_find_net_device_by_node() increments the reference count of the
returned structure, which should be balanced with a corresponding
put_device() when the reference is no longer needed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: deff710703d8 ("net: dsa: Allow default tag protocol to be overridden from DT")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- simplified the patch as suggestions;
- modified the Fixes tag as suggestions.
---
 net/dsa/dsa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index a20efabe778f..31b409a47491 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1247,6 +1247,7 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
 	const char *name = of_get_property(dn, "label", NULL);
 	bool link = of_property_read_bool(dn, "link");
+	int err = 0;
 
 	dp->dn = dn;
 
@@ -1260,7 +1261,11 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 			return -EPROBE_DEFER;
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, conduit, user_protocol);
+		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
+		if (err)
+			put_device(conduit);
+
+		return err;
 	}
 
 	if (link)
-- 
2.17.1


