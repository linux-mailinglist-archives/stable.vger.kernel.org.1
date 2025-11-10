Return-Path: <stable+bounces-192994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F46C49634
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EC341143
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3D2FC013;
	Mon, 10 Nov 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBtFK4y5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257E2D94BB
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809638; cv=none; b=p9nPPsWzn7VL5Yn+yVBrAQaPV8/f/y6V3lOMHkTOLUzW01mcZCj0IY/JOB5X4rMSpSGBCDDiABWufIJjRbhCT2rk+HmC2aqmAgITBdRQx3wtVuYZffzywUo+Cj70j8MHONkqg7JkO2G0BFgfP4UIcIMGYhyb1AW7SWtcQZ9kRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809638; c=relaxed/simple;
	bh=VwpxWlflDd3Cl0Mm2O4FlTqYvEwO9NBeGIQsW7oDzZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA8C6f+xzhnrT9VMf6GCDz6TMqDsBCITn4i4UCB+Auk7aE0BEichTXYLuUHKnFwO0bPStp0Ej9DNswTk0X2wGGmZBXbp4HXyTSihoBnrXHD+D3PzFJjoHNgw2qWKi43UHSRgkgZzxj2OX97ZwwPsjIclpmjvnTYiuqJwxRBgKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBtFK4y5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762809626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqbdrlaMc3Jk8JpenOWMbSfatSrNtvvxxieQXTOmSxo=;
	b=SBtFK4y5d9TdxFFuamr6mI1dPs3y1a+hGQLJA0GYNJPTZeDMfA/18nSVDEuXR+pIJOt3jb
	F+i+samMxZRxGoySv/8sqdKWKS0Y5SyRWWxUxdnAz2Z2ImBgu8t8//CV1LS2reW6aXcFBb
	NDwY5ciyaEoqpCiIu/CJtpXwD60KJIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-OW3wz_ZXNEe33dtCVjHiHQ-1; Mon,
 10 Nov 2025 16:20:16 -0500
X-MC-Unique: OW3wz_ZXNEe33dtCVjHiHQ-1
X-Mimecast-MFC-AGG-ID: OW3wz_ZXNEe33dtCVjHiHQ_1762809614
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C992F195609D;
	Mon, 10 Nov 2025 21:20:13 +0000 (UTC)
Received: from emilne-na.westford.csb (unknown [10.45.224.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE81E19560B7;
	Mon, 10 Nov 2025 21:20:08 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com,
	james.smart@broadcom.com,
	paul.ely@broadcom.com,
	justin.tee@broadcom.com,
	sagi@grimberg.me,
	njavali@marvell.com,
	ming.lei@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
Date: Mon, 10 Nov 2025 16:20:00 -0500
Message-ID: <20251110212001.6318-2-emilne@redhat.com>
In-Reply-To: <20251110212001.6318-1-emilne@redhat.com>
References: <20251110212001.6318-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
release handler. And even admin queue is unquiesced there, this way
is definitely wrong because the ctr->ref is grabbed when submitting
command.

And Marco observed that nvme_fc_ctrl_free() can be called from request
completion code path, and trigger kernel warning since request completes
from softirq context.

Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
which is also aligned with nvme-tcp and nvme-rdma.

Patch originally proposed by Ming Lei, then modified to move the tagset
removal down to after nvme_fc_delete_association() after further testing.

Cc: Marco Patalano <mpatalan@redhat.com>
Cc: Ewan Milne <emilne@redhat.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/fc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b613fc5966a7..9e1841223e8a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2359,17 +2359,11 @@ nvme_fc_ctrl_free(struct kref *ref)
 		container_of(ref, struct nvme_fc_ctrl, ref);
 	unsigned long flags;
 
-	if (ctrl->ctrl.tagset)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-
 	/* remove from rport list */
 	spin_lock_irqsave(&ctrl->rport->lock, flags);
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
-
 	kfree(ctrl->queues);
 
 	put_device(ctrl->dev);
@@ -3265,11 +3259,18 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
+
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
 static void
-- 
2.43.0


