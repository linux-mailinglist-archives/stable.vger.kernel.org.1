Return-Path: <stable+bounces-265122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lf9hEuuEMWrxlQUAu9opvQ
	(envelope-from <stable+bounces-265122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2BE692F20
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GvnvWIxa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265122-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265122-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0953316A41F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4C47799B;
	Tue, 16 Jun 2026 17:06:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AC376A19;
	Tue, 16 Jun 2026 17:06:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629579; cv=none; b=EbT7M3UOJGzoycwLyFy8h4BJUPQIfSvs0NLMaNbxURMsWpes86qs7SkzJXf+29PlD0abu7OrRHovFTG9y5dtURn0hNST6NPhymM+ds6DeWEP0kxSJR031Ituv48ezSZdgkZcduFup8nekOVAVuclPhGWSyOdWtZSN3bKp2dzXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629579; c=relaxed/simple;
	bh=VKaZTw0gorbhMWE1OTvhN6LFZAzJivYnSd0Vl7GgjxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz+/jOEJAoqGIPNusO36Grh1xuDzLtcmNSKgebf9Ir4LZBCutcglrwzlBPPADmWkhHDzKnKTNOzcrey/iPo6jaA7EAQdaY43ke/aKjDADRU1EEJ6tv4hwCwVm3xpGyioeYtVD/C1kRHqhkRAp8VeK9s1lZDj+aTvMWWob4PsdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GvnvWIxa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389401F000E9;
	Tue, 16 Jun 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629578;
	bh=sHUjNt/iGJZeSFl71XXehqpf7YeDM8jPykXIkMtQooc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvnvWIxatByh0haRFSooJlF1uQMt6vEwaI+ikVguiWFul35yqdMajtXrJdkUiUJSU
	 zsXs/bzwAzfAjj7LSXY/GA9hnIMfbtsLPVcOJUjKUroI4UVCz2poHBrPh1z2A2N5us
	 32kYcvrd6OSTtOzuBtghbu/zvduJ8nbhwM4r0GSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 6.6 313/452] ARM: 9475/1: entry: use byte load for KASAN VMAP stack shadow
Date: Tue, 16 Jun 2026 20:29:00 +0530
Message-ID: <20260616145133.954270149@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265122-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kmehltretter@gmail.com,m:linusw@kernel.org,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E2BE692F20

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karl Mehltretter <kmehltretter@gmail.com>

commit 77a1f6883dc6e837bb2cb30b9b02e2f94338e2c6 upstream.

Commit 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from
VMAP shadow") added a dummy read from the KASAN VMAP stack shadow in
__switch_to(). The read uses ldr, but the KASAN shadow address is
byte-granular and is not guaranteed to be word aligned.

ARMv5 faults unaligned word loads. With CONFIG_KASAN_VMALLOC and
CONFIG_VMAP_STACK enabled, ARM926/VersatilePB crashes in __switch_to()
with an alignment exception before reaching init.

Use ldrb for the dummy shadow access. The code only needs to fault in the
shadow mapping if the stack shadow is missing, so a byte load is sufficient
and matches the granularity of KASAN shadow memory.

Fixes: 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from VMAP shadow")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/entry-armv.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -561,7 +561,7 @@ ENTRY(__switch_to)
 	@ are using KASAN
 	mov_l	r2, KASAN_SHADOW_OFFSET
 	add	r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
-	ldr	r2, [r2]
+	ldrb	r2, [r2]
 #endif
 #endif
 



