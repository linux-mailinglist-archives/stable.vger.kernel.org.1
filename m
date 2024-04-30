Return-Path: <stable+bounces-42229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1C8B7201
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CEE281BC9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7912C487;
	Tue, 30 Apr 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kUH4ywnr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4812B176;
	Tue, 30 Apr 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474984; cv=none; b=Tf9gMycWBCY0bKmj2gKm52KPgmu5H7duZiMy1Jevsh9huFIjxeRuLPxLMArqdES+66CS19guNYzcPK3nnE8JI5mN4dtwFpN9UBDHz62gUc+pGiMwO5FJS6JO3v3+xxRldGToBpMggUPU7kYzZaVgB/db3u8lFVZQ4T485KT0B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474984; c=relaxed/simple;
	bh=32DfC9nNlx0ILb4rimoifvAa/1s+7zz5J6PQSEyxy34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuwmL9HciN0uEA6AG42wZovcXiRJJeG9A3ic0ryJLMgdTECGWyeCl5qr4890rS8mvMAuEe9ITSTOBa6J5S2rVrJDB5JGi695/vETgBU9c7HQTbaYmXhBCChacwgMwWAZZ6WdOpAvgQvaEEiKQyPxkByxmYZ++ya+XRQulDObxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kUH4ywnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E68BC2BBFC;
	Tue, 30 Apr 2024 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474984;
	bh=32DfC9nNlx0ILb4rimoifvAa/1s+7zz5J6PQSEyxy34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUH4ywnrRdzqRzvJMGk0/iV3igumB2G2cBLK/lwNdT7bonWqGvzB+FT89LQtLR4AU
	 2+TL0Pb426jvM5vzB3MNhBWAToWF4MoqrQ/bPwh4722Xidq6VNC2bzfpEIdYtPMJSw
	 rRhQSuTw8HUHHe/7QR3wCkgtogebjvamJPBX+As0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/138] mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
Date: Tue, 30 Apr 2024 12:39:42 +0200
Message-ID: <20240430103052.270747209@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 8ca3f7a7b61393804c46f170743c3b839df13977 ]

The rehash delayed work migrates filters from one region to another.
This is done by iterating over all chunks (all the filters with the same
priority) in the region and in each chunk iterating over all the
filters.

If the migration fails, the code tries to migrate the filters back to
the old region. However, the rollback itself can also fail in which case
another migration will be erroneously performed. Besides the fact that
this ping pong is not a very good idea, it also creates a problem.

Each virtual chunk references two chunks: The currently used one
('vchunk->chunk') and a backup ('vchunk->chunk2'). During migration the
first holds the chunk we want to migrate filters to and the second holds
the chunk we are migrating filters from.

The code currently assumes - but does not verify - that the backup chunk
does not exist (NULL) if the currently used chunk does not reference the
target region. This assumption breaks when we are trying to rollback a
rollback, resulting in the backup chunk being overwritten and leaked
[1].

Fix by not rolling back a failed rollback and add a warning to avoid
future cases.

[1]
WARNING: CPU: 5 PID: 1063 at lib/parman.c:291 parman_destroy+0x17/0x20
Modules linked in:
CPU: 5 PID: 1063 Comm: kworker/5:11 Tainted: G        W          6.9.0-rc2-custom-00784-gc6a05c468a0b #14
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:parman_destroy+0x17/0x20
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_region_fini+0x19/0x60
 mlxsw_sp_acl_tcam_region_destroy+0x49/0xf0
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x1f1/0x470
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: 843500518509 ("mlxsw: spectrum_acl: Do rollback as another call to mlxsw_sp_acl_tcam_vchunk_migrate_all()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/d5edd4f4503934186ae5cfe268503b16345b4e0f.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index cdad4772b60a0..b63b4a3ee7c42 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1230,6 +1230,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_start(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_acl_tcam_chunk *new_chunk;
 
+	WARN_ON(vchunk->chunk2);
+
 	new_chunk = mlxsw_sp_acl_tcam_chunk_create(mlxsw_sp, vchunk, region);
 	if (IS_ERR(new_chunk))
 		return PTR_ERR(new_chunk);
@@ -1364,6 +1366,8 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 						   ctx, credits);
 	if (err) {
+		if (ctx->this_is_rollback)
+			return err;
 		/* In case migration was not successful, we need to swap
 		 * so the original region pointer is assigned again
 		 * to vregion->region.
-- 
2.43.0




