Return-Path: <stable+bounces-250179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADKXHYQNDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:37:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E097F59881B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0E8334FAA7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F436A354;
	Wed, 20 May 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ConRCf8A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD450366542;
	Wed, 20 May 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294751; cv=none; b=LFlJjlJdiXH8j8AvTbfPwv3Eu4mKOgZBT2aZiAR4lyUGS/O/sqdRc+nepZ3N+0tkwyQdgbhyfDg343OyFWtPOPnNwTTu8hpG7MsEZh5no4VSHsV0TSO25aN81AIE580ECJcti8PUWpW7uK3ko6Vkawu1eOhVKbOn8/FhgTM/AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294751; c=relaxed/simple;
	bh=mJ4Zk2/n5ikigvqBfzEgxz7wRQ27vsZDO8NjDpUbnts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E75f4nGZVFyh4Yzq7fh08qOfHNQRPH1YVa/CP7SmjgcIPpqBtDqgH8SpW3UMrgOAoHe8Uhx0xeK/39QvVpOK7KC3jsdqkOSe4R94fd72bIEZFSg7jSaWoa7zoWTsTmD/ccl7dn7bSLXHHBChnaQLLDJ2MqoC38iLMeftUYf1HB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ConRCf8A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E44D1F000E9;
	Wed, 20 May 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294750;
	bh=l60iTYtQnxaeGhilKuhiVHCYJdooq9OteLW97aCWY+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ConRCf8AAcH77uDqAHzQta3hLRR3hoY6T/GkcAieMgM/EPvWsNode9JYNnDb3KeR8
	 MHzdd6Sr3Df3Dj/ARb+JXAx6cyq79YdVwHxQUesRr8oByLCQduhGRu/Xq0uU5IikiW
	 hWEBrUeNnqoR2J+ehdhwb0fWMl+3QviMXB7BYLqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0157/1146] bpf: Prefer vmlinux symbols over module symbols for unqualified kprobes
Date: Wed, 20 May 2026 18:06:47 +0200
Message-ID: <20260520162151.853210168@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250179-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,crowdstrike.com:email]
X-Rspamd-Queue-Id: E097F59881B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

[ Upstream commit 1870ddcd94b061f54613b90d6300a350f29fc2f4 ]

When an unqualified kprobe target exists in both vmlinux and a loaded
module, number_of_same_symbols() returns a count greater than 1,
causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
vmlinux symbol is unambiguous.

When no module qualifier is given and the symbol is found in vmlinux,
return the vmlinux-only count without scanning loaded modules. This
preserves the existing behavior for all other cases:
- Symbol only in a module: vmlinux count is 0, falls through to module
  scan as before.
- Symbol qualified with MOD:SYM: mod != NULL, unchanged path.
- Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.

Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")
Fixes: 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")
Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Link: https://lore.kernel.org/r/20260407203912.1787502-2-andrey.grodzovsky@crowdstrike.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a5dbb72528e0c..058724c41c469 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -765,6 +765,14 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
 	if (!mod)
 		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
+	/*
+	 * If the symbol is found in vmlinux, use vmlinux resolution only.
+	 * This prevents module symbols from shadowing vmlinux symbols
+	 * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
+	 */
+	if (!mod && ctx.count > 0)
+		return ctx.count;
+
 	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
 
 	return ctx.count;
-- 
2.53.0




