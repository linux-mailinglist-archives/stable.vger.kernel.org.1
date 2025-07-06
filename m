Return-Path: <stable+bounces-159467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CFAF78C1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28B35826E7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39042EE978;
	Thu,  3 Jul 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zNqVDTAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE62EAB69;
	Thu,  3 Jul 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554323; cv=none; b=nZwGjw7bhSE3NrNZZZKhD65DYT39AaeIz2/zjqkfmEF6SwIO9IXVT1jfw4dqiHl8KmkWpGSOW6yBEkRnaTVM+/TyJ3uAHxaYLmzvWaUdiDEfgapAcyhGXoWl3M5W3uzOmEyA7Rt0AmqCF4Sffrwh3x7VrUG49TCc9scHpdW3M44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554323; c=relaxed/simple;
	bh=+/xURjeiJUOQxkQo8vJQt6NJUxG3XdV91SBb9efxJw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL4DLEeX4tblHLISkT02mbVmwBKcRFDGI63CleLU8W42vujNunWvULavXdP786gjV0GNFWCnfx2IVTQxjJBtoxV3zAXAvGR6mWP4uzp8tMpag49fE6VBoFBsfQ+HlUWfKtBKKlAcuWyxe/BY4PvpPDRvdAA+3mCD6eOuxYkZr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zNqVDTAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE1FC4CEE3;
	Thu,  3 Jul 2025 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554323;
	bh=+/xURjeiJUOQxkQo8vJQt6NJUxG3XdV91SBb9efxJw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zNqVDTAJk58NNLm6VbSl/Fohvi+x50KMflWDT5bv/D0vOA+FDz/fQf1KIqSkL6wtC
	 dao/WbSNA2+x6MMO/MWLNto94HLwHPswc4h70XlHI1okDBQZqlP4KLmNO8Iih2AQtt
	 FK9sbJQIQFgFbyrgs+HsHHsU6KizByIF6py77vWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Stanner <phasta@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6.12 150/218] drm/etnaviv: Protect the schedulers pending list with its lock
Date: Thu,  3 Jul 2025 16:41:38 +0200
Message-ID: <20250703144002.148186462@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit 61ee19dedb8d753249e20308782bf4e9e2fb7344 upstream.

Commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still
active") ensured that active jobs are returned to the pending list when
extending the timeout. However, it didn't use the pending list's lock to
manipulate the list, which causes a race condition as the scheduler's
workqueues are running.

Hold the lock while manipulating the scheduler's pending list to prevent
a race.

Cc: stable@vger.kernel.org
Fixes: 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is still active")
Reported-by: Philipp Stanner <phasta@kernel.org>
Closes: https://lore.kernel.org/dri-devel/964e59ba1539083ef29b06d3c78f5e2e9b138ab8.camel@mailbox.org/
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20250602132240.93314-1-mcanal@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -34,6 +34,7 @@ static enum drm_gpu_sched_stat etnaviv_s
 							  *sched_job)
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
+	struct drm_gpu_scheduler *sched = sched_job->sched;
 	struct etnaviv_gpu *gpu = submit->gpu;
 	u32 dma_addr;
 	int change;
@@ -76,7 +77,9 @@ static enum drm_gpu_sched_stat etnaviv_s
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 
 out_no_timeout:
-	list_add(&sched_job->list, &sched_job->sched->pending_list);
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 



