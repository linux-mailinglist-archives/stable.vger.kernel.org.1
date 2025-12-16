Return-Path: <stable+bounces-202533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FBCC38F3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A143030146
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405A35CBD3;
	Tue, 16 Dec 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdQmGoSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392635E540;
	Tue, 16 Dec 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888207; cv=none; b=PWQ/K+UaHJ9uF1rRbWNcJ01NF3dOMATyWi5tTGyn7awXM+NTZbQ/G25Dpr86dwBu7vh6+SdjRvNAxXnjSPDzBX44kymp6HpzK9XkUJZ1qPu66V33yNL4a9tIZ1x50kPQdfyp+XS36xSj+t7yGiqZpWeIWAVoqAjOL5As2ZPSrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888207; c=relaxed/simple;
	bh=6cqnZc2oeet89SrUVJPdk51xn895QPcAE2oXBZmwQ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTTH68waamXD8e0m3o6kFJtYDuH7CQQGAzxCMrzSN38jImb2zDYcb8V2/YRbgllqORAQJgmW603qeECTdUhjwY/1HHPcjMvOU7OPv1VcIUzhwRg1pJu3LBJDrPC2ULs8OTP+L3TAkg3x2GAUPIgU/GTDNzLX++QjOoR9475nSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CdQmGoSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BFC4CEF5;
	Tue, 16 Dec 2025 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888207;
	bh=6cqnZc2oeet89SrUVJPdk51xn895QPcAE2oXBZmwQ1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdQmGoSloLmjvMdQZ7Abo8xVX5Ob0+DtZZlAQHqqsgtwOdqcajYxr4+Gxm+0MSfR5
	 xWUls4sPxlKllsjf74NnnCWRde/Hp/U2Wmv/iflnHm0G5vaXUrdGeF5dyKwCJ+EMco
	 1ftc1DdCdEbQUmR3lkfdoRANggV1c6+KYKwY5A2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 465/614] virtio: fix virtqueue_set_affinity() docs
Date: Tue, 16 Dec 2025 12:13:52 +0100
Message-ID: <20251216111418.216847025@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 43236d8bbafff94b423afecc4a692dd90602d426 ]

Rewrite the comment for better grammar and clarity.

Fixes: 75a0a52be3c2 ("virtio: introduce an API to set affinity for a virtqueue")
Message-Id: <e317e91bd43b070e5eaec0ebbe60c5749d02e2dd.1763026134.git.mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e231147ff92db..1a019a1f168d5 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -384,7 +384,7 @@ const char *virtio_bus_name(struct virtio_device *vdev)
  * @vq: the virtqueue
  * @cpu_mask: the cpu mask
  *
- * Pay attention the function are best-effort: the affinity hint may not be set
+ * Note that this function is best-effort: the affinity hint may not be set
  * due to config support, irq type and sharing.
  *
  */
-- 
2.51.0




