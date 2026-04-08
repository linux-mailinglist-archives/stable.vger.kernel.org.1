Return-Path: <stable+bounces-234027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L6/FkWa1mmTGggAu9opvQ
	(envelope-from <stable+bounces-234027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109193C0196
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A17D33012CA1
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEB3D88FE;
	Wed,  8 Apr 2026 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qA5VSAF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF23D4134;
	Wed,  8 Apr 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671796; cv=none; b=lTKDSC9Dg0/P/Bw4h20Ctxq3ZYX3Hk9YgKxqZL5gK7URGblu5yW1/cIGUwc6n5W2vE603FU0EUxMuo5rRqz9UDs2yDXCpzhtuBoe2mlnEB1XrwWIvUbLWiSnljRC4PRxB2jMwRyEZdvB+6e/XDEbqZ/unAGcrwRmLvYWIqP7Q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671796; c=relaxed/simple;
	bh=y+bHvTpQAmKj5Y1PAbRdnQmt+Y+QgKTS7X0eSGgK2QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD2XAVuXnN3lKWiuQDg+1qwEXxx6w38RwTb/UTDU311Vy7Q7hD4yqTCKYB4T0WlwTHSNSuHnU9Wg0/OxKp8I9whp+zTvdpu4y3gPqQrlPJEJ826yeJS3T8F3Jh6esy8yEumCaA/JlLIyUjKzs3nKbb0Gtb04BQ1jrhveTI4LGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qA5VSAF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B40C19421;
	Wed,  8 Apr 2026 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671796;
	bh=y+bHvTpQAmKj5Y1PAbRdnQmt+Y+QgKTS7X0eSGgK2QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA5VSAF4zlyT7vbNrszuwDeSTHoKgPoYkG+ZjJ770fuwmD7VIAD5fhz7cGbmhjUy3
	 yia7EUyVu6lNcAl/cKmYI92fFU2/Is5B8mR3I0pigEjZ8O8fslcdXIeYKciY7sxmZn
	 ZctKpzCsRN6ljTuczdyukPywIhmbU6wGTUG0krLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Samal <anil.samal@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/312] RDMA/irdma: Fix deadlock during netdev reset with active connections
Date: Wed,  8 Apr 2026 19:59:48 +0200
Message-ID: <20260408175936.393127896@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234027-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 109193C0196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 6d1ca8a1717c4..1eb219fa0d453 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -534,7 +534,8 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	}
 
 	irdma_qp_rem_ref(&iwqp->ibqp);
-	wait_for_completion(&iwqp->free_qp);
+	if (!iwdev->rf->reset)
+		wait_for_completion(&iwqp->free_qp);
 	irdma_free_lsmm_rsrc(iwqp);
 	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
 
-- 
2.53.0




