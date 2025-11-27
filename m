Return-Path: <stable+bounces-197417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F028C8F0DF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB7ED350CC4
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CBA334385;
	Thu, 27 Nov 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ro5c5Snr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A4274652;
	Thu, 27 Nov 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255759; cv=none; b=uoN0GR7rUpk/bIs9nVjcA8z/SRH3SgYci3Scndh72atlHRgX18sl3JZ1RJijYyj9Fnxs7b9gKbSPh3gm1u1pt5zRh1g4CnCwILbqHtAbjLDC5ZdoQJXcoTbj0dhjFH97mz/i67k/aWwhzyf1PNvkYdKBJHbu8C22Vn1KoVggL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255759; c=relaxed/simple;
	bh=Bq0ZCRQ+AZ44bouEX4FUOHTs+dZYo7WxKz1+RWcJ/ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8RCNosUJeXdj8t4kL+DDdw73AEIueQGHeSqeSkUlKL4ISptWQI0dh0cAw8KR3r8HZzdETmIyqyACURVRt+6zOJzSoG3KE5EOYJBy9RH/ccYW5p0wlTE3LfJ/TAyGr6pAnvdYBdy7lZovxIuWctPsz8znHOPjL7iTM7eyC0i/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ro5c5Snr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD416C4CEF8;
	Thu, 27 Nov 2025 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255759;
	bh=Bq0ZCRQ+AZ44bouEX4FUOHTs+dZYo7WxKz1+RWcJ/ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ro5c5SnrfzbfQsDnGdm+R0TpsBd9GRiWDx3sdhCk2DNIvSRIWgiqKpVGkwVlq+Ph3
	 Zut1q3snJJANS+/QEmK+CDx3wWYx4WSsOPu+6xyuPG9wlPNI2opamx5076XC14SqzB
	 wooty0Vow9FqbTWxl6RnmvIQnaYEZgpq5R8WDxDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prateek Agarwal <praagarwal@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 097/175] drm/tegra: Add call to put_pid()
Date: Thu, 27 Nov 2025 15:45:50 +0100
Message-ID: <20251127144046.503001321@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
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

From: Prateek Agarwal <praagarwal@nvidia.com>

[ Upstream commit 6cbab9f0da72b4dc3c3f9161197aa3b9daa1fa3a ]

Add a call to put_pid() corresponding to get_task_pid().
host1x_memory_context_alloc() does not take ownership of the PID so we
need to free it here to avoid leaking.

Signed-off-by: Prateek Agarwal <praagarwal@nvidia.com>
Fixes: e09db97889ec ("drm/tegra: Support context isolation")
[mperttunen@nvidia.com: reword commit message]
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20250919-host1x-put-pid-v1-1-19c2163dfa87@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/uapi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index 5adab6b229164..d0b6a1fa6efad 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -114,9 +114,12 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 		if (err)
 			goto put_channel;
 
-		if (supported)
+		if (supported) {
+			struct pid *pid = get_task_pid(current, PIDTYPE_TGID);
 			context->memory_context = host1x_memory_context_alloc(
-				host, client->base.dev, get_task_pid(current, PIDTYPE_TGID));
+				host, client->base.dev, pid);
+			put_pid(pid);
+		}
 
 		if (IS_ERR(context->memory_context)) {
 			if (PTR_ERR(context->memory_context) != -EOPNOTSUPP) {
-- 
2.51.0




