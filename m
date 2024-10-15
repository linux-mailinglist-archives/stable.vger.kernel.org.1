Return-Path: <stable+bounces-85199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE499E624
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37D71C23435
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5A1E7C14;
	Tue, 15 Oct 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUl3EOeq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147B1EF096;
	Tue, 15 Oct 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992300; cv=none; b=gjl8BDyGdyTKD8Vw2Evzu68wpHdmvIpITkbKEPSV08ZRIZbHJyen3KRafWSGCzRNmsZcDr8lTw0ehutHyUJCg6TGZgeu2bWC4XyCgMwe1jLLxDvv9CP4Z9Fb0ygpdztZsUz/iCEZcHDRLz/dgcrhLtg7rJ1+Dcc458bLHWzHp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992300; c=relaxed/simple;
	bh=k/ChTEgZBCEBF8ecftPrac+Lv9BII0sZ/gqS5zn4No0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxL34r+ZckCX1Qpm2xyq2ZFThqfRv1hd4iX32Ivis14H+nK61h+tIciQcyEQFLrI407ZWfQ9lXHTb3Np6MD/BjEjBp4fQLzfPpE1PunWrNLMPVcSWaefdXe/6DyCPnxhLUhwE43tzODVwSdd/m2Vh4kyMwD4uethRNauFcRKwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUl3EOeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF69C4CED1;
	Tue, 15 Oct 2024 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992300;
	bh=k/ChTEgZBCEBF8ecftPrac+Lv9BII0sZ/gqS5zn4No0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUl3EOeq+Tdx/HsMTppLAZZD5ywcJmYmD+GclDbVJW6YZUtDcCuonW5wzoC4PEUCL
	 rM0yNIXpnfMBkCqUzyBLnkKboF2Wu1INLJVYKr6Gg7ZLi6BAz/hpA2vSlPe1h/sO3t
	 WbLAQsaUcXNvd7rVsSPBRYOdezEHJP/n60sqowok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 045/691] net/mlx5: Explicitly set scheduling element and TSAR type
Date: Tue, 15 Oct 2024 13:19:53 +0200
Message-ID: <20241015112442.132446399@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit c88146abe4d0f8cf659b2b8883fdc33936d2e3b8 ]

Ensure the scheduling element type and TSAR type are explicitly
initialized in the QoS rate group creation.

This prevents potential issues due to default values.

Fixes: 1ae258f8b343 ("net/mlx5: E-switch, Introduce rate limiting groups API")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 65c8f1f08472..b7758a1c015e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -424,6 +424,7 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
+	__be32 *attr;
 	u32 divider;
 	int err;
 
@@ -434,6 +435,12 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	*attr = cpu_to_be32(TSAR_ELEMENT_TSAR_TYPE_DWRR << 16);
+
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 esw->qos.root_tsar_ix);
 	err = mlx5_create_scheduling_element_cmd(esw->dev,
-- 
2.43.0




