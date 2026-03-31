Return-Path: <stable+bounces-231793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODB0Htf7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D268636D4CF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF8E30E9AF3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0523426D23;
	Tue, 31 Mar 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bL+OViNj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456F3E559E;
	Tue, 31 Mar 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975083; cv=none; b=VkVKbhSjg3cy6HBH6M9gBu+u+UDDwAr/XCNbA1/dLkLdNNYvntuWXu6MoHZVYY630iF78pxgQOSJX1Hsp0ml3dlPWJpvDZFpvOIUQR2jJLvIzqePfYKsGs2PMlGL8dnKv7k2ugZihcPNU4vpDnE60o/JOPLAhMfvVbJUqNBvDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975083; c=relaxed/simple;
	bh=pgUxXCHQUuUk0aBdCvEXAR3c8I8Yy3gbIdKJyYb7n2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6n0m7e2sIGHh3PkJDMqoqpAdbx5atm6mvL+XA+/N7gMmKWi0+tFOBegYYmwBMtHyUeB8oaQpa5ij3BbD47+HJaLF7ounIaWvkeflgKzoAVWlCjyFaiungqn26JjBqCC0NxZwZx1qketKp5t2NjPovPE1PFwT/lF0hFWX92MCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bL+OViNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A20C19423;
	Tue, 31 Mar 2026 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975083;
	bh=pgUxXCHQUuUk0aBdCvEXAR3c8I8Yy3gbIdKJyYb7n2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bL+OViNjs/GRzsQAF6xYMU0FjyM7FpmBjheyq3OHGH1UdLIEgzSjegydIe63vH22H
	 IsiLPDFSYpjpEBPye5lMnCK93kbjxGJEbFFZpOcqqsq4AN71Zax6rdLC2P0th7h9Qa
	 NEgL1dJsSd/3Xz9qKcXwRtzESBiGoe1H0MAMUqfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 156/342] RDMA/irdma: Initialize free_qp completion before using it
Date: Tue, 31 Mar 2026 18:19:49 +0200
Message-ID: <20260331161804.750056925@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231793-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D268636D4CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 11a95521fb93c91e2d4ef9d53dc80ef0a755549b ]

In irdma_create_qp, if ib_copy_to_udata fails, it will call
irdma_destroy_qp to clean up which will attempt to wait on
the free_qp completion, which is not initialized yet. Fix this
by initializing the completion before the ib_copy_to_udata call.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 68fb81b7bd221..d279a015094be 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1105,6 +1105,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	spin_lock_init(&iwqp->sc_qp.pfpdu.lock);
 	iwqp->sig_all = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	rf->qp_table[qp_num] = iwqp;
+	init_completion(&iwqp->free_qp);
 
 	if (udata) {
 		/* GEN_1 legacy support with libi40iw does not have expanded uresp struct */
@@ -1129,7 +1130,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		}
 	}
 
-	init_completion(&iwqp->free_qp);
 	return 0;
 
 error:
-- 
2.53.0




