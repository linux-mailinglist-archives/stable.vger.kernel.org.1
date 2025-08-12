Return-Path: <stable+bounces-167693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B4B23166
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C13A5C63
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423E2FF15D;
	Tue, 12 Aug 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIW31vWY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBE2882CE;
	Tue, 12 Aug 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021677; cv=none; b=ssJrNteNEwNUZWIipfHF162JwzWnI3NWAfakv4YYwFvxQu75+WiKlstptgI9Fz/jBk0h2anVZOv9Ht7D68k2/zybRwH2vgVPG4Uq1gZ4lBMwto4W55d6ftyFMRE10O67gfyARIwhlJezLB0IkbGIAQ7/5BWaOgOECy98QGQtpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021677; c=relaxed/simple;
	bh=HAIjS9mACo0ISIlDIZDU3qcL8uLo5zSwF3ikrmZLl6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRDC+6YRshI91IM4umc6IA831v6i2e2vVwitcdYAvuhchTMcoUQ5TtrgRJNbb/XvuDeUNYSZZDjufAcf2ohmNVEpUTIq3SGPvL4HUFhUaM0MTLQbLagPzDw7AV8V+XvhvSogdQANXgFdKpSR3wbqjQ1uace8yPdJR28N/wPB1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIW31vWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3473BC4CEF1;
	Tue, 12 Aug 2025 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021677;
	bh=HAIjS9mACo0ISIlDIZDU3qcL8uLo5zSwF3ikrmZLl6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIW31vWYukehS6LVNoZpdJqhENXhKQbMiZKLR7i4BbXID9ou7XilbaBFAlJJlBPax
	 fBoq2CQivqOZSwxLyvGbK0+sPhICuZLITpIU0Wm/7WTWUhUASgr0DSM6e4dDbU9Rrk
	 UksIlRBn6fbznwwpzYgeunefTlMAQGDXNP3s51Rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 159/262] vhost-scsi: Fix log flooding with target does not exist errors
Date: Tue, 12 Aug 2025 19:29:07 +0200
Message-ID: <20250812172959.874078442@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 69cd720a8a5e9ef0f05ce5dd8c9ea6e018245c82 ]

As part of the normal initiator side scanning the guest's scsi layer
will loop over all possible targets and send an inquiry. Since the
max number of targets for virtio-scsi is 256, this can result in 255
error messages about targets not existing if you only have a single
target. When there's more than 1 vhost-scsi device each with a single
target, then you get N * 255 log messages.

It looks like the log message was added by accident in:

commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
control queue handler")

when we added common helpers. Then in:

commit 09d7583294aa ("vhost/scsi: Use common handling code in request
queue handler")

we converted the scsi command processing path to use the new
helpers so we started to see the extra log messages during scanning.

The patches were just making some code common but added the vq_err
call and I'm guessing the patch author forgot to enable the vq_err
call (vq_err is implemented by pr_debug which defaults to off). So
this patch removes the call since it's expected to hit this path
during device discovery.

Fixes: 09d7583294aa ("vhost/scsi: Use common handling code in request queue handler")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250611210113.10912-1-michael.christie@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 662351511157..90a3c0fc5ab0 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1032,10 +1032,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 			/* validated at handler entry */
 			vs_tpg = vhost_vq_get_backend(vq);
 			tpg = READ_ONCE(vs_tpg[*vc->target]);
-			if (unlikely(!tpg)) {
-				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+			if (unlikely(!tpg))
 				goto out;
-			}
 		}
 
 		if (tpgp)
-- 
2.39.5




