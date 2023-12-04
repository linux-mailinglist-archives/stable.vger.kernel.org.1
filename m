Return-Path: <stable+bounces-3927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B570C803F94
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006C7B20BD3
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204A374C9;
	Mon,  4 Dec 2023 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SikVv5/l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5135F17
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD05C433B6;
	Mon,  4 Dec 2023 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722048;
	bh=eTg1VInLU4qMeGqYVspdg5OJ9xCuQsygjmP3eMfpLw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SikVv5/lKGTVVs0ZQoPjUxLchz13rMa+0NbQE8AuYKGceATteFqAE1XW5JFTCOF61
	 BdGdK6Rk4PxkiOBczkwRmE5F7tDqZ187i5wD4vsvrmEhrU8zT8iOamEVdqyTWfftcT
	 ZEY8L8LCgigUqTOy4wA4bjdSxwjOU3v2uKcRbPYMCaVYNgxtZd9tZk/eIiOeQkfE3C
	 sPYiSHj/7+ad4DnEegVr01mG8s8kHgtowoBUDP+3v61bQ+lIM+iQcgSReOZy1OO+C+
	 qdh6TLO5ECW+iKOjja+y9BZiC6DbH8MDfdz5kHKakuIunN59CkQOsY7RkKkmI7ecpB
	 LT5SZxmD+3WRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 20/32] nvme-core: fix a memory leak in nvme_ns_info_from_identify()
Date: Mon,  4 Dec 2023 15:32:40 -0500
Message-ID: <20231204203317.2092321-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit e3139cef8257fcab1725441e2fd5fd0ccb5481b1 ]

In case of error, free the nvme_id_ns structure that was allocated
by nvme_identify_ns().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e1..b4521deb1c716 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1479,7 +1479,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1497,8 +1498,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
+
+error:
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
-- 
2.42.0


