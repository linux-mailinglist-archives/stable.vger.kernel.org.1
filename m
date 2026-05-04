Return-Path: <stable+bounces-243359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L0kKjep+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9D74BEC54
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99555304B985
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861023DDDD6;
	Mon,  4 May 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pb5NUSSL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804D1ADC83;
	Mon,  4 May 2026 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903683; cv=none; b=rAd2mzWjVnoOX0wM6R6pY20kotRPVidcoTzoo316zbzRDd3AXhAqJ9hD1rHOBvqvJAwk7uYO05xcPnydBF5zhPtyLqndQScSQQi42LWuldrx+MdfB2pDjGYOZVpN8jBU/D3diiuD5WMbbGWx+LVe2DURcfZ350bsgeStYuZ8hZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903683; c=relaxed/simple;
	bh=ghFt9ZGYO2xYnudN3SVViW48i9qDZN04/GSlNWA2ytU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW4SiVnWOgvAa++p92CzVFnMhk4/QvXNP2xNMX015T2oA3tRxkm0dbJ3ee9nB28snQdqV8z7ooh9ON4lhcpo1+X1XBxonIZJP4WO2e9jwma///ucQ7NH4tlVMOdNVJSTXd6VQn48l53k2jQYiK6oJD1HEs2nRmWu7DoKtgOvp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pb5NUSSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AE0C2BCC4;
	Mon,  4 May 2026 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903683;
	bh=ghFt9ZGYO2xYnudN3SVViW48i9qDZN04/GSlNWA2ytU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pb5NUSSL1cRNckPUqlAvwwrcH83tragGw/KDu+PVhwJfD8obBAt+EjZACLbr5Lf9c
	 WQ/zZEMyPeQgfPkd0TruEA02qUInROU/+JiiZCLlN4M58iJeNYaQLBHAiYii/0St7W
	 W/ESk7lJWWtHhj4fLmh1VtSXXqxdP6/KXwXWtbD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 008/275] LoongArch: Add spectre boundry for syscall dispatch table
Date: Mon,  4 May 2026 15:49:08 +0200
Message-ID: <20260504135143.248348947@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3E9D74BEC54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243359-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 0c965d2784fbbd7f8e3b96d875c9cfdf7c00da3d upstream.

The LoongArch syscall number is directly controlled by userspace, but
does not have a array_index_nospec() boundry to prevent access past the
syscall function pointer tables.

Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/syscall.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,6 +9,7 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/nospec.h>
 #include <linux/objtool.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
@@ -61,7 +62,7 @@ void noinstr __no_stack_protector do_sys
 	add_random_kstack_offset();
 
 	if (nr < NR_syscalls) {
-		syscall_fn = sys_call_table[nr];
+		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
 		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
 					   regs->regs[7], regs->regs[8], regs->regs[9]);
 	}



