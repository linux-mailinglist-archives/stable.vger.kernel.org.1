Return-Path: <stable+bounces-173526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86853B35DCF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66F518831CD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FD23B628;
	Tue, 26 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCHcCFAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBD393DD1;
	Tue, 26 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208477; cv=none; b=FBpt1COGoUgHxFeVgCab4vJiDWaTn9J3/iZp3x1gUIBPKyu17SoCfy2k0N+ypdG2dmgXGOqYNjcJKIwA498EKJMsodZ97GPiQPF6rfCA3olAg5UFq9Y5crggDZA68itNHdmUKm0Z32wy3ESQawupyHYANGoT93/cOt2Jj25hovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208477; c=relaxed/simple;
	bh=foWzlYNB1qzIXehHfjtUkj30rxzOWmfSwDnMJHqFLAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS+//oclQuJ3aFeGgHCeqKKu3d/rgj4fZXQzYcdNVlAeACqVGyUnEnviUhJdq8Hdh38q2e35PTgQnJNYeNRNnLHMF+iHWRhpejzgvhr8WZ/cfcdlWw+j7hqRrUY43e6Czl1zieDgCitYsTmnBhXybdBEAYDLguaCp1sUDGME4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCHcCFAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE8AC4CEF1;
	Tue, 26 Aug 2025 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208477;
	bh=foWzlYNB1qzIXehHfjtUkj30rxzOWmfSwDnMJHqFLAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCHcCFAWi9YuMUu8fMPO5vRnjSv7URMBam3QrR/W2I5l9QHScTkpjOzCOvK8D/G3v
	 2Goj1AipqMsCoPgLL3pke3a8ZyL8vLP6OloNJO0ICmSXY7PJePxM8CZ6H9fiBAvqIg
	 1bAr7IUFsHzhpOK317RSRq27DJsdlNIUVnriX++g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amber Lin <Amber.Lin@amd.com>,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 126/322] drm/amdkfd: Destroy KFD debugfs after destroy KFD wq
Date: Tue, 26 Aug 2025 13:09:01 +0200
Message-ID: <20250826110918.909467431@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

From: Amber Lin <Amber.Lin@amd.com>

commit 2e58401a24e7b2d4ec619104e1a76590c1284a4c upstream.

Since KFD proc content was moved to kernel debugfs, we can't destroy KFD
debugfs before kfd_process_destroy_wq. Move kfd_process_destroy_wq prior
to kfd_debugfs_fini to fix a kernel NULL pointer problem. It happens
when /sys/kernel/debug/kfd was already destroyed in kfd_debugfs_fini but
kfd_process_destroy_wq calls kfd_debugfs_remove_process. This line
    debugfs_remove_recursive(entry->proc_dentry);
tries to remove /sys/kernel/debug/kfd/proc/<pid> while
/sys/kernel/debug/kfd is already gone. It hangs the kernel by kernel
NULL pointer.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0333052d90683d88531558dcfdbf2525cc37c233)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -78,8 +78,8 @@ err_ioctl:
 static void kfd_exit(void)
 {
 	kfd_cleanup_processes();
-	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
+	kfd_debugfs_fini();
 	kfd_procfs_shutdown();
 	kfd_topology_shutdown();
 	kfd_chardev_exit();



