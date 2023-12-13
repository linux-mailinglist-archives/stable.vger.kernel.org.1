Return-Path: <stable+bounces-6255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6EF80D99F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA37D2820B0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395B51C47;
	Mon, 11 Dec 2023 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZId56mk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC0321B8;
	Mon, 11 Dec 2023 18:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA898C433C8;
	Mon, 11 Dec 2023 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320932;
	bh=oDIU6CDGf3w7HkyE3T3MHM5oZlFyUdSs9t6/amq2yZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZId56mkAchylMukmrONBjXoIm/dgiYNo0yNHiX4Agntj+XDP8OJj5ujeowsuLiGN
	 YN1Q/65LGhNHOjQPYwyVTVoxtVbEYtNlNRfMoqknu3iYrNpJ7tAhZG8bjd/F+hdiOu
	 1cn+0p6tXd/K1Qhpd/a/olH+AwCfmLv+CTabIR7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 049/141] RDMA/irdma: Do not modify to SQD on error
Date: Mon, 11 Dec 2023 19:21:48 +0100
Message-ID: <20231211182028.660478454@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit ba12ab66aa83a2340a51ad6e74b284269745138c ]

Remove the modify to SQD before going to ERROR state. It is not needed.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20231114170246.238-2-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8ccbe761b8607..1d57194476a7b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1334,13 +1334,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
 		case IB_QPS_RESET:
-			if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS) {
-				spin_unlock_irqrestore(&iwqp->lock, flags);
-				info.next_iwarp_state = IRDMA_QP_STATE_SQD;
-				irdma_hw_modify_qp(iwdev, iwqp, &info, true);
-				spin_lock_irqsave(&iwqp->lock, flags);
-			}
-
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata) {
-- 
2.42.0




