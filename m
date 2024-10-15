Return-Path: <stable+bounces-85675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EEB99E861
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF99282B5A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69881D8DEA;
	Tue, 15 Oct 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oc4uijnr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7E1C57B1;
	Tue, 15 Oct 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993916; cv=none; b=BcRT6850b/DXes10toZsSci7RBcRVbC37eDf2AsPRo5egWVzdBCOceBfCNykiaW1WIS8vqdIjlNkebKDjQwLHzJQvic88UFfrg04CPYVCk1jBwQ50bNZTs47JoPfEt9zAhDE5xADaGnPHDiC/Yy25GtErXtfzOL+OeTxRB8NcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993916; c=relaxed/simple;
	bh=e06+3XN32kYpxDoIUKQAW6ri62ViSsDYOWoBT51CpBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipRZoNi1ABspLusSRHMDqvilugydMuNTLFa2EUH+bMqU+JXiZCkG4JDhAslVKq7Y+Fz7QIAyDLFLDobKEffTFzJ/uHkMv+rY92NuOzkUfNwkyUyZi84x0y7vK4oMaTUPW+PzZmYUQ01qerU0Jl9NXc1BkOxKxd5UO76v24yTIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oc4uijnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CAEC4CECE;
	Tue, 15 Oct 2024 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993916;
	bh=e06+3XN32kYpxDoIUKQAW6ri62ViSsDYOWoBT51CpBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oc4uijnrALpqwTrpuwd2gHe04isfDoeqgUhr3XErtMhft8pMbav+jabxqml/KOX6n
	 9zXNnrZ86gU6r8wY2vk1OjJjX4nWm9V9X5bjvfurDy4kzcYzULRLWKmq8Ymr2PXBZo
	 Psxj2M70yDfbpR8Gbr6WGV8wEfqsnycD4ZGT/LJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 521/691] nfsd: map the EBADMSG to nfserr_io to avoid warning
Date: Tue, 15 Oct 2024 13:27:49 +0200
Message-ID: <20241015112501.022603787@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Li Lingfeng <lilingfeng3@huawei.com>

commit 340e61e44c1d2a15c42ec72ade9195ad525fd048 upstream.

Ext4 will throw -EBADMSG through ext4_readdir when a checksum error
occurs, resulting in the following WARNING.

Fix it by mapping EBADMSG to nfserr_io.

nfsd_buffered_readdir
 iterate_dir // -EBADMSG -74
  ext4_readdir // .iterate_shared
   ext4_dx_readdir
    ext4_htree_fill_tree
     htree_dirblock_to_tree
      ext4_read_dirblock
       __ext4_read_dirblock
        ext4_dirblock_csum_verify
         warn_no_space_for_csum
          __warn_no_space_for_csum
        return ERR_PTR(-EFSBADCRC) // -EBADMSG -74
 nfserrno // WARNING

[  161.115610] ------------[ cut here ]------------
[  161.116465] nfsd: non-standard errno: -74
[  161.117315] WARNING: CPU: 1 PID: 780 at fs/nfsd/nfsproc.c:878 nfserrno+0x9d/0xd0
[  161.118596] Modules linked in:
[  161.119243] CPU: 1 PID: 780 Comm: nfsd Not tainted 5.10.0-00014-g79679361fd5d #138
[  161.120684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qe
mu.org 04/01/2014
[  161.123601] RIP: 0010:nfserrno+0x9d/0xd0
[  161.124676] Code: 0f 87 da 30 dd 00 83 e3 01 b8 00 00 00 05 75 d7 44 89 ee 48 c7 c7 c0 57 24 98 89 44 24 04 c6
 05 ce 2b 61 03 01 e8 99 20 d8 00 <0f> 0b 8b 44 24 04 eb b5 4c 89 e6 48 c7 c7 a0 6d a4 99 e8 cc 15 33
[  161.127797] RSP: 0018:ffffc90000e2f9c0 EFLAGS: 00010286
[  161.128794] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  161.130089] RDX: 1ffff1103ee16f6d RSI: 0000000000000008 RDI: fffff520001c5f2a
[  161.131379] RBP: 0000000000000022 R08: 0000000000000001 R09: ffff8881f70c1827
[  161.132664] R10: ffffed103ee18304 R11: 0000000000000001 R12: 0000000000000021
[  161.133949] R13: 00000000ffffffb6 R14: ffff8881317c0000 R15: ffffc90000e2fbd8
[  161.135244] FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
[  161.136695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.137761] CR2: 00007fcaad70b348 CR3: 0000000144256006 CR4: 0000000000770ee0
[  161.139041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.140291] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  161.141519] PKRU: 55555554
[  161.142076] Call Trace:
[  161.142575]  ? __warn+0x9b/0x140
[  161.143229]  ? nfserrno+0x9d/0xd0
[  161.143872]  ? report_bug+0x125/0x150
[  161.144595]  ? handle_bug+0x41/0x90
[  161.145284]  ? exc_invalid_op+0x14/0x70
[  161.146009]  ? asm_exc_invalid_op+0x12/0x20
[  161.146816]  ? nfserrno+0x9d/0xd0
[  161.147487]  nfsd_buffered_readdir+0x28b/0x2b0
[  161.148333]  ? nfsd4_encode_dirent_fattr+0x380/0x380
[  161.149258]  ? nfsd_buffered_filldir+0xf0/0xf0
[  161.150093]  ? wait_for_concurrent_writes+0x170/0x170
[  161.151004]  ? generic_file_llseek_size+0x48/0x160
[  161.151895]  nfsd_readdir+0x132/0x190
[  161.152606]  ? nfsd4_encode_dirent_fattr+0x380/0x380
[  161.153516]  ? nfsd_unlink+0x380/0x380
[  161.154256]  ? override_creds+0x45/0x60
[  161.155006]  nfsd4_encode_readdir+0x21a/0x3d0
[  161.155850]  ? nfsd4_encode_readlink+0x210/0x210
[  161.156731]  ? write_bytes_to_xdr_buf+0x97/0xe0
[  161.157598]  ? __write_bytes_to_xdr_buf+0xd0/0xd0
[  161.158494]  ? lock_downgrade+0x90/0x90
[  161.159232]  ? nfs4svc_decode_voidarg+0x10/0x10
[  161.160092]  nfsd4_encode_operation+0x15a/0x440
[  161.160959]  nfsd4_proc_compound+0x718/0xe90
[  161.161818]  nfsd_dispatch+0x18e/0x2c0
[  161.162586]  svc_process_common+0x786/0xc50
[  161.163403]  ? nfsd_svc+0x380/0x380
[  161.164137]  ? svc_printk+0x160/0x160
[  161.164846]  ? svc_xprt_do_enqueue.part.0+0x365/0x380
[  161.165808]  ? nfsd_svc+0x380/0x380
[  161.166523]  ? rcu_is_watching+0x23/0x40
[  161.167309]  svc_process+0x1a5/0x200
[  161.168019]  nfsd+0x1f5/0x380
[  161.168663]  ? nfsd_shutdown_threads+0x260/0x260
[  161.169554]  kthread+0x1c4/0x210
[  161.170224]  ? kthread_insert_work_sanity_check+0x80/0x80
[  161.171246]  ret_from_fork+0x1f/0x30

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -100,6 +100,7 @@ nfserrno (int errno)
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
+		{ nfserr_io, -EBADMSG },
 	};
 	int	i;
 



