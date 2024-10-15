Return-Path: <stable+bounces-85544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA099E7C6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DC028165E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB421D95AB;
	Tue, 15 Oct 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxHG72FB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AF19B3FF;
	Tue, 15 Oct 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993470; cv=none; b=VSsu8GTzhNcWqa10ULjoMMCym7qtx7usKx8tXMyS/PqNY1NaPFqmfrpePK3JzoXw9WD1t1nZqYxQZxyUz5LfNVlEutd6ARSyGgdQNdGAv/Tt16l4aiK16kVbzloIhawn1yVWUaXoSUhhNMRE/3PfgJbSm5nxMsotn8gzvyAEjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993470; c=relaxed/simple;
	bh=pryBSm15TwtmzVOmA6RuTC0hWGoYKxmrIer7sFnFF04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWi7nlOlZ2IhBr2VoV6x6rlb97mejho+KrTphexu6NFQR7pD3OtRb6lvo+deo9fDuiiZ7A/dyqPbDhiOQm2Eqewkp7Fxqfw3C0MVdLuccecayke4BP9JIPhfX404JlMgE9emQb41Pq2z2SbjbN2eVJbqMyZRgfBUlmeLc2AQU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxHG72FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E136AC4CEC6;
	Tue, 15 Oct 2024 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993470;
	bh=pryBSm15TwtmzVOmA6RuTC0hWGoYKxmrIer7sFnFF04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxHG72FBUeiDHPWQH/snMfDKypjiAcI/SlTRb1RS5w0B66d/DjZfeSJpMG4UDPiSf
	 BDcoWUXLIu83lvFoBWgngerd3+GQt+GuBpRRg7wLVsGyqZ0pcxMkt18lPgG8E7tdWB
	 rxsSmSmtz9lZ1m4f1H8C2fVajZSWrSo/53VdhQOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elena Salomatkina <esalomatkina@ispras.ru>,
	Simon Horman <horms@kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 380/691] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
Date: Tue, 15 Oct 2024 13:25:28 +0200
Message-ID: <20241015112455.426878978@linuxfoundation.org>
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

From: Elena Salomatkina <esalomatkina@ispras.ru>

[ Upstream commit f25389e779500cf4a59ef9804534237841bce536 ]

In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
which is dereferenced on the next line in a reference
to the modify field.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index a1afb8585e37f..ae64d22d21613 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -23,6 +23,9 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
 	struct mlx5e_tir_builder *builder;
 
 	builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
+	if (!builder)
+		return NULL;
+
 	builder->modify = modify;
 
 	return builder;
-- 
2.43.0




