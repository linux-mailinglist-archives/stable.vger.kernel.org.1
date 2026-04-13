Return-Path: <stable+bounces-236358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EgVE50b3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB43EF5DC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797A730B5B95
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DF25A2C9;
	Mon, 13 Apr 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="adSQ0T1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8826A1CF;
	Mon, 13 Apr 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096699; cv=none; b=FTUIKTDF3mHFs6+q056zk5/1mb5Y1O5K/dZ32dres50iZi0H1V8MymraUidoJP2CFqeJjJISPGmUp0LOPiPhc9WX0iuPilTYh/j45HXIYWqsbP80w4wfHLuAvuPa+An/IqpXekDuvR+5FmStK0rMv9P7CP9+UgV5xM/ptlhhhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096699; c=relaxed/simple;
	bh=wtDjfMGyriUotsi4clz6g7/DXIR4vbXa+7ZtvSNAjRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4vozB0VA9rlzJidWJXdVulJ4GjElIjnvRUGvBvI7fIZRIV9oZeEEAHzuFn691Ci1ck4XlhZE6CIUVjY99/zta5vncgISHABjxfYXv5aI2Hu6i2F7K87ICEUKJ3ZP7UmaPw1D/U8e0Kksxl1IT4yzWW+AxBgwSV3Wcn4q2pn2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=adSQ0T1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7304CC2BCAF;
	Mon, 13 Apr 2026 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096699;
	bh=wtDjfMGyriUotsi4clz6g7/DXIR4vbXa+7ZtvSNAjRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adSQ0T1VCRh4DGh3MT31LsOryPAelTgpfp2LmN1Am3INmItV7GgJAywBKALEwhMq1
	 GLuD/a/0oRSy4fgTxDer6TDmpVdeHfPk7wTUXgZEYPH0baWWV+ZVMEu98VxhNcbKk4
	 /N/8j3pZqFgUVF91D2Y2znybkPYgSIKQjps9exq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 29/70] LoongArch: Remove unnecessary checks for ORC unwinder
Date: Mon, 13 Apr 2026 18:00:24 +0200
Message-ID: <20260413155729.276259569@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236358-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1AB43EF5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 4cd641a79e69270a062777f64a0dd330abb9044a ]

According to the following function definitions, __kernel_text_address()
already checks __module_text_address(), so it should remove the check of
__module_text_address() in bt_address() at least.

int __kernel_text_address(unsigned long addr)
{
	if (kernel_text_address(addr))
		return 1;
	...
	return 0;
}

int kernel_text_address(unsigned long addr)
{
	bool no_rcu;
	int ret = 1;
	...
	if (is_module_text_address(addr))
		goto out;
	...
	return ret;
}

bool is_module_text_address(unsigned long addr)
{
	guard(rcu)();
	return __module_text_address(addr) != NULL;
}

Furthermore, there are two checks of __kernel_text_address(), one is in
bt_address() and the other is after calling bt_address(), it looks like
redundant.

Handle the exception address first and then use __kernel_text_address()
to validate the calculated address for exception or the normal address
in bt_address(), then it can remove the check of __kernel_text_address()
after calling bt_address().

Just remove unnecessary checks, no functional changes intended.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
V2: Add upstream commit ID.

 arch/loongarch/kernel/unwind_orc.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -359,12 +359,6 @@ static inline unsigned long bt_address(u
 {
 	extern unsigned long eentry;
 
-	if (__kernel_text_address(ra))
-		return ra;
-
-	if (__module_text_address(ra))
-		return ra;
-
 	if (ra >= eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
 		unsigned long func;
 		unsigned long type = (ra - eentry) / VECSIZE;
@@ -382,10 +376,13 @@ static inline unsigned long bt_address(u
 			break;
 		}
 
-		return func + offset;
+		ra = func + offset;
 	}
 
-	return ra;
+	if (__kernel_text_address(ra))
+		return ra;
+
+	return 0;
 }
 
 bool unwind_next_frame(struct unwind_state *state)
@@ -511,9 +508,6 @@ bool unwind_next_frame(struct unwind_sta
 		goto err;
 	}
 
-	if (!__kernel_text_address(state->pc))
-		goto err;
-
 	preempt_enable();
 	return true;
 



