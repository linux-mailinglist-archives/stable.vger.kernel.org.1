Return-Path: <stable+bounces-2998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 033537FC721
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98112B25331
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0542A8B;
	Tue, 28 Nov 2023 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfrZB/3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322C44379
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40750C433B8;
	Tue, 28 Nov 2023 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205693;
	bh=H1n0/0ZWiphOnQ/0+HECM1KvuLVot5qfm9D9IAn5bnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfrZB/3btONDC+l0vt/mvr/uMQg/clPtqt8h8ANgheRVGyCq23Vd/fB3oE3yTgWUp
	 OVelBnbuA+57s8FZb09HDfGJMJlls6UpqlfMF9X+4VSulGH1ZLiPn6wRaC5sEQVNVl
	 An/86an28YNcxozcPDvt+PbOspBKJYQm6LvPABFax5JuKclkhyBEyQbzJfGyw+ci/o
	 5uOfNOc9w+tiQajs2ILKqRO6U4CWfLvtIYvddXj5LDwmFZPkRHbBum1+9bzTcEsw1M
	 AB4It99NawDu1OpZJJEjEsmwXFNs956aEdXRFLs8O5zeQqvikfz3agCYX/uCjeKz12
	 5EdXLDs8AYdOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/25] nvme-auth: set explanation code for failure2 msgs
Date: Tue, 28 Nov 2023 16:07:28 -0500
Message-ID: <20231128210750.875945-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
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
index 7c9dfb420c464..d67076e98b4bc 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -835,6 +835,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.42.0


