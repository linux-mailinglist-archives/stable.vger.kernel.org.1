Return-Path: <stable+bounces-197663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486FC94B34
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 04:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A124B345329
	for <lists+stable@lfdr.de>; Sun, 30 Nov 2025 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68776223702;
	Sun, 30 Nov 2025 03:39:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67001E1DF0
	for <stable@vger.kernel.org>; Sun, 30 Nov 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764473987; cv=none; b=Qa2TnTWkWktGSxulHjcEeJEhhzwG+m3s1ClP4xuZk7dxsEaIKXipfnyLhqcWHAHV+HF9hTykF16hiY55QBSfjXiROGAzzrP0DNh8/u1o/kFbKmFXR/3uYBp70ErkjghIIvLvSqQqcSd+NImITGc1L671Odh5XnpDC4WhTAEUmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764473987; c=relaxed/simple;
	bh=FHmfxBJ3157gvfojzWka9epkDh8kiSyjDN14jlsHFvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kt3VYj0JoM2absrm+GDq5FT6GlCIv9Gou8LmJ3Zs8FH2SFKd+FUG2VCg+raDxAxxyAnVFhYUxMQ31bG+pu9mMZEOKOE8wa+mzHh8CI4pobM0LDocXReSRr47YRf8Npi9xccgSwgCsTzfpuE3+mFgK0/+iJGS3fDpC0vCB/IzcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id D3E708B2A35; Sun, 30 Nov 2025 11:23:14 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org,
	mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH 6.1.y v1 0/2] mptcp: Fix conflicts between MPTCP and sockmap
Date: Sun, 30 Nov 2025 11:23:01 +0800
Message-ID: <20251130032303.324510-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overall, we encountered a warning [1] that can be triggered by running the
selftest I provided.

sockmap works by replacing sk_data_ready, recvmsg, sendmsg operations and
implementing fast socket-level forwarding logic:
1. Users can obtain file descriptors through userspace socket()/accept()
   interfaces, then call BPF syscall to perform these replacements.
2. Users can also use the bpf_sock_hash_update helper (in sockops programs)
   to replace handlers when TCP connections enter ESTABLISHED state
  (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB/BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)

However, when combined with MPTCP, an issue arises: MPTCP creates subflow
sk's and performs TCP handshakes, so the BPF program obtains subflow sk's
and may incorrectly replace their sk_prot. We need to reject such
operations. In patch 1, we set psock_update_sk_prot to NULL in the
subflow's custom sk_prot.

Additionally, if the server's listening socket has MPTCP enabled and the
client's TCP also uses MPTCP, we should allow the combination of subflow
and sockmap. This is because the latest Golang programs have enabled MPTCP
for listening sockets by default [2]. For programs already using sockmap,
upgrading Golang should not cause sockmap functionality to fail.

Patch 2 prevents the panic from occurring.

Despite these patches fixing stream corruption, users of sockmap must set
GODEBUG=multipathtcp=0 to disable MPTCP until sockmap fully supports it.

[1] truncated warning:
------------[ cut here ]------------

BUG: kernel NULL pointer dereference, address: 00000000000004bb
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 400 Comm: test_progs Not tainted 6.1.0+ #16
RIP: 0010:mptcp_stream_accept (./include/linux/list.h:88 net/mptcp/protocol.c:3719)

RSP: 0018:ffffc90000ef3cf0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880089dcc58
RDX: 0000000000000003 RSI: 0000002c000000b0 RDI: 0000000000000000
RBP: ffffc90000ef3d38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880089dc600
R13: ffff88800b859e00 R14: ffff88800638c680 R15: 0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000004bb CR3: 000000000b8e8006 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
? apparmor_socket_accept (security/apparmor/lsm.c:966)
do_accept (net/socket.c:1856)
__sys_accept4 (net/socket.c:1897 net/socket.c:1927)
__x64_sys_accept (net/socket.c:1941)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)

[2]: https://go-review.googlesource.com/c/go/+/607715

Jiayuan Chen (2):
  mptcp: disallow MPTCP subflows from sockmap
  net,mptcp: fix proto fallback detection with BPF

 net/mptcp/protocol.c | 5 +++--
 net/mptcp/subflow.c  | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.43.0


