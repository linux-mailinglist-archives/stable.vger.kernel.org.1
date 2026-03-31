Return-Path: <stable+bounces-231567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM1wNUL3y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143836CBF0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83D10302A3BE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8A3D75B3;
	Tue, 31 Mar 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t9pTVvWF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BD423146;
	Tue, 31 Mar 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974503; cv=none; b=M2++6zxekClSFXJ/UKev2s0nrSuBhEApSpDxto2ZD+pJfYbp8TXwawA2XwJ2XLNdqQv9XjG6d5ewRU5pd19JSnU7ROH4Kwu/EeVVV5wEg4aTNsRuQIdEWCwnBdmOA02mItG2S97Xg8UOQafzpJTxu973Kvs+8DNz06act6fW+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974503; c=relaxed/simple;
	bh=MasMk6GfogtzJEVPMu/GCt1cjRYVRwdA4QDsRf5flfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP0CTZuat+G2nYhXVKZiC67Uv95PjK30maEjJACAMDCnuhK6AMwvZDS6/KgDvlldtyd7GYe1Ov6knHJtLkVefKzIHW43sAEbF7nBVNWteUmc2KK6jMZ99uY25ZN4XJHbYoVYONn6/aIhkYcDlZ7OUN68T5vSz0MUx0wrqGPY3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t9pTVvWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18899C19423;
	Tue, 31 Mar 2026 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974503;
	bh=MasMk6GfogtzJEVPMu/GCt1cjRYVRwdA4QDsRf5flfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9pTVvWFwlK2nPGJP1Xrf42z8TT2xxSODzjXjlNjj9FxH5QGRbTQ04Gbb40HHstpZ
	 GcVOkw+BsAn8yH5R94S59YuhCx0LIB+ICTey1Pnxnak1tftnFyXktWKWHSVFwXd3jV
	 bhDMwx1coF6MwFBlvFz/t7s83iBRAUX5XPab3r14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 077/175] RDMA/irdma: Initialize free_qp completion before using it
Date: Tue, 31 Mar 2026 18:21:01 +0200
Message-ID: <20260331161732.605687671@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231567-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7143836CBF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 3b0050e594fdf..a2a6910113e62 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1008,6 +1008,7 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	spin_lock_init(&iwqp->sc_qp.pfpdu.lock);
 	iwqp->sig_all = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	rf->qp_table[qp_num] = iwqp;
+	init_completion(&iwqp->free_qp);
 
 	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
 		if (dev->ws_add(&iwdev->vsi, 0)) {
@@ -1042,7 +1043,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		}
 	}
 
-	init_completion(&iwqp->free_qp);
 	return 0;
 
 error:
-- 
2.53.0




