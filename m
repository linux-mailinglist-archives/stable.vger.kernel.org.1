Return-Path: <stable+bounces-91352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392499BED97
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F265B285BD8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454B1EBFFA;
	Wed,  6 Nov 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fdN9aWNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6841CC14B;
	Wed,  6 Nov 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898483; cv=none; b=pgL48la5oUo8E7wcRJE3m6xxzkujmd4dbr4cDERQ91Xqhv0pwdkPmHScc43wg6nOC/ghbaAupRthFV6qlrOMnVyWraRiPhOCW8SeePhFxopawM9GKS1aIveDrh0VneIPaz8+TV8rysOs9rZWcZycVdP1L4ZZmQD+2ZlCeRRnHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898483; c=relaxed/simple;
	bh=UovDFy7Nnxcv4ViyqGfWfdYoqWskLNYH6cieaiQ7DUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJWPExtjwb1/7tTgDivdPrKtmUP5vsThOc7VCKXriqOHSXMXNf5oLsT1jA+0I20mAv+0FME7ZA6cB1bWF3FTZxA4tHMwG/SGK7+/1Kl1qYcV1MWQqpM4TtqOjh0WjT8tAqPAZvzl0YZLuanbmpZDSL4YXo0xcUqRtZjlNXUNQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fdN9aWNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA26C4CECD;
	Wed,  6 Nov 2024 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898483;
	bh=UovDFy7Nnxcv4ViyqGfWfdYoqWskLNYH6cieaiQ7DUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdN9aWNOKxC7daVPBcWDeQB6PpBff/Tc8jBZTZUetzsgkZCw8Oua4LxrOggHrbs7O
	 Jpclik9hgusT6pYaHzfNjXX0tPM8HCoT4szF2YgaELg7yDPYarTQh8QjZjiCEBc4ww
	 grws1R6F7oZmgnHKrxh80RpH1MoR9EB/J7/vMSqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Camm Maguire <camm@maguirefamily.org>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.4 253/462] parisc: Fix stack start for ADDR_NO_RANDOMIZE personality
Date: Wed,  6 Nov 2024 13:02:26 +0100
Message-ID: <20241106120337.773223238@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -719,7 +719,8 @@ int setup_arg_pages(struct linux_binprm
 		stack_base = STACK_SIZE_MAX;
 
 	/* Add space for stack randomization. */
-	stack_base += (STACK_RND_MASK << PAGE_SHIFT);
+	if (current->flags & PF_RANDOMIZE)
+		stack_base += (STACK_RND_MASK << PAGE_SHIFT);
 
 	/* Make sure we didn't let the argument array grow too large. */
 	if (vma->vm_end - vma->vm_start > stack_base)



