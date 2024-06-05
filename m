Return-Path: <stable+bounces-48219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5918FCDD7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B33D1F27602
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD31D1579;
	Wed,  5 Jun 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+oCLBIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C71D1570;
	Wed,  5 Jun 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589167; cv=none; b=H/a4b7XHQQm/nQUdlIUwI9GUNAf+qK2n5gWiwGUx9fMX7VR7gunExSvYTdokhojGEzf2UQxNJ+Cxevb17xDTE+WFcXEgSpnIeU1vs4yfWoRjTgBpSu1am0s+6iz7c+4YN8rAUro/0q1Z0sUUU2FR1u3XAjxcH7O7mGPCkopCQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589167; c=relaxed/simple;
	bh=0Q8eaGMyTpjn7ZtOcjGlTiOA+wWWTJCHK9F63KK14yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ba5rLARaNuBBo0uD88noSjwW6MH2wLA8jA1hT9Q2jMmd6169j0JVWgnD+mceKb18jq3hU6o0Kzz7932oM7I+hPCF1bnkF4xnJk/+hFkCBjhzauJDJ++qWV4xiVfqGbBoLQAA3LVzG4kRaUQc0vaHLTmOWOUiLJwrpS5/nLIwE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+oCLBIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F16C32781;
	Wed,  5 Jun 2024 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589167;
	bh=0Q8eaGMyTpjn7ZtOcjGlTiOA+wWWTJCHK9F63KK14yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+oCLBIxUQKg9xV6MmTht1tGp/E+zETplYS3BHj5314VDAo2F6/0krI1gOn2qFvg+
	 JS/narjJIzjKoaPUNSAB7SR7yvjEDfOwXXcxyEG1HuVqvksoT/IRyr2FQAP901nfXp
	 jQ0z6hzvQ9kOR3T0pSI9KKCRqfs0iTplBrGK7XJbBaBKyP4D9S4UWHSxJnf5thJDHu
	 imSU3alepTZ8G20oDNHc1IegD192eQ4HV4mVl0khoxT5c5oCqaaJh5G6FG4mQOq8xO
	 jqaLgHzt9zIqTAstDwkPK73LXrc7vjepjEWQcG8NJJU7qK95lAYCDSVQjttBnmSr/y
	 BK9TGnDqq4lew==
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
Subject: [PATCH AUTOSEL 5.10 7/8] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Wed,  5 Jun 2024 08:05:50 -0400
Message-ID: <20240605120554.2968012-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120554.2968012-1-sashal@kernel.org>
References: <20240605120554.2968012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 59109eb8e8e46..a04bb02c1251b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -795,6 +795,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
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


