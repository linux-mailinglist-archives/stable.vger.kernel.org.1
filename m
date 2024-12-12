Return-Path: <stable+bounces-102117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAE9EF0C4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EE118988D8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD43222D4C;
	Thu, 12 Dec 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uo4S2yt9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A570221DB0;
	Thu, 12 Dec 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020036; cv=none; b=tpl9jGHdgph9kdX/hn+NK3bsAKPRtbR6dhOGLh0CZpIm+LJtTrscc09X7kUMXhk4jiP5pLVVugovhqhd5W2ggMcFvQ1zNi1+vVKvuGfJSYEAgdoiCNgudANVilwy9CEaLYDminyS4KzDDQeR+pOitXeafAhAYT06NMlUyuZvebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020036; c=relaxed/simple;
	bh=Mp/QABc3NY6SFnjlaaBCamG6zjfZGyHKwAJpneYUyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMB7IRUIS0Xnhax+mS+Lugamk4Cc26a6AUiu2HXFv25Dq4WfaDwZnNr/tMKXXnVoZ/w87wc+Di36/yy+fGbyGcByXLDmqFOHoh2Sl9YvFFpuc5VLPyCtuwvazw380HRZ4MboX6m/wqWQ2jMkI7qYfi4N9QBc4uF6f5aUrypsVKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uo4S2yt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934EFC4CECE;
	Thu, 12 Dec 2024 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020036;
	bh=Mp/QABc3NY6SFnjlaaBCamG6zjfZGyHKwAJpneYUyew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo4S2yt9c4QV8owdzQh8eRtp5oXSZXBfvCeggUNbbtW1ZhiNSPjxPhV/RG/CNPxdq
	 ugV7m/In9bJbIsp3iYA9opgVEGjwnu4SkXPogjF99Qwr5jn53HRqnR7tI27pK5CFY1
	 iWcgqYJp5UTlDNUhOW9XHO2XapMI9sCjOA+vDZuY=
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
	Bin Lan <bin.lan.cn@windriver.com>
Subject: [PATCH 6.1 354/772] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
Date: Thu, 12 Dec 2024 15:54:59 +0100
Message-ID: <20241212144404.539179440@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

commit efeb7dfea8ee10cdec11b6b6ba4e405edbe75809 upstream.

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
[ For the function mlxsw_sp_acl_to_tcam() is not exist in 6.1.y, pick
mlxsw_sp_acl_to_tcam() from commit 74cbc3c03c828ccf265a72f9bcb5aee906978744 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h          |    1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c      |    5 +++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c |    4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -970,6 +970,7 @@ enum mlxsw_sp_acl_profile {
 };
 
 struct mlxsw_afk *mlxsw_sp_acl_afk(struct mlxsw_sp_acl *acl);
+struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl);
 
 int mlxsw_sp_acl_ruleset_bind(struct mlxsw_sp *mlxsw_sp,
 			      struct mlxsw_sp_flow_block *block,
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -40,6 +40,11 @@ struct mlxsw_afk *mlxsw_sp_acl_afk(struc
 	return acl->afk;
 }
 
+struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl)
+{
+	return &acl->tcam;
+}
+
 struct mlxsw_sp_acl_ruleset_ht_key {
 	struct mlxsw_sp_flow_block *block;
 	u32 chain_index;
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -747,13 +747,13 @@ static void
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
 



