Return-Path: <stable+bounces-232091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP0+JX79y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C72436D9E0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FAE309E0EE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA98426EA6;
	Tue, 31 Mar 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgrWZ+k9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F865426D2B;
	Tue, 31 Mar 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975852; cv=none; b=E85kzITGB4mTMsE28VcfNV6/ClY7l/NbNxZPB327M4aMBV2oyvu75v4aGUuRjzHxDbnuPS7ZZFdASGBuAEN8CRJOOQtN96EtSwsd5REKjfnaWcD24DWerR4PNEqmUePwWophtRdINMaV+dPi2t4cWN4Uzf/5ITtZo7nKRGMu69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975852; c=relaxed/simple;
	bh=oTFjn7np7mNBqcyeL26y6PUEajoicRjugZ2rcQqsXUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl+sN4m9WXg1Nbs+nzWyCtkHkPAmzQdoikpyHP9f2FMbeIomZFJpMTNlXHE5w7CU+IStKlpwhkM8/Od4OHH/5ts25M/H7EoBEalQ+f4L2wjOGSss1svcLuE2cys9r7aBD9DuWn+chuepGG1Z7Hn4hl9aH/V6rC0uhUTC2Nz0aHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgrWZ+k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164E5C19423;
	Tue, 31 Mar 2026 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975852;
	bh=oTFjn7np7mNBqcyeL26y6PUEajoicRjugZ2rcQqsXUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgrWZ+k9f0d6t7/VzYw9wMbL1AJENxALWw8E32P48xLL5fEMY+GdQlA6zT0hpOJsx
	 4YJiULcRvOVz12pVzNvTvE9BJ6DNYB/dzdDVXXkXE4q+yAVIfXMaAA/SzSWw8DC+HZ
	 ZaauAUN/RcCnKZiflgrQSf9KaNmwqVkIyuG2rV7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 112/244] RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
Date: Tue, 31 Mar 2026 18:21:02 +0200
Message-ID: <20260331161745.802297841@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232091-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5C72436D9E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 87a6d58663ded..a88f93b961682 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2340,8 +2340,6 @@ void irdma_modify_qp_to_err(struct irdma_sc_qp *sc_qp)
 	struct irdma_qp *qp = sc_qp->qp_uk.back_qp;
 	struct ib_qp_attr attr;
 
-	if (qp->iwdev->rf->reset)
-		return;
 	attr.qp_state = IB_QPS_ERR;
 
 	if (rdma_protocol_roce(qp->ibqp.device, 1))
-- 
2.53.0




