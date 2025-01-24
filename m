Return-Path: <stable+bounces-110370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD1A1B269
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A847A1FED
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFD1DB137;
	Fri, 24 Jan 2025 09:12:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E11D6DC8;
	Fri, 24 Jan 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709956; cv=none; b=BHAmHaySk8ux4zqR9LWqhzrTH6ONTEQOl9I5F01mP9oL1AQ3R1inwph/M6Ul/xv3wcoCRn+beWee0uu+yCrFIl9YWBXq7IchfDYdnFwZs8sFstWPYqnZnWRumjwS5mRVJvArwqOyQi6+0hnx+NJYxEpOoNZZ/dKkj4ky1Y+WG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709956; c=relaxed/simple;
	bh=T0kC0aZm4QOSjS2LuV5WxT7ZuhH14TLndzU7DXnO/98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTg9fw1yKQBPgfAor60Y6sO9zw8/eN19uLdcKAdqIbYI2cRvcacnaqH5KcMCcT1kxs0hq/CJ/FAKvuOhcW6av4E9qNRseuHwbAZLEPnLF3Ua+m7wa26j97726+J07KbPvm0UbFNp9NY5c9hiEEWL/GvIVuBa7ARwCJ+d0Q1zX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.38])
	by gateway (Coremail) with SMTP id _____8DxGeF4WZNnJTFoAA--.7025S3;
	Fri, 24 Jan 2025 17:12:24 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.38])
	by front1 (Coremail) with SMTP id qMiowMDxK8V0WZNn+IksAA--.13847S2;
	Fri, 24 Jan 2025 17:12:23 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] audit: Initialize lsmctx to avoid memory allocation error
Date: Fri, 24 Jan 2025 17:12:09 +0800
Message-ID: <20250124091209.4013832-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxK8V0WZNn+IksAA--.13847S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw18Gr1fZFWDWr4fZw48KrX_yoW7Jw43pF
	y5Ar48Cr4kXryUAr10yF1DJrW7Xw1UCa18Jr17Gr17G3WUJw1DJr1UGFW7Cw1UJrn8JrW7
	ArnrZr1rtr1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU

Initialize the local variable lsmctx in audit_receive_msg(), so as to
avoid memory allocation errors like:

[  258.074914] WARNING: CPU: 2 PID: 443 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x4c8/0x1040
[  258.074994] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
[  258.074997] pc 900000000304d588 ra 9000000003059644 tp 9000000107774000 sp 9000000107777890
[  258.075000] a0 0000000000040cc0 a1 0000000000000012 a2 0000000000000000 a3 0000000000000000
[  258.075003] a4 9000000107777bd0 a5 0000000000000280 a6 0000000000000010 a7 0000000000000000
[  258.075006] t0 9000000004b4c000 t1 0000000000000001 t2 1f3f37829c264c80 t3 000000000000002e
[  258.075009] t4 0000000000000000 t5 00000000000003f6 t6 90000001066b6310 t7 000000000000002f
[  258.075011] t8 000000000000003c u0 00000000000000b4 s9 900000010006f880 s0 9000000004a4b000
[  258.075014] s1 0000000000000000 s2 9000000004a4b000 s3 9000000106673400 s4 9000000107777af0
[  258.075017] s5 90000001066b6300 s6 0000000000000012 s7 fffffffffffff000 s8 0000000000000004
[  258.075019]    ra: 9000000003059644 ___kmalloc_large_node+0x84/0x1e0
[  258.075026]   ERA: 900000000304d588 __alloc_pages_noprof+0x4c8/0x1040
[  258.075030]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[  258.075040]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[  258.075045]  EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
[  258.075051]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[  258.075056] ESTAT: 000c0000 [BRK] (IS= ECode=12 EsubCode=0)
[  258.075061]  PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
[  258.075064] CPU: 2 UID: 0 PID: 443 Comm: auditd Not tainted 6.13.0-rc1+ #1899
[  258.075068] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
[  258.075070] Stack : ffffffffffffffff 0000000000000000 9000000002debf5c 9000000107774000
[  258.075077]         90000001077774f0 0000000000000000 90000001077774f8 900000000489e480
[  258.075083]         9000000004b380e8 9000000004b380e0 9000000107777380 0000000000000001
[  258.075089]         0000000000000001 9000000004a4b000 1f3f37829c264c80 90000001001a9b40
[  258.075094]         9000000107774000 9000000004b080e8 00000000000003d4 9000000004b080e8
[  258.075100]         9000000004a580e8 000000000000002d 0000000006ebc000 900000010006f880
[  258.075106]         00000000000000b4 0000000000000000 0000000000000004 0000000000001277
[  258.075112]         900000000489e480 90000001066b6300 0000000000000012 fffffffffffff000
[  258.075118]         0000000000000004 900000000489e480 9000000002def6a8 00007ffff2ba4065
[  258.075124]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1d
[  258.075129]         ...
[  258.075132] Call Trace:
[  258.075135] [<9000000002def6a8>] show_stack+0x30/0x148
[  258.075146] [<9000000002debf58>] dump_stack_lvl+0x68/0xa0
[  258.075152] [<9000000002e0fe18>] __warn+0x80/0x108
[  258.075158] [<900000000407486c>] report_bug+0x154/0x268
[  258.075163] [<90000000040ad468>] do_bp+0x2a8/0x320
[  258.075172] [<9000000002dedda0>] handle_bp+0x120/0x1c0
[  258.075178] [<900000000304d588>] __alloc_pages_noprof+0x4c8/0x1040
[  258.075183] [<9000000003059640>] ___kmalloc_large_node+0x80/0x1e0
[  258.075187] [<9000000003061504>] __kmalloc_noprof+0x2c4/0x380
[  258.075192] [<9000000002f0f7ac>] audit_receive_msg+0x764/0x1530
[  258.075199] [<9000000002f1065c>] audit_receive+0xe4/0x1c0
[  258.075204] [<9000000003e5abe8>] netlink_unicast+0x340/0x450
[  258.075211] [<9000000003e5ae9c>] netlink_sendmsg+0x1a4/0x4a0
[  258.075216] [<9000000003d9ffd0>] __sock_sendmsg+0x48/0x58
[  258.075222] [<9000000003da32f0>] __sys_sendto+0x100/0x170
[  258.075226] [<9000000003da3374>] sys_sendto+0x14/0x28
[  258.075229] [<90000000040ad574>] do_syscall+0x94/0x138
[  258.075233] [<9000000002ded318>] handle_syscall+0xb8/0x158
[  258.075239]
[  258.075241] ---[ end trace 0000000000000000 ]---

Cc: stable@vger.kernel.org
Fixes: 6fba89813ccf333d ("lsm: ensure the correct LSM context releaser")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 13d0144efaa3..5f5bf85bcc90 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1221,7 +1221,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct audit_buffer	*ab;
 	u16			msg_type = nlh->nlmsg_type;
 	struct audit_sig_info   *sig_data;
-	struct lsm_context	lsmctx;
+	struct lsm_context	lsmctx = { NULL, 0, 0 };
 
 	err = audit_netlink_ok(skb, msg_type);
 	if (err)
-- 
2.47.1


