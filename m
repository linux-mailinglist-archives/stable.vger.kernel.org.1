Return-Path: <stable+bounces-263916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8PYXL9VqMWpTiwUAu9opvQ
	(envelope-from <stable+bounces-263916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:25:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C012691017
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:25:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Y1f36262;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263916-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263916-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510633125256
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DE43E49F;
	Tue, 16 Jun 2026 15:19:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0D43E49D;
	Tue, 16 Jun 2026 15:19:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623157; cv=none; b=WVCk8CshzfUKIEnMVn5tU1UigrtO6tkfJ4TnvwHCm41TsQP4Qwyr8wCJUCkMivD6MSPlC5mQJlTpTYt+8W2Dh7A9jcczuZEmUlY6sMMGYEpIibR29SgVt32EKeNxILcC3uAguHTbf9Blo+2VCQz7L7WlaZZoKSZHkNHUqkU3KfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623157; c=relaxed/simple;
	bh=p3sZAr/SyrMs3Y9Zg6GT+7tgEP6TWYNkZ2ZkKxRlAE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfsLqAUFwn9OHAhhE1K9KOPnOhfafSC/5TQR1/mZvkBSJsUQFtZNgs0kZPpuB0TygfxG6cQuQqGeQFS2B2toHZNCFXlllFseM1P6T61f8c9mbL9QxkEz3inCyLf0DfxzlFCk6rl92jlsKfBlh+h5pQaAoG6cKZgZKCceg0DUTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1f36262; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB81F000E9;
	Tue, 16 Jun 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623156;
	bh=AeRLlcAGl0vs1ujdhh33h03sMlj+PVFoMKpWPv2N/WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1f36262pXNwmOnU4ikhgmjBfF85iCsNDhyQZx3vm8Qdl93oiZgpj1xVqfUzTXfe4
	 buO+Mbv9juEhMRxNuHdiHyy5bNhzITYIn1vJFn6MxAWGg5w5sMbcn/yFj+sHf7QOTJ
	 SI1lXBQfmNpPRnSKqCg7b6ecoA9L/wPD253AyMfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Patel <ripatel@wii.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 097/378] riscv: cfi: reject unknown flags in PR_SET_CFI
Date: Tue, 16 Jun 2026 20:25:28 +0530
Message-ID: <20260616145115.399443909@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263916-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ripatel@wii.dev,m:pjw@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,wii.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C012691017

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Patel <ripatel@wii.dev>

[ Upstream commit 15b4155138505669d3d43d7692459ee8ea2a86e7 ]

prctl(PR_SET_CFI,PR_CFI_BRANCH_LANDING_PADS) silently ignored
unknown control values. Only PR_CFI_{ENABLE,DISABLE,LOCK} should
be permitted.

This changes the behavior of the uABI (fails previously accepted bits
with EINVAL).

Fixes: 08ee1559052b ("prctl: cfi: change the branch landing pad prctl()s to be more descriptive")
Signed-off-by: Richard Patel <ripatel@wii.dev>
Link: https://patch.msgid.link/20260518183918.322545-1-ripatel@wii.dev
[pjw@kernel.org: change the patch description to note that although this is a uABI change, it does not break the uABI]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/usercfi.h             | 1 +
 arch/riscv/kernel/usercfi.c                  | 3 +++
 tools/testing/selftests/riscv/cfi/cfitests.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index f56966edbf5c62..61ee02cee29720 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -50,6 +50,7 @@ void set_indir_lp_status(struct task_struct *task, bool enable);
 void set_indir_lp_lock(struct task_struct *task, bool lock);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
+#define PR_CFI_SUPPORTED_STATUS_MASK (PR_CFI_ENABLE | PR_CFI_DISABLE | PR_CFI_LOCK)
 
 #else
 
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 2c535737511dce..1ea86f21fbfa61 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -476,6 +476,9 @@ int arch_prctl_set_branch_landing_pad_state(struct task_struct *t, unsigned long
 	if (!is_user_lpad_enabled())
 		return -EINVAL;
 
+	if (state & ~PR_CFI_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
 	/* indirect branch tracking is locked and further can't be modified by user */
 	if (is_indir_lp_locked(t))
 		return -EINVAL;
diff --git a/tools/testing/selftests/riscv/cfi/cfitests.c b/tools/testing/selftests/riscv/cfi/cfitests.c
index 39d097b6881ff2..0e3943461e7d83 100644
--- a/tools/testing/selftests/riscv/cfi/cfitests.c
+++ b/tools/testing/selftests/riscv/cfi/cfitests.c
@@ -141,6 +141,12 @@ int main(int argc, char *argv[])
 
 	ksft_print_msg("Starting risc-v tests\n");
 
+	/* Test unknown PR_CFI bits */
+	ret = my_syscall5(__NR_prctl, PR_SET_CFI, PR_CFI_BRANCH_LANDING_PADS,
+			  PR_CFI_ENABLE | 0xffff0, 0, 0);
+	if (!ret)
+		ksft_exit_fail_msg("PR_SET_CFI accepted reserved branch landing pad bits\n");
+
 	/*
 	 * Landing pad test. Not a lot of kernel changes to support landing
 	 * pads for user mode except lighting up a bit in senvcfg via a prctl.
-- 
2.53.0




