Return-Path: <stable+bounces-44266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE428C5204
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF62B21F81
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B34F88C;
	Tue, 14 May 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9Cb9YGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653154BFE;
	Tue, 14 May 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685349; cv=none; b=Z1XS9QmQ6ebE+S7fdZAzJdz4d24pIRtEops6ymQC95XuEKHzeSkZzR+EYaXmtrKUeMk6rVigGuuwsAJI+gGmXgK5f0N67xdl6b604BPzz50kg/Mo2nNpH+ZKK4xGlvqzSeNHSmiYBF5ZhtCnUb4M+TSk6hUW9n5tY1l91rLHtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685349; c=relaxed/simple;
	bh=U0Bufdi5L9PjWPL+jpl9a3E7XJYdpjPA/FlrEwpTifo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up5+g3EO9mpEAPjlhVil3CD8n/mKDZHwS2LJE0xtoGn3LxV2nPGOUn0fxT7i5KyxspwMpAjFNmS6UMP6Q4iydGZbRiGNLSWlWEN6a60Iyz8xeuVI4Q74a5KWELkj/zgiq+frjIXitkAbaj+Ct1SPy2QEzqzBDt8P7puHV1evpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9Cb9YGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B7DC2BD10;
	Tue, 14 May 2024 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685349;
	bh=U0Bufdi5L9PjWPL+jpl9a3E7XJYdpjPA/FlrEwpTifo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9Cb9YGxaPfVm+XgWYh8d6TBHpGKVgY5IdzZdIO07Vt2tysA9PrrAgTdEwASQ8zd0
	 VgaBX78dx2Vxm/KK/ylPDnVSdJsQT7O8pk0u5kJj3pQLIisbFzQF2EJBFXzdwbWUkN
	 afC63qeSftv5iEQ/kzqAkVS0fVE71kWpFTkhSbTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <kolga@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 173/301] SUNRPC: add a missing rpc_stat for TCP TLS
Date: Tue, 14 May 2024 12:17:24 +0200
Message-ID: <20240514101038.789209158@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit 8e088a20dbe33919695a8082c0b32deb62d23b4a ]

Commit 1548036ef120 ("nfs: make the rpc_stat per net namespace") added
functionality to specify rpc_stats function but missed adding it to the
TCP TLS functionality. As the result, mounting with xprtsec=tls lead to
the following kernel oops.

[  128.984192] Unable to handle kernel NULL pointer dereference at
virtual address 000000000000001c
[  128.985058] Mem abort info:
[  128.985372]   ESR = 0x0000000096000004
[  128.985709]   EC = 0x25: DABT (current EL), IL = 32 bits
[  128.986176]   SET = 0, FnV = 0
[  128.986521]   EA = 0, S1PTW = 0
[  128.986804]   FSC = 0x04: level 0 translation fault
[  128.987229] Data abort info:
[  128.987597]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  128.988169]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  128.988811]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  128.989302] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106c84000
[  128.990048] [000000000000001c] pgd=0000000000000000, p4d=0000000000000000
[  128.990736] Internal error: Oops: 0000000096000004 [#1] SMP
[  128.991168] Modules linked in: nfs_layout_nfsv41_files
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs
uinput dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill
ip_set nf_tables nfnetlink qrtr vsock_loopback
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
sunrpc vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops uvc
videobuf2_v4l2 videodev videobuf2_common mc vmw_vmci xfs libcrc32c
e1000e crct10dif_ce ghash_ce sha2_ce vmwgfx nvme sha256_arm64
nvme_core sr_mod cdrom sha1_ce drm_ttm_helper ttm drm_kms_helper drm
sg fuse
[  128.996466] CPU: 0 PID: 179 Comm: kworker/u4:26 Kdump: loaded Not
tainted 6.8.0-rc6+ #12
[  128.997226] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.21805430.BA64.2305221830 05/22/2023
[  128.998084] Workqueue: xprtiod xs_tcp_tls_setup_socket [sunrpc]
[  128.998701] pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  128.999384] pc : call_start+0x74/0x138 [sunrpc]
[  128.999809] lr : __rpc_execute+0xb8/0x3e0 [sunrpc]
[  129.000244] sp : ffff8000832b3a00
[  129.000508] x29: ffff8000832b3a00 x28: ffff800081ac79c0 x27: ffff800081ac7000
[  129.001111] x26: 0000000004248060 x25: 0000000000000000 x24: ffff800081596008
[  129.001757] x23: ffff80007b087240 x22: ffff00009a509d30 x21: 0000000000000000
[  129.002345] x20: ffff000090075600 x19: ffff00009a509d00 x18: ffffffffffffffff
[  129.002912] x17: 733d4d4554535953 x16: 42555300312d746e x15: ffff8000832b3a88
[  129.003464] x14: ffffffffffffffff x13: ffff8000832b3a7d x12: 0000000000000008
[  129.004021] x11: 0101010101010101 x10: ffff8000150cb560 x9 : ffff80007b087c00
[  129.004577] x8 : ffff00009a509de0 x7 : 0000000000000000 x6 : 00000000be8c4ee3
[  129.005026] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000094d56680
[  129.005425] x2 : ffff80007b0637f8 x1 : ffff000090075600 x0 : ffff00009a509d00
[  129.005824] Call trace:
[  129.005967]  call_start+0x74/0x138 [sunrpc]
[  129.006233]  __rpc_execute+0xb8/0x3e0 [sunrpc]
[  129.006506]  rpc_execute+0x160/0x1d8 [sunrpc]
[  129.006778]  rpc_run_task+0x148/0x1f8 [sunrpc]
[  129.007204]  tls_probe+0x80/0xd0 [sunrpc]
[  129.007460]  rpc_ping+0x28/0x80 [sunrpc]
[  129.007715]  rpc_create_xprt+0x134/0x1a0 [sunrpc]
[  129.007999]  rpc_create+0x128/0x2a0 [sunrpc]
[  129.008264]  xs_tcp_tls_setup_socket+0xdc/0x508 [sunrpc]
[  129.008583]  process_one_work+0x174/0x3c8
[  129.008813]  worker_thread+0x2c8/0x3e0
[  129.009033]  kthread+0x100/0x110
[  129.009225]  ret_from_fork+0x10/0x20
[  129.009432] Code: f0ffffc2 911fe042 aa1403e1 aa1303e0 (b9401c83)

Fixes: 1548036ef120 ("nfs: make the rpc_stat per net namespace")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index a15bf2ede89bf..c3007f3e16f8c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2644,6 +2644,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 		.xprtsec	= {
 			.policy		= RPC_XPRTSEC_NONE,
 		},
+		.stats		= upper_clnt->cl_stats,
 	};
 	unsigned int pflags = current->flags;
 	struct rpc_clnt *lower_clnt;
-- 
2.43.0




