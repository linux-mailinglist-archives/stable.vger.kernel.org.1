Return-Path: <stable+bounces-43163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09498BDC17
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 09:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0A11C223E1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0A13BAE9;
	Tue,  7 May 2024 07:08:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FA13B78A;
	Tue,  7 May 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065732; cv=none; b=mkL+ODKlmpXIRZ4Rpj5dC91SDlVjmYF99ImvauT9kjpX7N4fMdPopRRVcbeUc4G3Z2Xjod1Jgjadj7VXQ4xo4+KIxEAM6fo2Gdf0hn1rSwcBkWp0QISVtKXhJSPB2CquB782vN+BWbpF55+IXNCwr2/mMziR3E8JWZ3XzIHsxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065732; c=relaxed/simple;
	bh=HhIO9q2RC6AL+ZdN38tHyxgIXQsJwRDBxquAnk/Fcj4=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=HtQr311dTNTq4Vw2d+QjjzdupUkwNdH0xaEPaGfU7HbP5M9sa5ZTHWeZz8XSxBnfoIIcZCZUV3sG91C4zkQZjQzY1ZzTCaadyxQ+sW7VqAo0JQ94QpC9nJl89kFyjF/w/hNpFX2iukNaV7OnY7/bPf6X+M+mjSzNOiPJ64UN6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4VYThS4L1Xz9yXD;
	Tue,  7 May 2024 15:01:12 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4VYThK54g3z4xCtV;
	Tue,  7 May 2024 15:01:05 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VYTh61gZzz8XrXL;
	Tue,  7 May 2024 15:00:54 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl1.zte.com.cn with SMTP id 44770ibD087732;
	Tue, 7 May 2024 15:00:44 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 7 May 2024 15:00:46 +0800 (CST)
Date: Tue, 7 May 2024 15:00:46 +0800 (CST)
X-Zmail-TransId: 2af96639d19effffffffd7c-0e6a2
X-Mailer: Zmail v1.0
Message-ID: <20240507150046826ZGsq8VfvyxBzczJHMtBxQ@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <dwmw2@infradead.org>, <richard@nod.at>, <dev@elkcl.ru>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <wang.yong12@zte.com.cn>,
        <lu.zhongjun@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGpmZjI6Zml4IHBvdGVudGlhbCBpbGxlZ2FsIGFkZHJlc3MgYWNjZXNzIGluIGpmZnMyX2ZyZWVfaW5vZGU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 44770ibD087732
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6639D1B6.000/4VYThS4L1Xz9yXD

From: Wang Yong <wang.yong12@zte.com.cn>

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
---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c..40cc5e6 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -58,6 +58,7 @@ static void jffs2_i_init_once(void *foo)
 	struct jffs2_inode_info *f = foo;

 	mutex_init(&f->sem);
+	f->target = NULL;
 	inode_init_once(&f->vfs_inode);
 }

-- 
2.15.2

