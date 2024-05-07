Return-Path: <stable+bounces-43329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1E28BF1C6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8001F232EE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5904147C81;
	Tue,  7 May 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWgU2iMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BB147C77;
	Tue,  7 May 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123400; cv=none; b=FjGzTmE3n3NBrsRCmcO8Yoyjau8eaUBy5LNs8Wq8MnAXjjhDoDh9gNJCafuG4dGmTEallNOOrncKtZIBbVuJoieKfkC2F4ZsyAbZT4JUI2RHfh4jbB3PEcNZ19FPlR/88USbGaoXzb5WcaKZe+G3CwmCpE2bHHLIfR0M3GdwZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123400; c=relaxed/simple;
	bh=WuKHMzHmfeavA/ODjXfv1tfreNkvMC2a5zUZGsav9ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/SKRjY4BuW0m55tNKgtJKP2EdaBHiKIyyPxG+Kjp/tLMUMNfmbxxN6UOu7m1EjgPfh1Tckglk68cpfSUFvAFzIu3WBibfhCxBh6ZlIZ3ic6SuM5JWXrgI32obqjnxD0iuWCsLUDlq095fvA4lRteyhEMdg+x+e95ObClKe6jB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWgU2iMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229BC3277B;
	Tue,  7 May 2024 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123400;
	bh=WuKHMzHmfeavA/ODjXfv1tfreNkvMC2a5zUZGsav9ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWgU2iMIPGsvrY9fe7bEZ3XzZTSuiJCryyhMo3z4tTJVJlpZErsFlMDKaTISBz0tB
	 EURLWTJp/f59/GJx92QaqOYN6kAIypOiiom/yOjWMpLgc7Mmg+X0ODzL0Bj9hMkfgH
	 4hJhZM9kMZrwySf2GeiPWYlkH+fg5rJ2kZjnWga489ag3/m3U1UP0yEWBuu6n60Xx8
	 32zV5u/cexEsSweiVgCLgCE4plFQ6Lgvy3LixyTss9ZHzdVwxhpctWB0y3U2PEFNHA
	 hXvBpeXI4OwHMkkifNq2uR1aK2SIcmsuzIdSBteEAa4RcBDnncVnQHDTVVAO7Hfjuw
	 oEdWl46rfJ6DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Jirong Feng <jirong.feng@easystack.cn>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 50/52] nvmet: fix nvme status code when namespace is disabled
Date: Tue,  7 May 2024 19:07:16 -0400
Message-ID: <20240507230800.392128-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 505363957fad35f7aed9a2b0d8dad73451a80fb5 ]

If the user disabled a nvmet namespace, it is removed from the subsystem
namespaces list. When nvmet processes a command directed to an nsid that
was disabled, it cannot differentiate between a nsid that is disabled
vs. a non-existent namespace, and resorts to return NVME_SC_INVALID_NS
with the dnr bit set.

This translates to a non-retryable status for the host, which translates
to a user error. We should expect disabled namespaces to not cause an
I/O error in a multipath environment.

Address this by searching a configfs item for the namespace nvmet failed
to find, and if we found one, conclude that the namespace is disabled
(perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR in this case
and keep DNR bit cleared.

Reported-by: Jirong Feng <jirong.feng@easystack.cn>
Tested-by: Jirong Feng <jirong.feng@easystack.cn>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 13 +++++++++++++
 drivers/nvme/target/core.c     |  5 ++++-
 drivers/nvme/target/nvmet.h    |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 2482a0db25043..b7bfee4b77a84 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -728,6 +728,19 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct config_item *ns_item;
+	char name[4] = {};
+
+	if (sprintf(name, "%u", nsid) <= 0)
+		return false;
+	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	ns_item = config_group_find_item(&subsys->namespaces_group, name);
+	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	return ns_item != NULL;
+}
+
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8658e9c08534d..7a6b3d37cca70 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -425,10 +425,13 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
-	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		if (nvmet_subsys_nsid_exists(subsys, nsid))
+			return NVME_SC_INTERNAL_PATH_ERROR;
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a6..477416abf85ab 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,6 +542,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
-- 
2.43.0


