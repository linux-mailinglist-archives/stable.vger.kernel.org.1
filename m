Return-Path: <stable+bounces-169107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F71B23839
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D423189C705
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF429BDB7;
	Tue, 12 Aug 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/7cEiM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEB27703A;
	Tue, 12 Aug 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026401; cv=none; b=QsJhbewgALVFjYvmBRQrE5+zvnNuaAVGsFkwSH3ljHPnrl02dlNeAh47vcV7GohU5reUcze39CLdQsPq8CM2VZnfjMQk/hwlqDyA9EAlsE/ZOQJ5HcFEsX9sGVbWc3pW8l+kByvGUjWLs8NMTp4UekEahUzgcY+WZKW0KeiJokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026401; c=relaxed/simple;
	bh=YHUsia4wCUVIM4s8s1C+hlFAVPkCe14zuyUvkLNAGgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmzXLB8vdBLdQBboc09sF8A/uPAsj4HK1oPep/qoarPEjwkQYG+vLCobrqHPe71qUlt2Y3YOviaKd5TduFdVwNjVqu9JwHyyu+FkNeOLv7n9P54Rw+3MSICxGzjBjyju0j0qivIs4DVH8B5FmhrMMOAgt9uNdWFWT0Z9gsfEzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/7cEiM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3109BC4CEF0;
	Tue, 12 Aug 2025 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026401;
	bh=YHUsia4wCUVIM4s8s1C+hlFAVPkCe14zuyUvkLNAGgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/7cEiM0fNxQSBl9Ia4V03fNPRwUrClUDUP6Hib8fBkx7tGtmus7LlW2CIYtLSNep
	 lHahh/zNrMiAi/EmQkFexWNmqGBgjej26EtaRnSg7SP46NXKOK3c9EDPhFytbWnzGb
	 reSQSkCUW9mZmAJfmtt1Aav/PqI/Uyke9UmKnH1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 325/480] vhost-scsi: Fix log flooding with target does not exist errors
Date: Tue, 12 Aug 2025 19:48:53 +0200
Message-ID: <20250812174410.846341485@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
index 26bcf3a7f70c..5b112de79f27 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1148,10 +1148,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
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




