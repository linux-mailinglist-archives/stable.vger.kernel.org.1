Return-Path: <stable+bounces-112648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50333A28DDE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B053A4B27
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5561519AA;
	Wed,  5 Feb 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7P6uASK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B62E634;
	Wed,  5 Feb 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764275; cv=none; b=OsQmdwRcjr2wUpRIyIhyLsYO8BmqT18fH7RHiSFNAK1wP/vtbmLbvMfnsT3Eke0ugIlbBWTmB3FXGiZxEBAs1+8aqGFbL9y/FHuVlPBrIM++BNUr3BhgCwzkjs/l3uQNN1M6jRMzQ60UNBcg0C1saQ/OwcZzeAMEDUp/2zh/Wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764275; c=relaxed/simple;
	bh=BTiE9Fv2aS6Cc/5/fQQP8b4dczfBdHBeXN8OSfN+sKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqHDEpMd5q74L4hceOUwLw6TUB2PibQ0dXh8ar5dhGVWZ7xPM1ft+2Qe7b9fskvUwsbJK07PSNFypGZqrgZIi79fCphwYnDhjhLeHqcCtoj1RXEf+YU55Mu+wUB0McGTvhQmVh4NJKdRqk/bqxDken1XTdiSE5BPlkXCWfM+ONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n7P6uASK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A1C4CED1;
	Wed,  5 Feb 2025 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764275;
	bh=BTiE9Fv2aS6Cc/5/fQQP8b4dczfBdHBeXN8OSfN+sKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7P6uASK8P5plS+hIHwSmVnXq/6fAZ10cis8A7BTLCuhqmQ6WKyrDd5ZR6gaMNugN
	 COvrr7l80OPr0gGsobz+9VZLGAI5BxyDyOT1BtmPRHVhyaeSLG78g/fhYRYywGHGCQ
	 lNVFyM8OvZki6lTlG25ti9SO8SRH/7hfMUrkVjGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 157/393] selftests/bpf: Fix fill_link_info selftest on powerpc
Date: Wed,  5 Feb 2025 14:41:16 +0100
Message-ID: <20250205134426.308484362@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>

[ Upstream commit 4d33dc1bc31df80356c49e40dbd3ddff19500bcb ]

With CONFIG_KPROBES_ON_FTRACE enabled on powerpc, ftrace_location_range
returns ftrace location for bpf_fentry_test1 at offset of 4 bytes from
function entry. This is because branch to _mcount function is at offset
of 4 bytes in function profile sequence.

To fix this, add entry_offset of 4 bytes while verifying the address for
kprobe entry address of bpf_fentry_test1 in verify_perf_link_info in
selftest, when CONFIG_KPROBES_ON_FTRACE is enabled.

Disassemble of bpf_fentry_test1:

c000000000e4b080 <bpf_fentry_test1>:
c000000000e4b080:       a6 02 08 7c     mflr    r0
c000000000e4b084:       b9 e2 22 4b     bl      c00000000007933c <_mcount>
c000000000e4b088:       01 00 63 38     addi    r3,r3,1
c000000000e4b08c:       b4 07 63 7c     extsw   r3,r3
c000000000e4b090:       20 00 80 4e     blr

When CONFIG_PPC_FTRACE_OUT_OF_LINE [1] is enabled, these function profile
sequence is moved out of line with an unconditional branch at offset 0.
So, the test works without altering the offset for
'CONFIG_KPROBES_ON_FTRACE && CONFIG_PPC_FTRACE_OUT_OF_LINE' case.

Disassemble of bpf_fentry_test1:

c000000000f95190 <bpf_fentry_test1>:
c000000000f95190:       00 00 00 60     nop
c000000000f95194:       01 00 63 38     addi    r3,r3,1
c000000000f95198:       b4 07 63 7c     extsw   r3,r3
c000000000f9519c:       20 00 80 4e     blr

[1] https://lore.kernel.org/all/20241030070850.1361304-13-hbathini@linux.ibm.com/

Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241209065720.234344-1-skb99@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c       |  4 ++++
 .../selftests/bpf/progs/test_fill_link_info.c       | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 5b0c6a04cdbfe..e0208b0e53f16 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -164,6 +164,10 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 		/* See also arch_adjust_kprobe_addr(). */
 		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
 			entry_offset = 4;
+		if (skel->kconfig->CONFIG_PPC64 &&
+		    skel->kconfig->CONFIG_KPROBES_ON_FTRACE &&
+		    !skel->kconfig->CONFIG_PPC_FTRACE_OUT_OF_LINE)
+			entry_offset = 4;
 		err = verify_perf_link_info(link_fd, type, kprobe_addr, 0, entry_offset);
 		ASSERT_OK(err, "verify_perf_link_info");
 	} else {
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 564f402d56fef..54b53ad05339d 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -6,13 +6,20 @@
 #include <stdbool.h>
 
 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+extern bool CONFIG_PPC_FTRACE_OUT_OF_LINE __kconfig __weak;
+extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
+extern bool CONFIG_PPC64 __kconfig __weak;
 
-/* This function is here to have CONFIG_X86_KERNEL_IBT
- * used and added to object BTF.
+/* This function is here to have CONFIG_X86_KERNEL_IBT,
+ * CONFIG_PPC_FTRACE_OUT_OF_LINE, CONFIG_KPROBES_ON_FTRACE,
+ * CONFIG_PPC6 used and added to object BTF.
  */
 int unused(void)
 {
-	return CONFIG_X86_KERNEL_IBT ? 0 : 1;
+	return CONFIG_X86_KERNEL_IBT ||
+			CONFIG_PPC_FTRACE_OUT_OF_LINE ||
+			CONFIG_KPROBES_ON_FTRACE ||
+			CONFIG_PPC64 ? 0 : 1;
 }
 
 SEC("kprobe")
-- 
2.39.5




