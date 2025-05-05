Return-Path: <stable+bounces-140990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018ECAAAD22
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8771A8428F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A63E2FF4;
	Mon,  5 May 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSrc4YGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4E3AC5BD;
	Mon,  5 May 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487145; cv=none; b=H/dV/xTfqGr/moGzcZ9d9e/7NeQN3KS0hhb5+ulm/3hvCuGFcnNLanSW4I+o6KquL79IpYGp1xXiHmuXCPesWFu4Rb4HhUYRsbByPvsaEjINkB20a56lEuJHcG6b671qZZJKnvGj+X/PDisKg9JXh9Nvb0btW96KR7LR9ldSQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487145; c=relaxed/simple;
	bh=o6vPQm8ORAMEIjP7fhptjMtwSNq9nMRVlWGY99NWjZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xa/cXbGA9fhdIV8nY2Q2IDEKt2mQlfOLHYYdogISreAY63NoYb+A3EyBNATW2t1FW6LcnRdsQmqMu3t9zW8Cuc6lKII6NqZ9lIy8Mz714iXQXI7EdZ+KCKVpX76+vqBs6g2dqma0nvuKGKZb267d8UAzPGnPGCYrrEH47SmJ4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSrc4YGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F2C4CEEE;
	Mon,  5 May 2025 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487143;
	bh=o6vPQm8ORAMEIjP7fhptjMtwSNq9nMRVlWGY99NWjZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSrc4YGQXNcraedU3V9MzwlkEmcOiZF+MaSYYjotDqktpWMZFN++hOvTMeNeFmfzh
	 2yA1SDlJ8HruqWDIzeSgNZvtt28MIK/m6tI1AakTe/KaW0Ot9soVf7kaFjJ4E+xdF0
	 OE5FwOBc1uUzOLtl5W32o/QBSbXs8tZJaXiyco81Iw5TAYC7LGEWOtkXakoHTAnBpF
	 SBQGUL4GQBLvgSOD+j4qWsmY11aR/z6at+dMXoFe4eKG59COieSRzHO8REmMNLl6gQ
	 JHKbfsn7H5L7e7VLUe8vo1Lk5xab6OR1NgNOdW92+a3K+DDAkLI6I2WrGwxd7tvLVu
	 oKDXQOTTM4a2Q==
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
Subject: [PATCH AUTOSEL 5.10 022/114] um: Store full CSGSFS and SS register from mcontext
Date: Mon,  5 May 2025 19:16:45 -0400
Message-Id: <20250505231817.2697367-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 49c3744cac371..81b9d1f9f4e68 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -26,7 +26,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
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


