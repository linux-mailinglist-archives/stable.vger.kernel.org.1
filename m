Return-Path: <stable+bounces-80349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1DD98DD0B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB161C202F7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2A1D0BAE;
	Wed,  2 Oct 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQKDMpxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4E1D14E4;
	Wed,  2 Oct 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880114; cv=none; b=ZlBXki9W8YrU2E+xFiS1liXxLFeMlSyytwKvWmOPL02xnpuM+NpPdFROemG2cpWZ1Ozhsi6XYTFQQpZVmLMN1/nRPp0FOXVSQWAyzBztmqEd5QKDNGI9sKyW6VidseVgIyKZafnY++OPXeLOocgxUIhf1E3XmcFLs2Zknz+d53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880114; c=relaxed/simple;
	bh=hRYHlqj42tasjA5p6b1vE5qb046nBnoOv6mgO29wg3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ2Rb+vytFT1L0g3xGpyzlwV+LBhlN0ytO3hG6korkqbg6rLvEdzVb5JgLzdEUhH2rtQZpTO7snLqoBjZanT0OZGnWiPRrVaHAKNm9TO1tBoeHLP6697p5iVtQcDuM6st4J5VtkQgrbX1VThGeWGqIw/dhhjJ76lQzg/DzOUnu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQKDMpxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFCFC4CEC2;
	Wed,  2 Oct 2024 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880114;
	bh=hRYHlqj42tasjA5p6b1vE5qb046nBnoOv6mgO29wg3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQKDMpxhzg0TH0gsejYEDLJxoXnf4fz3yZu/fioWg7vPyD/IdM/LwooQQYQjbe6Iz
	 tgdfgVOsZeP7DbDHhAMZrjJ/1XVc57R3Nl8MlbA2xJF9lXCxoxUTn2XiYA6kc9XmVy
	 nYawvc5MfnV8cOjqbpX57CYnwVX16+N8qMmXuExQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Scott Mayhew <smayhew@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 331/538] nfsd: return -EINVAL when namelen is 0
Date: Wed,  2 Oct 2024 14:59:30 +0200
Message-ID: <20241002125805.495194991@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 22451a16b7ab7debefce660672566be887db1637 ]

When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
result in namelen being 0, which will cause memdup_user() to return
ZERO_SIZE_PTR.
When we access the name.data that has been assigned the value of
ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
triggered.

[ T1205] ==================================================================
[ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
[ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
[ T1205]
[ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
[ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[ T1205] Call Trace:
[ T1205]  dump_stack+0x9a/0xd0
[ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
[ T1205]  __kasan_report.cold+0x34/0x84
[ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
[ T1205]  kasan_report+0x3a/0x50
[ T1205]  nfs4_client_to_reclaim+0xe9/0x260
[ T1205]  ? nfsd4_release_lockowner+0x410/0x410
[ T1205]  cld_pipe_downcall+0x5ca/0x760
[ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
[ T1205]  ? down_write_killable_nested+0x170/0x170
[ T1205]  ? avc_policy_seqno+0x28/0x40
[ T1205]  ? selinux_file_permission+0x1b4/0x1e0
[ T1205]  rpc_pipe_write+0x84/0xb0
[ T1205]  vfs_write+0x143/0x520
[ T1205]  ksys_write+0xc9/0x170
[ T1205]  ? __ia32_sys_read+0x50/0x50
[ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
[ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
[ T1205]  do_syscall_64+0x33/0x40
[ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[ T1205] RIP: 0033:0x7fdbdb761bc7
[ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
[ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
[ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
[ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
[ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
[ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
[ T1205] ==================================================================

Fix it by checking namelen.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 74725959c33c ("nfsd: un-deprecate nfsdcld")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Scott Mayhew <smayhew@redhat.com>
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4recover.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3509e73abe1f4..4395577825a7f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -806,6 +806,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			ci = &cmsg->cm_u.cm_clntinfo;
 			if (get_user(namelen, &ci->cc_name.cn_len))
 				return -EFAULT;
+			if (!namelen) {
+				dprintk("%s: namelen should not be zero", __func__);
+				return -EINVAL;
+			}
 			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
 			if (IS_ERR(name.data))
 				return PTR_ERR(name.data);
@@ -828,6 +832,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			cnm = &cmsg->cm_u.cm_name;
 			if (get_user(namelen, &cnm->cn_len))
 				return -EFAULT;
+			if (!namelen) {
+				dprintk("%s: namelen should not be zero", __func__);
+				return -EINVAL;
+			}
 			name.data = memdup_user(&cnm->cn_id, namelen);
 			if (IS_ERR(name.data))
 				return PTR_ERR(name.data);
-- 
2.43.0




