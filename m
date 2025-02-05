Return-Path: <stable+bounces-113795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB98A293F7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D36F3AC066
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419701E89C;
	Wed,  5 Feb 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPxBMYsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EC1519B4;
	Wed,  5 Feb 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768199; cv=none; b=MjV/jssFM6ayU+YDPv2pLgdirvIQFAVA1fpz4U6gQ7wzYfaI6ZAvfjxE2qB9sm5FVcgFt5EUthovkUMQ1IX4xG72YXA+33OuUOO/w2O70CPnXYFrmmZTgyfAck0R/ksmhkGQ8rn+bCOhHNS9IlJvAKh7gx7Yo7ZNoChEyWh9VNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768199; c=relaxed/simple;
	bh=GrWbuAC7Rx4pEZdJ73H8AXDc9U0B5afYes7Y34QPjlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ulxk4yxKmjWhJz5knOQDaJ3m7EY/2JL6LrX6VoPvJtyjZoNl0qOPUgM4o1wFnsoJDPfAjRz5aluIfuKAqHu5hqdyWt1beq9s5kucoqtcNDktV0cDH0HmofpI0k8GbGf0E4nk0yJP0oJZvi0BZYGbNv7cccbNA//DdfS4LTlGwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPxBMYsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C6C4CED1;
	Wed,  5 Feb 2025 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768198;
	bh=GrWbuAC7Rx4pEZdJ73H8AXDc9U0B5afYes7Y34QPjlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPxBMYsR54wd0hV3qRWL+2164Wp9DVnxmU5pvy3fx6wCso3kFD+wrEzlDmtCHIsS2
	 E32wwkrCG88aIRGu+IzauH32sqI+er54ia11pT+WmUNa6AnYGuh1duZ5oukTUKlvhY
	 2eMysbkdT7zOcjS/MyMU2zxa7s7AP2nx+ZMAvWJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 511/623] perf trace: Fix BPF loading failure (-E2BIG)
Date: Wed,  5 Feb 2025 14:44:13 +0100
Message-ID: <20250205134515.769074126@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Howard Chu <howardchu95@gmail.com>

[ Upstream commit 013eb043f37bd87c4d60d51034401a5a6d105bcf ]

As reported by Namhyung Kim and acknowledged by Qiao Zhao (link:
https://lore.kernel.org/linux-perf-users/20241206001436.1947528-1-namhyung@kernel.org/),
on certain machines, perf trace failed to load the BPF program into the
kernel. The verifier runs perf trace's BPF program for up to 1 million
instructions, returning an E2BIG error, whereas the perf trace BPF
program should be much less complex than that. This patch aims to fix
the issue described above.

The E2BIG problem from clang-15 to clang-16 is cause by this line:
 } else if (size < 0 && size >= -6) { /* buffer */

Specifically this check: size < 0. seems like clang generates a cool
optimization to this sign check that breaks things.

Making 'size' s64, and use
 } else if ((int)size < 0 && size >= -6) { /* buffer */

Solves the problem. This is some Hogwarts magic.

And the unbounded access of clang-12 and clang-14 (clang-13 works this
time) is fixed by making variable 'aug_size' s64.

As for this:
-if (aug_size > TRACE_AUG_MAX_BUF)
-	aug_size = TRACE_AUG_MAX_BUF;
+aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];

This makes the BPF skel generated by clang-18 work. Yes, new clangs
introduce problems too.

Sorry, I only know that it works, but I don't know how it works. I'm not
an expert in the BPF verifier. I really hope this is not a kernel
version issue, as that would make the test case (kernel_nr) *
(clang_nr), a true horror story. I will test it on more kernel versions
in the future.

Fixes: 395d38419f18: ("perf trace augmented_raw_syscalls: Add more check s to pass the verifier")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20241213023047.541218-1-howardchu95@gmail.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 4a62ed593e84e..e4352881e3faa 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -431,9 +431,9 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 {
 	bool augmented, do_output = false;
-	int zero = 0, size, aug_size, index,
-	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
+	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
 	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
+	s64 aug_size, size;
 	unsigned int nr, *beauty_map;
 	struct beauty_payload_enter *payload;
 	void *arg, *payload_offset;
@@ -484,14 +484,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		} else if (size > 0 && size <= value_size) { /* struct */
 			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
 				augmented = true;
-		} else if (size < 0 && size >= -6) { /* buffer */
+		} else if ((int)size < 0 && size >= -6) { /* buffer */
 			index = -(size + 1);
 			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
 			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-			aug_size = args->args[index];
-
-			if (aug_size > TRACE_AUG_MAX_BUF)
-				aug_size = TRACE_AUG_MAX_BUF;
+			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
 
 			if (aug_size > 0) {
 				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
-- 
2.39.5




