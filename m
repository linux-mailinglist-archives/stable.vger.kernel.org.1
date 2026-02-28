Return-Path: <stable+bounces-220566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBydFXI6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8591C6705
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D2EC3104549
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B03DB4F3;
	Sat, 28 Feb 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN2YjBXk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC03DB4E7;
	Sat, 28 Feb 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300447; cv=none; b=by60bGtnL305BL+8MaUDZ7MLbLlmcKidP9mmbEIZftAxKRkR6/ZHe+758NGE+S7aGKMSSq9gUmddfhD4G+4wXIF9h1JWEBDVUQ89olP00Da5XXxzJJu1rLgpUrjj9GCIYFs1xINGQP1DFRJLLgREuK1ash188Wn3sM0FT4V2AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300447; c=relaxed/simple;
	bh=RZJViCNLIiBqodozrBC42YiKsU8srBesroCSyoWxziI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4H/wEDfKXW9Yn688z45+6DjFVGZZ3lgg6shUkfJKm2bQab7FLq8Tjcg3n5qxS+JnRNScmfM144h9wyOfE98yHaDtQVL0DZE5epDBztT43UxIbCDt+WXW4ZnfMu54nqF5qLt9wmBaWOvJklq79Ox0E2+rZeq1RmssDDvGpeWH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN2YjBXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4EC19424;
	Sat, 28 Feb 2026 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300447;
	bh=RZJViCNLIiBqodozrBC42YiKsU8srBesroCSyoWxziI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qN2YjBXkFbdrRtTkGuM3eP6XoAAj5hY1pG1y30dK2xy8w7wrTI2O24U1Iy82FuRk2
	 /ybYm0zOjKbYYzVhJXSczxYdexxBELaDoy1XuhMa2ytRr1IYr9MEPWWp4XsXfFEM+W
	 hT4ENydy+BhBzfJUE80r6Mjk1Om5mN0hhIbDpj012/7AxoBxqlL2AXa9zFsWaLm7cN
	 eeDlRY6W2+uJgyQbuvx+FSkGSS8ulhIFy8dIAXeSqs0VG7gm+7fuKElbKMBEIgsC62
	 ybRxgCBMw0Rbsklbt2tNF1FvWb/wqyo21G953W8hACSlfFmVVWgdxYT7EHci7PM31p
	 khukPLxTPGsXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 487/844] RDMA/efa: Fix typo in efa_alloc_mr()
Date: Sat, 28 Feb 2026 12:26:40 -0500
Message-ID: <20260228173244.1509663-488-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-220566-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AC8591C6705
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit f22c77ce49db0589103d96487dca56f5b2136362 ]

The pattern is to check the entire driver request space, not just
sizeof something unrelated.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://patch.msgid.link/1-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com
Acked-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 755bba8d58bbc..5cab7dd70aebf 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1663,7 +1663,7 @@ static struct efa_mr *efa_alloc_mr(struct ib_pd *ibpd, int access_flags,
 	struct efa_mr *mr;
 
 	if (udata && udata->inlen &&
-	    !ib_is_udata_cleared(udata, 0, sizeof(udata->inlen))) {
+	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
 		ibdev_dbg(&dev->ibdev,
 			  "Incompatible ABI params, udata not cleared\n");
 		return ERR_PTR(-EINVAL);
-- 
2.51.0


