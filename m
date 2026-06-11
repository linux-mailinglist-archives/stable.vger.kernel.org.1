Return-Path: <stable+bounces-262763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7bd6EeLdKmqxyQMAu9opvQ
	(envelope-from <stable+bounces-262763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:10:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB75673550
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 18:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="jtT/akk6";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262763-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262763-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5500C34C2402
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00240E8C2;
	Thu, 11 Jun 2026 16:05:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D53E1232;
	Thu, 11 Jun 2026 16:05:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193944; cv=none; b=ilg5unFgOINC9x8Jl7tGeSeKB7ACEvutP7P51u/Oxvt7bqWuySnF3+1TT+ZjCya/DBz4B+pRN6tObr9GvsU9UIlFEcjEn/cx12jCKGLqjD1t9Ta+U/MfY0YdGgAUTgattZz0RE8YOqdXkogOHEwLq0DrONIa1SJaky5YDmLeD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193944; c=relaxed/simple;
	bh=tPEYGTReNBpzGa4ZYaLpUtrW1Ehx4NWZ6t0zF7gE6Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9beHliLchoFCUyGZW2k/lOm6fYeqZ9OR/wN3Bx//CwxLM2C5YUmueXudmCpOi2rheOyE93XQzUYThXoOPxAWnukG0cZv+rm+tHGkhTIrMWqeX19b45S909tK96iIoxw2AH/jB9GoAUO6NBaaKyPxt9RJ276ijbNhSdWbi1wmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=jtT/akk6; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420765d92;
	Fri, 12 Jun 2026 00:00:30 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amakarov@marvell.com,
	tduszynski@marvell.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
Date: Fri, 12 Jun 2026 00:00:14 +0800
Message-Id: <20260611160014.3202224-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb769e36e03a1kunm0ec2af3116af50
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0lIVkNPTU1NS0oZGktKQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jtT/akk6nxnmkESfgZyrKu/p2SuQtoGT9Vd/4dM3+cJCUxML3jyKOzuLQQYhGwzUWeVmlwv0EDuVwLxA2pl9sW0wOGIpJT4+dmXx4DRD3XTj2o4qirb2H5ofZ+j9r/uowp8S3Wq6QvpfyY8e7Ss9SI55AgREhUbhfgoVeOibfVI=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=PV98ZFoL/Kf04cmRFpbNWkl0lnCxZ26qXLfqpZVoivw=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262763-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BB75673550

otx2vf_register_mbox_intr() currently installs the VF mailbox IRQ
handler before clearing stale mailbox interrupt state. The code then says
that local interrupt bits should be cleared first to avoid spurious
interrupts, but that clear still happens only after request_irq() has
already made the handler reachable.

A running system can reach this during VF mailbox interrupt registration
while stale or latched RVU_VF_INT state is still present. If delivery
happens in the request_irq()-to-clear window,
otx2vf_vfaf_mbox_intr_handler() can run before local quiesce and touch
the same vf->mbox and vf->mbox_wq carrier that probe and teardown later
reuse or destroy.

Move the stale mailbox interrupt clear ahead of request_irq(), but keep
interrupt enabling after the handler is installed. This closes the
pre-clear early-IRQ window without creating a new enable-before-handler
window.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 25381f079b97..5534c2c8db0f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -251,9 +251,17 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 {
 	struct otx2_hw *hw = &vf->hw;
 	struct msg_req *req;
+	u64 mbox_int_mask;
 	char *irq_name;
 	int err;
 
+	mbox_int_mask = !is_cn20k(vf->pdev) ? BIT_ULL(0) :
+				BIT_ULL(0) | BIT_ULL(1) |
+				BIT_ULL(2) | BIT_ULL(3);
+
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, mbox_int_mask);
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVF%d AFVF Mbox", ((vf->pcifunc &
@@ -274,18 +282,8 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	if (!is_cn20k(vf->pdev)) {
-		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
-		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
-	} else {
-		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0) | BIT_ULL(1) |
-			     BIT_ULL(2) | BIT_ULL(3));
-		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0) |
-			     BIT_ULL(1) | BIT_ULL(2) | BIT_ULL(3));
-	}
+	/* Enable mailbox interrupt for msgs coming from PF. */
+	otx2_write64(vf, RVU_VF_INT_ENA_W1S, mbox_int_mask);
 
 	if (!probe_pf)
 		return 0;
-- 
2.34.1

