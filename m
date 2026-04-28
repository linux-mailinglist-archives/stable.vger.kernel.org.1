Return-Path: <stable+bounces-241511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEvjAKmB8Gn6UAEAu9opvQ
	(envelope-from <stable+bounces-241511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:45:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EE481C26
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CADF3046E3C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FE3DA5CC;
	Tue, 28 Apr 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3qmyruB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F843D8115
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366950; cv=none; b=MRPYLr+JY8BwNkBinFDdqezJ/jC7tNZfXVa9eiIdbqLsW5Sm3yhDrBdjAPGn0IcXt4CERlbYou0AIArJR93Og9Ir4v4Bu89JwdVNX0TK+MSS+UjGS8azO2CRpkizXKJ20QZvKnjEDIKn+SjvzThsVggv2wBe8zvXxrSAY8gML9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366950; c=relaxed/simple;
	bh=ah1lKBfov9hxlk1IZ1s3wEToN1/ZHsVOy/QkBZqP1kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi7S05PpF8rqvrnzkScIWSlGyR9o+tu0S5TKdpXk/XByZL/tsvK6fjSzuCRDbacwb6DUil7UpsBan0knn2NI8iZ+SkX5Jq2sC/jGVgDJ/JLyLvGM7AU+X1z/qk8cuLawmLWJC3XW+P+7o3BckSrkp1+Qc2WmlSJYeekheNYhM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3qmyruB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C266C2BCF4;
	Tue, 28 Apr 2026 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366949;
	bh=ah1lKBfov9hxlk1IZ1s3wEToN1/ZHsVOy/QkBZqP1kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3qmyruBkch0BGe4xwFFkbHcVZws+mvs9uW7CqBtZSpgUevpDIHnBV7Jtghgw3Pwc
	 E1hGdkp74295+hjiRxH/Vl489ySRpkMYDgon5opQfQ81Mx3TQ8XLGdUYZhTRTzk8wj
	 9LYuMbmXLDXo3X9VQaZ75eBp26MQW7fo96jCXVLc1fgYtuq9jWvMVLnl1Mnzr74Fgp
	 +IZ5lIHEIw39cDiA7cJtFzel8alcrUx9tJUl4VK9+bcs8ntsKRPaAKoI09RxzQ/2jn
	 tWcH3Iu3igae4zKJKwu4HWJwuJ9IIEqK+K7PygOVgqrBCg0pDDf0yCOT0dgx+Hb80W
	 1dlJifyz4aBBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] LoongArch: Add spectre boundry for syscall dispatch table
Date: Tue, 28 Apr 2026 05:02:27 -0400
Message-ID: <20260428090227.2121911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042748-removal-hesitate-2626@gregkh>
References: <2026042748-removal-hesitate-2626@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE2EE481C26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241511-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,loongson.cn:email]

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
index b4c5acd7aa3b3..f4e3bd219b1d7 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,6 +9,7 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
@@ -55,7 +56,7 @@ void noinstr do_syscall(struct pt_regs *regs)
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	if (nr < NR_syscalls) {
-		syscall_fn = sys_call_table[nr];
+		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
 		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
 					   regs->regs[7], regs->regs[8], regs->regs[9]);
 	}
-- 
2.53.0


