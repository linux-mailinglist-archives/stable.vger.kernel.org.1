Return-Path: <stable+bounces-159088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89EAEE969
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AD9189D541
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7E225403;
	Mon, 30 Jun 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OsY4xs8h"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614814C6C;
	Mon, 30 Jun 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318498; cv=none; b=njLDVgyvf2Yh6Gnnl8tHq8H9pWEp+YmyQV30btaQdtDuJ751ejTB9uD/QLebItQJf7htbfQsKysc+BahGkNBBSbrMhOnhHHp+x6usp+KNpGmSckFsVFi+t+L7gx8dJmrv/H2SWkHinBekAMbU9LkGkKNlu6arsxdDR4OZhuLcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318498; c=relaxed/simple;
	bh=2ryoA5kkM/lRzndBu5WvKiYQE2hLvpGyMnJc0TN5g7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnLa31VVyLvOLKEkOp6g9PLL7ObjRFbDv6YBLuCaQPjA+UiG6I00n3kMQ1UUwJeUhJtPYXi/e5GxAgx4Gzo3yKoKZQuXBhVNknGWVOtKZ6mNfGtKyXMhry3wc0TtEGlREzuLDYcityR5IpRLhRwzuE98VL3wZc1JePnSrXX3r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OsY4xs8h; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.24])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2C19D407618E;
	Mon, 30 Jun 2025 21:21:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2C19D407618E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751318493;
	bh=2F3EogwDEnJvzuxBQjf9S7/RInXYPKivFjLuSHo7src=;
	h=From:To:Cc:Subject:Date:From;
	b=OsY4xs8h1hebKF3JZOF1/HL7iaxomDsxU5ZzMwq9dn7B9uRnlLa7WjfRturDZstoO
	 aaiQujlHzl1075mQtDV6WTeJIyjCwvGPYBuc0oSYfYFE/gexMoZ8U819UqvviCzr8c
	 gHY83VWQRNNxqgrhcQq6KP9H+3ozFty05hEypTIc=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Zack Rusin <zack.rusin@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: handle allocation failure of waiter context
Date: Tue,  1 Jul 2025 00:19:47 +0300
Message-ID: <20250630211948.1556524-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle result of kmalloc() to prevent possible NULL pointer dereference.
For the sake of not introducing additional layer of indentation, extract
seqno_waiter_rm_context creating code into a separate helper function.

Judging by commit 0039a3b35b10 ("drm/vmwgfx: Add seqno waiter for
sync_files"), possible errors in seqno waiting aren't fatal, thus just
skip this block if an allocation failure occurs - no need to propagate
upwards.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 0039a3b35b10 ("drm/vmwgfx: Add seqno waiter for sync_files")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e831e324e737..12d897eca410 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -4085,6 +4085,23 @@ static void seqno_waiter_rm_cb(struct dma_fence *f, struct dma_fence_cb *cb)
 	kfree(ctx);
 }
 
+static void seqno_waiter_create(struct dma_fence *f,
+				struct vmw_private *dev_priv)
+{
+	struct seqno_waiter_rm_context *ctx;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return;
+
+	ctx->dev_priv = dev_priv;
+	vmw_seqno_waiter_add(dev_priv);
+	if (dma_fence_add_callback(f, &ctx->base, seqno_waiter_rm_cb) < 0) {
+		vmw_seqno_waiter_remove(dev_priv);
+		kfree(ctx);
+	}
+}
+
 int vmw_execbuf_process(struct drm_file *file_priv,
 			struct vmw_private *dev_priv,
 			void __user *user_commands, void *kernel_commands,
@@ -4265,15 +4282,7 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 		} else {
 			/* Link the fence with the FD created earlier */
 			fd_install(out_fence_fd, sync_file->file);
-			struct seqno_waiter_rm_context *ctx =
-				kmalloc(sizeof(*ctx), GFP_KERNEL);
-			ctx->dev_priv = dev_priv;
-			vmw_seqno_waiter_add(dev_priv);
-			if (dma_fence_add_callback(&fence->base, &ctx->base,
-						   seqno_waiter_rm_cb) < 0) {
-				vmw_seqno_waiter_remove(dev_priv);
-				kfree(ctx);
-			}
+			seqno_waiter_create(&fence->base, dev_priv);
 		}
 	}
 
-- 
2.50.0


