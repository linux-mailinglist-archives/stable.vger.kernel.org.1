Return-Path: <stable+bounces-234531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LEPAjCj1mlqGwgAu9opvQ
	(envelope-from <stable+bounces-234531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:49:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13F3C1A76
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92950307BC8C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882523AF643;
	Wed,  8 Apr 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+H3qO6f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4D26FA5A;
	Wed,  8 Apr 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673101; cv=none; b=OZ8L+It2JNHm/iaJrINThxqr0sSppa/vq8I9LeBZSfjHaDmQt2P47catp7hqxtDJ9oSM+fO5P4igPyMzVektvLdZYWiBw5ubcQJHS0saoHBeOVB5TFhYQ9/9lju7/9Lu4TuTiy1RuPko4z4eXq2n1mwmbUJcpQS+Le88Ay2Zw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673101; c=relaxed/simple;
	bh=pMDpseXrGS1kV7Ms+jE3dSY+wTuef6m4xkDzHD3nbvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glv+9mQkoMMNjV7+Dz6bJ5gPI5soiCUcr7kAlTUtToYtzy2m/dSicYRRVmRIy1s+h0HZZd2xasalqBDuqVy01mSvq6bexAl/XXu4skslraLfRpxWIljLCBXyY0d5qfbiEG3UY5QOb/jIJWgUYNZNpDuEUZ/XK63j7h92NiVOejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+H3qO6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A0DC19421;
	Wed,  8 Apr 2026 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673101;
	bh=pMDpseXrGS1kV7Ms+jE3dSY+wTuef6m4xkDzHD3nbvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+H3qO6fIrYS5w/poMju52YXLSt1zUr6pSM0SyCI02RL3CiibMmvCGbO3BfzGZm6a
	 IdpCSQ7LmjGuKpD58eZ7IlQTyPIKMFt996qZ8VJ00VHylQvveAj1537GUAG93hF+6z
	 8QYQI9t0cQBkmVxAzqXLHpBpTrGKFgkF/hPg4BQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qi Tang <tpluszz77@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 101/277] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Wed,  8 Apr 2026 20:01:26 +0200
Message-ID: <20260408175937.643283673@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234531-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4C13F3C1A76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Tang <tpluszz77@gmail.com>

[ Upstream commit b0db1accbc7395657c2b79db59fa9fae0d6656f3 ]

check_mem_access() matches PTR_TO_BUF via base_type() which strips
PTR_MAYBE_NULL, allowing direct dereference without a null check.

Map iterator ctx->key and ctx->value are PTR_TO_BUF | PTR_MAYBE_NULL.
On stop callbacks these are NULL, causing a kernel NULL dereference.

Add a type_may_be_null() guard to the PTR_TO_BUF branch, matching the
existing PTR_TO_BTF_ID pattern.

Fixes: 20b2aff4bc15 ("bpf: Introduce MEM_RDONLY flag")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20260402092923.38357-2-tpluszz77@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ecdbc821bd1a4..db1c591a1da3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7737,7 +7737,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	} else if (reg->type == CONST_PTR_TO_MAP) {
 		err = check_ptr_to_map_access(env, regs, regno, off, size, t,
 					      value_regno);
-	} else if (base_type(reg->type) == PTR_TO_BUF) {
+	} else if (base_type(reg->type) == PTR_TO_BUF &&
+		   !type_may_be_null(reg->type)) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
 		u32 *max_access;
 
-- 
2.53.0




