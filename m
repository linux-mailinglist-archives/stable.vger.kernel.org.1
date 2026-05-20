Return-Path: <stable+bounces-250142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L4N4JS8NDmqe5wUAu9opvQ
	(envelope-from <stable+bounces-250142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:36:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D35987B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32143331612
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E1372690;
	Wed, 20 May 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="16xCZtoj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D636CE19;
	Wed, 20 May 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294654; cv=none; b=CNltXFnfmPaIWsVvDpha75YZwg+z5aSDyzEWI6HSv3TXQa4fp2o1hqD+H+QNZGd2rsfjl1nlCGfTAq09lFWUummdHGnwS/4y7Zdxae+SsLkTMwo308iTd7r4jbdC4QtJfTLiUCMfgYepHvfWLD+GZaO5jpp1v61lT4hLiIbm6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294654; c=relaxed/simple;
	bh=PeF/5xOQZiwRNLLn49EYir2GPzyNrBnfxwtsCnjA/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWCw+rZPYygxgLZoq3coTavP8mrivvC/d9dR8SRm1ybte1wzHfrumpoqR7u932xuD6lEbfQ3p7uWcmY835tot3k9nRi8SQoJcafaNqGO3RweD6+rWU3Ui3Uz8S/kV58QP/KdqcVTSJjIOU/+B0xcMxmd4MXqeW9KqIxLv1DLQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=16xCZtoj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74651F00893;
	Wed, 20 May 2026 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294653;
	bh=F9jK61HlSdKZ646UKcULJJT9II4Y2aCGagAPi0smh8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=16xCZtojgkIVJcSION9NuiAZ3Ir37INbDYoKV+eVfJ+7Q+1Ps25VJZt3BR9vRcZqJ
	 gSBKKCQKdg1Teu3BULbBIue3KdbLADgvmEjwrt4YBBMfO8103jevW0KUQEI6TWdSL0
	 kuM9MYeSmKBUsF4Mhk7UnOF/mq6q//b0No6hsKpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Llamas <cmllamas@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0119/1146] bpf: Switch CONFIG_CFI_CLANG to CONFIG_CFI
Date: Wed, 20 May 2026 18:06:09 +0200
Message-ID: <20260520162151.027388906@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250142-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 025D35987B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit 9b0cf064ea0a6bac5e1a5fb43b004fd52fbe2b3b ]

This was renamed in commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG
to CONFIG_CFI") as it is now a compiler-agnostic option. Using the wrong
name results in the code getting compiled out. Meaning the CFI failures
for btf_dtor_kfunc_t would still trigger.

Fixes: 99fde4d06261 ("bpf, btf: Enforce destructor kfunc type with CFI")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20260312183818.2721750-1-cmllamas@google.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 71f9143fe90f3..63d075f374591 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9019,7 +9019,7 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
 
-		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		if (IS_ENABLED(CONFIG_CFI)) {
 			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
 			t = btf_type_by_id(btf, t->type);
 			if (!btf_type_is_void(t))
-- 
2.53.0




