Return-Path: <stable+bounces-2961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365D7FC6D7
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D52B286547
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D764439F;
	Tue, 28 Nov 2023 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNX0Kp4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2C44361
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8865C433C9;
	Tue, 28 Nov 2023 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205603;
	bh=IuRIfCe42GtH8vil+KPwg5Oag3H3ZiaNViBmiSmku88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNX0Kp4jYD65Hqx9/XscUqG3tqOaix0kOos6o3SgNG7Jui811z2LTmWXxOZy5lls6
	 zcjfGqGhqSz2/fQTH2MKFu8OAfZNB32u4QHgJEYfuK5oY/HvbGkHIIu9g/UtLqXqPB
	 PPxHNoaoAuy+gKZT7HjhFtSYOFQk5O7D7XT0q6Mtcgau/F0DlRT+TgLVMJXRJ8KGWV
	 ky6hMh74sCZkH4BFf2Ego+PVZLnS2FNdQyGUs4FzngKjTxHu5+ptG8pUWEULP+sDje
	 PkxCpEcvW2eJH3IXJkZS2djCZPQR+Uet9CQEAbyXoVZp8ACfOshz+Scgmd4/sPvAj4
	 dKkJurEAW3htQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/40] nvme-auth: set explanation code for failure2 msgs
Date: Tue, 28 Nov 2023 16:05:21 -0500
Message-ID: <20231128210615.875085-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Mark O'Donovan <shiftee@posteo.net>

[ Upstream commit 38ce1570e2c46e7e9af983aa337edd7e43723aa2 ]

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index cc02a95a50c9a..a31080b7fd7de 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.42.0


