Return-Path: <stable+bounces-48960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49DF8FEB47
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ADD1F27F63
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157551A38F6;
	Thu,  6 Jun 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXlqw2NZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9E1993A8;
	Thu,  6 Jun 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683231; cv=none; b=qXoxQGaAmoTfDyc3aaPFduTSAXIMhLJ/HLUgTcjX8MdgX4AgirYlfSx4A4NqKAMOJtVsqdB6BInDtU0N61HKsCvQnby9+S13l/clQtGETf405HWdXY4gelIV7SElEiKr/hLZcu8mPFhIoaJSAIhVONw5l4RB8yfF3A0f/eKF5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683231; c=relaxed/simple;
	bh=AhuTzB4mUg1Vx5/r27cyOwdVdsSayRhj4denapFZNlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5mzGlq+bhFGRIf1f5l6MNuCn3//kPj/wmhsebBB+PoHcgCusxCa77l88ZfpwLf7BfstI+ZksVn+wTmpjjHvAVzXtzdd1qaF6nh7M+TZuulJ6yXkQYbS6hHnnV9jqbkWJKvs5/NXY7ELmK2frwf6bZoQsBSXGJuscXa9cO+3hc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXlqw2NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62FEC32781;
	Thu,  6 Jun 2024 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683231;
	bh=AhuTzB4mUg1Vx5/r27cyOwdVdsSayRhj4denapFZNlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXlqw2NZ1sYr612JiT2Njh1ciS6EDXSmxWJ9oQMXX+oBo27MPUZ+AyPWlwI0y+ksZ
	 fAnNLnD4AjWqH47Q1zrAZfTuLAiueq4rLiwUj2aGrH8kXhCp0ea6Gp3rjF7AzNno0x
	 Tsz0RzrehqNQgzCP9CuZpkaOYjjwIfvedSNDT0/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 143/744] mlx5: stop warning for 64KB pages
Date: Thu,  6 Jun 2024 15:56:55 +0200
Message-ID: <20240606131737.007835657@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a5535e5336943b33689f558199366102387b7bbf ]

When building with 64KB pages, clang points out that xsk->chunk_size
can never be PAGE_SIZE:

drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:19:22: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (xsk->chunk_size > PAGE_SIZE ||
            ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~

In older versions of this code, using PAGE_SIZE was the only
possibility, so this would have never worked on 64KB page kernels,
but the patch apparently did not address this case completely.

As Maxim Mikityanskiy suggested, 64KB chunks are really not all that
useful, so just shut up the warning by adding a cast.

Fixes: 282c0c798f8e ("net/mlx5e: Allow XSK frames smaller than a page")
Link: https://lore.kernel.org/netdev/20211013150232.2942146-1-arnd@kernel.org/
Link: https://lore.kernel.org/lkml/a7b27541-0ebb-4f2d-bd06-270a4d404613@app.fastmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240328143051.1069575-9-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 36826b5824847..78739fe138ca4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -28,8 +28,10 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5e_xsk_param *xsk,
 			      struct mlx5_core_dev *mdev)
 {
-	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+	/* AF_XDP doesn't support frames larger than PAGE_SIZE,
+	 * and xsk->chunk_size is limited to 65535 bytes.
+	 */
+	if ((size_t)xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
 		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
 			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
-- 
2.43.0




