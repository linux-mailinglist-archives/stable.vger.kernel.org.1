Return-Path: <stable+bounces-241519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN1iHzp98GkaUAEAu9opvQ
	(envelope-from <stable+bounces-241519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:26:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF24815DB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10D132177FC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE56243951;
	Tue, 28 Apr 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BufhYfE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F333DEE9
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367982; cv=none; b=nv5ZcnJNGsj13j9oncOXS+ON7KoQpjgBmvzY0qkZGw+6KSX5FJNY0P7jPDVsHoILPhXYtyCS76BNhL7e1GwXf2E70aQ2EQpc01yjLHYHyKuVoDKuALb4a+U5rmegy4pVTjmh6/urW6efDn6D8yQ2ZHxFbK9Dj5HjLWEJmi8Yhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367982; c=relaxed/simple;
	bh=rAc/qiSZN94iSJ9KBgHr7Is1blSdGcd+uWk9k4LTuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es5V0caV5ZGolXlOo7AcHWfgMxCpW17hQc79+lthDGJjYTraYxlZNhl1aAXAf5nYahtYsLC4EzdOHKcC5vos6OskO8KgcrMHO/crYgCrDDO3gv+LROFlEAV9EyEF2krx5EQOUE0ykylqqdZgHcd8e4P5bxpPCycFFcYCOu+IU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BufhYfE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B11C2BCAF;
	Tue, 28 Apr 2026 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777367981;
	bh=rAc/qiSZN94iSJ9KBgHr7Is1blSdGcd+uWk9k4LTuL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BufhYfE1arqBX856JQ9INXNHhtzcICOOUha7mvHevEOIFJ+tZ5xF5xhM0bxEeycF6
	 peLCKOgw6fTWZZ1DajbViJz9Ui6JcUkPSw7ZAlMwZuuJL6Fxlr5J80yiXZ5LUUH0MS
	 g7ao9Tkjz1neHW1PaGgxlu9+vHAc2+TvAekk2fjAI/vzEcA6VwdCxnSER2zDyWTF+Q
	 M+LfM08DvWiagLGWrjlxGQQHRLTph0cbwgOKCkXAHa6etWu+5UNWAarINhwfEy0kAa
	 zwpQwhTJHlZXRTbpOCBPFGNJycaEOmGgQeaMhLEQ0gEJEC4aUmy9Twpmvu21a8DXpH
	 asJzExMhmw/Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] LoongArch: Add spectre boundry for syscall dispatch table
Date: Tue, 28 Apr 2026 05:19:39 -0400
Message-ID: <20260428091939.2488103-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042749-drinkable-parsley-6732@gregkh>
References: <2026042749-drinkable-parsley-6732@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAAF24815DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241519-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,loongson.cn:email]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 0c965d2784fbbd7f8e3b96d875c9cfdf7c00da3d ]

The LoongArch syscall number is directly controlled by userspace, but
does not have a array_index_nospec() boundry to prevent access past the
syscall function pointer tables.

Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 3fc4211db9895..37442bceeec68 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,6 +9,7 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
@@ -54,7 +55,7 @@ void noinstr do_syscall(struct pt_regs *regs)
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	if (nr < NR_syscalls) {
-		syscall_fn = sys_call_table[nr];
+		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
 		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
 					   regs->regs[7], regs->regs[8], regs->regs[9]);
 	}
-- 
2.53.0


