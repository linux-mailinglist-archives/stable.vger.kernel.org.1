Return-Path: <stable+bounces-246904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPUnIkeZBGqILwIAu9opvQ
	(envelope-from <stable+bounces-246904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:31:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C835362DD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6A57308DB15
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA2495531;
	Wed, 13 May 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="jRxw0N9D"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AF494A00;
	Wed, 13 May 2026 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685245; cv=none; b=hzjVNJN6qhxLI+L8kHiDCZydHuWRrGO/t3/oAWlLGaBL9Rs06YZzVkqHZgCJG8+CqSwOECsSE+ykvQfOl0yJB86+AAlPoiH51hsDe2dEsAqsvg9qzA/fKAyBS+Wbpza084Ty7E2tY4M5MvXIxASahL0gdQYS8fIcvBVtqt1tnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685245; c=relaxed/simple;
	bh=jr1uCbXzPOI5jlgob/d6VQkhNdVVwkXU+GXgAodbg4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dsm5hrFhzCnG/NsFg0tdg1/LqSziY8scjMqb/spdY0Iv+tFppecyhCIgFmP/LMt8gkQvSWuqhIDVUolt4cLXJ1/MxKG64ZRxnhAUuSD/2EEpR6S5mxZ40n9y86SB2i7G+Z6ND89O7rv7jz7jN4ie2sRGlhuI6sHziNpgY1Gltp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=jRxw0N9D; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3e4819849;
	Wed, 13 May 2026 23:13:49 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sgoutham@marvell.com
Cc: gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
Date: Wed, 13 May 2026 23:13:20 +0800
Message-Id: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e21e6b9ab03a2kunmeb1bcee240f47
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSklLVhkZSkpNSU1PQk1ISlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=jRxw0N9Dokpw4f5XYfkWGi3kNF3YWXJfAepgcFiDaPbf/f/90dkLa0KkOjBavCBB0RExs0hc70Wovb5RZnArAKZnaMygvTYuAAObef3BNWJDPnxeoQPasCyXe1JfSqT2Ue2lY6fb8pWEc2X39zh19Ub17P4yuVIUsepQWO2sJ0Y=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=W0FkMjhAS3TdO0vToK7D5NC5wfrqAeVfjl99ako6Xoo=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: 85C835362DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-246904-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Action: no action

rvu_rep_rsrc_init() allocates queue memory before calling
otx2_init_hw_resources(). When hardware resource setup fails,
otx2_init_hw_resources() already unwinds the partially initialized
SQ, CQ, and aura state before returning an error. The representor
error path then calls otx2_free_hw_resources() again and can free
the same resources a second time.

Fix this by splitting the cleanup labels so that a failure from
otx2_init_hw_resources() only releases queue memory. Keep the
otx2_free_hw_resources() call for failures that happen after
hardware resource initialization completed successfully.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime validation was not performed because reproducing this path
requires OcteonTX2 representor hardware.

Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 94f155ffb17f..0f5d5642d3f7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -609,7 +609,7 @@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
 
 	err = otx2_init_hw_resources(priv);
 	if (err)
-		goto err_free_rsrc;
+		goto err_free_mem;
 
 	/* Set maximum frame size allowed in HW */
 	err = otx2_hw_set_mtu(priv, priv->hw.max_mtu);
@@ -621,6 +621,7 @@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
 
 err_free_rsrc:
 	otx2_free_hw_resources(priv);
+err_free_mem:
 	otx2_free_queue_mem(qset);
 	return err;
 }
-- 
2.34.1


