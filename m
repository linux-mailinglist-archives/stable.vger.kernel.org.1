Return-Path: <stable+bounces-220174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBfqFdgto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B66D1C55E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD609312D9C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCA4ADD96;
	Sat, 28 Feb 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQD9cKZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30F4ADD8C;
	Sat, 28 Feb 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300082; cv=none; b=t4IuEojhvA0yuD0lUUGUov1yy5eoFzc7sCz6wldQ4cLNVhNzC5/u622ASniDi7SXf4fjvJUKPMZMUqdTgOTc9ib67JAUYhRvKMXxmWK4CEKNEETp8dV0IGLXjnZSV6/eojuNm6F7msm9ndtDGHV0KpRqNwIknhIzzPqvvCGltG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300082; c=relaxed/simple;
	bh=zz3M9mpjhNOrmlHz15hpQTc3IFIDCq+wlZspWI8Z17g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omftgbZRyeUDSNvif4FrBXMnj8jWimquIPMoiOsiyziRTALgg86SthQwNMVQci2QgpojRRndZcvjUw46BPSySalMdKOHU6kDe1ij2lAbFi2PvbL4YgmGmNqJcBHAx53hjn74p0OeC6cbaOHAtqovCT4janR5qMC2QnR77LfYZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQD9cKZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E67C116D0;
	Sat, 28 Feb 2026 17:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300081;
	bh=zz3M9mpjhNOrmlHz15hpQTc3IFIDCq+wlZspWI8Z17g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQD9cKZobvxZnEhvXs9fO/FeubGacBApnVT5fZSTLa21qSmRE7gDk+9+jiLSefdaX
	 aT35aXJbArqXT/XA8p8i63nVUCtPAxPtnQW7IlbgJ1Zd4YY+aZI5mqi3oPqStruZm1
	 8kEoJNKDZr7h+QwLYht7p6k1mtwbV5KANCz2DcGjNX/YhbIMqoJi/D8cUkcY2qN1Qy
	 m9sdq5pYEn/as5zJLMMmnJlmqeMejlWTuwFSCwVyiOuRL9RKQYxWu4W+syCtobi3YT
	 gztPDPYwk+EtuM8fskVy+e3CoaFDqE99VgkSsjOBgvv9mgTRqHldE/0WJYyC6UphCz
	 P7IMlMCShoixQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sami Tolvanen <samitolvanen@google.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 096/844] gendwarfksyms: Fix build on 32-bit hosts
Date: Sat, 28 Feb 2026 12:20:09 -0500
Message-ID: <20260228173244.1509663-97-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220174-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B66D1C55E7
X-Rspamd-Action: no action

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit ddc54f912a551f6eb0bbcfc3880f45fe27a252cb ]

We have interchangeably used unsigned long for some of the types
defined in elfutils, assuming they're always 64-bit. This obviously
fails when building gendwarfksyms on 32-bit hosts. Fix the types.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/linux-modules/aRcxzPxtJblVSh1y@kitsune.suse.cz/
Tested-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gendwarfksyms/dwarf.c   | 4 +++-
 scripts/gendwarfksyms/symbols.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 3538a7d9cb070..e76d732f5f602 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -750,6 +750,7 @@ static void process_enumerator_type(struct state *state, struct die *cache,
 				    Dwarf_Die *die)
 {
 	bool overridden = false;
+	unsigned long override;
 	Dwarf_Word value;
 
 	if (stable) {
@@ -761,7 +762,8 @@ static void process_enumerator_type(struct state *state, struct die *cache,
 			return;
 
 		overridden = kabi_get_enumerator_value(
-			state->expand.current_fqn, cache->fqn, &value);
+			state->expand.current_fqn, cache->fqn, &override);
+		value = override;
 	}
 
 	process_list_comma(state, cache);
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index ecddcb5ffcdfb..42cd27c9cec4f 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Google LLC
  */
 
+#include <inttypes.h>
 #include "gendwarfksyms.h"
 
 #define SYMBOL_HASH_BITS 12
@@ -242,7 +243,7 @@ static void elf_for_each_global(int fd, elf_symbol_callback_t func, void *arg)
 				error("elf_getdata failed: %s", elf_errmsg(-1));
 
 			if (shdr->sh_entsize != sym_size)
-				error("expected sh_entsize (%lu) to be %zu",
+				error("expected sh_entsize (%" PRIu64 ") to be %zu",
 				      shdr->sh_entsize, sym_size);
 
 			nsyms = shdr->sh_size / shdr->sh_entsize;
@@ -292,7 +293,7 @@ static void set_symbol_addr(struct symbol *sym, void *arg)
 		hash_add(symbol_addrs, &sym->addr_hash,
 			 symbol_addr_hash(&sym->addr));
 
-		debug("%s -> { %u, %lx }", sym->name, sym->addr.section,
+		debug("%s -> { %u, %" PRIx64 " }", sym->name, sym->addr.section,
 		      sym->addr.address);
 	} else if (sym->addr.section != addr->section ||
 		   sym->addr.address != addr->address) {
-- 
2.51.0


