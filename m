Return-Path: <stable+bounces-242839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NPBK2Es+Gm/rAIAu9opvQ
	(envelope-from <stable+bounces-242839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1EF4B87AF
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E050A30048E0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E82264D3;
	Mon,  4 May 2026 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqwuzw61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867D199931
	for <stable@vger.kernel.org>; Mon,  4 May 2026 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871966; cv=none; b=KAdCtzbNQjh9ArbcapJHM1JVAKBA3w1g9BA7h8ZWOOOca8DLDWFVN34mwMSGHeFPL4faPaKMpNtuU7zemVTOM3/GlnKPwHO2ccfp3or7y0V5SPHorLIJD0rG5mEi7qxpvTNoCJ2gkuhBHyrLfWTpN7MTfXbtwereSxHYpc8YalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871966; c=relaxed/simple;
	bh=id9+iWMpaC3OfLB/KLTKRhoDnXIdrK9EvD7XA2qc4eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNMl4F6uSZUZD/GeE3vmxnd2b0pSpz1qORHE1R0fBtwuk3bIuwZ3LhmTVhBbhpv/coK+mCAfxdNwEmDVv5z+YlFdbfDl+o0wD/Pgqu6c0KgJpM5UNRoEtD54AMEtk7FrHvFF4m05VLxJETYj05zXeYpddQ9BoVihybvB/tqr+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqwuzw61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7725CC2BCC9;
	Mon,  4 May 2026 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777871966;
	bh=id9+iWMpaC3OfLB/KLTKRhoDnXIdrK9EvD7XA2qc4eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqwuzw617ku8SPaKIyYN8v7U/YMRbclprCCfRaOMI7IMif1YEuVv8R6d7phL9isUH
	 GBNF4yR2V/5cc8WDEw+ZspgSh5OAFLFA/s6otr6jewMs7tcUXEP8TEl003Gy2591I1
	 r4b3NrEP4kSTh5A/y8Mbh+3u7f1VeEOpK6Ayvfsp9X8xzL6mXFj/1CZyvCr6hirCcg
	 26rKao2F6BVYb83sU2D1oAH5QQkh08dbAgDU2X2fSrpQpgBdZSXnB+9Cl2EsU/NJ2v
	 we3r8A1UzO9Fsj6yh9CqAR8VcUbHchQjokeG4+gJGWvY76yNPWmnsJ5mc5XRo6wqD6
	 kYo84Up4B3rUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net: qrtr: ns: Free the node during ctrl_cmd_bye()
Date: Mon,  4 May 2026 01:19:19 -0400
Message-ID: <20260504051919.1726114-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504051919.1726114-1-sashal@kernel.org>
References: <2026050140-unneeded-foster-afe0@gregkh>
 <20260504051919.1726114-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C1EF4B87AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242839-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 68efba36446a7774ea5b971257ade049272a07ac ]

A node sends the BYE packet when it is about to go down. So the nameserver
should advertise the removal of the node to all remote and local observers
and free the node finally. But currently, the nameserver doesn't free the
node memory even after processing the BYE packet. This causes the node
memory to leak.

Hence, remove the node from Xarray list and free the node memory during
both success and failure case of ctrl_cmd_bye().

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-3-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index e3b16bd0d2081..17291fceb4aeb 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -337,7 +337,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	struct qrtr_node *node;
 	unsigned long index;
 	struct kvec iv;
-	int ret;
+	int ret = 0;
 
 	iv.iov_base = &pkt;
 	iv.iov_len = sizeof(pkt);
@@ -352,8 +352,10 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 
 	/* Advertise the removal of this client to all local servers */
 	local_node = node_get(qrtr_ns.local_node);
-	if (!local_node)
-		return 0;
+	if (!local_node) {
+		ret = 0;
+		goto delete_node;
+	}
 
 	memset(&pkt, 0, sizeof(pkt));
 	pkt.cmd = cpu_to_le32(QRTR_TYPE_BYE);
@@ -370,10 +372,18 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
 		if (ret < 0) {
 			pr_err("failed to send bye cmd\n");
-			return ret;
+			goto delete_node;
 		}
 	}
-	return 0;
+
+	/* Ignore -ENODEV */
+	ret = 0;
+
+delete_node:
+	xa_erase(&nodes, from->sq_node);
+	kfree(node);
+
+	return ret;
 }
 
 static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
-- 
2.53.0


