Return-Path: <stable+bounces-150419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A59ACB803
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB3A1C242A6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240B223DFA;
	Mon,  2 Jun 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zXA6jtVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F808223DF6;
	Mon,  2 Jun 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877064; cv=none; b=NNt5rx+4fx6FOC/6CvP3VkKmslIaimB6iWvvF967PMnepBMJifxR8/6dTlMRNkMoWpFrEA5+G8a9V5KYOJFId6PuOoyXE0Z+PwyI5L6d9RaM2UvrfA7FhDr3qPWlLSWFgPIAxT6ZHhUxwMgLwhmsaVu9Jz3XWkciddd+CgZJQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877064; c=relaxed/simple;
	bh=tJs7AfAwYkF2PTS9AM+4t24WaAxX/sAAPHsjtMPmJbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkRAvwcRuqwoFyCOBNNRq50JYEIv6ptt3bDDAGW9m7XI9W/9n/SoG+T59lJtBlDxW6eXHkKqRBg+KPx31UvxReO8d5hMleRoMimIOY0z8WxhTmWKckEQ5l809hJd+Pk4kshQe2dQfL8E3OqGHOxsWoPQixwzLT7QlHGbReB2+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zXA6jtVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242B3C4CEEB;
	Mon,  2 Jun 2025 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877064;
	bh=tJs7AfAwYkF2PTS9AM+4t24WaAxX/sAAPHsjtMPmJbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zXA6jtVUifZv6k7SsefzIcwn8CY43KbZ4wKuNdjPhp3/Bp9jgtaTnJuHXraZDEKEl
	 NCO2rGPTREALTnt8OUBRjzD1c7ucIh66SiYM68xHE26mzkU+rTDTkhUDALH/ke/Zxq
	 ALOjFTZbebTq/jO6ySuBwxrjhQx11rtVvF2WzOMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 160/325] eth: mlx4: dont try to complete XDP frames in netpoll
Date: Mon,  2 Jun 2025 15:47:16 +0200
Message-ID: <20250602134326.305412615@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8fdeafd66edaf420ea0063a1f13442fe3470fe70 ]

mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
using page pool until now, so it could run XDP completions
in netpoll (NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call it from
what is potentially HW IRQ context.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250213010635.1354034-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 7fccf1a79f09b..95eae224bbb4a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -446,6 +446,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5




