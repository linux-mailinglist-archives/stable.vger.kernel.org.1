Return-Path: <stable+bounces-133550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899ACA9261E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767A54A0565
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909091E25E1;
	Thu, 17 Apr 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ul9ErrIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67A18C034;
	Thu, 17 Apr 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913416; cv=none; b=MqhpZU3We4eU6bDO87znH4MbRau3r/Vt2NtFQ0/AkcXJfdWdixngZnMmgPIJzJbsqw137VKucdo38HYIlnenkxTvTegLyvGbLVBXCZJPnmEBbrWmyvRqv9bRLL4tQuEFjcNs7iHVfXi8/oLz5H5HCeNAy5R+2nLDbn0/B+doqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913416; c=relaxed/simple;
	bh=uTJOTeb0kFwGaoIdlZO9ceeNCHWeoSUsewcfkpsJ+oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQutPOPtczR+F6jswncNmScESFhuOmw1IABg99aMYFxsQZBIKBhVymq4BMLsVKeFUrPtSgYIf31uKcyewfNSZcHqTZ4tLf3xtqveFB5NY5BBFSmFebJrLCwTKsUCa44RAZjviL4oszNQB0r+K+HG0Ny01m5UNbL3HuCJbkmZ0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ul9ErrIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FEC4CEE4;
	Thu, 17 Apr 2025 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913414;
	bh=uTJOTeb0kFwGaoIdlZO9ceeNCHWeoSUsewcfkpsJ+oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ul9ErrIErpkDa/zmwlSQvnZH+0uuLEbA3Mh7Elj3Ek+Ei9oOrGNajtOfpfsLt5HlU
	 PTUhkaIAoTQ0tNyj9s/apji9jiE6WtR7h1M3lBZH+SZUz6dQTafL6E6Z6XeND+iCOh
	 faVutTBOy/w9a5JA9uMxeZ5b2rFpjjItOc3Np9cA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.14 302/449] accel/ivpu: Fix deadlock in ivpu_ms_cleanup()
Date: Thu, 17 Apr 2025 19:49:50 +0200
Message-ID: <20250417175130.252203960@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

commit 9a6f56762d23a1f3af15e67901493c927caaf882 upstream.

Fix deadlock in ivpu_ms_cleanup() by preventing runtime resume after
file_priv->ms_lock is acquired.

During a failure in runtime resume, a cold boot is executed, which
calls ivpu_ms_cleanup_all(). This function calls ivpu_ms_cleanup()
that acquires file_priv->ms_lock and causes the deadlock.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250325114306.3740022-2-maciej.falkowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_ms.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/drm_file.h>
+#include <linux/pm_runtime.h>
 
 #include "ivpu_drv.h"
 #include "ivpu_gem.h"
@@ -299,6 +300,9 @@ unlock:
 void ivpu_ms_cleanup(struct ivpu_file_priv *file_priv)
 {
 	struct ivpu_ms_instance *ms, *tmp;
+	struct ivpu_device *vdev = file_priv->vdev;
+
+	pm_runtime_get_sync(vdev->drm.dev);
 
 	mutex_lock(&file_priv->ms_lock);
 
@@ -311,6 +315,8 @@ void ivpu_ms_cleanup(struct ivpu_file_pr
 		free_instance(file_priv, ms);
 
 	mutex_unlock(&file_priv->ms_lock);
+
+	pm_runtime_put_autosuspend(vdev->drm.dev);
 }
 
 void ivpu_ms_cleanup_all(struct ivpu_device *vdev)



