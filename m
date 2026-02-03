Return-Path: <stable+bounces-213146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMhnI8JYgWkFFwMAu9opvQ
	(envelope-from <stable+bounces-213146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:09:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A8D39FB
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 711E0300A8F6
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7753F2F12D9;
	Tue,  3 Feb 2026 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jd8m1RH/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1232F12C3;
	Tue,  3 Feb 2026 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084477; cv=none; b=h33JwfQvjMjzandLF4TT2ovmKFJLmUPOR+MzUE6Sz3MCPF3evpHsHfGnVFV80eFWjUX4ueKg0LQCaS0plFBEcSA+AH+6xYjLoyMFkAVLpZ9kEJ58RDpcHt5QIK2dvy/CInKEuUBNXyGwGVFaZ6sI2eyUVJw+mUA6JxgPElr9ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084477; c=relaxed/simple;
	bh=jFKza2X4gHVxNwPsHqjcoR6OhiKUqCsSj+WN6ieXtww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmQXP0RrIr+BvlUP1c1s9CgBahhwPHpC/rmAkfLkS4t5wbXYlf26Ib5kTVFUGXjo035uS6ExT3i2c/GuuVEx8fChJE0jrtNvfzHXaOh5XLbacXkY241XWWysqxLGEEFgFvCUgR+Y80yIqa0tCy3Gr4EDs0BahIruj7if20zZ0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jd8m1RH/; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ci
	U4ATNB9aX0EL3qFSGEVr2hVOabS7xQU44FB8uyVDI=; b=Jd8m1RH/qXKlrJYI5O
	zv5rUx31vU9ZMSPuq1cwDgkOwWgkYAHM1uJFw+07F1dl522ixZ8rh2zZV3Dfcj8F
	ZRNMqmumANd/ChYF34U/W3fUo/YJR/hUdKweZQ9rqlpirkCdi//kSBHFBGiQH6fh
	cS6WsyCojYp+HbK8A3X96tByI=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHPMdTWIFpOcoGJA--.140S2;
	Tue, 03 Feb 2026 10:07:17 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] genirq/irq_sim: Initialize work context pointers properly
Date: Tue,  3 Feb 2026 10:07:14 +0800
Message-Id: <20260203020714.799655-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHPMdTWIFpOcoGJA--.140S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw43try5Zr4xXry7JFW8Zwb_yoW8JFyfpF
	WfGw1Ivr4DWF10ga4UGrn2v34Yg3WDXw47Wan8uFyfXrZ0qwnrXF1DKrWaqry0vrWFgFWj
	vF1Fqa10v3WDAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEc_-sUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hflf2mBWFf68QAA3b
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
	TAGGED_FROM(0.00)[bounces-213146-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: DE6A8D39FB
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
index 0cd02efa3a74..12a1b951341f 100644
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


