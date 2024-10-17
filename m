Return-Path: <stable+bounces-86688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C679A2E50
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E7F1F23353
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32A1D0411;
	Thu, 17 Oct 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mRfP35qH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065A144D21
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196415; cv=none; b=k8aDr3OuFTD+LM5GjYL08weBbHil/iXhtkygKPcjTY57MxsLtR05hxyJRzU3UZyDJbqHZ0l8MTqLrsGgXESVg/H/fqf2gFBFCfMJtXHfVBa+ghB4TUltebwaK9pVriku3cciMww0SCEYWjtyUdz44vr0pXWs1W7J7k2CMLlxH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196415; c=relaxed/simple;
	bh=mBEYwA7Kux0pQmr5/7bhju2bPOVZGLhyNXG5tA5AJac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYIAO1gdkUYKYGR+P0pzI4zcWubB9XmcEa5tNUAqmCB+hfrpypXeZRgPCxlaw4a5Nv4I/h5jUlFCEsr9ImGgy9IRWu4KohT1fNdMFSRxWQ6GfuVaCsOcM5yAesCk39xsKCjRIUSOZccc38XLJ/1NlaLvAVKuJ3IHm7Onw4cv/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mRfP35qH; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lO4XsKGJDduFArK5Uu6GrMjMatvlns/boAj09ZvsK4Y=; b=mRfP35qHCD8uWCNDwuA71y38w1
	MprIgBWRNnmCxRQyqqCfkHiTiClFJ2HNtHOgplhyGntZqxKRJ6T92qqiSfkUPaEKobojrhkhxx0Sd
	fWhV5ENL2Gy67SOH8PgFjQ/PUAnGjhlQjJf0UTqTqVh6LxuyMED1KnssVezRATNHi5Qm5RS04TLQm
	uAbi5284UPuoURhbtm5iMoLIAoiupaC/YfbCCqp1Jo0t+j1hTYoTNcg5ywKRY4jt5N/OZ1uU9nP3l
	uQuZpoDbEYfW5LqZG7mjfKgRsTI4mK+9Qa8Qc/6V2dNuOU85kXMOo2d/rmPB69hkFkePXOuxgEDNh
	WE/ljdYw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Wye-00BmZ7-Sy; Thu, 17 Oct 2024 22:20:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 00/20] Fix NULL pointer dereference for corrupted UDF filesystems
Date: Thu, 17 Oct 2024 17:19:42 -0300
Message-Id: <20241017202002.406428-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UDF filesystems which have relocated blocks past the end of the device may
lead to a dcache without an inode that would lead to a NULL pointer
dereference, like this:

[   20.554242] attempt to access beyond end of device
[   20.554242] loop0: rw=2049, want=2054, limit=2048
[   20.557322] Buffer I/O error on dev loop0, logical block 1026, lost async page write
[   20.562948] ==================================================================
[   20.565002] BUG: KASAN: null-ptr-deref in path_openat+0x6ae/0x9f9
[   20.566460] Read of size 2 at addr 0000000000000000 by task repro/415
[   20.567768]
[   20.568112] CPU: 0 PID: 415 Comm: repro Not tainted 5.15.168-rc1-00692-g63cec7aeaef7 #5
[   20.569739] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   20.571549] Call Trace:
[   20.571965]  <TASK>
[   20.572338]  dump_stack_lvl+0x45/0x5d
[   20.572991]  ? path_openat+0x6ae/0x9f9
[   20.573742]  kasan_report+0x1b7/0x1d8
[   20.574559]  ? path_openat+0x6ae/0x9f9
[   20.575241]  path_openat+0x6ae/0x9f9
[   20.575915]  ? may_open+0x135/0x135
[   20.576839]  ? lockdep_hardirqs_on_prepare+0x1f1/0x1f1
[   20.577953]  ? kvm_sched_clock_read+0x5/0x11
[   20.579140]  ? sched_clock_cpu+0x1a/0x106
[   20.580687]  do_filp_open+0xab/0x12e
[   20.582278]  ? path_openat+0x9f9/0x9f9
[   20.583503]  ? kvm_sched_clock_read+0x5/0x11
[   20.584925]  ? lock_downgrade+0x324/0x324
[   20.586144]  ? lock_acquired+0x2d1/0x333
[   20.587385]  ? __check_heap_object+0x5d/0xe0
[   20.588436]  ? do_raw_spin_unlock+0xca/0xd6
[   20.589853]  ? _raw_spin_unlock+0x1a/0x2e
[   20.590697]  ? alloc_fd+0x218/0x22e
[   20.591460]  do_sys_openat2+0xbd/0x15c
[   20.592241]  ? file_open_root+0xee/0xee
[   20.593034]  ? lock_downgrade+0x324/0x324
[   20.593839]  do_sys_open+0x7b/0xac
[   20.594532]  ? filp_open+0x43/0x43
[   20.595138]  ? lockdep_hardirqs_on_prepare+0x1ce/0x1f1
[   20.596062]  ? __x64_sys_creat+0x1b/0x33
[   20.596796]  do_syscall_64+0x6d/0x84
[   20.597485]  entry_SYSCALL_64_after_hwframe+0x6c/0xd6
[   20.598359] RIP: 0033:0x79f47fd46c7d
[   20.599067] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 81 0d 00 f7 d8 64 89 01 48
[   20.603403] RSP: 002b:00007fffca44e7f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
[   20.605712] RAX: ffffffffffffffda RBX: 00007fffca44e928 RCX: 000079f47fd46c7d
[   20.607476] RDX: 000079f47fd46c7d RSI: 0000000000000000 RDI: 0000000020000d00
[   20.609956] RBP: 00007fffca44e810 R08: 0000000000000000 R09: 0000000000000000
[   20.612074] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   20.613364] R13: 00007fffca44e938 R14: 00005c3ad8078d10 R15: 000079f47fe87000
[   20.615618]  </TASK>
[   20.616752] ==================================================================

Jan Kara (19):
  udf: New directory iteration code
  udf: Convert udf_expand_dir_adinicb() to new directory iteration
  udf: Move udf_expand_dir_adinicb() to its callsite
  udf: Implement searching for directory entry using new iteration code
  udf: Provide function to mark entry as deleted using new directory
    iteration code
  udf: Convert udf_rename() to new directory iteration code
  udf: Convert udf_readdir() to new directory iteration
  udf: Convert udf_lookup() to use new directory iteration code
  udf: Convert udf_get_parent() to new directory iteration code
  udf: Convert empty_dir() to new directory iteration code
  udf: Convert udf_rmdir() to new directory iteration code
  udf: Convert udf_unlink() to new directory iteration code
  udf: Implement adding of dir entries using new iteration code
  udf: Convert udf_add_nondir() to new directory iteration
  udf: Convert udf_mkdir() to new directory iteration code
  udf: Convert udf_link() to new directory iteration code
  udf: Remove old directory iteration code
  udf: Handle error when expanding directory
  udf: Don't return bh from udf_expand_dir_adinicb()

 fs/udf/dir.c       |  148 ++-----
 fs/udf/directory.c |  564 ++++++++++++++++++------
 fs/udf/inode.c     |   90 ----
 fs/udf/namei.c     | 1052 +++++++++++++++-----------------------------
 fs/udf/udfdecl.h   |   45 +-
 5 files changed, 825 insertions(+), 1074 deletions(-)

-- 
2.34.1


