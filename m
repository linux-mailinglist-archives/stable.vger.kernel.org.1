Return-Path: <stable+bounces-48209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3508FCDB8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22CE1F29EDF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A791CF119;
	Wed,  5 Jun 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntiqb7sd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BB1CF10F;
	Wed,  5 Jun 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589144; cv=none; b=uMzERByPL5Wh7TdXdLpXQ1BN/XW7AF1XG3QL7h4rF+B4ycSgn0siDA6rprbRc4gK1q7BSV3IHXpDI8j/Om7E/VvjJ5FAn2u/DBnpNf0ZqFMKJeRvvVSlXH6ulynBoqLk2Foo9ZQR3rDfZiPPNKzm6SY0A0u4Zp6jU2tPSxsz2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589144; c=relaxed/simple;
	bh=9+I3qk58P2Tix1QmChv9y7ZaEhThCOAIIu7ewW9ZtCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWk0Og2Ut2rJjAgA9DD2hG+TY2EWirU3amI/cgGlM/LqGwvIsYx+zNRbsrjjAwHnMzD+fzy2dwGm2cz2gZ7UuNiHvZfrp8RdLAQW+83BWpKIeL6ckfk/mbSx1oyAi/7/eoHda+Mk3BMiSDJgHL1b38mNI/8u0q/fQqgws7O2tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntiqb7sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F897C32781;
	Wed,  5 Jun 2024 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589144;
	bh=9+I3qk58P2Tix1QmChv9y7ZaEhThCOAIIu7ewW9ZtCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntiqb7sdOtqKeY4i0szQRof4wur3l4q1h2VymufQXGk0F1GjMXdYyzqp2vq3T5klV
	 wBrbdni+au7wBspwm8OZqGE9dZXYvzorqSN4dWerVDBZkABdx/3Bz+FXt/T2CBJdh0
	 o0NyOhCN+bRUV5Wvacct+/tNEm0z4RqY6ALVJdtlrVFn+m1GubHHz1sNvpFhUzGN6C
	 rqJzua/Th5F82as6Lemj01VQ476GFripe3v+2GzoFzkcUdIzfGDbOlD+yioAGfSJ9G
	 RIlfm9qwiS4ZFBfdn+W7bM3UPQj7HidGmwl6+cEWBSDWm+0xgHljeRca+NbkOUw50F
	 d2/wlxD6educg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Alex Turin <alex@vastdata.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 09/12] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Wed,  5 Jun 2024 08:05:19 -0400
Message-ID: <20240605120528.2967750-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4 ]

In nvmet_sq_destroy we capture sq->ctrl early and if it is non-NULL we
know that a ctrl was allocated (in the admin connect request handler)
and we need to release pending AERs, clear ctrl->sqs and sq->ctrl
(for nvme-loop primarily), and drop the final reference on the ctrl.

However, a small window is possible where nvmet_sq_destroy starts (as
a result of the client giving up and disconnecting) concurrently with
the nvme admin connect cmd (which may be in an early stage). But *before*
kill_and_confirm of sq->ref (i.e. the admin connect managed to get an sq
live reference). In this case, sq->ctrl was allocated however after it was
captured in a local variable in nvmet_sq_destroy.
This prevented the final reference drop on the ctrl.

Solve this by re-capturing the sq->ctrl after all inflight request has
completed, where for sure sq->ctrl reference is final, and move forward
based on that.

This issue was observed in an environment with many hosts connecting
multiple ctrls simoutanuosly, creating a delay in allocating a ctrl
leading up to this race window.

Reported-by: Alex Turin <alex@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2c44d5a95c8d6..ef2e500bccfdf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -801,6 +801,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
+	/*
+	 * we must reference the ctrl again after waiting for inflight IO
+	 * to complete. Because admin connect may have sneaked in after we
+	 * store sq->ctrl locally, but before we killed the percpu_ref. the
+	 * admin connect allocates and assigns sq->ctrl, which now needs a
+	 * final ref put, as this ctrl is going away.
+	 */
+	ctrl = sq->ctrl;
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
-- 
2.43.0


