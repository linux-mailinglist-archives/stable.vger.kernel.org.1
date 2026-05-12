Return-Path: <stable+bounces-246574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAwmNW9xA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:29:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA8C5279C7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3CE317AD94
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D636C5A1;
	Tue, 12 May 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDbeLhii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C239365A19;
	Tue, 12 May 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609574; cv=none; b=jRQhPW00fGPZaA51S+CmtZZhfXLzCns1xNyq2VzLxTtH8zFtrCd+gwLJOrO8s2oU45Uv5Tm0Ptuq/hsHwqLCsEuQAq299LgorQ6GXOftyKovn/V7ySf458COhNLC6jMV8xRcQY6cWuIn+wCIGy1P4AGw6+ziZ18d4w1ln3ndtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609574; c=relaxed/simple;
	bh=s/Z2wq+bZUZDD6RTBhval3iewRH7sO9LBkf2jjLmFCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTuZqJIKyGUsX5mIf90WPHkQcCWkeib5rCG7Xrqew+JeVzgIiQQwFtR+GK8Q7CBH6Ef8rVpECwX3ZPBk6I2OnbkzN+WI8Kll32pUDySDy4Qd9J5ckt3WUuOwMZR3T3QtXJNlehmO5sues+kwFANeMkwP7oX2hpygj2KiaMqpq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDbeLhii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70BCC2BCC7;
	Tue, 12 May 2026 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609574;
	bh=s/Z2wq+bZUZDD6RTBhval3iewRH7sO9LBkf2jjLmFCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDbeLhiiE84BgU7BysQvmyex+gWvDlS/QHPeW0WKcriR17FeL3K1zJqju68gJduoM
	 skd3kvaASRcP+4QqoaKmeGS2eh/HYnKevryMw6fPY6m31Wu0l27RPUWEh0ghPEzgZK
	 fTBAgJefxhjL9S6Z5d8ezgv0BvaHprrHN+Sfd5rw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 206/307] RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
Date: Tue, 12 May 2026 19:40:01 +0200
Message-ID: <20260512173944.465371136@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3DA8C5279C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246574-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,msgid.link:url,hisilicon.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 0c99acbc8b6c6dd526ae475a48ee1897b61072fb upstream.

Sashiko points out that hns_roce_qp_remove() requires the caller to hold
locks.  The error flow in hns_roce_create_qp_common() doesn't hold those
locks for the error unwind so it risks corrupting memory.

Grab the same locks the other two callers use.

Cc: stable@vger.kernel.org
Fixes: e088a685eae9 ("RDMA/hns: Support rq record doorbell for the user space")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=9
Link: https://patch.msgid.link/r/15-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1178,6 +1178,7 @@ static int hns_roce_create_qp_common(str
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_qp ucmd = {};
+	unsigned long flags;
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
@@ -1264,7 +1265,13 @@ static int hns_roce_create_qp_common(str
 	return 0;
 
 err_flow_ctrl:
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
+	hns_roce_lock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			  init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
 	hns_roce_qp_remove(hr_dev, hr_qp);
+	hns_roce_unlock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			    init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 err_store:
 	free_qpc(hr_dev, hr_qp);
 err_qpc:



