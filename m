Return-Path: <stable+bounces-252524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFYQK4j7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A2F595DC4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DED03108C89
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E293F54D1;
	Wed, 20 May 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gayPgFku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29E2F363F;
	Wed, 20 May 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300899; cv=none; b=rOlvoqs+e1tkU56/4vAJQVReVCXdtjBKD04YGqDM6qVmEr+3KFxv8Jth0tVmMqtIKAzb1bMQxE/clZoa8NYOScePcJQmut8GsgxeQ0zUvj2bQAZx7T49hySyLeEeipRHCKERRXjXGchR+Q4LXZG9NNCriuHfmehfGvdNCEbqE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300899; c=relaxed/simple;
	bh=cDhTqZgGDYfGs+ntE2gaGfvDGFjFejS1AmzslzK/d4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ6DUdQb47m6gk5aifovqgZ0H04HJTRDH5zEZCRP+O2jQwi6roOr6Ui8PIB7n4cx6RjthaCVYG5oeakXLbRMiYmvJ8BKRZ9BIwI99GDle3uPm6v02XmMM4ZJu3u5gjxC/mOxl7vOs8Bk1envxph6ci3sIB3LbGpx7Ad1W/z0hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gayPgFku; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C141F000E9;
	Wed, 20 May 2026 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300898;
	bh=zx01TzF6pRuSMxzCt8mKdwxNjmCwmC3/fxBLz4x4j8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gayPgFkuoY3SmcbImb6CmdgBF1OTBCHRc41VckEvDG/5sKH0sOwRZMCU02xmZQV3C
	 NsrDdMR3D7UE0ivWKF4Nv5eD+yqWmtNouTAPMWoOCNcV0hQ08AmXb/nhyhbBE+jCTp
	 a45NoWqp1CMfN5+RdP8uW0bbRN4K8zQDpQpDlPSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hiker Cl <clhiker365@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 351/666] bpf: Fix NULL deref in map_kptr_match_type for scalar regs
Date: Wed, 20 May 2026 18:19:22 +0200
Message-ID: <20260520162118.839191080@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252524-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,meta.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 30A2F595DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 4d0a375887ab4d49e4da1ff10f9606cab8f7c3ad ]

Commit ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local
kptr") refactored map_kptr_match_type() to branch on btf_is_kernel()
before checking base_type(). A scalar register stored into a kptr
slot has no btf, so the btf_is_kernel(reg->btf) call dereferences
NULL.

Move the base_type() != PTR_TO_BTF_ID guard before any reg->btf
access.

Fixes: ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local kptr")
Reported-by: Hiker Cl <clhiker365@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221372
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/20260416-kptr_crash-v1-1-5589356584b4@meta.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56a74ce4a29b9..64a6ec8eb847b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5473,6 +5473,9 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	int perm_flags;
 	const char *reg_name = "";
 
+	if (base_type(reg->type) != PTR_TO_BTF_ID)
+		goto bad_type;
+
 	if (btf_is_kernel(reg->btf)) {
 		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
 
@@ -5485,7 +5488,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			perm_flags |= MEM_PERCPU;
 	}
 
-	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
+	if (type_flag(reg->type) & ~perm_flags)
 		goto bad_type;
 
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
-- 
2.53.0




