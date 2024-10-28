Return-Path: <stable+bounces-89014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F89B2DBA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF6DB20A8B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67531DF961;
	Mon, 28 Oct 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrIGBOSE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B81DF960;
	Mon, 28 Oct 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112730; cv=none; b=cv8+O4F+20kN6bLcIut8G8JCVGQxmSkmt6xufD7vcmzvO/62Smxmif9NopQ6L36gjWByraHLP3H4POMrx+zlsAdCQgwXZRf/Ld1puEJu7OIas+Fn3yfQYA9G5kqWSDLkT8sTFcSNyB2YWxMpdWWTo2cNvJbmpQ0UG4qw1lD9mwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112730; c=relaxed/simple;
	bh=9AzQdJ7a7ZmHLyvXYcvwTYK3YDslAKLGKeQaeCzx/34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrzO+9GzJLhJJQVNbRxaZR/5j2p6zFLWBD/iydPD86uv+jVg11zeh96ivdqyZIZjj6sQEYX3GAgxlU98U/Ouno/RRM3jR7Mdv5C/KPyvn7B1gT7IVak196M7zFxppyKUC4Dx42fKv+G8aJ46eUtk6vqJfA/tTXmPnNdkobrSMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrIGBOSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B729C4CEE4;
	Mon, 28 Oct 2024 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112730;
	bh=9AzQdJ7a7ZmHLyvXYcvwTYK3YDslAKLGKeQaeCzx/34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrIGBOSEonr5OyXOb4Axjggr8O80L0wPQxCU21lZuIHyMOvInbWfiaXCOqBga6PaN
	 WDYJ4F4bnFGlusGkN22YCpbr7DwkJVXGF02iNbQrmbJMElJOGNmuU9BqtldT53B5Lc
	 Wi36RqlHLSfQTSOoPLsHs8eJ3FXRMx48BShcd3oKyh7zB8AAoZDTH8V5znJWIWDdtj
	 VaGfeGKGg/eFOUls8hAixnwHu70L2LTMdrbKG/JvdUqxWHe5R98PQdt55Rv/vNbqjv
	 6LPYFmQywhTxCdKAuA3qiebLfLZ6/eOTX+OJ5HxdI8fCG2ox62hDYQah39t+jrBJ7X
	 NtA11xsfJRMtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 32/32] drm/xe: Don't restart parallel queues multiple times on GT reset
Date: Mon, 28 Oct 2024 06:50:14 -0400
Message-ID: <20241028105050.3559169-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Nirmoy Das <nirmoy.das@intel.com>

[ Upstream commit cdc21021f0351226a4845715564afd5dc50ed44b ]

In case of parallel submissions multiple GuC id will point to the
same exec queue and on GT reset such exec queues will get restarted
multiple times which is not desirable.

v2: don't use exec_queue_enabled() which could race,
    do the same for xe_guc_submit_stop (Matt B)

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2295
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241022103555.731557-1-nirmoy.das@intel.com
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
(cherry picked from commit c8b0acd6d8745fd7e6450f5acc38f0227bd253b3)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 690f821f8bf5a..8628fbfade5a8 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1762,8 +1762,13 @@ void xe_guc_submit_stop(struct xe_guc *guc)
 
 	mutex_lock(&guc->submission_state.lock);
 
-	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
+	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
+		/* Prevent redundant attempts to stop parallel queues */
+		if (q->guc->id != index)
+			continue;
+
 		guc_exec_queue_stop(guc, q);
+	}
 
 	mutex_unlock(&guc->submission_state.lock);
 
@@ -1801,8 +1806,13 @@ int xe_guc_submit_start(struct xe_guc *guc)
 
 	mutex_lock(&guc->submission_state.lock);
 	atomic_dec(&guc->submission_state.stopped);
-	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
+	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q) {
+		/* Prevent redundant attempts to start parallel queues */
+		if (q->guc->id != index)
+			continue;
+
 		guc_exec_queue_start(q);
+	}
 	mutex_unlock(&guc->submission_state.lock);
 
 	wake_up_all(&guc->ct.wq);
-- 
2.43.0


