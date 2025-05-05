Return-Path: <stable+bounces-140475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17344AAA91E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2531116FB19
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E129A3F5;
	Mon,  5 May 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0JIAJ6K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC93589DA;
	Mon,  5 May 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484946; cv=none; b=TdbDqifCfh1nETEpE98eynafnvrYl8zMepNrOXaKSLiJoyzxCnGiB4ijFozPGc3x1GVkLy88Yqk0Kp8PzeAuvj+jmHkl+wFEXdwom89baKm0pWENenKwp1ElTZyBLfJNbw+alLmzzeB6bhh6Y/H+UBNoSNd1PJ82Rd8sO+DoUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484946; c=relaxed/simple;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKG0X12RePBYzAGeL9ss12OBWEQ0Ly9Obi/N0HPF4/R6o/goIEnIl6XwXPyZBSjSDEqkLVE6XfGbXLaRlvYtyZiJPav4Sl8fZ7TQcAbty2bzQrbRNCsGS8LJyZmwBI6AYsTVS+6EOrBOfFHl9r0TDSdiN9ZyacJJkIFyuu2L9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0JIAJ6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A3C4CEE4;
	Mon,  5 May 2025 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484945;
	bh=9weVegpYXoQ9xLpHIcIuPVDiPw1gpg0ij9gTTrw3cNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0JIAJ6K2O/McaKT/B1QQHdMVTaQFecF5DCLtOfC+xz3q8G+U53zygMuH8g6QF5Wv
	 nybzDppBBlX/EYPT4qofgS8MgKGXHoaWUM7jQZZuDDzjDDPRvaxZ8KjTlqCMfbhYBz
	 tq9A12LreBMTIl8gyNz6PehNTAZENKEhAYpUSL2lAkJQiXBvObu0VwBy3DeDZAaaC7
	 W9Ns1kXSCPd49ZajU7tqLBw8LpESXgQIjTFNlp8an0MYgmCPG1yWTcqssvnfPRZh2U
	 cJv22t7zU1wtdU1SIgAEr8iyIM3EBOx6ajeltcVm/w9DD21Y+F5w4kvMS+XSOJj4de
	 c90iDNzKP/s/w==
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
Subject: [PATCH AUTOSEL 6.12 089/486] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 18:32:45 -0400
Message-Id: <20250505223922.2682012-89-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


