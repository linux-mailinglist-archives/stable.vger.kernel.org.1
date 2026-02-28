Return-Path: <stable+bounces-220422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OAvDwZJo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:59:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 959731C7AE1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CB91305F541
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25383B232C;
	Sat, 28 Feb 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECx+igH+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5D3B2321;
	Sat, 28 Feb 2026 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300312; cv=none; b=dMdrGw5HagTlmHC5IKtXO/NKJmGYE4ue0gNZjJRRmP+kP3BBy4Zmt/pOrT6e41ZzXhWxX1I1ApmyANZkLgJ9mIfqFCEjGeQLFIt44ZEqJ9T3VKI120PBps8lORWB3DD4bZle7WzoppFJop+RJSmJ+sOlsgcD+v/1XfpsoKfdbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300312; c=relaxed/simple;
	bh=FTnfptXU6GfqP6kpcpXunaUsnAH5Vacm9bOsUQdIZpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec9pohaNLusE2m3y6xywny4QlB1Tx4EqJqpzlQhf7dcHYeEE7E6dQAZvv5tCAGZn5oaT6n0/AOFTsma5xMg5nI1UdQf5fbt+XF75rKn2p3e8nVbo3yUxTWcyXiu45WZJ9lI4zJaXiVErR8EmyGgBpPr58osXL9mxULRVolz+N1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECx+igH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB35C19423;
	Sat, 28 Feb 2026 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300312;
	bh=FTnfptXU6GfqP6kpcpXunaUsnAH5Vacm9bOsUQdIZpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECx+igH+/J9EmzjLOWkOtitWu8Z9LBmBN/dMX/tRZvqVDPnNFfHzVpaP0Zejq13C/
	 FH1x2NhTd4X6iNG5EBWGqQ4mZNLFEBohJ7ZkeiFSxJwZ+agjmy481VMwwyYBJS/zSe
	 07UxG4aZwysF4YgOPyejE9DmS/L03Uiws7LgZrRZVpgQJrIFKqVSBnKYx4Z50Flrwv
	 vtwXbmXF2ZrY+5eOHzryVxxCy8jdThE1jufTn1XB8r9bAujFqu2zqh0/I9j5xQtF4k
	 dx+4q6hWaBkUG1+ynTY3ek4u+7LHlkUn5/VU92u/fwYixPxCluX3MkAx6JH4PzUgfV
	 Z7eJFY0qMEdig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 343/844] um: Preserve errno within signal handler
Date: Sat, 28 Feb 2026 12:24:16 -0500
Message-ID: <20260228173244.1509663-344-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220422-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email,antgroup.com:email]
X-Rspamd-Queue-Id: 959731C7AE1
X-Rspamd-Action: no action

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit f68b2d5a907b53eed99cf2efcaaae116df73c298 ]

We rely on errno to determine whether a syscall has failed, so we
need to ensure that accessing errno is async-signal-safe. Currently,
we preserve the errno in sig_handler_common(), but it doesn't cover
every possible case. Let's do it in hard_handler() instead, which
is the signal handler we actually register.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20260106001228.1531146-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 327fb3c52fc79..de372b936a804 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -36,7 +36,6 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	struct uml_pt_regs r;
-	int save_errno = errno;
 
 	r.is_user = 0;
 	if (sig == SIGSEGV) {
@@ -50,8 +49,6 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 		unblock_signals_trace();
 
 	(*sig_info[sig])(sig, si, &r, mc);
-
-	errno = save_errno;
 }
 
 /*
@@ -207,8 +204,11 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
+	int save_errno = errno;
 
 	(*handlers[sig])(sig, (struct siginfo *)si, mc);
+
+	errno = save_errno;
 }
 
 void set_handler(int sig)
-- 
2.51.0


