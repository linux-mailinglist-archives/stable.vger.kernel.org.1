Return-Path: <stable+bounces-115715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B40A345A3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B383A13EB
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993D1FFC41;
	Thu, 13 Feb 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRuC94Za"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7915853B;
	Thu, 13 Feb 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458999; cv=none; b=rPlORjomKUTKMVFn2erYQ6lK6Ei3ovWB39H9YJ1UYightPUB5x38B1R3ooM6BttTd6zYMJDedaDQdCFY38SI5TtKmep7U8jCIfA21oncUH2z6XA62v/4q1Nij4FGNcnmSqYyLghELWk0G59EfTElYK5UkfqlTSp3L4Rs/SRhXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458999; c=relaxed/simple;
	bh=QMQPUTaOYHw5ruSkqrjpMpt18M2bFQNh1Bdzirgmwtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STtaftyPWpL0PkaPvHpHYVHqSrmS0JgkI3wY3rOJ6vwcDyBeOkdgTruJrzjrgZYA6gZCUF3bEFBIOTUELhgjvhaFDrRUZEV9+SveFPMaVdgPsQ9Z/W8ohHn8WggTeLrc87jinHW6HMyAkSOO2V2n1qebYOC+KMYg9OZWZImBEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRuC94Za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EDEC4CED1;
	Thu, 13 Feb 2025 15:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458998;
	bh=QMQPUTaOYHw5ruSkqrjpMpt18M2bFQNh1Bdzirgmwtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRuC94ZaPM+X7rmPr3GE3YMvEWkmMVbidXHNzVZUMZbXdpMdJWD7eby+ZbUh5y2zq
	 GRJyBlKWytZLyO0K9DUiuHbH9yOLCivTtDVjtuHLKkv/RQMYFQP+R9N2QXRbz9Yb9C
	 XYdDzzRO99KG4cTEqY2ObbtiCMn8b4CzonCZKMhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 106/443] nvme: handle connectivity loss in nvme_set_queue_count
Date: Thu, 13 Feb 2025 15:24:31 +0100
Message-ID: <20250213142444.699892437@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 294b2b7516fd06a8dd82e4a6118f318ec521e706 ]

When the set feature attempts fails with any NVME status code set in
nvme_set_queue_count, the function still report success. Though the
numbers of queues set to 0. This is done to support controllers in
degraded state (the admin queue is still up and running but no IO
queues).

Though there is an exception. When nvme_set_features reports an host
path error, nvme_set_queue_count should propagate this error as the
connectivity is lost, which means also the admin queue is not working
anymore.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 12e7ae1f99e20..46e04b30f6425 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1695,7 +1695,13 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*
-- 
2.39.5




