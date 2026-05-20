Return-Path: <stable+bounces-249896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF7pDoCgDWqC0AUAu9opvQ
	(envelope-from <stable+bounces-249896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43E58CF76
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2999D3003802
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3D3A8FE8;
	Wed, 20 May 2026 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH5H7uoS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD784343891
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277653; cv=none; b=LpaEEO8zq8nABkISm7PavNusByxIRt+vZekywC+Y6Qcj2WOKrJC2gotBYaEZknsW2d6LGCRizbsDgTz+8o3qy219xKSmATidrI7tUj1BqbDwgF+/xxkbu7RSbUCL0rtZplMvKOPy+AHdpb3bMJuOJXzJmUmGjSR4/erKL+CrlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277653; c=relaxed/simple;
	bh=3fPwA9kQX1/JfRqyfyxQyIXv7gks0lKvSM+ZrJdKR+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfzDmNYclhY6HMNj7aniH/c82t+Db8FmYFQoVa30V4MKkCA4n5LcjIWNqhIUUa9k1a5rCPTwi9uduzyfFXQJ2WNjhoKE30lAcTsq3PmLNmJcz/ZycBHx0alojXpDNMGh0NLFPtAmxVUBuWNhGrnUtL7idUvxR8BzYsRY4Q0xv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH5H7uoS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6F21F000E9;
	Wed, 20 May 2026 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779277652;
	bh=lw8Ne5+rwKG3bjgNp2mTe2hV2ZF16qB+Gto2UR5DBGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aH5H7uoSW5U3um4clKtVsm5i1SN+SYOpYJwpY4tlvhuIBaG1fFFcBLrqst1y3Zowp
	 T3Q4RUZRN7D4hkvSlEpZGMXcDMgmPxw4mdZjrOqzUdQk8rFxEruvFYzXgcDwviYvOW
	 oKGpPk9SPeTUg06QGjppGjb2ddiTbJNMz/sutTvh9vvJ49PQA/2765N3d0QU1iaJ0U
	 C72ME06+Qsi9azH9OB2mw9fZgRiKh92uMweYV5lSNopa2bjzfJInajnvAmA/s8ig6E
	 TrrtO34Su6HekOP2/ZAudXLkS+rishJK2uW22wpd8DRkIXciAQBDHcpw68NMIRDbK/
	 zFM43LGEXhnsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Long Li <longli@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
Date: Wed, 20 May 2026 07:47:30 -0400
Message-ID: <20260520114730.3470533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051232-unwilling-overhear-52b1@gregkh>
References: <2026051232-unwilling-overhear-52b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249896-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C43E58CF76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 6aaa978c6b6218cfac15fe1dab17c76fe229ce3f ]

Sashiko points out that mana_ib_cfg_vport_steering() is leaked, the normal
destroy path cleans it up.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Link: https://patch.msgid.link/r/7-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 8009a339bf9ca..ba0da3d670b6d 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -234,13 +234,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
-		goto fail;
+		goto err_disable_vport_rx;
 	}
 
 	kfree(mana_ind_table);
 
 	return 0;
 
+err_disable_vport_rx:
+	mana_disable_vport_rx(mpc);
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
-- 
2.53.0


