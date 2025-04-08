Return-Path: <stable+bounces-130774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA32A8062C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B441B821E5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3945268685;
	Tue,  8 Apr 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBj2JZ8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70138269801;
	Tue,  8 Apr 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114615; cv=none; b=ST6z7dZdlensji50V7fB4utO9YA6E7c14apIH8oEWMzvDDwZi6bL2Lt5Q9RZNFMDVQqh9mGKqZ7eh/XJTik1iX+FDntyNTX5E8QQ1nlUC6GTpJIyM79wklcGcXcrajaqhXHd+QeallyZ417vwT6CvovD3U6fmjrbwEWfyVhsq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114615; c=relaxed/simple;
	bh=8pwQXGlvY3CcLkHBhOzhGZhD816CXq0wX2k/z1Emwuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjJQVsZMYVETKGgEso3I3ERBVG7zZEsbcCqw5136DSXOw5G187zVqHa8FBX6z8GXjXRrMjEShQBMZIalPlG0x8fJXz4s/6p+qIJ9c4E2GHzD2T7I2jW3tu8EjDx0d2G4DXaNc73cXvywd/YSC1CRiL9hrVCWr0k67xqBzDxGP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBj2JZ8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02232C4CEE5;
	Tue,  8 Apr 2025 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114615;
	bh=8pwQXGlvY3CcLkHBhOzhGZhD816CXq0wX2k/z1Emwuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBj2JZ8UWo38My1ZaZ3QarUywcuEMvrDbancegeHaj/zntRSjheKVxC+AAtWdZyiQ
	 evT9m/oqswFqicHElXWgK9DM/N53oMVLKOMkNYTEGUi7KpyHpJ+UxN8K3bjN0cZ+Zo
	 t4fSgzyewJ7wJod7QtccCTAE+Gt0VcdBEviJT8Hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 133/499] remoteproc: core: Clear table_sz when rproc_shutdown
Date: Tue,  8 Apr 2025 12:45:45 +0200
Message-ID: <20250408104854.510745237@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit efdde3d73ab25cef4ff2d06783b0aad8b093c0e4 ]

There is case as below could trigger kernel dump:
Use U-Boot to start remote processor(rproc) with resource table
published to a fixed address by rproc. After Kernel boots up,
stop the rproc, load a new firmware which doesn't have resource table
,and start rproc.

When starting rproc with a firmware not have resource table,
`memcpy(loaded_table, rproc->cached_table, rproc->table_sz)` will
trigger dump, because rproc->cache_table is set to NULL during the last
stop operation, but rproc->table_sz is still valid.

This issue is found on i.MX8MP and i.MX9.

Dump as below:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010af63000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 UID: 0 PID: 1060 Comm: sh Not tainted 6.14.0-rc7-next-20250317-dirty #38
Hardware name: NXP i.MX8MPlus EVK board (DT)
pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __pi_memcpy_generic+0x110/0x22c
lr : rproc_start+0x88/0x1e0
Call trace:
 __pi_memcpy_generic+0x110/0x22c (P)
 rproc_boot+0x198/0x57c
 state_store+0x40/0x104
 dev_attr_store+0x18/0x2c
 sysfs_kf_write+0x7c/0x94
 kernfs_fop_write_iter+0x120/0x1cc
 vfs_write+0x240/0x378
 ksys_write+0x70/0x108
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x10c
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x30/0xcc
 el0t_64_sync_handler+0x10c/0x138
 el0t_64_sync+0x198/0x19c

Clear rproc->table_sz to address the issue.

Fixes: 9dc9507f1880 ("remoteproc: Properly deal with the resource table when detaching")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20250319100106.3622619-1-peng.fan@oss.nxp.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c2cf0d2777296..b21eedefff877 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2025,6 +2025,7 @@ int rproc_shutdown(struct rproc *rproc)
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
 	rproc->table_ptr = NULL;
+	rproc->table_sz = 0;
 out:
 	mutex_unlock(&rproc->lock);
 	return ret;
-- 
2.39.5




