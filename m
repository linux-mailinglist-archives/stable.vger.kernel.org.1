Return-Path: <stable+bounces-266601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Jp+M8X0MWoztAUAu9opvQ
	(envelope-from <stable+bounces-266601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25B695EBC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bFiEfNYW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266601-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266601-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35A43131DEA
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 01:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9229D294;
	Wed, 17 Jun 2026 01:13:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13472DECDE;
	Wed, 17 Jun 2026 01:13:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658792; cv=none; b=a2oN+f/v+m5U/FNlaTCzrV1SztukJaon6kCvwvSCGnU2N81NlsB/Z11nplKMZ9wOBW8id0pDrHGeNU4v7UyBjnoX9ItHGxa6qNYDtGvL0Sa7LWhOaaUqgY3N31EYTRmxuWG2FmbphjdthWnryBTlCs8zbEg/p+6oActfKMlKAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658792; c=relaxed/simple;
	bh=lJS4Lr2DMeso/p7noic83xPLk5vlFPh5umlIeGag2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilvtVgIZNRNsFdr3ho/K/564lj7yJb3hHKuJ2TB02/msolSx8YEuIQrog63os/TY1jEWrKYMBa85sURrmakxbhm0Tmp6vX40rjgSfuojMDQ1F74eh8561wM3kol7oYbm+Pw+j1LZcEpPNZsJQmW3/ACOdOgiqilnoJoxgP+VA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFiEfNYW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658911F000E9;
	Wed, 17 Jun 2026 01:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658791;
	bh=wrnde2OJqwUpd6m+jvjgM6T+I6w4Dvvp+6fyFS/ZWaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFiEfNYWrj8CyLou5sBVI77e+eIs8v2elfoVGodFIluztC2De73npX/wYPgHwXlWy
	 HSkAUObMPrvyTwtjV2e27+sH/5Y0CuOl7C5QE21eS5tw8gSc2XVjndtekrmD15QkAY
	 9hh1Lmz3eZrFpfhWzlwPiL14L8gg2AcY8JQargXhKfYtqUpItgZUPhS2Lp6ChiAex3
	 HiGUfndAqFLXwrw/G8NdhPsic9QLQJ5NK71ZaronXTQ5YFRp+9ScKPYJdx/jIZyKfm
	 Sy7NQY0gpmIKVsLRXvepGLkRdACJVbrxoUwplNSQKSFr3hUB1ZP0RWAu1IOODwj0yS
	 Jet/1jauQSEWg==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	x86@ekrnel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
Date: Tue, 16 Jun 2026 20:13:01 -0500
Message-ID: <20260617011303.3969027-2-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617011303.3969027-1-clrkwllms@kernel.org>
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bpf@vger.kernel.org,m:x86@ekrnel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E25B695EBC

[ Upstream commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 ]

strchr() now propagates const when passed a const char * argument in
newer GCC/glibc combinations, causing -Werror=discarded-qualifiers to
fire on the assignment to next_path. Declare next_path as const char *
since it is only used for pointer arithmetic, never written through.

[ clrkwllms: only the next_path change from the upstream commit applies
  to 6.1.y ]

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7bd6aff6e260..33b214a91338 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10748,7 +10748,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.54.0


