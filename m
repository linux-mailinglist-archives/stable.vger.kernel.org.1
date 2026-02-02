Return-Path: <stable+bounces-213033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAd5FKlggGlj7AIAu9opvQ
	(envelope-from <stable+bounces-213033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:30:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0DC9B15
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA2A300EAAD
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737B30FC22;
	Mon,  2 Feb 2026 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aF8rzc2g"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68E352F80;
	Mon,  2 Feb 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020907; cv=none; b=BIgrI7Iat+E2FKPdfOH26RvTDxmxOiYbFxz1SoPFxah2dpT/5Yp8pQ6Z59LzvKQnAR/7X3aPkanhtmxkcDHMcax6y0a5CKvWkmUELO+ly8gbTxcKivezlIxugXDFXSgHDaAW+UOiU0zgZGMN0LiRo+otehHo2D4MSMNLzd0xQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020907; c=relaxed/simple;
	bh=T5+KczoAP1NUwDlN6a69PvYkARmGNe9ONrOwxLlPiUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mkX5a7JGO5pfvJG9O9geND4212BB/uPkXQpkQmC+6XDQ5NLe1Qk/fxtzKDow0Vtwi6Dw+vqW3WVQVIDEQ3GfjlSsX/XUklq4m26QdYqIA/LFXjQYiFy+DCQS/NCfD0lQtG+sojQrtvrzyVoJfqTnpjsbE8phn/gY3n3p/mLFznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aF8rzc2g; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ww
	bgMuHQZvi+yF5BLaeUFOatTaDISEHlDID+NA7oQGE=; b=aF8rzc2gKyPZehJdVE
	cQHPLKEP6d2R7V8GcnTpwCtGI4tOdIJ9MR2KBMsj1YRg68SGG9pk1lF087weor4O
	uqnEb/I3zOsVGvMs32tzRzrw8REtO9JEr4bCXvhAn+QzgViC7w01x1w8B3OAgtMC
	Inb5hEg90AkB/JWlhyGfR5e20=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3+50DYIBpLJNtJQ--.520S2;
	Mon, 02 Feb 2026 16:27:49 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y] genirq/irq_sim: Initialize work context pointers properly
Date: Mon,  2 Feb 2026 16:27:28 +0800
Message-Id: <20260202082728.975184-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3+50DYIBpLJNtJQ--.520S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43try5Zr4xXry7JFW8Zwb_yoW8JFyfpF
	WfGw1Ivr4DX3WFga4UGrs2vr9Yg3WDXw47Gan8uFyfXrZ0qwnrXF1qqrWaqr10vrWFgFWj
	vF1Fqa1jvw1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pN-e5XUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QWTLWmAYAWYmwAA3p
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linutronix.de,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B0DC9B15
X-Rspamd-Action: no action

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


