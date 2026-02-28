Return-Path: <stable+bounces-220633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKyEGHM8o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D271C696C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4302731157A4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE4C3EAE79;
	Sat, 28 Feb 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3sZlu6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6A3EAE71;
	Sat, 28 Feb 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300516; cv=none; b=eftbr+F9QhscmUpAIatxVyUUriLzbYu5cjvwla6szKjhtDjtx3m2P426T4SyKcenX6R/WO0Zizs8+BEzv6Ilbigf9bWex6PWvQ9b0x+dBa5/LL61GjfmsI41KrZruQ1coXtY1XfDTy5qQ+mM2S9hyO0xnl5/swbx67a64fimVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300516; c=relaxed/simple;
	bh=XMJpDTLdhtk0HnBKXtLfwrh8DmxRCR19o+jYxY50M94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUG5sU5tOmZBo/cQVzsq6Tv4YRkt4k4ZwTOS4F40n8qtEAnBZBrueosrz/0i93RCawKbWeHMBUIQ+ld2LHvO3QX1dNVC7YlqEOmut9egj4lJmmgksGbwnqaia1FmuQcYGVqsH3UuaE3g4J/dqKHcKOXyWdg3Pbt2QaF7h5ixUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3sZlu6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2E1C2BC9E;
	Sat, 28 Feb 2026 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300516;
	bh=XMJpDTLdhtk0HnBKXtLfwrh8DmxRCR19o+jYxY50M94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3sZlu6b3XhzgwPyyBCRxFwsrwzUQswOx9EOWXwrkdJf5YWnVLuv47qkrrrK7k5if
	 ssLtYdx/SDa3cWHcaJ5WRPeLoJaLFy8P2KbinEVdyWk03u0yIRaT+eGCtebNoFFG1Q
	 q0KJiFnDIlrFnW8bOFID/D/GqV9s69tA1xegMem0MkBHdLhbDM+Nz8u4fbU+b0xAy4
	 Uj9tpsGqarvgzyaxR6OT+PPzb0nKMD3JslIB9ZEiNOeWPtwDoiW5H31cXCzfaAR2NJ
	 5KsYIHZ4/csAKjWmEJaiMxWN61ReeP8GCyMIiRx/dKhMg6uZK67RtUJHKiODkeMpn3
	 IizJ5uk4GIsmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 554/844] arm64: kernel: initialize missing kexec_buf->random field
Date: Sat, 28 Feb 2026 12:27:47 -0500
Message-ID: <20260228173244.1509663-555-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220633-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 08D271C696C
X-Rspamd-Action: no action

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit 15dd20dda979ebab72f6df97845828e78d63ab91 ]

Commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
introduced the kexec_buf->random field to enable random placement of
kexec_buf.

However, this field was never properly initialized for kexec images
that do not need to be placed randomly, leading to the following UBSAN
warning:

[  +0.364528] ------------[ cut here ]------------
[  +0.000019] UBSAN: invalid-load in ./include/linux/kexec.h:210:12
[  +0.000131] load of value 2 is not a valid value for type 'bool' (aka '_Bool')
[  +0.000003] CPU: 4 UID: 0 PID: 927 Comm: kexec Not tainted 6.18.0-rc7+ #3 PREEMPT(full)
[  +0.000002] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[  +0.000000] Call trace:
[  +0.000001]  show_stack+0x24/0x40 (C)
[  +0.000006]  __dump_stack+0x28/0x48
[  +0.000002]  dump_stack_lvl+0x7c/0xb0
[  +0.000002]  dump_stack+0x18/0x34
[  +0.000001]  ubsan_epilogue+0x10/0x50
[  +0.000002]  __ubsan_handle_load_invalid_value+0xc8/0xd0
[  +0.000003]  locate_mem_hole_callback+0x28c/0x2a0
[  +0.000003]  kexec_locate_mem_hole+0xf4/0x2f0
[  +0.000001]  kexec_add_buffer+0xa8/0x178
[  +0.000002]  image_load+0xf0/0x258
[  +0.000001]  __arm64_sys_kexec_file_load+0x510/0x718
[  +0.000002]  invoke_syscall+0x68/0xe8
[  +0.000001]  el0_svc_common+0xb0/0xf8
[  +0.000002]  do_el0_svc+0x28/0x48
[  +0.000001]  el0_svc+0x40/0xe8
[  +0.000002]  el0t_64_sync_handler+0x84/0x140
[  +0.000002]  el0t_64_sync+0x1bc/0x1c0

To address this, initialise kexec_buf->random field properly.

Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
Suggested-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
Link: https://lkml.kernel.org/r/20250826-akpm-v1-1-3c831f0e3799@debian.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/kexec_image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 532d72ea42ee8..b70f4df15a1ae 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
 	struct arm64_image_header *h;
 	u64 flags, value;
 	bool be_image, be_kernel;
-	struct kexec_buf kbuf;
+	struct kexec_buf kbuf = {};
 	unsigned long text_offset, kernel_segment_number;
 	struct kexec_segment *kernel_segment;
 	int ret;
-- 
2.51.0


