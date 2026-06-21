Return-Path: <stable+bounces-267519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qjfPAy5YN2rXMgcAu9opvQ
	(envelope-from <stable+bounces-267519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 05:19:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E65676AA116
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 05:19:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=HQ1ky3GI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267519-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267519-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FF6830034A9
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB62D9796;
	Sun, 21 Jun 2026 03:19:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14072623;
	Sun, 21 Jun 2026 03:18:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782011940; cv=none; b=YHYwfwbSTp9GebO9ap+TubI7d2Kl3qGWjk1GUaOsN0kEev5Hllo3eny65LA7vv4WtN1kJ9GGabqHP8Z98Q4SbeKMctbjgDtJ4gNq3gJuEwMwBzz+Xj2xW71+I/UXA77oFFRZP/1hbC/B6eaKMGLbfTtcVfk+5o5QPpBPj48l39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782011940; c=relaxed/simple;
	bh=mkbMD+7zYAGDcZYs3QlObBY1EwK96OR38KEFRiqawnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+/hHNuRlVQZC7Gi2/4gs6vkJJhRACWvCFI7CxIx1J8pFVMGBCtD1wVoCQdLAikYiz6iNsP6lSRWOUAsEqOlru0OnNMnHYe13RLk2WbWHbP0K+h/HLdvcPee7cqfObHYtSMS1h44rvQglu/F8GwLMRsjRBawxAUkubBGPjLncyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HQ1ky3GI; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ms
	ZxSSxn9EyZY/UGjk9JvrVC6Nu7xVFKZEtKn+1E0AM=; b=HQ1ky3GIyAQ7N04dit
	aDgAarWX5h/j3jt8r30H2IFzMoCmCI5nBKz7to9/N16d8S86fcXcBsrs4H4x65eR
	R4DXnRHUV5Z2xc7XIoH9mln6H48nu1dr05Vstu3R66DfbgRiSoFwxEm71Imtd0Rv
	KsYJV+7JlZtBNjnYw3jG1LnOk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnsXi6Vzdq_vrOEw--.27839S2;
	Sun, 21 Jun 2026 11:17:16 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: chandrashekar.devegowda@intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
Date: Sun, 21 Jun 2026 11:17:14 +0800
Message-Id: <20260621031714.3605022-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnsXi6Vzdq_vrOEw--.27839S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1ktr1xurWDGry3ZFy3XFb_yoWkGrXE9r
	nYyF97Wwnrtay0kF1UtFZ5ZFyFkrWS9FsYgF97t3yFq3yUZ34fCws3uFy3G3W7CF4Yyr9r
	ur1DJa4UAryxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU0D73UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Rxt22o3V7wKpwAA3c
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ilpo.jarvinen@linux.intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267519-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	TAGGED_RCPT(0.00)[stable,netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65676AA116

t7xx_cldma_late_init() creates md_ctrl->gpd_dmapool before
initializing the TX and RX rings. If any ring initialization
fails, the error path frees the already initialized rings but
leaves the DMA pool allocated.

Destroy md_ctrl->gpd_dmapool on the late-init failure path
to avoid leaking the DMA pool.

Fixes: 39d439047f1d ("net: wwan: t7xx: Add control DMA interface")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index e10cb4f9104e..2917cee9b802 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -1063,6 +1063,9 @@ static int t7xx_cldma_late_init(struct cldma_ctrl *md_ctrl)
 	while (i--)
 		t7xx_cldma_ring_free(md_ctrl, &md_ctrl->tx_ring[i], DMA_TO_DEVICE);
 
+	dma_pool_destroy(md_ctrl->gpd_dmapool);
+	md_ctrl->gpd_dmapool = NULL;
+
 	return ret;
 }
 
-- 
2.25.1


