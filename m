Return-Path: <stable+bounces-54302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62290ED90
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75091F2125A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F9144D3E;
	Wed, 19 Jun 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/CfYv/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C182495;
	Wed, 19 Jun 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803178; cv=none; b=IKYz9QH54IuVecN4f54SvapKhajULor4hQIYBIfInG8vkdcIU8iTLEI2AZscCLw34ClfP8YCy27YeApSQ8BFuI4qQN/UlqWYCCFEeNl3sHUopmg0kePWyKYUBMuoO4r7cUsoTnzvFVznDAP7qBHXnNHW1YoF/LTwuhuktQMYnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803178; c=relaxed/simple;
	bh=Uo2mvOkWto1mH2SDXeKhXRfkh2ysMJ6PY6GaR3ZbbKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUTzngKWyK+j6vrUX82EDqZm++XUmMuOtGuPc0rcVngQ+XDEaSxGGlJr8484p3M3GiRZpy6qHAajZbatv5lbCHvhfViRiEcb6fXJ1yFmCAUP2/34Bssz6oduNsNYQks1jsNjmQkBZWFmsrlDuPtDDGuXE3JO9TqBRkBcf+A5JdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/CfYv/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43918C2BBFC;
	Wed, 19 Jun 2024 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803178;
	bh=Uo2mvOkWto1mH2SDXeKhXRfkh2ysMJ6PY6GaR3ZbbKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/CfYv/mocV1pLnfP3rjcxhaTCIUjkKRBAKAz2mj7HClisajLIBPa2qU2N/s5boMA
	 sEXbN7AcrEz0Ksv9y9xdl/0+xRHCxEk+ep2fvSm1dkaWeqtfOSwfDpEVsE9LbJM5UE
	 hSOY5/N5iZ45EyMR1X14wXIhmM2yMh8RBzEtefqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jie Wang <wangjie125@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 148/281] net: hns3: add cond_resched() to hns3 ring buffer init process
Date: Wed, 19 Jun 2024 14:55:07 +0200
Message-ID: <20240619125615.536366080@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 968fde83841a8c23558dfbd0a0c69d636db52b55 ]

Currently hns3 ring buffer init process would hold cpu too long with big
Tx/Rx ring depth. This could cause soft lockup.

So this patch adds cond_resched() to the process. Then cpu can break to
run other tasks instead of busy looping.

Fixes: a723fb8efe29 ("net: hns3: refine for set ring parameters")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 19668a8d22f76..c9258b1b2b429 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3539,6 +3539,9 @@ static int hns3_alloc_ring_buffers(struct hns3_enet_ring *ring)
 		ret = hns3_alloc_and_attach_buffer(ring, i);
 		if (ret)
 			goto out_buffer_fail;
+
+		if (!(i % HNS3_RESCHED_BD_NUM))
+			cond_resched();
 	}
 
 	return 0;
@@ -5111,6 +5114,7 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 		}
 
 		u64_stats_init(&priv->ring[i].syncp);
+		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index acd756b0c7c9a..d36c4ed16d8dd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -214,6 +214,8 @@ enum hns3_nic_state {
 #define HNS3_CQ_MODE_EQE			1U
 #define HNS3_CQ_MODE_CQE			0U
 
+#define HNS3_RESCHED_BD_NUM			1024
+
 enum hns3_pkt_l2t_type {
 	HNS3_L2_TYPE_UNICAST,
 	HNS3_L2_TYPE_MULTICAST,
-- 
2.43.0




