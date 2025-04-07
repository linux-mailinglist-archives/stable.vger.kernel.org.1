Return-Path: <stable+bounces-128620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563CA7E9F2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9028188CC06
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55D2580C9;
	Mon,  7 Apr 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpAnxmvV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E39257ACF;
	Mon,  7 Apr 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049509; cv=none; b=l36mSNQHhHv49PwEnEUSm2QzMumbuRPdlFMERGrRemQv/+r80G5NWtMT+cTZ5jcfxmoYjQRP1cFpO/u1DzW/ufq2oKAoSUYOfagBVZ4BNcCCKtbDDqo/cqyxPTzZOIrmj+mxBN1DBUZWag8pbMSC7lbBKNZPN2X2LKZZvt6n62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049509; c=relaxed/simple;
	bh=uQ9BX1Anrr185nCbF9o0UfRIAVFd3yOMLRqLKUlV05E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1rKJ2+DIuFj5j7+Zqr9jIs4BB2gV4gVIfRBS/jenycCGoHmqVZfepTitRKK3fIUmfB9xzhO5sKrFJxhfFejD8uFpt72JQXNzXGZ/d29m7gmPjfcRAf3jR7ndLG0pjz7a/pLZtMOWT0/k+zj+mhs+p06USj89QIixnJHpyyMyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpAnxmvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C4C4CEDD;
	Mon,  7 Apr 2025 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049509;
	bh=uQ9BX1Anrr185nCbF9o0UfRIAVFd3yOMLRqLKUlV05E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpAnxmvV1vsUpz/fpBuGnvMm5CPHxwy0/lnaZaJzXQYi1lZJm9qo02mmQPNuDMMGR
	 vsqN07xtFMPtfVD/FK/NKXwaUQrXVa9lhzUVJBcHmsQ4ky3UJUpgtnpvkcEmtwU2IL
	 mc0aZDB9KLNW2u4J359MP/Zn5VFB3GuHzzL7NR+aQJp9w9UF8TJOoVwZQPlHWTsPke
	 RcvZN9IbU2sVahkhZPeA/NJqIHkScD1GW+Hov6YahLpswjG9WSgdd2VwKtzGe2zODL
	 lHQhJl5YVEbLvX4LG+oAlXHQzoxjmIU1FVDkMDEnb3PltWPc4iPPHMKPgq03UZVsni
	 rM87VHO6H4ZAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 23/31] um: work around sched_yield not yielding in time-travel mode
Date: Mon,  7 Apr 2025 14:10:39 -0400
Message-Id: <20250407181054.3177479-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 887c5c12e80c8424bd471122d2e8b6b462e12874 ]

sched_yield by a userspace may not actually cause scheduling in
time-travel mode as no time has passed. In the case seen it appears to
be a badly implemented userspace spinlock in ASAN. Unfortunately, with
time-travel it causes an extreme slowdown or even deadlock depending on
the kernel configuration (CONFIG_UML_MAX_USERSPACE_ITERATIONS).

Work around it by accounting time to the process whenever it executes a
sched_yield syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20250314130815.226872-1-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/linux/time-internal.h |  2 ++
 arch/um/kernel/skas/syscall.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index b22226634ff60..138908b999d76 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
+extern unsigned long tt_extra_sched_jiffies;
+
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index b09e85279d2b8..a5beaea2967ec 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
+
+	/*
+	 * If no time passes, then sched_yield may not actually yield, causing
+	 * broken spinlock implementations in userspace (ASAN) to hang for long
+	 * periods of time.
+	 */
+	if ((time_travel_mode == TT_MODE_INFCPU ||
+	     time_travel_mode == TT_MODE_EXTERNAL) &&
+	    syscall == __NR_sched_yield)
+		tt_extra_sched_jiffies += 1;
+
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 
-- 
2.39.5


