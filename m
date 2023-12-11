Return-Path: <stable+bounces-6085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397C80D8AC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D49281AF9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232751C2C;
	Mon, 11 Dec 2023 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RP/VRBni"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF275102A;
	Mon, 11 Dec 2023 18:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E28C433C7;
	Mon, 11 Dec 2023 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320470;
	bh=X1OS0npo3Ut+s4GEXcM4Mv23y6cqfpP1vTTKHfmb9Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RP/VRBniaKFO7BWMoPFIAHhavLWF8ulDhKt33jUw5blS/W6G89vPABp/63/RTTozj
	 0FKutXcK5w8Ss09AgPamKPTiLa0eWBfNEZJxzd30dAk3YRB22kaeHrXSiShn3x2KXZ
	 +yaZzI9Zmha+MiSgTpiJu7xFV/oZ1FbS+DOe7UGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/194] RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
Date: Mon, 11 Dec 2023 19:21:03 +0100
Message-ID: <20231211182039.752208179@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit 3a71cd6ca0ce33d1af019ecf1d7167406fa54400 ]

Since srv_mr->iu is allocated and used only when always_invalidate is
true, free it only when always_invalidate is true.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Link: https://lore.kernel.org/r/20231120154146.920486-5-haris.iqbal@ionos.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6710887b1a13f..091db0853a6fb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -549,7 +549,10 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &srv_path->mrs[i];
-		rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
+		if (always_invalidate)
+			rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(srv_path->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
-- 
2.42.0




