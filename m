Return-Path: <stable+bounces-51479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03790701D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7339D1C23BC2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77E145B21;
	Thu, 13 Jun 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnfO23KG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35E1459FA;
	Thu, 13 Jun 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281419; cv=none; b=b9W5l/Fz6BqjjLDpiJXUyRjn8lAAc0Aj6sifKBrCphBtJ0kECpZ22uRZjxSiJXDFcD1U/ayVSF71NlfANcho60emwBpNudoixe6tzzsg5KiTsU2HJeLnS60Y/vEMDW9Kms3/4z2tQiRW8jj6eyb8646Zku2i1vmlOsNn8k2K2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281419; c=relaxed/simple;
	bh=dqQ+R4qhjMeKcvuVeDvrlormS6yG/lT+Vya+46ib2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtH7cZctxa9ZfBSZFi+9rm84Dt0Y6iPu8w175kVxB/kz0HXXqfp2/FCJ24gwU03AUYWKK4d0UaTUFP2ExyUE3pxwr2OvoWYBoE8q5bvIC/VBlZR7owI1/hnplaVcjyoGczsGcQ8UYTdxtF7KF1fxkweJ1tkImEldIh0RIX0hcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnfO23KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DABC32786;
	Thu, 13 Jun 2024 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281419;
	bh=dqQ+R4qhjMeKcvuVeDvrlormS6yG/lT+Vya+46ib2ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnfO23KGk2LUSNQmcJyHRuXjluAGjm36CMCjEE5mLh62VrdKptn/S3dOFDX7NCSpa
	 4gbdq5V0Jt0qhdGbiwWta0EQKIxsjyQ/4rU5dzsYCTXt04mEkA2/NjRQmlec/NiscP
	 UFwr3QXvuoXppXeNWDja/PZpY3pyDViPz9Zsu6r8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 248/317] nvmet: fix ns enable/disable possible hang
Date: Thu, 13 Jun 2024 13:34:26 +0200
Message-ID: <20240613113257.144714455@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 9aed5cc710960..f2d11fc047524 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -532,10 +532,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
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




