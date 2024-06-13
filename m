Return-Path: <stable+bounces-51498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7CC907030
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F07289613
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A213D635;
	Thu, 13 Jun 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVYf/zVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2678614D;
	Thu, 13 Jun 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281474; cv=none; b=I0HS1kj/2a2VPsUn4YNJsNtMct+wYtHqEjbJqokcWC0S4JCE+X7z7j27Pu/MjbdbgdU/jnBnXHVJZh0MYrYte9KgyN2LI1oidesYVmFU42cLGkAVNk0lcxIbcKT+T+wLqF7oMdfQiAd/UWI2snZYbmZyHe6y40mnLwTEcHi8WLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281474; c=relaxed/simple;
	bh=UpabC2t4uQ1GHB5kEuETmNjUIy3gqfVGaMMzCri65yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOuyA8JZg95LOUibDR/sc84YwzSjENqAckBcgTjrtNB6CncTeZ2QAjG1IZkONF496HwlrxCgV7Qxw5TAfy3Eb3n6oxIOrTG5+fH0geLKru2s9c6jWltWROpUGLCmWDJCkLL8lF6WKHroveTdETQN9jCJKSp+gMmc8RlhoO2rqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVYf/zVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B2C2BBFC;
	Thu, 13 Jun 2024 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281474;
	bh=UpabC2t4uQ1GHB5kEuETmNjUIy3gqfVGaMMzCri65yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVYf/zVzgcvvzEvgXVnRMRuvT+rgQBH+XazLhjuTrHOIZVljwSbf3z2il9YuYLiGT
	 EyCZ6oaTgkrNSumojapKWn+BhrHXU8jzPKG5qtaVnKFLUMeS/vj0rGO3msu4Op4JZ8
	 rVD4BdgV5XJmB3gfr/ULaVmC/VRcy9bMs+ZCyyFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuanbin Xie <xieyuanbin1@huawei.com>,
	Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 236/317] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
Date: Thu, 13 Jun 2024 13:34:14 +0200
Message-ID: <20240613113256.679840606@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>

[ Upstream commit ffbf4fb9b5c12ff878a10ea17997147ea4ebea6f ]

When CONFIG_DEBUG_BUGVERBOSE=n, we fail to add necessary padding bytes
to bug_table entries, and as a result the last entry in a bug table will
be ignored, potentially leading to an unexpected panic(). All prior
entries in the table will be handled correctly.

The arm64 ABI requires that struct fields of up to 8 bytes are
naturally-aligned, with padding added within a struct such that struct
are suitably aligned within arrays.

When CONFIG_DEBUG_BUGVERPOSE=y, the layout of a bug_entry is:

	struct bug_entry {
		signed int      bug_addr_disp;	// 4 bytes
		signed int      file_disp;	// 4 bytes
		unsigned short  line;		// 2 bytes
		unsigned short  flags;		// 2 bytes
	}

... with 12 bytes total, requiring 4-byte alignment.

When CONFIG_DEBUG_BUGVERBOSE=n, the layout of a bug_entry is:

	struct bug_entry {
		signed int      bug_addr_disp;	// 4 bytes
		unsigned short  flags;		// 2 bytes
		< implicit padding >		// 2 bytes
	}

... with 8 bytes total, with 6 bytes of data and 2 bytes of trailing
padding, requiring 4-byte alginment.

When we create a bug_entry in assembly, we align the start of the entry
to 4 bytes, which implicitly handles padding for any prior entries.
However, we do not align the end of the entry, and so when
CONFIG_DEBUG_BUGVERBOSE=n, the final entry lacks the trailing padding
bytes.

For the main kernel image this is not a problem as find_bug() doesn't
depend on the trailing padding bytes when searching for entries:

	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
		if (bugaddr == bug_addr(bug))
			return bug;

However for modules, module_bug_finalize() depends on the trailing
bytes when calculating the number of entries:

	mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);

... and as the last bug_entry lacks the necessary padding bytes, this entry
will not be counted, e.g. in the case of a single entry:

	sechdrs[i].sh_size == 6
	sizeof(struct bug_entry) == 8;

	sechdrs[i].sh_size / sizeof(struct bug_entry) == 0;

Consequently module_find_bug() will miss the last bug_entry when it does:

	for (i = 0; i < mod->num_bugs; ++i, ++bug)
		if (bugaddr == bug_addr(bug))
			goto out;

... which can lead to a kenrel panic due to an unhandled bug.

This can be demonstrated with the following module:

	static int __init buginit(void)
	{
		WARN(1, "hello\n");
		return 0;
	}

	static void __exit bugexit(void)
	{
	}

	module_init(buginit);
	module_exit(bugexit);
	MODULE_LICENSE("GPL");

... which will trigger a kernel panic when loaded:

	------------[ cut here ]------------
	hello
	Unexpected kernel BRK exception at EL1
	Internal error: BRK handler: 00000000f2000800 [#1] PREEMPT SMP
	Modules linked in: hello(O+)
	CPU: 0 PID: 50 Comm: insmod Tainted: G           O       6.9.1 #8
	Hardware name: linux,dummy-virt (DT)
	pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : buginit+0x18/0x1000 [hello]
	lr : buginit+0x18/0x1000 [hello]
	sp : ffff800080533ae0
	x29: ffff800080533ae0 x28: 0000000000000000 x27: 0000000000000000
	x26: ffffaba8c4e70510 x25: ffff800080533c30 x24: ffffaba8c4a28a58
	x23: 0000000000000000 x22: 0000000000000000 x21: ffff3947c0eab3c0
	x20: ffffaba8c4e3f000 x19: ffffaba846464000 x18: 0000000000000006
	x17: 0000000000000000 x16: ffffaba8c2492834 x15: 0720072007200720
	x14: 0720072007200720 x13: ffffaba8c49b27c8 x12: 0000000000000312
	x11: 0000000000000106 x10: ffffaba8c4a0a7c8 x9 : ffffaba8c49b27c8
	x8 : 00000000ffffefff x7 : ffffaba8c4a0a7c8 x6 : 80000000fffff000
	x5 : 0000000000000107 x4 : 0000000000000000 x3 : 0000000000000000
	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3947c0eab3c0
	Call trace:
	 buginit+0x18/0x1000 [hello]
	 do_one_initcall+0x80/0x1c8
	 do_init_module+0x60/0x218
	 load_module+0x1ba4/0x1d70
	 __do_sys_init_module+0x198/0x1d0
	 __arm64_sys_init_module+0x1c/0x28
	 invoke_syscall+0x48/0x114
	 el0_svc_common.constprop.0+0x40/0xe0
	 do_el0_svc+0x1c/0x28
	 el0_svc+0x34/0xd8
	 el0t_64_sync_handler+0x120/0x12c
	 el0t_64_sync+0x190/0x194
	Code: d0ffffe0 910003fd 91000000 9400000b (d4210000)
	---[ end trace 0000000000000000 ]---
	Kernel panic - not syncing: BRK handler: Fatal exception

Fix this by always aligning the end of a bug_entry to 4 bytes, which is
correct regardless of CONFIG_DEBUG_BUGVERBOSE.

Fixes: 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic BUG traps")

Signed-off-by: Yuanbin Xie <xieyuanbin1@huawei.com>
Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/1716212077-43826-1-git-send-email-xiaojiangfeng@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/asm-bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 03f52f84a4f3f..bc2dcc8a00009 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -28,6 +28,7 @@
 	14470:	.long 14471f - 14470b;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
+		.align 2;				\
 		.popsection;				\
 	14471:
 #else
-- 
2.43.0




