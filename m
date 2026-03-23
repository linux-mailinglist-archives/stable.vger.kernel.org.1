Return-Path: <stable+bounces-227962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANUOFygtwWmbRAQAu9opvQ
	(envelope-from <stable+bounces-227962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:08:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3552F1AAF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B603036EC1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EF37C90E;
	Mon, 23 Mar 2026 12:00:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949738654A;
	Mon, 23 Mar 2026 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267244; cv=none; b=EKBubRVeeW0tFFgKnPDMWyFY0xAuTbmd6eQAsM1BnfVVWfXAnnbJIGbMEZpNqsKo7o0pXJahSK+YEb4UIpmvlBfnr4tDE/xZRCqDBWln1NJQPyCBc8/v1q6uTMqZcKWQMJbSuuNW4ZjUNlhA+nbo06Lq6p2aycLi4M68SYYjmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267244; c=relaxed/simple;
	bh=DcxRYRNdYwZfYPexQSZiTBmbCbm56NCY5EQJTOmVzKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pbco3TlpeRN/vi6spf9F8JbN7G9XgEU3E2I/hKocaoPHl1JpJ9/oKCfScrUZDsIA9o/gmzNG7kbVqS7H2e4XPyiOyitV1MDKK9/eYUzg3UNtaPJ8Qr5WEy7hGhPzfSaHv4Dp/tPgsXapXRVKyE98SucY+urHue3hCFstYlZctFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from yzs (unknown [115.192.255.131])
	by APP-05 (Coremail) with SMTP id zQCowAD3hAhEK8Fp9qw5Cw--.39901S2;
	Mon, 23 Mar 2026 20:00:04 +0800 (CST)
From: Zishun Yi <vulab@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zishun Yi <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: cacheinfo: Fix node reference leak in populate_cache_leaves
Date: Mon, 23 Mar 2026 19:59:57 +0800
Message-ID: <20260323115957.38348-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3hAhEK8Fp9qw5Cw--.39901S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4Duw18XF4rKF4xtw13Jwb_yoW8JFy3pr
	W2krWYyry8Gr4xKa4Iyrs7W3y0qas7WrsxC3Z7CF1UZwsxXry5Xwn5X34YqrnYvFyrZryS
	vr1UKw4Ivwn5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsPA2nA5q74rwABs2
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD3552F1AAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the while loop drops the reference to prev in each iteration.
If the loop terminates early due to a break, the final of_node_put(np)
correctly drops the reference to the current node.

However, if the loop terminates naturally because np == NULL, calling
of_node_put(np) is a no-op. This leaves the last valid node stored in
prev without its reference dropped, resulting in a node reference leak.

Fix this by changing the final `of_node_put(np)` to `of_node_put(prev)`.

Fixes: 94f9bf118f1e ("RISC-V: Fix of_node_* refcount")
Cc: stable@vger.kernel.org
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
---
I saw 37233169a6ea ("riscv: Prevent a bad reference count on CPU nodes")
added the stable tag and fixed a similar issue, so I included it here as
well.

 arch/riscv/kernel/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 26b085dbdd07..6c9a1ef2d45a 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -133,7 +133,7 @@ int populate_cache_leaves(unsigned int cpu)
 			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}
-	of_node_put(np);
+	of_node_put(prev);
 
 	return 0;
 }
-- 
2.51.2


