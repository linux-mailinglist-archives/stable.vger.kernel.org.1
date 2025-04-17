Return-Path: <stable+bounces-133951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6AA92925
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921A47B87B4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4502571CE;
	Thu, 17 Apr 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzEU2qG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67658253333;
	Thu, 17 Apr 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914640; cv=none; b=m3kk5bN8Lqg5HzsFbsm42yhrXy57BYiWxx89EG/N5oJGzqv35JsYEJN/4R6FMKqqxVuYr73qQE8JPrFZmYBKaw0jNNb3moIDFr0miGLvEqSdqjM9xzCjsoDBDxolqmKqFP5dt0XiiSzuvBaNWsgyce6ZAvgq13zsy6j1h+yrEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914640; c=relaxed/simple;
	bh=072dxLg2gPRsWzBQAdyeYcva16yJo1ji1kS/Tg3kltM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMS42T0kvSiE6WOlQNfmofFTeMa1o85ftKwIt/1Hlcd3j1aCd5Jz6ATSqvseG74wGpbRb+LEE2lPUmucmUnI1XkPaEefAolu1Rclg0MLEbb4peTmSyYnJcCCzu62k50bdlST+wO4chcjkw1OmbI5e5KrLLLK0ojMRPd5/Dtcxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzEU2qG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AEFC4CEE7;
	Thu, 17 Apr 2025 18:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914640;
	bh=072dxLg2gPRsWzBQAdyeYcva16yJo1ji1kS/Tg3kltM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzEU2qG9W3RokhaQfJzX1qRSbqa3TwyfISJi1zK38ujRvzknJt9pT+/B3Ta7hYwZF
	 KID4TxIg2+pGjGTI9oJC8NZ56jOiyvpeYv24SE0nU+LQtQY9yP+xkqeF74tb3GCXdU
	 jTwrqrMukRiybsC4OO196XLJ3H72o+6NNssY+HTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.13 275/414] accel/ivpu: Fix deadlock in ivpu_ms_cleanup()
Date: Thu, 17 Apr 2025 19:50:33 +0200
Message-ID: <20250417175122.486449826@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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



