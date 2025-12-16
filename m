Return-Path: <stable+bounces-201923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB664CC29FF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238BC3097C90
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A4355807;
	Tue, 16 Dec 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rapnfC8N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29555355805;
	Tue, 16 Dec 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886243; cv=none; b=pKtqWcAeb7Bl9WDjFHp+HLeTkEJ1zkwoE9LVQmXSACLjgOzcFbfxWRXxGFooTjcnSdGm/13DlC80+WOOJeXS6AiZi4JRpQ5DKds700fe7w2PgjpB7O0sqWbPK2pWGFz4KgDWAn959esIcu1BiUZl7JoJ81LmxLaXFkmk/Umwjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886243; c=relaxed/simple;
	bh=09QH47jtaaXlJ11VrALNAEzO525CfdEyxrySxxbe9js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMIW4MDqTyJTSnlwC7tgLkmatRwnNdNtzsV60MY867IFzQ0YMbH9DjdfOPJj976/I9p1RnUQWALrckGxb9zeC6/L0/G8eM52aKyVBeodztjayOAsl3hmSuZ5hAUM6y0ZJek2PDfAyNdvWKmwvUtED1BTKXD3jKCrPg0aXJbHMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rapnfC8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FDFC4CEF1;
	Tue, 16 Dec 2025 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886243;
	bh=09QH47jtaaXlJ11VrALNAEzO525CfdEyxrySxxbe9js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rapnfC8N7hgykXJ8Z/WOvPt905jFQwBTYfxzSsCHPUFZD4Jxds/ahpm4F6LpLGdvA
	 5lsWX3D3K8rBdUQW40hraSF826oBfmRe+Tq/mu/qR6ZejcVVpo36Fua9hVUojYhG6K
	 /uEDsHlAugJLvEMLQJoyO/ScbPzCZxK5qYoWTaw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 378/507] virtio: fix grammar in virtio_queue_info docs
Date: Tue, 16 Dec 2025 12:13:39 +0100
Message-ID: <20251216111359.154904627@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 63598fba55ab9d384818fed48dc04006cecf7be4 ]

Fix grammar in the description of @ctx

Fixes: c502eb85c34e ("virtio: introduce virtio_queue_info struct and find_vqs_info() config op")
Message-Id: <a5cf2b92573200bdb1c1927e559d3930d61a4af2.1763026134.git.mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index f8a00a780a44d..2e7ead07376d1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -24,7 +24,7 @@ typedef void vq_callback_t(struct virtqueue *);
  *        a virtqueue unused by the driver.
  * @callback: A callback to invoke on a used buffer notification.
  *            NULL for a virtqueue that does not need a callback.
- * @ctx: A flag to indicate to maintain an extra context per virtqueue.
+ * @ctx: whether to maintain an extra context per virtqueue.
  */
 struct virtqueue_info {
 	const char *name;
-- 
2.51.0




