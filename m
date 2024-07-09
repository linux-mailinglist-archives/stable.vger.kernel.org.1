Return-Path: <stable+bounces-58491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190692B74F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C70B282023
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0801158201;
	Tue,  9 Jul 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omo3NqTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD61156F57;
	Tue,  9 Jul 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524101; cv=none; b=oDA8FZY62phTJmEolYLn2EfU/hwP+Q1SypOA4btfdcJlCcOPJ5/TdoyKYtL5KCw2ParyMqv9Jmo+03A0hELfHBvjjkxXQsY3g9IF37Tiz/y4OU+JHzIni5L9huEBdOWkoxVOvkxMZeZv9ZM4D4pLOjgOVdN03BaY1qYax4NcOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524101; c=relaxed/simple;
	bh=b8pux91FCyeHSj+MwCSJlGw7D3Pdt5aRTtN8m5HT6bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcrwzhdgU9t9IO0wc73RL1vvleaA/SKH5Zk3AVi0Akdkel9BxEoHPQmNQ2DvAAHtOTqGVKVe8fw2NUQIpZ9ajDSjCajxpoydJE0MtZmnBPtuVEoWFXRoTE3QC7tr18nmrc84oh9hL2AcqDFLrr9C39kfGR6g6H32H2KSaLFeXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omo3NqTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A470C3277B;
	Tue,  9 Jul 2024 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524101;
	bh=b8pux91FCyeHSj+MwCSJlGw7D3Pdt5aRTtN8m5HT6bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omo3NqTfg/ioqs36fhr6Ai1WnNTDML9uYhkn2ew7ayL494yPJQbR0/VZbNnPlzd2W
	 JdjJv2U5RPsZh4swWick8DUhl8T4/hOqfjYghadis7nSVIzl8IkkZ9jJBgnl7jji2+
	 rpyEMlzPWsBX/yf04hjDE2abvMFc+jScGNbXrcFc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 071/197] jffs2: Fix potential illegal address access in jffs2_free_inode
Date: Tue,  9 Jul 2024 13:08:45 +0200
Message-ID: <20240709110711.711542665@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Yong <wang.yong12@zte.com.cn>

[ Upstream commit af9a8730ddb6a4b2edd779ccc0aceb994d616830 ]

During the stress testing of the jffs2 file system,the following
abnormal printouts were found:
[ 2430.649000] Unable to handle kernel paging request at virtual address 0069696969696948
[ 2430.649622] Mem abort info:
[ 2430.649829]   ESR = 0x96000004
[ 2430.650115]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 2430.650564]   SET = 0, FnV = 0
[ 2430.650795]   EA = 0, S1PTW = 0
[ 2430.651032]   FSC = 0x04: level 0 translation fault
[ 2430.651446] Data abort info:
[ 2430.651683]   ISV = 0, ISS = 0x00000004
[ 2430.652001]   CM = 0, WnR = 0
[ 2430.652558] [0069696969696948] address between user and kernel address ranges
[ 2430.653265] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 2430.654512] CPU: 2 PID: 20919 Comm: cat Not tainted 5.15.25-g512f31242bf6 #33
[ 2430.655008] Hardware name: linux,dummy-virt (DT)
[ 2430.655517] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2430.656142] pc : kfree+0x78/0x348
[ 2430.656630] lr : jffs2_free_inode+0x24/0x48
[ 2430.657051] sp : ffff800009eebd10
[ 2430.657355] x29: ffff800009eebd10 x28: 0000000000000001 x27: 0000000000000000
[ 2430.658327] x26: ffff000038f09d80 x25: 0080000000000000 x24: ffff800009d38000
[ 2430.658919] x23: 5a5a5a5a5a5a5a5a x22: ffff000038f09d80 x21: ffff8000084f0d14
[ 2430.659434] x20: ffff0000bf9a6ac0 x19: 0169696969696940 x18: 0000000000000000
[ 2430.659969] x17: ffff8000b6506000 x16: ffff800009eec000 x15: 0000000000004000
[ 2430.660637] x14: 0000000000000000 x13: 00000001000820a1 x12: 00000000000d1b19
[ 2430.661345] x11: 0004000800000000 x10: 0000000000000001 x9 : ffff8000084f0d14
[ 2430.662025] x8 : ffff0000bf9a6b40 x7 : ffff0000bf9a6b48 x6 : 0000000003470302
[ 2430.662695] x5 : ffff00002e41dcc0 x4 : ffff0000bf9aa3b0 x3 : 0000000003470342
[ 2430.663486] x2 : 0000000000000000 x1 : ffff8000084f0d14 x0 : fffffc0000000000
[ 2430.664217] Call trace:
[ 2430.664528]  kfree+0x78/0x348
[ 2430.664855]  jffs2_free_inode+0x24/0x48
[ 2430.665233]  i_callback+0x24/0x50
[ 2430.665528]  rcu_do_batch+0x1ac/0x448
[ 2430.665892]  rcu_core+0x28c/0x3c8
[ 2430.666151]  rcu_core_si+0x18/0x28
[ 2430.666473]  __do_softirq+0x138/0x3cc
[ 2430.666781]  irq_exit+0xf0/0x110
[ 2430.667065]  handle_domain_irq+0x6c/0x98
[ 2430.667447]  gic_handle_irq+0xac/0xe8
[ 2430.667739]  call_on_irq_stack+0x28/0x54
The parameter passed to kfree was 5a5a5a5a, which corresponds to the target field of
the jffs_inode_info structure. It was found that all variables in the jffs_inode_info
structure were 5a5a5a5a, except for the first member sem. It is suspected that these
variables are not initialized because they were set to 5a5a5a5a during memory testing,
which is meant to detect uninitialized memory.The sem variable is initialized in the
function jffs2_i_init_once, while other members are initialized in
the function jffs2_init_inode_info.

The function jffs2_init_inode_info is called after iget_locked,
but in the iget_locked function, the destroy_inode process is triggered,
which releases the inode and consequently, the target member of the inode
is not initialized.In concurrent high pressure scenarios, iget_locked
may enter the destroy_inode branch as described in the code.

Since the destroy_inode functionality of jffs2 only releases the target,
the fix method is to set target to NULL in jffs2_i_init_once.

Signed-off-by: Wang Yong <wang.yong12@zte.com.cn>
Reviewed-by: Lu Zhongjun <lu.zhongjun@zte.com.cn>
Reviewed-by: Yang Tao <yang.tao172@zte.com.cn>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index aede1be4dc0cd..4545f885c41ef 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -58,6 +58,7 @@ static void jffs2_i_init_once(void *foo)
 	struct jffs2_inode_info *f = foo;
 
 	mutex_init(&f->sem);
+	f->target = NULL;
 	inode_init_once(&f->vfs_inode);
 }
 
-- 
2.43.0




