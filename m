Return-Path: <stable+bounces-263509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BjT5JtmnMGrbVwUAu9opvQ
	(envelope-from <stable+bounces-263509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526D68B47B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=elo4vvDv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263509-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263509-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34B530173B7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CD3793BD;
	Tue, 16 Jun 2026 01:33:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24F1A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:33:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573591; cv=none; b=oBJriZDncHPEaOQIR+ZpqfJYLIpv7lw13VEsEpNmJ1gkXp8UHVGMx6XHP/uqSNoykku3E8mJFA0FlW9+8UcwuiU8iWkpNafaW4s5jBPbApIl4RMfuL1D2oY3R9J0bB09vcNF+oLUKc4ZZNzmiops7w03KODfwTWP3PvOd2ubKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573591; c=relaxed/simple;
	bh=rUoJvtXXMtSKWkhksKieFnwPsYS9tUOLqGUesGi52zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx+Z3X1pmzwoX96Y61zJINY4jmJeZ20hiAlX7Mtn3n0w/4YVBI8YgX84z05OdL42JtXa8CXrneRwCQ4d8bHuxYCO1PpaV9m9WeAFh5/MPGgrjUFqbl9kLMQoxDL9bp+id+SFkLVK2DFDA3Qf2SuyYwMWdh0/3jhmH4UVpcrZD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elo4vvDv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19A1F000E9;
	Tue, 16 Jun 2026 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573589;
	bh=5osW8llRrZgUy1B+gtND+2rpDZVFKu13y6pYaYij6nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=elo4vvDvVuUh2sm86QjC+Te2rgvTjWvec8Ce2xBPGlalCv5tePP1ZWHeGnuyyTsE/
	 kfNYpRYTLu/5rZIO9gHM3jnjWkDJkv/YmkuZ4E/VTkQ3uoXJKAlZlj1HNjTJkj4yZb
	 nN4LnPMPixODzk16F/uKK42LQqnzROUn3tG6kiAf3cY2cf8qv940hYV3h8pyOpL7kf
	 wGjQepRajjHRkl9ZsLqhZea3NCKSxwE5i+H9rzdIQqR0DWVqrAFZo3uW/589OApJNV
	 Gq1bnDfwZh8OErJ/Jw/fPS50n1VsCsleaDek+uUQQkKhkiXefHZuUlMcwl5XqkYVpc
	 PD5zVDTmSYBkA==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH linux-6.1.y 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
Date: Mon, 15 Jun 2026 20:33:05 -0500
Message-ID: <20260616013306.3850069-2-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013306.3850069-1-clrkwllms@kernel.org>
References: <20260616013306.3850069-1-clrkwllms@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,anthropic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0526D68B47B

From: Clark Williams <clark.williams@gmail.com>

strchr() now propagates const when passed a const char * argument in
newer GCC/glibc combinations, causing -Werror=discarded-qualifiers to
fire on the assignment to next_path. Declare next_path as const char *
since it is only used for pointer arithmetic, never written through.

Assisted-By: Claude Sonnet 4.6 <noreply@anthropic.com>
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


