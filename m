Return-Path: <stable+bounces-46690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C628D0AD7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892211C21649
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203C15FD04;
	Mon, 27 May 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vv2YMAUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D5D518;
	Mon, 27 May 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836603; cv=none; b=JrecWOju5Z57LZso0iseFZV5YtxCSojbVtgEWt0A7xG4JlADFkG0djVJNnc52x8SC0xqYZrde3mORLdPVlHxx/On43TTySzwT03NbKts1D/vcRWPWMrOK2OJ42nrjSw5xGsV7p6Mz+yKMrmdjmI5DCiz0sf1OvW+pUalCoMyIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836603; c=relaxed/simple;
	bh=ygCeWH/q7Qo8bnTpFYOVHVuAM/2ylQSh6ucjFmR+82c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4OAwnaR6UuKRvbgqjikmG2Wv/YIep6id9q40kY1gP1aBn2l7RLseGAMYJ4WGCD60jYUOpqhdSPkZOt4WsmJnqE7khSZTwK7DA7BD+QWMj98ysR39SOjRk5FBpi6yzl9hdQMb2LceVy+HmVQZsfvb2ci39cVl2O72GZC9kaCqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vv2YMAUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AEEC2BBFC;
	Mon, 27 May 2024 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836602;
	bh=ygCeWH/q7Qo8bnTpFYOVHVuAM/2ylQSh6ucjFmR+82c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vv2YMAUeoz/OOCRCsTFfJUsVNwNLeAJWiRwXULSZPB8PtJccvtSu3OagYfvY4KJBJ
	 FN9KBJUYFaAmjbKlY/qOOiJxbk65Y/4c1ADOMNDgkbUbw3V3ATwwOyLBqb0UZVrE/p
	 kFjpMbRm946pa+XlYkTggEo+yANd4MUbTqvK1QDg=
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
Subject: [PATCH 6.9 118/427] mlx5: stop warning for 64KB pages
Date: Mon, 27 May 2024 20:52:45 +0200
Message-ID: <20240527185612.836724250@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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
index 06592b9f04242..9240cfe25d102 100644
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




