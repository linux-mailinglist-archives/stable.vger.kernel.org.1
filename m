Return-Path: <stable+bounces-70935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D89610C4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EDE1C20FD8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D751C5783;
	Tue, 27 Aug 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="figUWUO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D471BC9E3;
	Tue, 27 Aug 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771551; cv=none; b=MsMPde5rNRuXGxSSKL7k5GXiDIgvWQyHMQmNUzXVxu86+0Ulzue62gFregW7gzVz7LCC0mcA+r+3zE914AR6EdGST18xrRiVQC3UBNbt32HfS3fpT5tvtzt4n3ZlBQSaqaKM/sLJAoyGMeN+Uq6Y823127itWwJAYNp8i+FBMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771551; c=relaxed/simple;
	bh=y4uJCYzgPyY4CvCJs05ZoSEbXUwT1hSiMDKPWkgY0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmX64Dw59Oi8yHfaUKRHRIEm+4oNNRp0kGsyp8mSga7GtD1/DDQAgrbvBAogGKJkohlfQKf+e9xbdey9Y7NVT/s8Xu1dfwnh4vntxiehwE8BmPCy6Mun4M7vXqDqh7ymTJ9TOaakQXFimzW9qr75HX6E6O5zC3BlixrZZE9UuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=figUWUO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132D6C61042;
	Tue, 27 Aug 2024 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771551;
	bh=y4uJCYzgPyY4CvCJs05ZoSEbXUwT1hSiMDKPWkgY0dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=figUWUO9vXt2/yw0KeSUiy5hOGYqsAKEHaj7jo7fN6Ae5/uYZwUW/Vp1KOFAg6l/t
	 WmY1bKlymPQKBAY/alFwPNTJRTrf2nxMeB+V73/eVEqwKCnymBaLfYa25moYYa6dBA
	 N+2YC3ITOYqngJLYGyW4X2lZSE3ASaAJ7DwdvRE0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>,
	Mark ODonovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 222/273] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Date: Tue, 27 Aug 2024 16:39:06 +0200
Message-ID: <20240827143841.853911982@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a54a93d0e3599b05856971734e15418ac551a14c ]

Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
moves starting keep-alive from nvme_start_ctrl() into
nvme_init_ctrl_finish(), but don't move stopping keep-alive into
nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
after failing to start controller, finally use-after-free is triggered if
nvme host driver is unloaded.

This patch fixes kernel panic when running nvme/004 in case that connection
failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().

This way is reasonable because keep-alive is now started in
nvme_init_ctrl_finish().

Fixes: 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
Cc: Hannes Reinecke <hare@suse.de>
Cc: Mark O'Donovan <shiftee@posteo.net>
Reported-by: Changhui Zhong <czhong@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc10..d973d063bbf50 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4522,7 +4522,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
-	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
@@ -4558,6 +4557,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(ctrl);
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-- 
2.43.0




