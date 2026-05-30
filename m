Return-Path: <stable+bounces-257119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC1+CdkWG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:56:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7160EA6B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF7930BA1B1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6333FE15;
	Sat, 30 May 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euUPLmPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B739D3D9;
	Sat, 30 May 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159870; cv=none; b=p8pHr2/Tk/v3T4IX2Qk+tlLqFX6ZtYhyI+IIiOkHHxZXrfFKuqz5VupaONb6yZRR7FHLoW13pnh9pT9P7WcbUUxMu6U38Du2wopH2HdgcDvnwURhhdYoWnaDtEtqANgUxE9lPcYYBTmmOZRqfo1zd4QrE/eMBehA2/VKU4rqVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159870; c=relaxed/simple;
	bh=H2pLUPfVDn3HKBcXNCHCUdgHz8RbYehOX7TASwr26h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUgZa/S44436kVG/P+ZQW7tkzLGThhRQuBD9VzEKQDVa9bl6eJVkGgXpU6PM5FBFNEf2VrskpzIxvm697EMIZJbWRz3pgmQXxBLNeliVDX6iPYEGyXap1CwIN8sCWdyNj3UDFhY7QgIQiqPBXVtLlMmJ/CnvyKSNJdpfeRAjRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euUPLmPb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D171F00893;
	Sat, 30 May 2026 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159861;
	bh=k0YmWC46Jm7Sj4tBgWKR1ofcxKbZwbiKdfxjFn0j6Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euUPLmPbQIaj+vuGFF5l7OUrsERuVugXWygriEQSWUOeyx/jb51shawfInndSnWqS
	 49fCd7sbICQBPPoONQai1ziWNR0b7sLE56XTdtTJuM93n5C92V5SFwA46YfVsPETBA
	 E8RrA6BSlOqB1hok7tD3m6jho7qwHXkSLqiuBuTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 181/969] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Sat, 30 May 2026 17:55:05 +0200
Message-ID: <20260530160305.491009732@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257119-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,sipsolutions.net,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86B7160EA6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 91e901c65b4da02a6fd543e3f0049829ae9645b7 upstream.

Building ARCH=um on glibc >= 2.43 fails:

  arch/um/drivers/cow_user.c: error: implicit declaration of
  function 'strrchr' [-Wimplicit-function-declaration]

glibc 2.43's C23 const-preserving strrchr() macro does not survive
UML's global -Dstrrchr=kernel_strrchr remap from arch/um/Makefile.
Call kernel_strrchr() directly in cow_user.c so the source no longer
depends on the -D rewrite.

Fixes: 2c51a4bc0233 ("um: fix strrchr() problems")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260408070102.2325572-1-michael.bommarito@gmail.com
[remove unnecessary 'extern']
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/drivers/cow_user.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -15,6 +15,12 @@
 #include "cow.h"
 #include "cow_sys.h"
 
+/*
+ * arch/um/Makefile remaps strrchr to kernel_strrchr; call the kernel
+ * name directly to avoid glibc >= 2.43's C23 strrchr macro.
+ */
+char *kernel_strrchr(const char *, int);
+
 #define PATH_LEN_V1 256
 
 /* unsigned time_t works until year 2106 */
@@ -153,7 +159,7 @@ static int absolutize(char *to, int size
 			   errno);
 		return -1;
 	}
-	slash = strrchr(from, '/');
+	slash = kernel_strrchr(from, '/');
 	if (slash != NULL) {
 		*slash = '\0';
 		if (chdir(from)) {



