Return-Path: <stable+bounces-201802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F91ECC279A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E9C3022199
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D035502A;
	Tue, 16 Dec 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vmj2mSIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E131355026;
	Tue, 16 Dec 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885834; cv=none; b=LxU1VyGoeNYWs+3OqSU/YAD4vhkwY4Oyx/ZEiqFVgCcNqXYjOXG4FEASLCr7n3M6DSI++amo/wfFp+WZXX66AwYyxDwz1C5zPvsL3xYB0xr03CgGV2sg0cUwjCkWB2fxTA7aUJMMkJjuXB9MdOMseLkoUNl1AN4tQZnyD4tJttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885834; c=relaxed/simple;
	bh=M9vL8820d+naSEvLxwZOjOeHcr1S//+zWn1JbysWRSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN0t3jMWDyZXCzM8NA5tTRlwGIFflLfbdiGCUmpmIokkPb0UiA/7jYCoJ2L3TNKMYlRHz6kv4nkSHI+GyhS7bSxuulUR8kzhQXFHjU3gYBT9ays+s2XgxCiwR4iheC0kDuppZ7Sii9nxrkeciOp9H69593EuY/xTV4kjoOZQxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vmj2mSIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD730C4CEF1;
	Tue, 16 Dec 2025 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885834;
	bh=M9vL8820d+naSEvLxwZOjOeHcr1S//+zWn1JbysWRSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vmj2mSIlEkUMrMstJELe3ohhaSV028SzqPmhYLkRO8h2pj3RkEc+YGdd9LRPVHaVk
	 7nxY05tdJHlitnaj8WdCh+otJ70MDV1L8BQyspqQ2tpTo2VP5OXDUodoPcKIadl1TO
	 W+gNu82HK7I4WfaEUXSfe6wNoGm7HWUtU8l1sh8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huiwen He <hehuiwen@kylinos.cn>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 259/507] drm/msm: Fix NULL pointer dereference in crashstate_get_vm_logs()
Date: Tue, 16 Dec 2025 12:11:40 +0100
Message-ID: <20251216111354.872612549@linuxfoundation.org>
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

From: Huiwen He <hehuiwen@kylinos.cn>

[ Upstream commit 3099e0247e3217e1b39c1c61766e06ec3d13835f ]

crashstate_get_vm_logs() did not check the return value of
kmalloc_array(). In low-memory situations, kmalloc_array() may return
NULL, leading to a NULL pointer dereference when the function later
accesses state->vm_logs.

Fix this by checking the return value of kmalloc_array() and setting
state->nr_vm_logs to 0 if allocation fails.

Fixes: 9edc52967cc7 ("drm/msm: Add VM logging for VM_BIND updates")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Patchwork: https://patchwork.freedesktop.org/patch/687555/
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 26c5ce897cbbd..8f933c1fe4bfa 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -348,6 +348,10 @@ static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_v
 
 	state->vm_logs = kmalloc_array(
 		state->nr_vm_logs, sizeof(vm->log[0]), GFP_KERNEL);
+	if (!state->vm_logs) {
+		state->nr_vm_logs = 0;
+	}
+
 	for (int i = 0; i < state->nr_vm_logs; i++) {
 		int idx = (i + first) & vm_log_mask;
 
-- 
2.51.0




