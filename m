Return-Path: <stable+bounces-249178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCn3M2CHCmpl2wQAu9opvQ
	(envelope-from <stable+bounces-249178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2EF5656B8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F8F3001A78
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8C3803D8;
	Mon, 18 May 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJTMqcFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D937F00A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074907; cv=none; b=lfgdUQPt4gUEBfYuXIpTdsatXsTfrdhcSqMqL+wjeG0WVmVABOiLQIlQcN19BoYgQgRFyFoTfrrIoIMin4XqSoZisyE8OkewyL/nixw7i6U1lWDndKF2boFk06FG4faB5EbNrwrg7fJ24q4Cft+WbVac256XBEPR5c1jxLnfL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074907; c=relaxed/simple;
	bh=AeDpg2IALDeZ5lMqIDvalIjINNL+S9fR2pQa6Tq1/Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHUEq9vE7omj2BwH8l4Po0RBK8C8Ajl7diRDghfRr9VwdtNgZhB8sSinmx/zZFfAxsW+kLiaRwThDSl2REfwxsGt8AO5gx+IO8tn89MMYqB/Mhf848aQxUoMRYdHK95OaCSkGNvi2DG3n8De0gLasU+LPVkIgtDCAKqmaYkzyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJTMqcFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6FEC2BCB0;
	Mon, 18 May 2026 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779074907;
	bh=AeDpg2IALDeZ5lMqIDvalIjINNL+S9fR2pQa6Tq1/Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJTMqcFCaND3kndsPYrUNc+sz7BpicxdYncC7MC21gx4xr0S9+LllIsgC273c/rYw
	 VbIzNp0tvEteH0xPlyjSIAtUW4BZKidhtCh7T2gZyQfU/wDZAdRV/leRAyVlEt0fEs
	 1UuHcqFAocYlhLAoEMuGit+oTX89WKYsVZO9340wXWEgmadBDwOoFce9vIvnsJf2wn
	 3sP85OihSM0FHxFULzSWZeZ7xjJ+zRBAFshROVqLZ4zFQalptjDZ/Dx/fYG+bpgxui
	 1mZaE3f6FYqu8LusEzqkQfh8hE1BQbmdJZqGyZ/KNqTJgyZTBIFXP4Mi3z8BjYN06h
	 SBnw9zskHiTdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Long Li <longli@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] RDMA/mana: Validate rx_hash_key_len
Date: Sun, 17 May 2026 23:28:24 -0400
Message-ID: <20260518032824.588408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051237-palpitate-lumping-b73c@gregkh>
References: <2026051237-palpitate-lumping-b73c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA2EF5656B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249178-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 6dd2d4ad9c8429523b1c220c5132bd551c006425 ]

Sashiko points out that rx_hash_key_len comes from a uAPI structure and is
blindly passed to memcpy, allowing the userspace to trash kernel
memory. Bounds check it so the memcpy cannot overflow.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Link: https://patch.msgid.link/r/4-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ kept the stable branch's existing `req_buf_size` calculation instead of upstream's `struct_size(req, indir_tab, ...)` form ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/qp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 8009a339bf9ca..3f5d088ebe407 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -24,6 +24,9 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	mdev = dev->gdma_dev;
 	gc = mdev->gdma_context;
 
+	if (rx_hash_key_len > sizeof(req->hashkey))
+		return -EINVAL;
+
 	req_buf_size =
 		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
 	req = kzalloc(req_buf_size, GFP_KERNEL);
-- 
2.53.0


