Return-Path: <stable+bounces-2997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C97FC71F
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8498CB25211
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374CA42A88;
	Tue, 28 Nov 2023 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+bavc+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836A44379
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE2C433B9;
	Tue, 28 Nov 2023 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205691;
	bh=ou5g1vYpCVBpRbsuoAPA3/wFNIfrgr0OMicmp/bNh8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+bavc+nSrWU+EdUaCtphpTgDYhVaFsC3RNm2dsUW4FcWgcGcZYhghz8DhjkkfNpK
	 gMtFPhZGCDO6kg1NGazqsh6LIuWJeBr+z42yT7r7OutNUCKF2aqXRIjfsMYsk0iaED
	 sQJAolt7KpM8xR016mXF6nz55ismspOQp00v4jmjE8D/NxaqHeMVUxxbLyEWVXPTAj
	 yWtueMO1/Ep5e5dD7CCI8wQ+4xBnzVud49qXWo0tQV/1UEv+l51pLiFogTNApgkNtm
	 CRNQjaJ5CizOOEn1giZ+5+9ig+22luoEeua+fJqPf5tnZPExD6c/mYCD+rU2FUcdM8
	 hmNH+3BHYdHFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark O'Donovan <shiftee@posteo.net>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/25] nvme-auth: unlock mutex in one place only
Date: Tue, 28 Nov 2023 16:07:27 -0500
Message-ID: <20231128210750.875945-11-sashal@kernel.org>
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

[ Upstream commit 616add70bfdc0274a253e84fc78155c27aacde91 ]

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9dfd3d0293054..7c9dfb420c464 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,6 +758,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
 		chap->error = ret;
 		goto fail2;
-- 
2.42.0


