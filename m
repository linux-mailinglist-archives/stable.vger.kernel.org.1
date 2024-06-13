Return-Path: <stable+bounces-51039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A118A906E0E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CDD1F21040
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91C144D18;
	Thu, 13 Jun 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zntvFgp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A31144D10;
	Thu, 13 Jun 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280127; cv=none; b=LNTeCAnBczoLc+8rjLddwDLMybLPrrhaXAvT1G24oxWDslbipCZlIwC8nLHZvSskPatx6utNTDTMCWzmBGJDhot5w8t4kjzlXtiQ8XxLgnQnCL4FfZaJZFvl+mt5+sI/SAwhcVawM/VvIYh7+qJf3A0WUu4BIFizsNe/WQLavbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280127; c=relaxed/simple;
	bh=43GLf7JN4BLVMFP07wx968SswOBqZHdnbhi5h6CF4DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+cKYIt02p4MqCk5GWfSUPfhkJWyGPci04nSeBgeo5lFpi8nBwZWu5AWKSKVYnvXF43l10HC6AkDpe9Hr0UKaL/HGSyZ7/wY0r6hFlrkd6HyJkKsqfgBCbFlrmAb5jWh4DhesM0qHkBcq4BW5NYgAejNh9i6vzHi7rm3dStc3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zntvFgp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ED0C32786;
	Thu, 13 Jun 2024 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280127;
	bh=43GLf7JN4BLVMFP07wx968SswOBqZHdnbhi5h6CF4DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zntvFgp/t+qDvH5Z2zctZkGt7AhAAd1wi5bJHP4sdwGtOBsexelOcKrWPu7Uxp/1t
	 wLHz1259Gq1S9ucY5AynO3ap85VIV22rSOCnHxRP7FQ4+ngA3EE8uJFMzwu2XRihGH
	 9IWvBXk38WDPaIHa4bl5+QqEDo8n8D5vFgC9r2gM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 150/202] nvmet: fix ns enable/disable possible hang
Date: Thu, 13 Jun 2024 13:34:08 +0200
Message-ID: <20240613113233.542030723@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index baf8a3e4ed12a..9add3516ae2e2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -507,10 +507,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
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




