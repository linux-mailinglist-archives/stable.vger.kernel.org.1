Return-Path: <stable+bounces-63958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846C941B74
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ACD282845
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1911898ED;
	Tue, 30 Jul 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="StZlF1m5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147C1A6195;
	Tue, 30 Jul 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358505; cv=none; b=a+aEhMSjFoxwCTj7JNdCZFzHVDkoidPKIpbfk2hck4A78PtlewFUmVXWRwgoLm2DvvYhuTzLEMW2HpAMU67L9uXRSisIgrtpndeCUzRtxUXgWZKd+ayriE1pYrbOjQa05AaefrTeAb0wlrNnLPCuB10DrkFOUqUk+EcfgGZ0vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358505; c=relaxed/simple;
	bh=QDKc91yg0m+cGEYa4vQd025ZlPT3kb51qHp0HyNGn2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHLnM2+su5Ni2GF9qT0ltGotIN4xwr7a67oqeI8Y4uxIITPP4wVV56mRgW4aIKuHKFGNkvHhQm0eiqFnqippfTjIFVlrghHDoy6CDd07djX1kVquON8AVGOfgNhe8d5bxO4F1P0opJ1/fkU7lkFt///kE8sIJCNJgC2Qu8cpgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=StZlF1m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D5C32782;
	Tue, 30 Jul 2024 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358505;
	bh=QDKc91yg0m+cGEYa4vQd025ZlPT3kb51qHp0HyNGn2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StZlF1m5NbCcTPm9lGY1L64Peh4wCNbtdJjTZ4EmuhHoL1czvMGXTHrZEUYamAXXE
	 aXEtcnf22D9Gar4OD/+dFAYuc9rg63yRG3vC17+EXGGrCnqVwkS9NwBV6SVxos1HZy
	 ZWqtux4TeNgJqZG0hllVou1NA+JMBLbfbujjvWTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 365/809] drm/panthor: Record devfreq busy as soon as a job is started
Date: Tue, 30 Jul 2024 17:44:01 +0200
Message-ID: <20240730151739.068955154@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Price <steven.price@arm.com>

[ Upstream commit 896868eded124059023be0af92d68cdaf9b4de70 ]

If a queue is already assigned to the hardware, then a newly submitted
job can start straight away without waiting for the tick. However in
this case the devfreq infrastructure isn't notified that the GPU is
busy. By the time the tick happens the job might well have finished and
no time will be accounted for the GPU being busy.

Fix this by recording the GPU as busy directly in queue_run_job() in the
case where there is a CSG assigned and therefore we just ring the
doorbell.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240703155646.80928-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 9a0ff48f7061d..463bcd3cf00f3 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2939,6 +2939,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 			pm_runtime_get(ptdev->base.dev);
 			sched->pm.has_ref = true;
 		}
+		panthor_devfreq_record_busy(sched->ptdev);
 	}
 
 	/* Update the last fence. */
-- 
2.43.0




