Return-Path: <stable+bounces-149363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E6ACB262
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D85617626E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92674227E89;
	Mon,  2 Jun 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1bb8+rX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE191DED64;
	Mon,  2 Jun 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873743; cv=none; b=R/ZqlQD4b8oDV5GPETWOe5WN0TW1Nr/7JLyQwSxiUyBeIy7vi8WH9PN6pB0CIjjKMSDLMCijRc94KaHOVOeikUVfQHa5eeZRQeEmVwm/+p7X+1sZVNJbjMptlRwTOgwbA5bzkdysJm+EpVQ/BHk+HIF3GBI3Krg1HAOT17WyiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873743; c=relaxed/simple;
	bh=SBakNTplbwVsL9XzTrkAwDawCywIIE04l3iqrg5347I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJqly1q+jyg1+iZmTAEbJRWYgBHgCbPfj8vjCU27nh+es9oT1GmeOe96zephyy1h3UGq0qgBCja1NDYY4+is/yaveRcC7U1XugsRCp/ETQ19PPWWcvEdx643ANld9+7zLvpsgXmPm/iye2J7LpzDdqT2R3cfBk0QvKpsft6xNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1bb8+rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE648C4CEEB;
	Mon,  2 Jun 2025 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873743;
	bh=SBakNTplbwVsL9XzTrkAwDawCywIIE04l3iqrg5347I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1bb8+rXWykuqZmU2LID5BfZ1S445fKb/XuJuKV3L+5SV9jmchtwmEZsVMtXcOQMH
	 xpgH41tWdu6m8qs3TEgI9Uxer3kPH6bnHkpTjYTKktcHHl2OZD/a8idbpo02sokt7C
	 5yCEobgPD4csW1NzO4z2PoWduZhRkkWRNvTxniYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 235/444] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
Date: Mon,  2 Jun 2025 15:44:59 +0200
Message-ID: <20250602134350.449253676@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <kees@kernel.org>

[ Upstream commit 4a6f18f28627e121bd1f74b5fcc9f945d6dbeb1e ]

GCC can see that the value range for "order" is capped, but this leads
it to consider that it might be negative, leading to a false positive
warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):

../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
  691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
      |                                    ~~~~~~~~~~~^~~
  'mlx4_alloc_db_from_pgdir': events 1-2
  691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                     |                         |                                                   |                     |                         (2) out of array bounds here
      |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
                 from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
  664 |         unsigned long          *bits[2];
      |                                 ^~~~

Switch the argument to unsigned int, which removes the compiler needing
to consider negative values.

Signed-off-by: Kees Cook <kees@kernel.org>
Link: https://patch.msgid.link/20250210174504.work.075-kees@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
 include/linux/mlx4/device.h                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d67..f2bded847e61d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
 }
 
 static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
-				    struct mlx4_db *db, int order)
+				    struct mlx4_db *db, unsigned int order)
 {
-	int o;
+	unsigned int o;
 	int i;
 
 	for (o = order; o <= 1; ++o) {
@@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
 	return 0;
 }
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_db_pgdir *pgdir;
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c891..86f0f2a25a3d6 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 		       struct mlx4_buf *buf);
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
-- 
2.39.5




