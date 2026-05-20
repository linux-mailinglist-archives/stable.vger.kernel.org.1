Return-Path: <stable+bounces-250154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LkBKZTuDWpu4wUAu9opvQ
	(envelope-from <stable+bounces-250154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4D5939DF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7FD33565A3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD13D75BA;
	Wed, 20 May 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VC6bBsvi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C43D5642;
	Wed, 20 May 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294686; cv=none; b=c0t2EXfGKLXimg5zvU1UttlfqzqQiOJbyZZoWolKo/zMchnQvzFViIQ0PQ5wSKAq8khtebFfiYZHpGkCmGBrS+Dvib24xL8Mppo9gGN3IV/VtRrq6rXiJ2jHZf9G3w6+APz/dg8vm/w+y8y2fs3s73K1dH53C13b6kiVMV9AgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294686; c=relaxed/simple;
	bh=C3NVLQJR1/8qs+1S7Bqr7JEmna2WyGbVwMN9CpIeD78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h79Amt+4P6R6VRYB1LK0bBI2oojYSn8ReMF3ZFuwQEnmnc168qRQzWMFtLzL95cbFvjHsk0wg7azkrv6Q+H0DVpQPIM9GFpbRAYXPqEYUNZujADnHITf+5qmpTf6RtlL9w52SFsvYGIKO7aRZEl0dEhfDrf3+i7HZbiWOU+2w34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VC6bBsvi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463341F000E9;
	Wed, 20 May 2026 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294684;
	bh=zRPuaodprnVLRxvs6jwDmGVlUAWiJ2kyQWbvP7hORzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VC6bBsvi5FkFkJWJl/MNGmysiy5KDT2skBwCvAJtWb8KjsSOQ0YKs0OOVN6DqEr9a
	 JreRaIH9cuDVTxBl+wOw2s0qAdTvfZlR4UBf1lCOEFrw6mHH0XJQ2B9bX7hzqF83b9
	 3Va5azA+Ppt3ePC27lArawzRqaE2JV+w/Dgh7BTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0134/1146] bpf: Fix variable length stack write over spilled pointers
Date: Wed, 20 May 2026 18:06:24 +0200
Message-ID: <20260520162151.355133123@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-250154-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 39E4D5939DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 4639eb9e30ab10c7935c7c19e872facf9a94713f ]

Scrub slots if variable-offset stack write goes over spilled pointers.
Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
and valid program is rejected by check_stack_read_fixed_off()
with obscure "invalid size of register fill" message.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20260324215938.81733-1-alexei.starovoitov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 23b35605ae377..8d00bd0f8b79d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5241,6 +5241,18 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 	}
 }
 
+static void scrub_special_slot(struct bpf_func_state *state, int spi)
+{
+	int i;
+
+	/* regular write of data into stack destroys any spilled ptr */
+	state->stack[spi].spilled_ptr.type = NOT_INIT;
+	/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
+	if (is_stack_slot_special(&state->stack[spi]))
+		for (i = 0; i < BPF_REG_SIZE; i++)
+			scrub_spilled_slot(&state->stack[spi].slot_type[i]);
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -5338,12 +5350,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	} else {
 		u8 type = STACK_MISC;
 
-		/* regular write of data into stack destroys any spilled ptr */
-		state->stack[spi].spilled_ptr.type = NOT_INIT;
-		/* Mark slots as STACK_MISC if they belonged to spilled ptr/dynptr/iter. */
-		if (is_stack_slot_special(&state->stack[spi]))
-			for (i = 0; i < BPF_REG_SIZE; i++)
-				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
+		scrub_special_slot(state, spi);
 
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && register_is_null(reg)) ||
@@ -5467,8 +5474,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			}
 		}
 
-		/* Erase all other spilled pointers. */
-		state->stack[spi].spilled_ptr.type = NOT_INIT;
+		/*
+		 * Scrub slots if variable-offset stack write goes over spilled pointers.
+		 * Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
+		 * and valid program is rejected by check_stack_read_fixed_off()
+		 * with obscure "invalid size of register fill" message.
+		 */
+		scrub_special_slot(state, spi);
 
 		/* Update the slot type. */
 		new_type = STACK_MISC;
-- 
2.53.0




