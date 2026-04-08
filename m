Return-Path: <stable+bounces-234026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH0aHEOa1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E507A3C018F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6AE230511D2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801383D47A5;
	Wed,  8 Apr 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2lwImlom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D31347517;
	Wed,  8 Apr 2026 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671794; cv=none; b=mKOs+glZjU1N7rVbToF2xmtr53sy1EPqgAvJXIHSqS/CuQj/rtT0aoG6zMBBINorpgGKigFziLkKeZ2cbWC8MYIvPjxFaCJDRGiiOOwEnNZHh3FM+tWQQRLSb0HURE1NfkLONXd7VomNBauX3oiKteg2sA88WRrRhwyR9xrr3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671794; c=relaxed/simple;
	bh=AggdHI+Znr7zTQreb9Nlw5j3IQDJVrRdP5nOcoLq3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN7hc+czhlASaQ3L21X7Wi2G0T6C6XMBELjmnHZf9D5yRjziFtppFyE5DRaUf79SMiU/ukJvDFNzYtqkNUaMvabJTgOwsOR2w1eTEbSlVgMOUtzxfxTBGuVVOZGFxvosOb4P0qWxQToduRsKjdi26BHjTkx1VMTVilGKndpzSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2lwImlom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5DEC19421;
	Wed,  8 Apr 2026 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671794;
	bh=AggdHI+Znr7zTQreb9Nlw5j3IQDJVrRdP5nOcoLq3Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2lwImlomkphGpCDvWOIFPvWtcBBpWCHdxqA/V8Spqb6mbkq9DeefVZlh6RmI6ikPv
	 ncZyl+Pt5S+MbhfqOdifk4vqZNqKl+sYwI1YeuY5v8rswVkWwYkAzDVGmlXY1M8yWX
	 W9iRlpUzPeISUtoWlLDvO5q3ptI5lOsXdUIc6GOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/312] RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
Date: Wed,  8 Apr 2026 19:59:47 +0200
Message-ID: <20260408175936.355113199@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234026-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E507A3C018F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit c45c6ebd693b944f1ffe429fdfb6cc1674c237be ]

During reset, irdma_modify_qp() to error should be called to disconnect
the QP. Without this fix, if not preceded by irdma_modify_qp() to error, the
API call irdma_destroy_qp() gets stuck waiting for the QP refcount to go
to zero, because the cm_node associated with this QP isn't disconnected.

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/utils.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index d236e4a27ca92..98a3849c39bf0 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2456,8 +2456,6 @@ void irdma_modify_qp_to_err(struct irdma_sc_qp *sc_qp)
 	struct irdma_qp *qp = sc_qp->qp_uk.back_qp;
 	struct ib_qp_attr attr;
 
-	if (qp->iwdev->rf->reset)
-		return;
 	attr.qp_state = IB_QPS_ERR;
 
 	if (rdma_protocol_roce(qp->ibqp.device, 1))
-- 
2.53.0




