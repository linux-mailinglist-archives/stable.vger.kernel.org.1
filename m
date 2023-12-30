Return-Path: <stable+bounces-8771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDC8204CF
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953201C20F0E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3979CD;
	Sat, 30 Dec 2023 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ltKr06HI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90988487;
	Sat, 30 Dec 2023 12:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406F0C433C7;
	Sat, 30 Dec 2023 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937720;
	bh=6mwUCUEt0d80Gx8/tsXONcrhoo6qLkmYZrdqM3a+YTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltKr06HIlF5tZWfvchjMr9rsvn6EmnbeZnFeUULU5r0bPXDCy5CROiqnF39i8Fa5T
	 SnuNQRiVrZB3af53ypx8IUAd24b7wCcNn8KknqdGOmwiQH4apAqzK7sHQi2IFYzm2n
	 jDhq89qK4DKabAtVk1ecyjSpR9QS9OHXpwGr/Htk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/156] net/mlx5e: XDP, Drop fragmented packets larger than MTU size
Date: Sat, 30 Dec 2023 11:58:11 +0000
Message-ID: <20231230115813.584257400@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit bcaf109f794744c14da0e9123b31d1f4571b0a35 ]

XDP transmits fragmented packets that are larger than MTU size instead of
dropping those packets. The drop check that checks whether a packet is larger
than MTU is comparing MTU size against the linear part length only.

Adjust the drop check to compare MTU size against both linear and non-linear
part lengths to avoid transmitting fragmented packets larger than MTU size.

Fixes: 39a1665d16a2 ("net/mlx5e: Implement sending multi buffer XDP frames")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 8bed17d8fe564..b723ff5e5249c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -493,6 +493,7 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	dma_addr_t dma_addr = xdptxd->dma_addr;
 	u32 dma_len = xdptxd->len;
 	u16 ds_cnt, inline_hdr_sz;
+	unsigned int frags_size;
 	u8 num_wqebbs = 1;
 	int num_frags = 0;
 	bool inline_ok;
@@ -503,8 +504,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 
 	inline_ok = sq->min_inline_mode == MLX5_INLINE_MODE_NONE ||
 		dma_len >= MLX5E_XDP_MIN_INLINE;
+	frags_size = xdptxd->has_frags ? xdptxdf->sinfo->xdp_frags_size : 0;
 
-	if (unlikely(!inline_ok || sq->hw_mtu < dma_len)) {
+	if (unlikely(!inline_ok || sq->hw_mtu < dma_len + frags_size)) {
 		stats->err++;
 		return false;
 	}
-- 
2.43.0




