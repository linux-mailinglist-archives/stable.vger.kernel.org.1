Return-Path: <stable+bounces-19068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B038984C9FA
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659B1288FDD
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F61B816;
	Wed,  7 Feb 2024 11:52:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B311D526
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306761; cv=none; b=fXNVtTM6BeVnirE/jqgYeH1irPKT+qp9bQwqaShLfTSgBPh3/I7PNirOYD/HVljZpUM4mwULdlJK1jOixj/dXjWxkVCaM9/EZCqd38Qog/oc/eRKG4AAgHONoCMB8DCCWulbrgSP+USTzvF1z6A0vOAu7uK727yRojgeMYIrH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306761; c=relaxed/simple;
	bh=gPWcPcTZyksxWBD1qDQ2urcLYgaX7UV3kaZK8GQoJr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS+nVrhpVUSEiiyhVP7rZ61ydsZEFdnXmCQQxjxsNOo2vc2NJSTo4vRtRBEPtXRFcXNsDJiRZWRPJf7UcVMGaGJjAZ8UiTVTtN3ccbz5w2MQtm+I9m2CXNbRwsqRtjbcjjaIucjK2h1zNEAvA4QBLQcK1Sy5BMuT5eogfcFphN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TVJPY3Rqfz1vt0Z;
	Wed,  7 Feb 2024 19:52:01 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F146140414;
	Wed,  7 Feb 2024 19:52:29 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 7 Feb
 2024 19:52:29 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sfrench@samba.org>
Subject: [PATCH 5.15 1/1] cifs: Fix stack-out-of-bounds in smb2_set_next_command()
Date: Wed, 7 Feb 2024 19:47:43 +0800
Message-ID: <20240207114743.2209367-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207114743.2209367-1-wangzhaolong1@huawei.com>
References: <20240207114743.2209367-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)

After backporting the mainline commit 33eae65c6f49 ("smb: client: fix
OOB in SMB2_query_info_init()") to the linux-5.10.y stable branch,
an issue arose where the cifs statfs system call failed, resulting in:

  $ df /mnt
  df: /mnt: Resource temporarily unavailable

KASAN also reported a stack-out-of-bounds error as follows:

 ==================================================================
 BUG: KASAN: stack-out-of-bounds in smb2_set_next_command+0x247/0x280
 [cifs]
 Write of size 8 at addr ffff8881073ef830 by task df/533

 CPU: 4 PID: 533 Comm: df Not tainted 5.10.0+ #17
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.
 fc37 04/01/2014
 Call Trace:
  dump_stack+0xb3/0xf1
  print_address_description.constprop.0+0x1e/0x280
  __kasan_report.cold+0x6c/0x84
  kasan_report+0x3a/0x50
  smb2_set_next_command+0x247/0x280 [cifs]
  smb2_query_info_compound+0x3e9/0x5d0 [cifs]
  smb2_queryfs+0xb9/0x180 [cifs]
  smb311_queryfs+0x218/0x230 [cifs]
  cifs_statfs+0x161/0x340 [cifs]
  statfs_by_dentry+0xa8/0x100
  vfs_statfs+0x2f/0x180
  user_statfs+0x96/0x100
  __se_sys_statfs+0x6a/0xc0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x62/0xc7
 RIP: 0033:0x7ff427ad93b7
 Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 05 59 ba 0d 00 64 c7 00
 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 89 00 00 00 0f 05 <48> 3d
 00 f0 ff ff 77 01 c3 48 8b 15 31 ba 0d 00 f7 d8 64 89 8
 RSP: 002b:00007ffd8371e158 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
 RAX: ffffffffffffffda RBX: 00007ffd8371e200 RCX: 00007ff427ad93b7
 RDX: 0000000000000003 RSI: 00007ffd8371e160 RDI: 00007ffd8371ee4b
 RBP: 00007ffd8371e160 R08: 00007ffd8371e283 R09: 0000000000000032
 R10: 00007ff4279ed368 R11: 0000000000000246 R12: 00007ffd8371e200
 R13: 000056296a125dd0 R14: 0000000000000001 R15: 0000000000000000

 The buggy address belongs to the page:
 page:00000000862dac80 refcount:0 mapcount:0 mapping:0000000000000000
 index:0x0 pfn:0x1073ef
 flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
 raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 addr ffff8881073ef830 is located in stack of task df/533 at offset 112
 in frame:
  smb2_query_info_compound+0x0/0x5d0 [cifs]

 this frame has 9 objects:
  [48, 49) 'oplock'
  [64, 76) 'resp_buftype'
  [96, 112) 'qi_iov'
  [128, 144) 'close_iov'
  [160, 208) 'rsp_iov'
  [240, 296) 'oparms'
  [336, 456) 'rqst'
  [496, 624) 'open_iov'
  [656, 736) 'fid'

 Memory state around the buggy address:
  ffff8881073ef700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881073ef780: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 01 f2
 >ffff8881073ef800: 00 04 f2 f2 00 00 f2 f2 00 00 f2 f2 00 00 00 00
                                      ^
  ffff8881073ef880: 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 f2 f2 f2
  ffff8881073ef900: f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ==================================================================
 Disabling lock debugging due to kernel taint

This issue was caused because the stable branch did not include the
prerequisite patch eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays
with flex-arrays"). The patch replaces the trailing 1-element array with
a flexible array in the smb2_query_info_req structure and modifies the
length calculation expression from `sizeof(smb2_query_info_req) - 1` to
`sizeof(smb2_query_info_req)`. Consequently, backporting only commit
33eae65c6f49 led to an incorrect length calculation for the
smb2_query_info_req structure within SMB2_query_info_init().

cifs_statfs
smb2_queryfs
  smb2_query_info_compound
    struct kvec qi_iov[1];
    rqst[1].rq_iov = qi_iov;
    rqst[1].rq_nvec = 1;
    SMB2_query_info_init
      # The length of len is incorrect because the value of sizeof(req)
      # is not decreased by 1.
      check_add_overflow(input_len, sizeof(*req), &len)
    smb2_set_next_command(tcon, &rqst[1]);
      # 1 byte greater than the actual length
      len = smb_rqst_len(server, rqst);
      # 'len' is not 8-byte aligned, then paddingg.
      # Access to .rq_iov[1] results in out-of-bounds array
      rqst->rq_iov[rqst->rq_nvec].iov_base = smb2_padding;
    compound_send_recv

cifs_demultiplex_thread
  cifs_read_from_socket
    cifs_readv_from_socket
      # The request may be invalid and no expected response.
      length = sock_recvmsg

This patch corrects the length calculation for the smb2_query_info_req
structure in SMB2_query_info_init() to address this problem.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6714e9db0ee8..63058e12dbbb 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3423,7 +3423,7 @@ SMB2_query_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	size_t len;
 	int rc;
 
-	if (unlikely(check_add_overflow(input_len, sizeof(*req), &len) ||
+	if (unlikely(check_add_overflow(input_len, sizeof(*req) - 1, &len) ||
 		     len > CIFSMaxBufSize))
 		return -EINVAL;
 
-- 
2.39.2


