Return-Path: <stable+bounces-2960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F817FC6D6
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E9B1C21785
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93039AD8;
	Tue, 28 Nov 2023 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLW2QL62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66844398
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328EC433C8;
	Tue, 28 Nov 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205602;
	bh=J2EZoT5nf42IyT+2nOUc2PQyHkSw27y/9C6HWxKjDDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLW2QL62+GM3PzvPxGZoNIVOCBC0lNRTZXSjl2Cch+21OQvi+JGdD+qdc3FjUlyqr
	 9qmWfapct6SO2YY1oY0e6WDUbKhMw1RdbTCYsRZhzqAA68GUxzfC+eSwim09l6RE0d
	 O0a+efKl/VuB0u/CjbiTevq9g73bUSVA1+awSJPooBN6/XkUQMtfCxaUVkxhP5kg5H
	 4vpGnfFqV3cRZfFdGBuKNVMEZTXwZHNGYSNdkd7NQD5SrsMczEdI9A/ZylPGnuRLtL
	 1i4hdPcT6/b6+rN+YtpiT/Yt6AosYp2OM/9L+melhdYSJkhzE3PIUbOfQ1JJimh9hZ
	 wkKB2LtvLMXKg==
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
Subject: [PATCH AUTOSEL 6.6 14/40] nvme-auth: unlock mutex in one place only
Date: Tue, 28 Nov 2023 16:05:20 -0500
Message-ID: <20231128210615.875085-14-sashal@kernel.org>
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

[ Upstream commit 616add70bfdc0274a253e84fc78155c27aacde91 ]

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 064592a5d546a..cc02a95a50c9a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -758,12 +758,11 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		__func__, chap->qid);
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ret) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		chap->error = ret;
 		goto fail2;
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
 
 	/* DH-HMAC-CHAP Step 3: send reply */
 	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
-- 
2.42.0


