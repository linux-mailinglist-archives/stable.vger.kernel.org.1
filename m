Return-Path: <stable+bounces-36174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7FD89ABF0
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854FC1F217A5
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56C3BBF5;
	Sat,  6 Apr 2024 16:11:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82513BBDE
	for <stable@vger.kernel.org>; Sat,  6 Apr 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419902; cv=none; b=qOm7RmkUQTfv5UF0ci4tqc8yydhsUUCts6+aPIfkYiACiFJHSsAo6RlwsvFmRII5bWWrw9FnfIBAHkxJxwEoq+5h7loWJa2/sbz2Nyi3HZsp69uaqM5QfDSrlsMd3IfJ6jZne9t2tHxwdLIa7/qMq/zhxjI8+ahLDNehbkgGrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419902; c=relaxed/simple;
	bh=7fWCjJs+M18WZPEDYoK7CCbbJjL/r+zVE9P3pIAZCyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfvdEBb3nTd0Ka/DK7Rxf8WnjU4/xAHmfhRJvenOsSY91Wm2upKHol9VduSPSMlu2i54TgM+r5/jD9K1q/NP0G0W8wUiUen2q1XiVXUsBKO8yV5VeNfGWuE3A69yhizz4IqdNam1s/brWum4/UqzeixmKgsOOlT87cBr2RH+E9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id E4DF972C90B;
	Sat,  6 Apr 2024 19:11:30 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id D562336D0160;
	Sat,  6 Apr 2024 19:11:30 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH v2 0/1] cifs: Convert struct fealist away from 1-element array
Date: Sat,  6 Apr 2024 19:11:06 +0300
Message-ID: <20240406161107.1613361-1-vt@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport of the mainline fix to the kernel panic when Wine is run over
CIFS share. This is intended for linux-6.1.y tree. Please apply.
Bug and testing details:

  Jan 24 15:15:20 kalt2test.dpt.local kernel: detected buffer overflow in strncpy
  Jan 24 15:15:20 kalt2test.dpt.local kernel: ------------[ cut here ]------------
  Jan 24 15:15:20 kalt2test.dpt.local kernel: kernel BUG at lib/string_helpers.c:1027!
  Jan 24 15:15:20 kalt2test.dpt.local kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  Jan 24 15:15:20 kalt2test.dpt.local kernel: CPU: 1 PID: 4532 Comm: vr402352.res Tainted: G           OE      6.1.73-un-def-alt1 #1
  Jan 24 15:15:20 kalt2test.dpt.local kernel: Hardware name: Gigabyte Technology Co., Ltd. B360M-D3H/B360M D3H-CF, BIOS F12 03/14/2019
  Jan 24 15:15:20 kalt2test.dpt.local kernel: RIP: 0010:fortify_panic+0xf/0x11
  ...
  Jan 24 15:15:20 kalt2test.dpt.local kernel: Call Trace:
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  <TASK>
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? __die_body.cold+0x1a/0x1f
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? die+0x2b/0x50
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? do_trap+0xcf/0x120
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? fortify_panic+0xf/0x11
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? do_error_trap+0x83/0xb0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? fortify_panic+0xf/0x11
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? exc_invalid_op+0x4e/0x70
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? fortify_panic+0xf/0x11
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? asm_exc_invalid_op+0x16/0x20
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? fortify_panic+0xf/0x11
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  CIFSSMBSetEA.cold+0xc/0x18 [cifs]
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  cifs_xattr_set+0x596/0x690 [cifs]
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? evm_protected_xattr_common+0x41/0xb0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr+0x52/0x70
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr_locked+0xbc/0x150
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  vfs_removexattr+0x56/0x100
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  removexattr+0x58/0x90
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? get_vtime_delta+0xf/0xb0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? ct_kernel_exit.constprop.0+0x6b/0x80
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? __ct_user_enter+0x5a/0xd0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? syscall_exit_to_user_mode+0x31/0x50
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? int80_emulation+0xb9/0x110
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? get_vtime_delta+0xf/0xb0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? ct_kernel_exit.constprop.0+0x6b/0x80
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? __ct_user_enter+0x5a/0xd0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? __fget_light.part.0+0x83/0xd0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  __ia32_sys_fremovexattr+0x80/0xa0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  int80_emulation+0xa9/0x110
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? get_vtime_delta+0xf/0xb0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? vtime_user_exit+0x1c/0x70
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? __ct_user_exit+0x6c/0xc0
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  ? int80_emulation+0x1b/0x110
  Jan 24 15:15:20 kalt2test.dpt.local kernel:  asm_int80_emulation+0x16/0x20
  Jan 24 15:15:20 kalt2test.dpt.local kernel: RIP: 0023:0xf7e3b9b1

This backport is a simple cherry-pick of mainline commit 398d5843c032
("cifs: Convert struct fealist away from 1-element array").

Build and runtime tested to fix the problem.
Downstream bug report and test report: https://bugzilla.altlinux.org/49177

Difference from v0:
- No changes, only a cover letter is added with bug details.

Kees Cook (1):
  cifs: Convert struct fealist away from 1-element array

 fs/smb/client/cifspdu.h |  4 ++--
 fs/smb/client/cifssmb.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.42.1


