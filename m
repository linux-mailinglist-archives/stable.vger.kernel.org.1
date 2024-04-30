Return-Path: <stable+bounces-42009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652088B70ED
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772B5B229F9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF312C7FB;
	Tue, 30 Apr 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R91v2LkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAB12C462;
	Tue, 30 Apr 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474263; cv=none; b=jLjCNUV8dD3beqSLmRRxAutsJOguSSaj2xwoKLtXOJ3JTltshplhD2ngb7+C8BV7f3BbC5Z4j/krEAVK7WmenPVlyuUs0sTb01ZSqVYXg2deF4h5fgxuq+5nKBppjiod4WZCTdLltIJ13gTS2tt06D16wdb5cJj8GXp1Usp6Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474263; c=relaxed/simple;
	bh=xoJ6t38JXO4Q1+Ds2mEqbMGjOWzWO12YfXdLKkgIwVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS/sUxQa8QEXILzsxL6646iFM8elsfbO9L796gczRr0wOF2qijPjhywgBqvLFm6EukLnZUFui1D1aO48DmlkBG8RR/57H/1mqSmutccUio/nOV0SDwbTvcps1dtonyK1+ckFpAbgIcb5iyYAmCyVJOFLWPTCXTGyNRa/UQavCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R91v2LkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62685C2BBFC;
	Tue, 30 Apr 2024 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474263;
	bh=xoJ6t38JXO4Q1+Ds2mEqbMGjOWzWO12YfXdLKkgIwVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R91v2LkJ+NVd50Wg6JXeGSmVmmmvNdtucz5GJdPzlzypaMZU3aZ6T+I2qNzuCRm9l
	 AataA1elKJR7QomXxtZj8lvxMb2SfzX+6kYtlIrq5BMIqx+8Iib7J9OwndhODHepo9
	 0gcXD/hMwB6aOsC/0KUZaZ8rPgH7V0B9co6EB4nM=
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
Subject: [PATCH 6.8 098/228] mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
Date: Tue, 30 Apr 2024 12:37:56 +0200
Message-ID: <20240430103106.627746596@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 54225988889931467a9b55fdbef534079b665519 ]

The rehash delayed work migrates filters from one region to another
according to the number of available credits.

The migrated from region is destroyed at the end of the work if the
number of credits is non-negative as the assumption is that this is
indicative of migration being complete. This assumption is incorrect as
a non-negative number of credits can also be the result of a failed
migration.

The destruction of a region that still has filters referencing it can
result in a use-after-free [1].

Fix by not destroying the region if migration failed.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_acl_ctcam_region_entry_remove+0x21d/0x230
Read of size 8 at addr ffff8881735319e8 by task kworker/0:31/3858

CPU: 0 PID: 3858 Comm: kworker/0:31 Tainted: G        W          6.9.0-rc2-custom-00782-gf2275c2157d8 #5
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x670
 kasan_report+0xd7/0x110
 mlxsw_sp_acl_ctcam_region_entry_remove+0x21d/0x230
 mlxsw_sp_acl_ctcam_entry_del+0x2e/0x70
 mlxsw_sp_acl_atcam_entry_del+0x81/0x210
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x3cd/0xb50
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x157/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 174:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc+0x19c/0x360
 mlxsw_sp_acl_tcam_region_create+0xdf/0x9c0
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x954/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Freed by task 7:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 poison_slab_object+0x102/0x170
 __kasan_slab_free+0x14/0x30
 kfree+0xc1/0x290
 mlxsw_sp_acl_tcam_region_destroy+0x272/0x310
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x731/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/3e412b5659ec2310c5c615760dfe5eac18dd7ebd.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 7e69225c057de..1ff0b2c7c11de 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1451,6 +1451,7 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 						ctx, credits);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		return;
 	}
 
 	if (*credits >= 0)
-- 
2.43.0




