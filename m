Return-Path: <stable+bounces-231784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEtnAv/6y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5536D2DA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7873078BAA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1C4266AA;
	Tue, 31 Mar 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="be4yTBrD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BA423A8B;
	Tue, 31 Mar 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975060; cv=none; b=gzE0R03+eA31RGKRBZQCRF/zRpIsctQwihIKMaxYLHVQTvTmrm/l6O0YJs7fepjkJRFvVsIgjn/RsemORadwBr0/pQgkvb3qe1+qTdBESRj75qCnGP+aQIJDew600bKbmFpCnv5vrPv+5vIv5Oq+HksGLiZw5z2lTAxS5Ep9LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975060; c=relaxed/simple;
	bh=BFrH0izzut3oYZ+zXxR6cIBeogPB77gebwE972naoO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0p/2liIO9woxXt6+6ceEBSbnhPiQ01SImS27ja7py37f6gjSAERqUALOHd3GjWZ+M0cCqb4yYvTipVnQ0EGfBpY6rgEzVaPKv8jXBoEjVXR1lAP56tKpq0RfhhOso7rYOTMSix/znFK9Yv9pCm8725Ft1dOy2tCVDNTAvUUAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=be4yTBrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA234C19423;
	Tue, 31 Mar 2026 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975060;
	bh=BFrH0izzut3oYZ+zXxR6cIBeogPB77gebwE972naoO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=be4yTBrDKGGdGg7DTdKacs/olrZOfuLfrR5V7iKm2ZIr1OR8Gdp0HAovB+5WsGWGZ
	 QluL7PMRDkIuSCrd/wUnWHfxLQRrGBaD+NF1AU/2X4v3sda6OO2DYmo+dcDhY/o4ar
	 7ZlBF7WkIOeK28wYbUK9O+VsBs51aUaK0SGkfOm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 148/342] RDMA/efa: Check stored completion CTX command ID with received one
Date: Tue, 31 Mar 2026 18:19:41 +0200
Message-ID: <20260331161804.450502859@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231784-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 98E5536D2DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonatan Nachum <ynachum@amazon.com>

[ Upstream commit 4b01ec0f133b3fe1038dc538d6bfcbd72462d2f0 ]

In admin command completion, we receive a CQE with the command ID which
is constructed from context index and entropy bits from the admin queue
producer counter. To try to detect memory corruptions in the received
CQE, validate the full command ID of the fetched context with the CQE
command ID. If there is a mismatch, complete the CQE with error.
Also use LSBs of the admin queue producer counter to better detect
entropy mismatch between smaller number of commands.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
Link: https://patch.msgid.link/20251210130614.36460-2-ynachum@amazon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: ef3b06742c8a ("RDMA/efa: Fix use of completion ctx after free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_com.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 0e979ca10d240..b31478f3a1212 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -3,6 +3,8 @@
  * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
+#include <linux/log2.h>
+
 #include "efa_com.h"
 #include "efa_regs_defs.h"
 
@@ -317,7 +319,7 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 
 	/* cmd_id LSBs are the ctx_id and MSBs are entropy bits from pc */
 	cmd_id = ctx_id & queue_size_mask;
-	cmd_id |= aq->sq.pc & ~queue_size_mask;
+	cmd_id |= aq->sq.pc << ilog2(aq->depth);
 	cmd_id &= EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
 
 	cmd->aq_common_descriptor.command_id = cmd_id;
@@ -418,7 +420,7 @@ static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
-	if (comp_ctx->status != EFA_CMD_SUBMITTED) {
+	if (comp_ctx->status != EFA_CMD_SUBMITTED || comp_ctx->cmd_id != cmd_id) {
 		ibdev_err(aq->efa_dev,
 			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
 			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
-- 
2.53.0




