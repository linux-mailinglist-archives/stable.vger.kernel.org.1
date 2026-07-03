Return-Path: <stable+bounces-271835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s2d1J3vqR2ofhgAAu9opvQ
	(envelope-from <stable+bounces-271835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:59:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF5704753
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=iaNmMNlX;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271835-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271835-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 527BB302B801
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018E530AAA9;
	Fri,  3 Jul 2026 16:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4862BF3E2
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 16:59:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097946; cv=none; b=RTW57xSm262B4yZsf+mjrxgo4jFHjUDMUeHMbifVvpYrFYTyxoQhWxNpEfEdSYyX49S6i1a4l7jHaehxn1oKqQKqoS/ss7zwKGEXXxQjq8AX9RE+DbghuL+R4hWoInbudVtPfF2I1dd4Gtvdjjn4IJBLqoSG4HbUbyPm6YlpFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097946; c=relaxed/simple;
	bh=8Sh0ZapBO5HhbmK4razIBjbrZy74H3yVffS4gyHeCZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKe2AsUTPMb6AEI7VbGODWxotlOgPUrS7WlnlBWvX8Pzxw8XGCI8xAgLtfBfe5QFOCBQvMpBo0zKrvdyiONFC2dl3uQK4zi3Drygt4P3vBYCMOU7sQ/3nxRNmF2S36HT8Jd/5wCJrRYLfTjffEPIqOdna5y6CXEBIEdNWUC+XQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iaNmMNlX; arc=none smtp.client-ip=91.218.175.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783097932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4FgBAGOtVqoAkgaBXGYo/0h+uTit4LUDfTjDWMATQQ=;
	b=iaNmMNlXIEED9kIXU6PpvwnZkav0b57801IIiImrQyKbHL0nVWWrXO9H/Nw2E7oeY6Qm1x
	gLMZEX634nh1ino0Btv5Z169gTAILFomD8qgMqCrf75Q5rznqLZiGsO4FORBroqWJgBWOD
	x5KwJwRG4hBHTWRbA1nCFiaCEFqI9ls=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Fix repository.c build failure
Date: Fri,  3 Jul 2026 18:58:35 +0200
Message-ID: <20260703165834.137242-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=thorsten.blum@linux.dev; h=from:subject; bh=8Sh0ZapBO5HhbmK4razIBjbrZy74H3yVffS4gyHeCZw=; b=kA0DAAoWXqtxINjMdS4ByyZiAGpH6jui18HJkbScRPepAnHtvHj3W/d5KSuRwpr7dc0afx8Aa 4h1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmpH6jsACgkQXqtxINjMdS6ijgD+LFmq TZ5L2ZMYVnIAec2nci4G4Ot/KT5LRhXOBex8CRQA/j4GER9ut3jGx9ghyxZalV/D5Py2EHh346r rYGcHUFIM
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271835-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:geoff@infradead.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:justinstitt@google.com,m:kees@kernel.org,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,google.com];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DDF5704753

GCC fails to build ps3_defconfig with the following errors:

  arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
  arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
     78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
  arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
     78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
when text is a short string literal that is smaller than sizeof(n), such
as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
sizeof(n) before memcpy().

Drop the redundant char * cast while at it.

Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/repository.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index b8c030eab138..0cc755ac3e7f 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -6,6 +6,8 @@
  *  Copyright 2006 Sony Corp.
  */
 
+#include <linux/minmax.h>
+
 #include <asm/lv1call.h>
 
 #include "platform.h"
@@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 static u64 make_first_field(const char *text, u64 index)
 {
 	u64 n = 0;
+	size_t len = min(strlen(text), sizeof(n));
 
-	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
+	memcpy(&n, text, len);
 	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
 }
 

