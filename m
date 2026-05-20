Return-Path: <stable+bounces-252135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNajMoX2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-252135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4946B5950E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A82D5307038A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB093BE64B;
	Wed, 20 May 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1nLSQT7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88036D4E1;
	Wed, 20 May 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299882; cv=none; b=OhqUFjru+apqeTwLMtB2ybrcJdotVKN9guUSbVbeoc66iMtprxuHXTjTMGNkwCXdL6+4CWlfgcnchizspkVhs0jZV0L68hnMtsWuXskt5CwUKGNlOWBhe8JB5eBUiqdxgDI2rLTWbyC1eGbeTcsLE2VSLx7rIXylX9R/LSHQm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299882; c=relaxed/simple;
	bh=k+ZJof8SwwwwVI/ztw17voOsKD4kBHOZSRkkFNG+aeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmZ6r6WW7ZCM+UnHWeTlllKRzgngU1WIsM7T8xXOvQBLBNvIOht8ZHVC/MF3rBPN/Xms8KBH4JmP8YHhJC28LIE2uwDmV7vapb6HgKci4N0Ss3EaOm6ZfV4vZ1PV5NznNgQPy6cbyJnCLHH/6O3brahrDEYsuqpCkN9z2PJpRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1nLSQT7W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BD11F000E9;
	Wed, 20 May 2026 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299881;
	bh=wZr3qP+3IcEDWoY9UFxrDfAMsLCXTMYjPZlWjHk03jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1nLSQT7Wu16sDBAQxvoL+iw2yIRS3Luy72vt3oVviiR5MAtzLGmXv4lIAxlves69t
	 Uxw8IoZGVg8eSf4o+4GjeUcxees0r8LkFAGGnUQ4T/gv5RpZtoJVkFcvs/hX56T2y4
	 paVyhLYs3mMggaTY4CoWV7/vgQXAYQxo8n9Ns56U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rohan Kakulawaram <rohanka@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 6.18 921/957] x86/kexec: Push kjump return address even for non-kjump kexec
Date: Wed, 20 May 2026 18:23:24 +0200
Message-ID: <20260520162154.554155012@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252135-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amazon.co.uk:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alien8.de:email]
X-Rspamd-Queue-Id: 4946B5950E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 786a45757dcdf8f2beb9d4a6db605db16c18b2b4 upstream.

The version of purgatory code shipped by kexec-tools attempts to look above
the top of its stack to find a return address for a kjump, even in a non-kjump
kexec.

After the commit in Fixes: the word above the stack might not be there,
leading to a fault (which is at least now caught by my exception-handling code
in kexec).

That commit fixed things for the actual kjump path, but no longer
"gratuitously" pushes the unused return address to the stack in the non-kjump
path. Put that *back* in the non-kjump path, to prevent purgatory from
crashing when trying to access it.

Fixes: 2cacf7f23a02 ("x86/kexec: Fix stack and handling of re-entry point for ::preserve_context")
Reported-by: Rohan Kakulawaram <rohanka@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Rohan Kakulawaram <rohanka@google.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/32d627134143ffd957891cb697138e839c623211.camel@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/relocate_kernel_64.S |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -133,6 +133,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
+	/*
+	 * Set return address to 0 if not preserving context. The purgatory
+	 * shipped in kexec-tools will unconditionally look for the return
+	 * address on the stack and set a kexec_jump_back_entry= command
+	 * line option if it's non-zero. There's no other way that it can
+	 * tell a preserve-context (kjump) kexec from a normal one.
+	 */
+	pushq	$0
 	/* store the start address on the stack */
 	pushq   %rdx
 



