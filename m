Return-Path: <stable+bounces-155071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC07AE17AA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F1016BC76
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9227D76E;
	Fri, 20 Jun 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fvKA18vM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141F30E830
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412152; cv=none; b=pr7+k6EDCr0kSnr5o8bloG2wfeIyPxCVC5wClvA8T2RyatCFiteOucvDBpfgea4XROeeSP4He9AphsavFfrdMxRMlTJR47G8sZKwqrFyxcbuY68pbFoMrGlp3FhVufUTdYVteiM6YtStlQy4lRLCqM92Gc2XYp49cjopAIzIRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412152; c=relaxed/simple;
	bh=t2QL979fpL7vsTt3idHtYl7hovMZc4fJEz+77Bxo78M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IyfrDaFnWrMIYMpfQ0epVgT5hTquF9/UhmHIXR7I2e5piM8SWMnVl+gNwsT4ZEqEk3W6JzkZsyaNGdz3Jo2gPLXb8jXfBQbhSGSS8F1/QKkPjsPH9eC5tLpGrmXkFKVuYDYuhVTD+IoSQLFcg7aUkT2dFFwRLgT60R3tgLrH/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fvKA18vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E1C4CEE3;
	Fri, 20 Jun 2025 09:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750412152;
	bh=t2QL979fpL7vsTt3idHtYl7hovMZc4fJEz+77Bxo78M=;
	h=Subject:To:Cc:From:Date:From;
	b=fvKA18vMt7g7X7nq6bae5yaWY7hk0T3TmsoRvRQ46b0p4jcIKNAPV/XhjokZgTt7D
	 dhIGZmsm5842gXedFo1sjGrP85p+u+B9s+shYPHWfvlwBFxpI2+Ma/vTaYFgACPxiQ
	 nfVDOjFW5OhnoLUZuAzXbCjTf4Pz9FXtSFW9cUwM=
Subject: FAILED: patch "[PATCH] accel/ivpu: Fix warning in ivpu_gem_bo_free()" failed to apply to 6.6-stable tree
To: jacek.lawrynowicz@linux.intel.com,jeff.hugo@oss.qualcomm.com,lizhi.hou@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:35:49 +0200
Message-ID: <2025062049-disperser-manager-db76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 91274fd4ed9ba110b02c53d71d2778b7d13b49ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062049-disperser-manager-db76@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91274fd4ed9ba110b02c53d71d2778b7d13b49ac Mon Sep 17 00:00:00 2001
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Date: Wed, 28 May 2025 19:12:20 +0200
Subject: [PATCH] accel/ivpu: Fix warning in ivpu_gem_bo_free()

Don't WARN if imported buffers are in use in ivpu_gem_bo_free() as they
can be indeed used in the original context/driver.

Fixes: 647371a6609d ("accel/ivpu: Add GEM buffer object management")
Cc: stable@vger.kernel.org # v6.3
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250528171220.513225-1-jacek.lawrynowicz@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index 5908268ca45e..248bfebeaa22 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -285,7 +285,8 @@ static void ivpu_gem_bo_free(struct drm_gem_object *obj)
 	list_del(&bo->bo_list_node);
 	mutex_unlock(&vdev->bo_list_lock);
 
-	drm_WARN_ON(&vdev->drm, !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
+	drm_WARN_ON(&vdev->drm, !drm_gem_is_imported(&bo->base.base) &&
+		    !dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_READ));
 	drm_WARN_ON(&vdev->drm, ivpu_bo_size(bo) == 0);
 	drm_WARN_ON(&vdev->drm, bo->base.vaddr);
 


