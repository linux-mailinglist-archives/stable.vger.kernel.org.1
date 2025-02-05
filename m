Return-Path: <stable+bounces-113637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE92A2933C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896AE3AFEE1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0C18D656;
	Wed,  5 Feb 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPvUwckl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BED18C006;
	Wed,  5 Feb 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767647; cv=none; b=Y+/AWA1dB1cEHE7DFtVxEE8pJgFE1CZeSDdoiw8JReZ+AGX71lSyHgXIERxFtudS5+HwTB3fesYub04at+Bz3XEq1CyTTChjGZB/ub2ZK1huNL9YyPl2UeF/j2SlwbUcdQ4pVdXUQjaUOT2vAOaW/VgQ2rVEVZnMcAB4lLjlNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767647; c=relaxed/simple;
	bh=OHzecnifTphLnMalowmq6pcQMDa92RU05vUKGfiSZnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlgjxmmLXhI1tI0z3ORg2vQ+dpZwpfcy83FZZELsi8m6R9IZoF1BIUp98WXQ1wongf79nyC7jKLycvhpCiV0XDj92ZTWO3AmiQaDBAijmRh5YJ36fA8kIazEKRgfIAS1WVKEM58OusTv2mVxhYcPnATnVFe+VM186Ri3YxRGLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPvUwckl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5ECC4CED1;
	Wed,  5 Feb 2025 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767647;
	bh=OHzecnifTphLnMalowmq6pcQMDa92RU05vUKGfiSZnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPvUwcklCNjSiu+PNUr1qz6+a2n16KY8tS7MxD5h2hpl9ny5EIfXLHimGtyxGMfR0
	 BfiwbvzNP/eVJUsT01SjGcKmUG3BhIJWrO5qs/JuaWpn6W+xVwKy13wtdFDzFEVYNP
	 BIAjBMsgPGWcxDZij+yuXW/RN04rsRbRqZ3VNGT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 433/623] RDMA/cxgb4: Notify rdma stack for IB_EVENT_QP_LAST_WQE_REACHED event
Date: Wed,  5 Feb 2025 14:42:55 +0100
Message-ID: <20250205134512.786781830@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anumula Murali Mohan Reddy <anumula@chelsio.com>

[ Upstream commit 42e6ddda4c17fa0d5120e3723d522649f8fc62fa ]

This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
error state and associated with an SRQ. This behaviour is incorporated
in flush_qp() which is called when QP transitions to error state.
Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
add support for draining Shared receive queues")

Fixes: 844bc12e6da3 ("IB/core: add support for draining Shared receive queues")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Link: https://patch.msgid.link/20250107095053.81007-1-anumula@chelsio.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/qp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 7b5c4522b426a..955f061a55e9a 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	int count;
 	int rq_flushed = 0, sq_flushed;
 	unsigned long flag;
+	struct ib_event ev;
 
 	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
 
@@ -1607,6 +1608,13 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	if (schp != rchp)
 		spin_lock(&schp->lock);
 	spin_lock(&qhp->lock);
+	if (qhp->srq && qhp->attr.state == C4IW_QP_STATE_ERROR &&
+	    qhp->ibqp.event_handler) {
+		ev.device = qhp->ibqp.device;
+		ev.element.qp = &qhp->ibqp;
+		ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+		qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
+	}
 
 	if (qhp->wq.flushed) {
 		spin_unlock(&qhp->lock);
-- 
2.39.5




