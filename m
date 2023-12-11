Return-Path: <stable+bounces-5446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEE80CC5A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0234B20C98
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829FE482C1;
	Mon, 11 Dec 2023 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWc7TwGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583947A7F
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25541C43391;
	Mon, 11 Dec 2023 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303214;
	bh=dT3TjpU5nkeVbApxHkWNYjJktKleH4Jfc/XG8mWzMKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWc7TwGA1vCcS3JtS9qg5KNymYBVaVbV0SjLSDcPmo1PCAf/NOoMowc3PrK/C7f0M
	 DQDPG22tfRh4HaN/WX3p/vHFwwGTHJLAvNh1oM6A51IermLPXJ5899c6JzXxAu9GFX
	 ng1jbJkESdHhnzClfEN3z02QEdQQOyn338Vn0UwoNzuITSXW0lpzhcRZS4VyAFVKbV
	 Gki7Ktne0tEjL2r2VVxi2OGuAcpeFbstsGNb2a52C4mY3mkZp0P3mOiUp+6ZrDY++/
	 wRyn4eChBxNRkS1rXOzzxaQb+gb+B+EbyvBxxdR2Pv7Bt9u45+wvXzmyVC7Z1pPcKm
	 HMRmWjaMCIUPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 14/19] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:57:48 -0500
Message-ID: <20231211135908.385694-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135908.385694-1-sashal@kernel.org>
References: <20231211135908.385694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.142
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 590ffa3e1c497..e523427d8a581 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -360,6 +360,11 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


