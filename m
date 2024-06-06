Return-Path: <stable+bounces-49601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6748FEDFA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B4281B3A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB751BE86D;
	Thu,  6 Jun 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCYKL1uE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B71BE86C;
	Thu,  6 Jun 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683547; cv=none; b=jQuGnVKnqU7QRnv8dX2qzrJC0ZECyEdCZsCxJAfBSnm2Eq2b1r8b1ClgIPcWn4SLMlcmSFX5OEtt6VlLxu/7MWs/j7QHQN4cqgeBS6PSVIW2NkvrM+8+6AoY7ppv8TsxIIUnRRVZU/CTJU8gzJBImLwtsp4/3ji8Lzuso6Jd5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683547; c=relaxed/simple;
	bh=2SgNhHk1zMS3pWYZft82FuFR+riMGH97gCHsssysk5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhjPhWHqpGSnnOTsylE4DTwuoOW3MxFKLHQeKgRGHL1t8ooDOxMC41KTF4OytrOXw5lqx6cl98Rx/FEBPVfs5/z2K6SsGQGPYTy4sMLaDv+XlBX5OIPjm/Qke+pvk82UG/onWDQjRk07idnCv2EHU5J5WHcpA97u/is/8tEUvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCYKL1uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBBFC2BD10;
	Thu,  6 Jun 2024 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683547;
	bh=2SgNhHk1zMS3pWYZft82FuFR+riMGH97gCHsssysk5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yCYKL1uE5PNp7pM4UD10zIXZI4lXv8EhLshLdwav/H33QNYsT82E1lFuHuiKjPnIf
	 OZ0tX23bwjwlfWi3+zmuErgjuUM3L2jOwvVth95kgW2TaQJC0Dty3EB9TLDBGtrowp
	 5/fPaqlYa0BIGtkfdtYojXL1Rt3HMBgeiXzCTelc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 436/473] nvmet: fix ns enable/disable possible hang
Date: Thu,  6 Jun 2024 16:06:05 +0200
Message-ID: <20240606131714.152431059@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit f97914e35fd98b2b18fb8a092e0a0799f73afdfe ]

When disabling an nvmet namespace, there is a period where the
subsys->lock is released, as the ns disable waits for backend IO to
complete, and the ns percpu ref to be properly killed. The original
intent was to avoid taking the subsystem lock for a prolong period as
other processes may need to acquire it (for example new incoming
connections).

However, it opens up a window where another process may come in and
enable the ns, (re)intiailizing the ns percpu_ref, causing the disable
sequence to hang.

Solve this by taking the global nvmet_config_sem over the entire configfs
enable/disable sequence.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 40c1c3db5d7cd..2e87718aa194d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -537,10 +537,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (strtobool(page, &enable))
 		return -EINVAL;
 
+	/*
+	 * take a global nvmet_config_sem because the disable routine has a
+	 * window where it releases the subsys-lock, giving a chance to
+	 * a parallel enable to concurrently execute causing the disable to
+	 * have a misaccounting of the ns percpu_ref.
+	 */
+	down_write(&nvmet_config_sem);
 	if (enable)
 		ret = nvmet_ns_enable(ns);
 	else
 		nvmet_ns_disable(ns);
+	up_write(&nvmet_config_sem);
 
 	return ret ? ret : count;
 }
-- 
2.43.0




