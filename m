Return-Path: <stable+bounces-42495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FC8B734C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC081C230DF
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAC12D76B;
	Tue, 30 Apr 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nAAX4DwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3017592;
	Tue, 30 Apr 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475848; cv=none; b=Lh6VL7DVALrotwPzuRFQ9MnzWmb/9bHbBi+KAFzixzhgOafREtR1NL9pKiC+GWODDtUGdeIGrOk4PU7xYwASKSKY8lFcrZ7ZvSuoYPPraaoyZWyg6bO61JHzT/diMTnHpvN9eWW3xihdCDS3RDSOKBMm3sBApWRBzEf6kwwrhcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475848; c=relaxed/simple;
	bh=+fiB6kwVRCS/cXHLcmJKX4kK0NO4hp8AXpw53e4R8L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4N79suAkcgPiKKYqtlBRqkF1O6lnVv8Hrg+L2RmJFgg0hLqTo1VeaEdG0gYuzUsz2U3aNwiZWyCmXOYfk3zTHdVTtCSEHbkEXkML8dBLzcGFkk8n3rJuZM81+8VS6m6+5vf3AAAYk6PuYnMUBxruKtYUtm7DeD71VflG5wpNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nAAX4DwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B874BC2BBFC;
	Tue, 30 Apr 2024 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475848;
	bh=+fiB6kwVRCS/cXHLcmJKX4kK0NO4hp8AXpw53e4R8L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAAX4DwQxk01oQ8ug0cdAcKEQB7IvFcs2adY/vZRYXx1TyzmvshjMThyjvAFJNuP7
	 gXLC/zwLwDDMZVXCH7ixXsSo2z7t05yQMqrh1CisDnuNpV2iOosfRkb2/3aY1hNNrl
	 A+JgTeSD6lGFXabqtGfkUez2+nPt2PL2ci3bb6q4=
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
Subject: [PATCH 5.15 37/80] mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work
Date: Tue, 30 Apr 2024 12:40:09 +0200
Message-ID: <20240430103044.513299810@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit fb4e2b70a7194b209fc7320bbf33b375f7114bd5 ]

The rehash delayed work is rescheduled with a delay if the number of
credits at end of the work is not negative as supposedly it means that
the migration ended. Otherwise, it is rescheduled immediately.

After "mlxsw: spectrum_acl_tcam: Fix possible use-after-free during
rehash" the above is no longer accurate as a non-negative number of
credits is no longer indicative of the migration being done. It can also
happen if the work encountered an error in which case the migration will
resume the next time the work is scheduled.

The significance of the above is that it is possible for the work to be
pending and associated with hints that were allocated when the migration
started. This leads to the hints being leaked [1] when the work is
canceled while pending as part of ACL region dismantle.

Fix by freeing the hints if hints are associated with a work that was
canceled while pending.

Blame the original commit since the reliance on not having a pending
work associated with hints is fragile.

[1]
unreferenced object 0xffff88810e7c3000 (size 256):
  comm "kworker/0:16", pid 176, jiffies 4295460353
  hex dump (first 32 bytes):
    00 30 95 11 81 88 ff ff 61 00 00 00 00 00 00 80  .0......a.......
    00 00 61 00 40 00 00 00 00 00 00 00 04 00 00 00  ..a.@...........
  backtrace (crc 2544ddb9):
    [<00000000cf8cfab3>] kmalloc_trace+0x23f/0x2a0
    [<000000004d9a1ad9>] objagg_hints_get+0x42/0x390
    [<000000000b143cf3>] mlxsw_sp_acl_erp_rehash_hints_get+0xca/0x400
    [<0000000059bdb60a>] mlxsw_sp_acl_tcam_vregion_rehash_work+0x868/0x1160
    [<00000000e81fd734>] process_one_work+0x59c/0xf20
    [<00000000ceee9e81>] worker_thread+0x799/0x12c0
    [<00000000bda6fe39>] kthread+0x246/0x300
    [<0000000070056d23>] ret_from_fork+0x34/0x70
    [<00000000dea2b93e>] ret_from_fork_asm+0x1a/0x30

Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/0cc12ebb07c4d4c41a1265ee2c28b392ff997a86.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index e0e7f630801a9..46b1120a8151e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -831,10 +831,14 @@ mlxsw_sp_acl_tcam_vregion_destroy(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam *tcam = vregion->tcam;
 
 	if (vgroup->vregion_rehash_enabled && ops->region_rehash_hints_get) {
+		struct mlxsw_sp_acl_tcam_rehash_ctx *ctx = &vregion->rehash.ctx;
+
 		mutex_lock(&tcam->lock);
 		list_del(&vregion->tlist);
 		mutex_unlock(&tcam->lock);
-		cancel_delayed_work_sync(&vregion->rehash.dw);
+		if (cancel_delayed_work_sync(&vregion->rehash.dw) &&
+		    ctx->hints_priv)
+			ops->region_rehash_hints_put(ctx->hints_priv);
 	}
 	mlxsw_sp_acl_tcam_vgroup_vregion_detach(mlxsw_sp, vregion);
 	if (vregion->region2)
-- 
2.43.0




