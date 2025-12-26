Return-Path: <stable+bounces-203411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2409CDE357
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31953007EF8
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086F1D63F5;
	Fri, 26 Dec 2025 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ATYbKYUo"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08B15E97;
	Fri, 26 Dec 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766714049; cv=none; b=HlDw5n0ESUPsBU5acoF/JniUD50aIvMLef73wRNrQmah/EGQXwVr7BNd4KKMzPdJgyq+4l9jWp+6MMsUnVj5zVJPgG5NrR25GRXXbtGj0saZ3cbMrolO2R/YaJRxjVYaOaZYsiMbEq56g9FdVYbt2P8JlAiIF+GMYoSmeQhFtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766714049; c=relaxed/simple;
	bh=T5+KczoAP1NUwDlN6a69PvYkARmGNe9ONrOwxLlPiUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6/YI8Q4XGiwj2snpJQikWNkLT42p9nndFrSnXRj5a4b4pAQZt07+AS8ou38/SlxBR/hZjvoernQkZCEaEVTw2xhlZ1Dq5WUUNHKcQKQVlEmQL+BPr+geGScTNQDSF7gCaiWR6vp9wdatS9vAIXZ5cCq70XXHFpc0VWrSpAzc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ATYbKYUo; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ww
	bgMuHQZvi+yF5BLaeUFOatTaDISEHlDID+NA7oQGE=; b=ATYbKYUo7O1CwnuaGw
	6jOY6MeT9vFhVpG5Ck52wXfT8PIEfuVZy235eztSTqLmgfJnqatAZMY+HR8HKuT3
	H+f2figyUhZJL8ahA2QzjQR/uVVamMOyGjgk93Jd/l7gfeE0ILVXw/LtOvyaFVTh
	HSLboVQZKmPVByPdleyToNS+Y=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3k6OW6k1pfyWDCQ--.731S2;
	Fri, 26 Dec 2025 09:53:27 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] genirq/irq_sim: Initialize work context pointers properly
Date: Fri, 26 Dec 2025 09:53:07 +0800
Message-Id: <20251226015307.1660054-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3k6OW6k1pfyWDCQ--.731S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43try5Zr4xXry7JFW8Zwb_yoW8JFyfpF
	WfGw1Ivr4DX3WFga4UGrs2vr9Yg3WDXw47Gan8uFyfXrZ0qwnrXF1qqrWaqr10vrWFgFWj
	vF1Fqa1jvw1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE0eHsUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hmOKGlN6plgVgAA3k

From: Gyeyoung Baek <gye976@gmail.com>

[ Upstream commit 8a2277a3c9e4cc5398f80821afe7ecbe9bdf2819 ]

Initialize `ops` member's pointers properly by using kzalloc() instead of
kmalloc() when allocating the simulation work context. Otherwise the
pointers contain random content leading to invalid dereferencing.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612124827.63259-1-gye976@gmail.com
[ The context change is due to the commit 011f583781fa
("genirq/irq_sim: add an extended irq_sim initializer")
which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..bde31468c19d 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -166,7 +166,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 {
 	struct irq_sim_work_ctx *work_ctx;
 
-	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+	work_ctx = kzalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
 		goto err_out;
 
-- 
2.34.1


