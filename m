Return-Path: <stable+bounces-231572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMyaCif4y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A493836CD35
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A89315B192
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF1A423A62;
	Tue, 31 Mar 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVoGqd9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC157423A89;
	Tue, 31 Mar 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974516; cv=none; b=PgZJHwdAey3YmzhfRla+2yTCS+yCDvefrlsQcB8hYuPc9txcUPvjqyzcOSdXdrxGPqk3hgAvgU/7oUZnbZKEyd6ZNyhCxEFovQEG81IyUTdPglmiaoRp2ZHtVtUtG3Rn4Rf+2ADovQKOhQEqNakvGgsNtqTRbQKuzaiMEVyN63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974516; c=relaxed/simple;
	bh=LvLRELhMNF7lbXT3ZaepV8CEqAfu8rPEuL5Sgt9JuEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBJ8aSudsRZosr+8W6DXcb8tX6jDbgF/9v68EKbNc4YjIrnCAwEy9T5KbLRiZkD9d4oZSJtJCHE5XZr4dAkwb7SedpPNyQTKWlucTdiNQuTcotMX/6sOcNKdKb+g5Lu1koYJt/wsFpAJZJ5WlJhQAcdS8R2julDHwFkcmafoJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JVoGqd9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02166C19423;
	Tue, 31 Mar 2026 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974516;
	bh=LvLRELhMNF7lbXT3ZaepV8CEqAfu8rPEuL5Sgt9JuEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVoGqd9Mo+Vga2vtjy2B2Wf0ADx4TLuloCtihK0SL1v3Qr9cilfuhTNdc4pnPHWyQ
	 stkkqcDYcGpSfsA7iDiZ9Rxz+DLlpsxRarVd4T/nH8Z5ff+QSIqkV+V/O7XHv6JFPg
	 CPFJOUJTyoyjkj4/REzdtMcxdz62nOKkmKzyPlBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Samal <anil.samal@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/175] RDMA/irdma: Fix deadlock during netdev reset with active connections
Date: Tue, 31 Mar 2026 18:21:06 +0200
Message-ID: <20260331161732.785929617@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A493836CD35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anil Samal <anil.samal@intel.com>

[ Upstream commit 6f52370970ac07d352a7af4089e55e0e6425f827 ]

Resolve deadlock that occurs when user executes netdev reset while RDMA
applications (e.g., rping) are active. The netdev reset causes ice
driver to remove irdma auxiliary driver, triggering device_delete and
subsequent client removal. During client removal, uverbs_client waits
for QP reference count to reach zero while cma_client holds the final
reference, creating circular dependency and indefinite wait in iWARP
mode. Skip QP reference count wait during device reset to prevent
deadlock.

Fixes: c8f304d75f6c ("RDMA/irdma: Prevent QP use after free")
Signed-off-by: Anil Samal <anil.samal@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cc8c6e8586252..532b36b25e919 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -536,7 +536,8 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	}
 
 	irdma_qp_rem_ref(&iwqp->ibqp);
-	wait_for_completion(&iwqp->free_qp);
+	if (!iwdev->rf->reset)
+		wait_for_completion(&iwqp->free_qp);
 	irdma_free_lsmm_rsrc(iwqp);
 	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
 
-- 
2.53.0




