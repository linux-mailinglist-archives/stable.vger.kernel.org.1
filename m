Return-Path: <stable+bounces-42246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2A8B7216
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51612B220C4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC812C530;
	Tue, 30 Apr 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OW4MPbpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237D12C47A;
	Tue, 30 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475040; cv=none; b=rNEmNpurEn2WnX+CyQ6EN4SaOuLYwMD3uoBMjVKqBsTjQnm1UmMTOuYsnTbe8JzAIjL4xIifH5LJAhw6OkC8fP10HyJK4Xon6c7v7zDrySbIAd5Obuc1nSHCgPqNKTKBrdtNr2ahkMv+6aaEe9CkQUu+WeYkwUC+QS7HxBuzKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475040; c=relaxed/simple;
	bh=w8eH7hkvGCGJff6PI2s7r6s9UMDq0vU8LF2z00KsjiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJiJbul+khbRlfRoimP3ASz5veAaUEHL0RG3AHLfnzWhSnQeAr+l5ABGACedzaWdIqMtLIEt3G3id+1KU8e+OqhQdawkqJvRkETMBQfiAVshyD7WvQxNs2euyhwIfTmNopaeSZc74QeX4NfdcLkLTAWdjntNSXFPc0MHldfMC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OW4MPbpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2DC2BBFC;
	Tue, 30 Apr 2024 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475039;
	bh=w8eH7hkvGCGJff6PI2s7r6s9UMDq0vU8LF2z00KsjiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW4MPbpdKyLP2aU5Y6X5b481cSp/h5SVgxYbADFvoHbEbyd6ky3mvWa9B9V7Bk2vl
	 18yBjyBe1F92LmPPqnhltCAqofmFg3X03mvaQ3WELtNkqmG5utf+sEiq7+PpFRa1SP
	 bKsszYTjYtIl5gAgPHgthAgdVgi1zEe76LwnRAsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10 112/138] tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together
Date: Tue, 30 Apr 2024 12:39:57 +0200
Message-ID: <20240430103052.707185260@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

From: Robin H. Johnson <robbat2@gentoo.org>

commit e531e90b5ab0f7ce5ff298e165214c1aec6ed187 upstream.

Running endpoint security solutions like Sentinel1 that use perf-based
tracing heavily lead to this repeated dump complaining about dockerd.
The default value of 2048 is nowhere near not large enough.

Using the prior patch "tracing: show size of requested buffer", we get
"perf buffer not large enough, wanted 6644, have 6144", after repeated
up-sizing (I did 2/4/6/8K). With 8K, the problem doesn't occur at all,
so below is the trace for 6K.

I'm wondering if this value should be selectable at boot time, but this
is a good starting point.

```
------------[ cut here ]------------
perf buffer not large enough, wanted 6644, have 6144
WARNING: CPU: 1 PID: 4997 at kernel/trace/trace_event_perf.c:402 perf_trace_buf_alloc+0x8c/0xa0
Modules linked in: [..]
CPU: 1 PID: 4997 Comm: sh Tainted: G                T 5.13.13-x86_64-00039-gb3959163488e #63
Hardware name: LENOVO 20KH002JUS/20KH002JUS, BIOS N23ET66W (1.41 ) 09/02/2019
RIP: 0010:perf_trace_buf_alloc+0x8c/0xa0
Code: 80 3d 43 97 d0 01 00 74 07 31 c0 5b 5d 41 5c c3 ba 00 18 00 00 89 ee 48 c7 c7 00 82 7d 91 c6 05 25 97 d0 01 01 e8 22 ee bc 00 <0f> 0b 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 89
RSP: 0018:ffffb922026b7d58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff9da5ee012000 RCX: 0000000000000027
RDX: ffff9da881657828 RSI: 0000000000000001 RDI: ffff9da881657820
RBP: 00000000000019f4 R08: 0000000000000000 R09: ffffb922026b7b80
R10: ffffb922026b7b78 R11: ffffffff91dda688 R12: 000000000000000f
R13: ffff9da5ee012108 R14: ffff9da8816570a0 R15: ffffb922026b7e30
FS:  00007f420db1a080(0000) GS:ffff9da881640000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000060 CR3: 00000002504a8006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kprobe_perf_func+0x11e/0x270
 ? do_execveat_common.isra.0+0x1/0x1c0
 ? do_execveat_common.isra.0+0x5/0x1c0
 kprobe_ftrace_handler+0x10e/0x1d0
 0xffffffffc03aa0c8
 ? do_execveat_common.isra.0+0x1/0x1c0
 do_execveat_common.isra.0+0x5/0x1c0
 __x64_sys_execve+0x33/0x40
 do_syscall_64+0x6b/0xc0
 ? do_syscall_64+0x11/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f420dc1db37
Code: ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 00 f7 d8 64 41 89 00 eb dc 0f 1f 84 00 00 00 00 00 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 01 43 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd4e8b4e38 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f420dc1db37
RDX: 0000564338d1e740 RSI: 0000564338d32d50 RDI: 0000564338d28f00
RBP: 0000564338d28f00 R08: 0000564338d32d50 R09: 0000000000000020
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000564338d28f00
R13: 0000564338d32d50 R14: 0000564338d1e740 R15: 0000564338d28c60
---[ end trace 83ab3e8e16275e49 ]---
```

Link: https://lkml.kernel.org/r/20210831043723.13481-2-robbat2@gentoo.org

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/trace_events.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -577,7 +577,7 @@ struct trace_event_file {
 	}								\
 	early_initcall(trace_init_perf_perm_##name);
 
-#define PERF_MAX_TRACE_SIZE	2048
+#define PERF_MAX_TRACE_SIZE	8192
 
 #define MAX_FILTER_STR_VAL	256U	/* Should handle KSYM_SYMBOL_LEN */
 



