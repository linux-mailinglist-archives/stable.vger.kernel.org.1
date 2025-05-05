Return-Path: <stable+bounces-139860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2AAAA10E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4494615AA
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0E299AAA;
	Mon,  5 May 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNulUB5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB3299AA0;
	Mon,  5 May 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483555; cv=none; b=rpSjiMHN++t96WecvxySRCr+yY8bf4HJo5uHRuTiJEvjkbQHmqQSkEYS9shImrqn2XJJF4nuKLDMUh/Dfj1qJOfRGsG63/o8cvP9CGQnHyyNXARm19PWYuogyOH84AG2S9mrQrLdEDPRW6bL6EetFnSrJbkMXlxILm5hQ/sRPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483555; c=relaxed/simple;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdGYcCwC+2kqFv952eLhOMO/o8dC9bpkjgfklPW+DZE7cWOxEmmXn4e9Lh4hOapVC7rM4ZRfW2lW3OddhJBM7PoGbnUv+5orQ8lQGkBlLM8Q804BvLJJRVZDdwqKJLpxacYEwyex2fdau7OXYFNF/0z1CxMmM3OuKaJXOFLS2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNulUB5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C3DC4CEEE;
	Mon,  5 May 2025 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483555;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNulUB5AU7oz9HvkwOwQ5rAhGoIE+OrXEy0iQgktSpwJNv5uow5EKgRQOx6+Mfeyz
	 H5nrD5zZKOqaKLJsDNoF1X7I6fTQ90gCDChzoLPgMfTftMBnuRVuu9WFMJoE5bHHdS
	 yThXZMzUDgSWjBIahFzgtk1Qd1YnMevDR5vsU9PUFl4U4OmwaR0s1IzDaL2b27pSzj
	 Qoo7i/e4XDxOod9hFwuPkbRNt3dtP+LP3QGqsXvFOTzLwsjOoIU0jEnzR9HeRMhuT3
	 YW4qyCGcxoEac7PnUw4+obMiJQz/9ApR3MjLgE7D/B2pW+VkwHaKyhzSlcfLlIexwX
	 YMu+KOy7a++Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 113/642] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 18:05:29 -0400
Message-Id: <20250505221419.2672473-113-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin@sipsolutions.net>

[ Upstream commit cef721e0d53d2b64f2ba177c63a0dfdd7c0daf17 ]

Doing this allows using registers as retrieved from an mcontext to be
pushed to a process using PTRACE_SETREGS.

It is not entirely clear to me why CSGSFS was masked. Doing so creates
issues when using the mcontext as process state in seccomp and simply
copying the register appears to work perfectly fine for ptrace.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Link: https://patch.msgid.link/20250224181827.647129-2-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/os-Linux/mcontext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d281177..1b0d95328b2c7 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -27,7 +27,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
-- 
2.39.5


