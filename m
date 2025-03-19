Return-Path: <stable+bounces-125069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D13A6924E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158041B8588F
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F71DB14C;
	Wed, 19 Mar 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p+m7LDlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC71B87D5;
	Wed, 19 Mar 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394934; cv=none; b=BTonelyJ3AFe1rPbenJ7f2/EJjIB+K4BWqZ5Ev0u5M55SjD8bjdqpNkzVrzkcXuVAp3uKcDHbcztGa/02Rdk+LjeW0fVj7xefDEAvWMRE8Caw8xw+q+wuhFpSAukM/JYtwllYF8mkpyK4WIVtjchEbvl9lKjGGdZxufPUwWBMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394934; c=relaxed/simple;
	bh=5xMop1VwjtfLvsffSGkKFJq2T1mPhxoAhpXR834/lPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiM090XNk7MFNiA7sGefldtTZrVeVColjWGZTjrEekze7lX40iMdsM8SYaJhV8B/+ILIDKz7D2iv15WsnfIWcfrrJwYw1EKrgchBXraNElTEmBnW7kSTvHRYSF2Zl7k4G1r3igj0W+3Q9bxYnSE6VS03jZ4AEJO6rK9asEz+XpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p+m7LDlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D611C4CEE8;
	Wed, 19 Mar 2025 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394934;
	bh=5xMop1VwjtfLvsffSGkKFJq2T1mPhxoAhpXR834/lPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+m7LDlWkyoQZtVEZb0jRaCB5NS01uyVD0fSt/TlAkBgWqjymY4q95H0Dug2szHJV
	 hE+fqOaoRfRqWr233FuioA9mXTfyZJGx96kD0u1dxjEp1z2iPAQiimP8FSKe7pmHse
	 Hep7IXqKK0A7Nk71j4HNyXDqDMxCkJsrTgJXm1hs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 149/241] vhost: return task creation error instead of NULL
Date: Wed, 19 Mar 2025 07:30:19 -0700
Message-ID: <20250319143031.403379433@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit cb380909ae3b1ebf14d6a455a4f92d7916d790cb ]

Lets callers distinguish why the vhost task creation failed. No one
currently cares why it failed, so no real runtime change from this
patch, but that will not be the case for long.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Message-ID: <20250227230631.303431-2-kbusch@meta.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 drivers/vhost/vhost.c  | 2 +-
 kernel/vhost_task.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e102505735a7b..0e6bf24093f75 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7435,7 +7435,7 @@ static void kvm_mmu_start_lpage_recovery(struct once *once)
 				      kvm_nx_huge_page_recovery_worker_kill,
 				      kvm, "kvm-nx-lpage-recovery");
 
-	if (!nx_thread)
+	if (IS_ERR(nx_thread))
 		return;
 
 	vhost_task_start(nx_thread);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473e..63612faeab727 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -666,7 +666,7 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 
 	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
 				 worker, name);
-	if (!vtsk)
+	if (IS_ERR(vtsk))
 		goto free_worker;
 
 	mutex_init(&worker->mutex);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 8800f5acc0071..2ef2e1b800916 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -133,7 +133,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 
 	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
 	if (!vtsk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_completion(&vtsk->exited);
 	mutex_init(&vtsk->exit_mutex);
 	vtsk->data = arg;
@@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
 	if (IS_ERR(tsk)) {
 		kfree(vtsk);
-		return NULL;
+		return ERR_PTR(PTR_ERR(tsk));
 	}
 
 	vtsk->task = tsk;
-- 
2.39.5




