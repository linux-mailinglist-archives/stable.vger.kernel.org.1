Return-Path: <stable+bounces-6260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BC80D9A7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB101C21502
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEF51C47;
	Mon, 11 Dec 2023 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApirVK3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1F321B8;
	Mon, 11 Dec 2023 18:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8D7C433C7;
	Mon, 11 Dec 2023 18:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320945;
	bh=X9ZTEJZSoi4t1/spWUctol33ugcrIaRLDLf5FGxi4gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApirVK3yvvGZD7bxRmKALg8DZPmcmlRHE1Xmb8J9QJ7AmYX1xQlbDwILThItRQn5P
	 XvyS/xuESSiBUDbxWyW9b0vLY52z/dy5S3LR9eoyXZW+u4Gs16TlmP7VANKonDuTBB
	 DgnfSRvS03x77TCNhTrUgHihl+f3+rSHsGvRTICE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Wang <jinpu.wang@ionos.com>,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/141] RDMA/rtrs-clt: Start hb after path_up
Date: Mon, 11 Dec 2023 19:21:52 +0100
Message-ID: <20231211182028.836405976@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Wang <jinpu.wang@ionos.com>

[ Upstream commit 3e44a61b5db873612e20e7b7922468d7d1ac2d22 ]

If we start hb too early, it will confuse server side to close
the session.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Link: https://lore.kernel.org/r/20231120154146.920486-3-haris.iqbal@ionos.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index afe8670f9e555..fac5e122fd372 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2341,8 +2341,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	if (err)
 		goto destroy;
 
-	rtrs_start_hb(&clt_path->s);
-
 	return 0;
 
 destroy:
@@ -2616,6 +2614,7 @@ static int init_path(struct rtrs_clt_path *clt_path)
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
+	rtrs_start_hb(&clt_path->s);
 out:
 	mutex_unlock(&clt_path->init_mutex);
 
-- 
2.42.0




