Return-Path: <stable+bounces-258123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP3SGrgkG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:56:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84855610ABC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2FAE30D8CFB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB93AB482;
	Sat, 30 May 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx202YML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD319D8AC;
	Sat, 30 May 2026 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163293; cv=none; b=eDz05Mgm+wRnqixwBs1dXCGiwDnDO2leouZDOJpiqfAunFQY6jndHRHluIxmEqbnyXQLvSD7inqTkWGUHT8GY58iykvZqOlgt+AgNZuIBVl1eZmld8hnrNwLDuazoNZu9O+ZS5j0RWWyzd2H8uaRyE6HVjwqKnm9AlS+6h8yIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163293; c=relaxed/simple;
	bh=JxzZfeYk3c/CosuIenSeELbUIgJ/EDHmvmJaz+HKtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHBXzhWsCfDwPrFnmgYfSmJIYsvfrttzUNzaVFU7XKIQC8QbtsUhqzRMoQ9nHTD1Xlv3J2Fm980zN1UbKbpuZo6GVwy4wUygdr5ZypQk+wJlVwELHl5C/unoYltDdkYU/BFeNB6Ri/Ooz7n/6QTMkpyODdafa0rQrJ/D927LDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nx202YML; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7048A1F00893;
	Sat, 30 May 2026 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163292;
	bh=qLkhRKfvPIbSWZ7Z++MZuLOMNg+4D9v9vQ0YqGcD17U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nx202YML6AZN/chzQKQ/r2AzVVk4vwz0lalj0/NggR1KAs1joaRSnjAc+pa9djHR4
	 jsruNxy83I/L91/yiC1xPhJJL0nW375cb8NM8bGEtjnC7Aq2gRtCW4dERmASd291nw
	 me74IzDqts7qE3XqedeFiRC3ZDp0CWO+EF1OlLJY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 197/776] um: drivers: call kernel_strrchr() explicitly in cow_user.c
Date: Sat, 30 May 2026 17:58:31 +0200
Message-ID: <20260530160245.598754959@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258123-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,sipsolutions.net,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sipsolutions.net:email]
X-Rspamd-Queue-Id: 84855610ABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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



