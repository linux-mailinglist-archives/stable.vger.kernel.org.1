Return-Path: <stable+bounces-250948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ9GEVn1DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-250948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D86594E72
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF95F31C2412
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D617A309;
	Wed, 20 May 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MdpKQP6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77583F20F0;
	Wed, 20 May 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296707; cv=none; b=k+NxigVXgmBJpo3E6ioR339UTHZ0liNJMrrmhAFa4b9wVyluA0nDKxHpTSyU0oGffpcDJUferUGO1u/xfxFNiuwBo4i6qE7w8+2nOG3uMpXAwcDbVUP6SyT3vqQRV6E3adrOQIiDSuR4vWncQQoIR1LCQH6PfkmLOpGwZL8AAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296707; c=relaxed/simple;
	bh=xBRu8gQqbs28eze0o8goWQPyASksOTKAlFNi3AuVBqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVYvxzWr1f2ft4UHq9v2mYy3UCHFg5G6OYO8jPktZ8tMTok0hrQGhjCHuiwPu1ZmSfPivANJFlpeLTnRIXfoRPNnlYqt903rE18hJe2eC1yqWzCN/Y/f/8IGj4B9mVFXRkHUcIQPu/bp/3DXWRAEY/axdCUwk04kN16l9Oq7hRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MdpKQP6/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174331F000E9;
	Wed, 20 May 2026 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296706;
	bh=I4D4TJZ0gEUCkL69ouBM94wrPlwPkbwOdt7iBd4Zdmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdpKQP6/CHQI/ZfvuF/4z+/6+hqQT0Ps4NxpkhkYB29urUp+R4QN5JjMjfOjY11IQ
	 FCkRNHlf2h0rZ/W+bcKXJ8J7K/aPWMljFQFnrsyjO3Hko3KCwHag6VV0F6vivARVif
	 MDTqhfvqsI4ma7gepHpJhSjI4+2JFiIsi8/hrZ10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0900/1146] nvme-pci: fix missed admin queue sq doorbell write
Date: Wed, 20 May 2026 18:19:10 +0200
Message-ID: <20260520162208.603221747@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250948-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,samsung.com:email,lst.de:email]
X-Rspamd-Queue-Id: 61D86594E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 1cc4cdae2a3b7730d462d69e30f213fd2efe7807 ]

We can batch admin commands submitted through io_uring_cmd passthrough,
which means bd->last may be false and skips the doorbell write to
aggregate multiple commands per write. If a subsequent command can't be
dispatched for whatever reason, we have to provide the blk-mq ops'
commit_rqs callback in order to ensure we properly update the doorbell.

Fixes: 58e5bdeb9c2b ("nvme: enable uring-passthrough for admin commands")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf66272..4c052ed18cb8d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2241,6 +2241,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
+	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_admin_init_hctx,
 	.init_request	= nvme_pci_init_request,
 	.timeout	= nvme_timeout,
-- 
2.53.0




