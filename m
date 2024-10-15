Return-Path: <stable+bounces-86199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF57499EC69
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869981F2101F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE77227BA2;
	Tue, 15 Oct 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oq51h6Se"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724B227B9A;
	Tue, 15 Oct 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998102; cv=none; b=GTGfJglc8JtFa+7phIPUsEDNvHzeIePj+evNBupmsSbgBrAaHaXV4HDD04S1uTzYrasioo/YgqEtPGVzh22onetup1ygXEJzUrtZ4R1ySJDLJxnBtyLL8NGoAlEzQ0tF4Xu+APX3GX12wzVTyWHbh56D/7E/B60URRnngi2EefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998102; c=relaxed/simple;
	bh=iTgaA8Nzz2HajQVHRmSqCo3chyK2LF35R/mqjgbXZHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBL71arei7ONyJFfR0BI15cQXLdYOakPfvVrvaxfW4+twqhq/ZIPHL/8EOUOGwgwOMWGUv6urvFOlFhmvQufZOZEODnoZZx5yTOOOIMtHUIHMPXQIEaqbFiXy84IYU9L+Q9boeV2j7xpAXIQ/n+3S0z7IKjsu3XPwxQTNmJoYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oq51h6Se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C702C4CEC6;
	Tue, 15 Oct 2024 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998102;
	bh=iTgaA8Nzz2HajQVHRmSqCo3chyK2LF35R/mqjgbXZHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oq51h6Se7HCBj0gH5C8rkGHUXtjB9v7sy25SZW4EPxKh83HntvvM6nYMWnGMBtx5S
	 fwc9/QQWYHWR5uDGntcPgl8nIncujL94F5LQqLetkM+zSGd63by3mGFrgCZ7MqjGnm
	 O1bnum0XMNEwoKluwVOSg6o1E9a7yDrJW2Gk631E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Camm Maguire <camm@maguirefamily.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 380/518] parisc: Fix stack start for ADDR_NO_RANDOMIZE personality
Date: Tue, 15 Oct 2024 14:44:44 +0200
Message-ID: <20241015123931.637560037@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit f31b256994acec6929306dfa86ac29716e7503d6 upstream.

Fix the stack start address calculation for the parisc architecture in
setup_arg_pages() when address randomization is disabled. When the
ADDR_NO_RANDOMIZE process personality is disabled there is no need to add
additional space for the stack.
Note that this patch touches code inside an #ifdef CONFIG_STACK_GROWSUP hunk,
which is why only the parisc architecture is affected since it's the
only Linux architecture where the stack grows upwards.

Without this patch you will find the stack in the middle of some
mapped libaries and suddenly limited to 6MB instead of 8MB:

root@parisc:~# setarch -R /bin/bash -c "cat /proc/self/maps"
00010000-00019000 r-xp 00000000 08:05 1182034           /usr/bin/cat
00019000-0001a000 rwxp 00009000 08:05 1182034           /usr/bin/cat
0001a000-0003b000 rwxp 00000000 00:00 0                 [heap]
f90c4000-f9283000 r-xp 00000000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f9283000-f9285000 r--p 001bf000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f9285000-f928a000 rwxp 001c1000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f928a000-f9294000 rwxp 00000000 00:00 0
f9301000-f9323000 rwxp 00000000 00:00 0                 [stack]
f98b4000-f98e4000 r-xp 00000000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f98e4000-f98e5000 r--p 00030000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f98e5000-f98e9000 rwxp 00031000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f9ad8000-f9b00000 rw-p 00000000 00:00 0
f9b00000-f9b01000 r-xp 00000000 00:00 0                 [vdso]

With the patch the stack gets correctly mapped at the end
of the process memory map:

root@panama:~# setarch -R /bin/bash -c "cat /proc/self/maps"
00010000-00019000 r-xp 00000000 08:13 16385582          /usr/bin/cat
00019000-0001a000 rwxp 00009000 08:13 16385582          /usr/bin/cat
0001a000-0003b000 rwxp 00000000 00:00 0                 [heap]
fef29000-ff0eb000 r-xp 00000000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0eb000-ff0ed000 r--p 001c2000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0ed000-ff0f2000 rwxp 001c4000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0f2000-ff0fc000 rwxp 00000000 00:00 0
ff4b4000-ff4e4000 r-xp 00000000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff4e4000-ff4e6000 r--p 00030000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff4e6000-ff4ea000 rwxp 00032000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff6d7000-ff6ff000 rw-p 00000000 00:00 0
ff6ff000-ff700000 r-xp 00000000 00:00 0                 [vdso]
ff700000-ff722000 rwxp 00000000 00:00 0                 [stack]

Reported-by: Camm Maguire <camm@maguirefamily.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: d045c77c1a69 ("parisc,metag: Fix crashes due to stack randomization on stack-grows-upwards architectures")
Fixes: 17d9822d4b4c ("parisc: Consider stack randomization for mmap base only when necessary")
Cc: stable@vger.kernel.org	# v5.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -766,7 +766,8 @@ int setup_arg_pages(struct linux_binprm
 		stack_base = STACK_SIZE_MAX;
 
 	/* Add space for stack randomization. */
-	stack_base += (STACK_RND_MASK << PAGE_SHIFT);
+	if (current->flags & PF_RANDOMIZE)
+		stack_base += (STACK_RND_MASK << PAGE_SHIFT);
 
 	/* Make sure we didn't let the argument array grow too large. */
 	if (vma->vm_end - vma->vm_start > stack_base)



