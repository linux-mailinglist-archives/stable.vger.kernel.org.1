Return-Path: <stable+bounces-48195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A4F8FCD8C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637A71C23D2B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FB1CC719;
	Wed,  5 Jun 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUHN7vbw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EC1CC711;
	Wed,  5 Jun 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589111; cv=none; b=ZPuHRiWwj1KQkwPqqOwxT+pvpDupQg9kkSTw087GlQLshNVrY8hw2KlEKNIig7kiyqdiiX0yU28TTPR1dX4hmsx9iGWG6kdSIQcjI2+C4WUZWYdLrDcpD9WzosTHMcPpLW0tfh6zFbi/Yd8aSooF2swZ57URjYKQ08/iooqP3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589111; c=relaxed/simple;
	bh=1RbxT/6OSTDCO1lrHIY3cQWVCBAg91gJZtNuWLxq+Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmSYbienipbDes15XdYOaA7OretGO8ThbOEBg6SvVOhiJTToGgBc1fa35xqYGgfk/TUyRUar2N3WfZ8vreYgORCkfZaBCSJwx2jGMrncsAAeRzruIdLicM7pahwjuLSugBpCHgbxLkYXcplkLkRL7MwgOmHZIU+zt8+38PUWkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUHN7vbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BBC3277B;
	Wed,  5 Jun 2024 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589110;
	bh=1RbxT/6OSTDCO1lrHIY3cQWVCBAg91gJZtNuWLxq+Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUHN7vbwEFuKf6tNBBko4yWH1H0+PpdN1QsivhfTDoxVm6wbW1Xqg5o3vuyd6GPk4
	 zII0JXKvyswJXsrwrGBwwlyxobJ3cMkWzECIkLtfbwF+kggE2k6apUIC9Vtpa742fE
	 D0rADZjYuAluI495+QrockfjIjeqgFqfbPaV1odWqax8a1orKHIfbx6tmcAa9PV+vd
	 +AlCdhISaqceQh9WDZkKsMLix1VkRrU5DnA/QVW1zbvlFjjW21+4VhdThkA9KRHiW1
	 0UfZyquT2XeAFY+utcMeMlqrxFA1indcSORhiYVZxTZ+5Z3A8LyGcyPJ8IjsxDriAb
	 jGCTAWjXi6Y2A==
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
Subject: [PATCH AUTOSEL 6.1 09/14] nvmet: fix a possible leak when destroy a ctrl during qp establishment
Date: Wed,  5 Jun 2024 08:04:42 -0400
Message-ID: <20240605120455.2967445-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 3235baf7cc6b1..c7c8dedf1f47b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -802,6 +802,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	percpu_ref_exit(&sq->ref);
 	nvmet_auth_sq_free(sq);
 
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


