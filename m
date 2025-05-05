Return-Path: <stable+bounces-140369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A64AAA7F0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7621631DA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED0344506;
	Mon,  5 May 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvM1cW+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963C34349A;
	Mon,  5 May 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484709; cv=none; b=K6iQaDYYuCzqPXqiwx6UrWrKlNNDi/jjjQR98ahIBwkHY65/uwxy2JTu5UqMmBh1DS7t89ZM1M3sKNRmvKSejwDM0dXocsBT/h9UTwcm7Y+MUY67gU1WIjjWn7zsa+D+nB2bzlRzfm46BvOQj5n9NITgHeObWDdr5CskF5Ca4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484709; c=relaxed/simple;
	bh=HlSzp+yEa0DoVAu3CNxQX9WBoBXnANNxvrF+hMxFmdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BaS/TLUlNLsDxXOh9XKa714g3xrDsWShIE8n/hhEHR7bMhYj9jciOET1/LVvmWJqoAIN9BpWUz/8GRiGjnPYOsA0JbaZMSlLzDO+0eDoEFZ6pY5XXOEEMjtgkRxHcUnUSGzz0fODZMze+vuKWBWNE3He16PFe2GTyyZKeVtodxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvM1cW+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097FDC4CEEF;
	Mon,  5 May 2025 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484708;
	bh=HlSzp+yEa0DoVAu3CNxQX9WBoBXnANNxvrF+hMxFmdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvM1cW+1d5Wh5g+tJC+IUvLnD6/QhnHaCx4ooNLvM+FgWQ/Q5fvFvR5ygyvmvyMDY
	 uAPXaHK9T66iRu4G1yrC6it7/FJC5RopNdM5OvDiw2c3HJAp6GV+Lp4DFGP8Io04j4
	 PNU+KNCf0aW1rOl3KFBWRyje3n5RszQdERxuBLQal0wIWfUHs8mWD/qLijCxSZc7Y/
	 EKnH6Fdnx0tyr7rBER44qnfyFZj0CMlcNRVGIK5bHhUZ3l58GCzwqjBpZ09ZwHGdVx
	 m4dmyAUD8ShTb4cVWt5x3IvcZOBY4D42LaWXxRRMEZpTxaZVMsMJGUjaUcGnKEcl/S
	 qvtpSzWRS6dww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 620/642] accel/ivpu: Separate DB ID and CMDQ ID allocations from CMDQ allocation
Date: Mon,  5 May 2025 18:13:56 -0400
Message-Id: <20250505221419.2672473-620-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

[ Upstream commit 950942b4813f8c44dbec683fdb140cf4a238516b ]

Move doorbell ID and command queue ID XArray allocations from command
queue memory allocation function. This will allow ID allocations to be
done without the need for actual memory allocation.

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-2-maciej.falkowski@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_job.c | 88 +++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 7149312f16e19..98e53cb38ecd3 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -83,23 +83,9 @@ static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 	if (!cmdq)
 		return NULL;
 
-	ret = xa_alloc_cyclic(&vdev->db_xa, &cmdq->db_id, NULL, vdev->db_limit, &vdev->db_next,
-			      GFP_KERNEL);
-	if (ret < 0) {
-		ivpu_err(vdev, "Failed to allocate doorbell id: %d\n", ret);
-		goto err_free_cmdq;
-	}
-
-	ret = xa_alloc_cyclic(&file_priv->cmdq_xa, &cmdq->id, cmdq, file_priv->cmdq_limit,
-			      &file_priv->cmdq_id_next, GFP_KERNEL);
-	if (ret < 0) {
-		ivpu_err(vdev, "Failed to allocate command queue id: %d\n", ret);
-		goto err_erase_db_xa;
-	}
-
 	cmdq->mem = ivpu_bo_create_global(vdev, SZ_4K, DRM_IVPU_BO_WC | DRM_IVPU_BO_MAPPABLE);
 	if (!cmdq->mem)
-		goto err_erase_cmdq_xa;
+		goto err_free_cmdq;
 
 	ret = ivpu_preemption_buffers_create(vdev, file_priv, cmdq);
 	if (ret)
@@ -107,10 +93,6 @@ static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 
 	return cmdq;
 
-err_erase_cmdq_xa:
-	xa_erase(&file_priv->cmdq_xa, cmdq->id);
-err_erase_db_xa:
-	xa_erase(&vdev->db_xa, cmdq->db_id);
 err_free_cmdq:
 	kfree(cmdq);
 	return NULL;
@@ -233,30 +215,88 @@ static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
 	return 0;
 }
 
+static int ivpu_db_id_alloc(struct ivpu_device *vdev, u32 *db_id)
+{
+	int ret;
+	u32 id;
+
+	ret = xa_alloc_cyclic(&vdev->db_xa, &id, NULL, vdev->db_limit, &vdev->db_next, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	*db_id = id;
+	return 0;
+}
+
+static int ivpu_cmdq_id_alloc(struct ivpu_file_priv *file_priv, u32 *cmdq_id)
+{
+	int ret;
+	u32 id;
+
+	ret = xa_alloc_cyclic(&file_priv->cmdq_xa, &id, NULL, file_priv->cmdq_limit,
+			      &file_priv->cmdq_id_next, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	*cmdq_id = id;
+	return 0;
+}
+
 static struct ivpu_cmdq *ivpu_cmdq_acquire(struct ivpu_file_priv *file_priv, u8 priority)
 {
+	struct ivpu_device *vdev = file_priv->vdev;
 	struct ivpu_cmdq *cmdq;
-	unsigned long cmdq_id;
+	unsigned long id;
 	int ret;
 
 	lockdep_assert_held(&file_priv->lock);
 
-	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq)
+	xa_for_each(&file_priv->cmdq_xa, id, cmdq)
 		if (cmdq->priority == priority)
 			break;
 
 	if (!cmdq) {
 		cmdq = ivpu_cmdq_alloc(file_priv);
-		if (!cmdq)
+		if (!cmdq) {
+			ivpu_err(vdev, "Failed to allocate command queue\n");
 			return NULL;
+		}
+
+		ret = ivpu_db_id_alloc(vdev, &cmdq->db_id);
+		if (ret) {
+			ivpu_err(file_priv->vdev, "Failed to allocate doorbell ID: %d\n", ret);
+			goto err_free_cmdq;
+		}
+
+		ret = ivpu_cmdq_id_alloc(file_priv, &cmdq->id);
+		if (ret) {
+			ivpu_err(vdev, "Failed to allocate command queue ID: %d\n", ret);
+			goto err_erase_db_id;
+		}
+
 		cmdq->priority = priority;
+		ret = xa_err(xa_store(&file_priv->cmdq_xa, cmdq->id, cmdq, GFP_KERNEL));
+		if (ret) {
+			ivpu_err(vdev, "Failed to store command queue in cmdq_xa: %d\n", ret);
+			goto err_erase_cmdq_id;
+		}
 	}
 
 	ret = ivpu_cmdq_init(file_priv, cmdq, priority);
-	if (ret)
-		return NULL;
+	if (ret) {
+		ivpu_err(vdev, "Failed to initialize command queue: %d\n", ret);
+		goto err_free_cmdq;
+	}
 
 	return cmdq;
+
+err_erase_cmdq_id:
+	xa_erase(&file_priv->cmdq_xa, cmdq->id);
+err_erase_db_id:
+	xa_erase(&vdev->db_xa, cmdq->db_id);
+err_free_cmdq:
+	ivpu_cmdq_free(file_priv, cmdq);
+	return NULL;
 }
 
 void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv)
-- 
2.39.5


