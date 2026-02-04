Return-Path: <stable+bounces-214178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG1wAMZug2lNmwMAu9opvQ
	(envelope-from <stable+bounces-214178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:07:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F1E9E7C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6518030E1CA8
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7A3F0746;
	Wed,  4 Feb 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yqbc5xrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC1221F17;
	Wed,  4 Feb 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218825; cv=none; b=p9JBK3Iy+380mIUrjP9cjODrSXRCFAswCIMIMyQUxDgVtvN9EMswi4p1M/JmQnRbJp5+P6R2K45PJ8vy+gVaGyqmbmzlf6xQC3wMS3X++KwNGWILQrAU2NEft1m8eYAwDdNXNqQMaW5lJiB3poqvocJOgl59H2iIBhiYmZJlm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218825; c=relaxed/simple;
	bh=hBwyWkIibevi9ibnl4ebi5YXJvVV2xAU29aLSjEpc/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT1Q+50QAGbrXywzOXdkfxh+86IxmsxT3UnQcRBsJmaSvfGTHCChlBKevJfdKo4yPZF+d4WS6qP7A14nBL8GytxmdWwwZHEyzd6CBCRZ/mJKpSEu6VNq7HmTJzljYQykMX9PkQyQbjUQwtMdpWvfQ5D0iY2lLjczpqwl4QEpZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yqbc5xrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE6C4CEF7;
	Wed,  4 Feb 2026 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218825;
	bh=hBwyWkIibevi9ibnl4ebi5YXJvVV2xAU29aLSjEpc/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yqbc5xrMZpgR1dVCOHTKWKyczzHPPwOaqWzDgS63HYUr56m1QjVQ35b4Wa6ytLpYD
	 VsEW7kTZJO38XjHyv3+rvX44ZlPvzh5Uivg1x9RuHVFs3qHjkwFtDa4/fjouhS5/+d
	 2gjaPlE4YLMZccq87lcwaaTn4ah5gwO1ux6GXP+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Weimer <fweimer@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 6.12 72/87] libbpf: Fix -Wdiscarded-qualifiers under C23
Date: Wed,  4 Feb 2026 15:41:10 +0100
Message-ID: <20260204143849.510379380@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,kernel.org,gmail.com,suse.com];
	TAGGED_FROM(0.00)[bounces-214178-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email]
X-Rspamd-Queue-Id: 2A9F1E9E7C
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 upstream.

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error.

In C23, strstr() and strchr() return "const char *".

Change variable types to const char * where the pointers are never
modified (res, sym_sfx, next_path).

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/r/20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ shung-hsi.yu: needed to fix kernel build failure due to libbpf since glibc
  2.43+ (which adds 'const' qualifier to strstr). 'sym_sfx' hunk dropped because
  commit f8a05692de06 ("libbpf: Work around kernel inconsistently stripping
  '.llvm.' suffix") is not present. ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/libbpf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8174,7 +8174,7 @@ static int kallsyms_cb(unsigned long lon
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11959,7 +11959,7 @@ static int resolve_full_path(const char
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')



