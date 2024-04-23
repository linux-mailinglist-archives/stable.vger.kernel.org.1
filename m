Return-Path: <stable+bounces-41279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4B8AFAFF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284CA1F26A59
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3B14BFAB;
	Tue, 23 Apr 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aSUarKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC72143C6C;
	Tue, 23 Apr 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908799; cv=none; b=fmXOXEAfK68NuPTRrysAjqW0w1OIMtjCHwAhNp6Pj2gh04//eSjmVIKWIm+QGU8CH410f1+JaGleaziMaIZkMaKObHMoK3XY3UQoJG+CYWhSmexR4HunIWjnlwFWEGXuKw10nEMVIASvZw9Q3b/YlgVQynFyNbm2SGcTAFuFPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908799; c=relaxed/simple;
	bh=7evQwFjd6fYu1apk5zRu6d2tShinoz3XKA+dTJJu0Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyQ7NtlejTPFQz4c+FecAkuuE24NH0aNvxRefbUnWEtWVEirm6xmIdGHHhP/TEH0YLIza61qdGVizduPwa0o+Y3CwLkjvcQgXMQB+cKoEuqyiEsleybXEFujaORslgPSzUQXNMJ49Ms5O0qyCnLBvSwqlF+m7/zs5utIxXeIN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aSUarKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8203FC116B1;
	Tue, 23 Apr 2024 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908799;
	bh=7evQwFjd6fYu1apk5zRu6d2tShinoz3XKA+dTJJu0Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0aSUarKUIyHzU0QWs31lxwH+Lr7DZOrk2F3Mwj04AUZObffLgufktH5Gvbyw3kBoi
	 j+mLyfn36dGAIUZqBIhuoOKTUMQkdeAp8mpFbUOPkaKatT+jcQI0VeHEhl9xC8wrRE
	 QpCNumkJz7wmlzDzJccKioFzi33vnnAFqK5I238s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 28/71] RDMA/cm: Print the old state when cm_destroy_id gets timeout
Date: Tue, 23 Apr 2024 14:39:41 -0700
Message-ID: <20240423213845.117232556@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit b68e1acb5834ed1a2ad42d9d002815a8bae7c0b6 ]

The old state is helpful for debugging, as the current state is always
IB_CM_IDLE when timeout happens.

Fixes: 96d9cbe2f2ff ("RDMA/cm: add timeout to cm_destroy_id wait")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/20240322112049.2022994-1-markzhang@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 504e1adf1997a..c8a7fe5fbc233 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1033,23 +1033,26 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 	}
 }
 
-static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id)
+static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
+						enum ib_cm_state old_state)
 {
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state=%d refcnt=%d\n", __func__,
-	       cm_id, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 {
 	struct cm_id_private *cm_id_priv;
+	enum ib_cm_state old_state;
 	struct cm_work *work;
 	int ret;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irq(&cm_id_priv->lock);
+	old_state = cm_id->state;
 retest:
 	switch (cm_id->state) {
 	case IB_CM_LISTEN:
@@ -1158,7 +1161,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 						  msecs_to_jiffies(
 						  CM_DESTROY_ID_WAIT_TIMEOUT));
 		if (!ret) /* timeout happened */
-			cm_destroy_id_wait_timeout(cm_id);
+			cm_destroy_id_wait_timeout(cm_id, old_state);
 	} while (!ret);
 
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
-- 
2.43.0




