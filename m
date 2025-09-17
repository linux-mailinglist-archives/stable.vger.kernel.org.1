Return-Path: <stable+bounces-180126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35938B7EAB0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A1517936B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67F374291;
	Wed, 17 Sep 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H76+W5d2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761531A81D;
	Wed, 17 Sep 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113465; cv=none; b=iPFbENGuSQRAZJgf18nFbGGSbuAar9b8msal7ms74m/B2K0/WY732Z4ibfmp2dUV7CX0d4ujlnEr9dxoYiAuvom3LU+A6Ju+GuvvVRMw5BTocMjOIDQ6FLw9aGOAsq95/qe5ZSY+mTXps1Jb7I/enmwYDqzZ9GRKbKYpa+2pG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113465; c=relaxed/simple;
	bh=zDIOpSEjpVsRILIXLG3n+KuoKhF3wJNi5kCFETMKcY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTJavQ2bPsBOyQsc37D2tKfRRMYApKWAapegSrwtJjC10RLP6ywUwzU1tkDlMtqmRKH5iM8PZOn0wfrS6kusBUN6O2USW5ZGoyMF+CduyF4n/MKs9k6B6F14IdQMqck8vE/WrPi55WLFukwBhmxU+0uDCX7KipxoNuF2+QmC/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H76+W5d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07B5C4CEFA;
	Wed, 17 Sep 2025 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113465;
	bh=zDIOpSEjpVsRILIXLG3n+KuoKhF3wJNi5kCFETMKcY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H76+W5d2SZH4AZ+SH70CwLfQCQooxKEcs14Zyecj4E6HcTHUNBRC+3/h76594yPLh
	 ygB5yBEhjEE9Bi4TgeO1DyFpBFMzuU7GClUIXsFGd/4hNn5r3/EzeEwPoglR0koVys
	 Y90AJGvpOoifnLWdM4ETs0cDOpRf8WDHBKGsork4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chia-I Wu <olvaffe@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 6.12 095/140] drm/panthor: validate group queue count
Date: Wed, 17 Sep 2025 14:34:27 +0200
Message-ID: <20250917123346.622513488@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-I Wu <olvaffe@gmail.com>

[ Upstream commit a00f2015acdbd8a4b3d2382eaeebe11db1925fad ]

A panthor group can have at most MAX_CS_PER_CSG panthor queues.

Fixes: 4bdca11507928 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> # v1
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://lore.kernel.org/r/20250903192133.288477-1-olvaffe@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index c520f156e2d73..03eb7d52209a2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1023,7 +1023,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	struct drm_panthor_queue_create *queue_args;
 	int ret;
 
-	if (!args->queues.count)
+	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);
-- 
2.51.0




