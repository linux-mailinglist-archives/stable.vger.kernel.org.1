Return-Path: <stable+bounces-15469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA7838563
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80400B26CD8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02C19BDC;
	Tue, 23 Jan 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxMy3PW3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875261EF1F;
	Tue, 23 Jan 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975807; cv=none; b=pYQaFc+Wj+7p6RZt8J5QeSzsm8hIOeNmJnmJZBx3WzaLNdK3Y86++i0stQtLvlMi3AXtDhcuqGcwbzAyOG/VUUjyxqTMtFqiCyD7tAZxpE0WbO4Y9hwnoYxSaO+2HSNkhODAECAG6XR7Td6Z15tRq/Mwu/4nhOYxCojITxdXmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975807; c=relaxed/simple;
	bh=kmvzJLVuH2RmYY4BboENaP6WGUNLzDDf3yek9mcD+T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwiXBL9cOGLVrFi4h5tKt843TfiE37pQg1OLzx5CXZICjcw7D73CuGttwr3/ELh0i/gPaHB68P8PMmp76z0Sz88LRTE17pa2yL+F056ek2rVx2VN9nRBLBwy1nxo/StB3oFh4GL/NvMxrsHMZtWECj2Q8oqafy4BL0mgGFua6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxMy3PW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6C8C43390;
	Tue, 23 Jan 2024 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975807;
	bh=kmvzJLVuH2RmYY4BboENaP6WGUNLzDDf3yek9mcD+T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wxMy3PW3TbJlkvF8WRObXGFltBK7Z5O04FqWZMv0C+dbtlqFDYVklQfaNbXdqXjK1
	 xhEomJQ/cym3M3u5bw5fIwDI2CLKUYVAOeXFP70UqpYjzWwpjvdyYsGRL1x63uYwis
	 DqDQN7lDjMyM7k+jeCCAq6alH3JjfYiQqP4Ll9+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 576/583] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
Date: Mon, 22 Jan 2024 16:00:27 -0800
Message-ID: <20240122235829.831370006@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit efeb7dfea8ee10cdec11b6b6ba4e405edbe75809 ]

When calling mlxsw_sp_acl_tcam_region_destroy() from an error path after
failing to attach the region to an ACL group, we hit a NULL pointer
dereference upon 'region->group->tcam' [1].

Fix by retrieving the 'tcam' pointer using mlxsw_sp_acl_to_tcam().

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:mlxsw_sp_acl_tcam_region_destroy+0xa0/0xd0
[...]
Call Trace:
 mlxsw_sp_acl_tcam_vchunk_get+0x88b/0xa20
 mlxsw_sp_acl_tcam_ventry_add+0x25/0xe0
 mlxsw_sp_acl_rule_add+0x47/0x240
 mlxsw_sp_flower_replace+0x1a9/0x1d0
 tc_setup_cb_add+0xdc/0x1c0
 fl_hw_replace_filter+0x146/0x1f0
 fl_change+0xc17/0x1360
 tc_new_tfilter+0x472/0xb90
 rtnetlink_rcv_msg+0x313/0x3b0
 netlink_rcv_skb+0x58/0x100
 netlink_unicast+0x244/0x390
 netlink_sendmsg+0x1e4/0x440
 ____sys_sendmsg+0x164/0x260
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xc0
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 22a677661f56 ("mlxsw: spectrum: Introduce ACL core with simple TCAM implementation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/fb6a4542bbc9fcab5a523802d97059bffbca7126.1705502064.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index d50786b0a6ce..7d1e91196e94 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -681,13 +681,13 @@ static void
 mlxsw_sp_acl_tcam_region_destroy(struct mlxsw_sp *mlxsw_sp,
 				 struct mlxsw_sp_acl_tcam_region *region)
 {
+	struct mlxsw_sp_acl_tcam *tcam = mlxsw_sp_acl_to_tcam(mlxsw_sp->acl);
 	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
 
 	ops->region_fini(mlxsw_sp, region->priv);
 	mlxsw_sp_acl_tcam_region_disable(mlxsw_sp, region);
 	mlxsw_sp_acl_tcam_region_free(mlxsw_sp, region);
-	mlxsw_sp_acl_tcam_region_id_put(region->group->tcam,
-					region->id);
+	mlxsw_sp_acl_tcam_region_id_put(tcam, region->id);
 	kfree(region);
 }
 
-- 
2.43.0




