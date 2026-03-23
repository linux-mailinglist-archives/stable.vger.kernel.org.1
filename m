Return-Path: <stable+bounces-229964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNxnAkZwwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:54:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8EE2F9101
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F91231EBF04
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78B3BE17D;
	Mon, 23 Mar 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BA25YSQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58593BE147;
	Mon, 23 Mar 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283496; cv=none; b=C6AUMIxXyhLqSKeuD+iwgB4UB26xZ53kwfALzTF6MxNnoKwBHD8ye4h9J1nnh38VN3hw6bWrwfzcuJe4Jqpp9tv6RJXjgJZqkzAUwWyAcv17CdW2xjKKrqj9i6S84UJn7Sje6v6z+jU/lLVmAc+9ST86m3vC9WivOLwPqEf4VrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283496; c=relaxed/simple;
	bh=XqMy07hLksKFsGi0JhpO8aVhpligLV50VP5pJbswhH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NB1tGc1Vij8EGylSF/BI2dm3KD2b4SCktXWEo6K4EfWvfE9YtGfAQrPugtWPLsHtYdYJT3vQ16TE5ypQv03VejEMldyDvmMr9RHh4CFloT2dzao7Yn/EGQmP7gOfYGJi+ARngs65c0LR4v1wiIrH1Apt/TSn04sUva62qTy/7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BA25YSQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CE9C4CEF7;
	Mon, 23 Mar 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283496;
	bh=XqMy07hLksKFsGi0JhpO8aVhpligLV50VP5pJbswhH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BA25YSQ0GeZGKW2MTBnkHNqhgahwAlCUY1RtWbGAwglNUXG+zmpDHQU6m90BIoHrL
	 nf1+7B5gs+SMSlqH0fbbiDgt/OTAsCC1srZcBbJXFBeJUGswLJeSJ1Jkuv60M9QuSl
	 +a7UapFvl4ebgZ9d3QheeeySi3dds12pQB8eWoJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 6.6 121/567] ARM: clean up the memset64() C wrapper
Date: Mon, 23 Mar 2026 14:40:41 +0100
Message-ID: <20260323134536.800318755@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229964-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9D8EE2F9101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf upstream.

The current logic to split the 64-bit argument into its 32-bit halves is
byte-order specific and a bit clunky.  Use a union instead which is
easier to read and works in all cases.

GCC still generates the same machine code.

While at it, rename the arguments of the __memset64() prototype to
actually reflect their semantics.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/string.h |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -39,13 +39,17 @@ static inline void *memset32(uint32_t *p
 }
 
 #define __HAVE_ARCH_MEMSET64
-extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
+extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
 static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
 {
-	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
-		return __memset64(p, v, n * 8, v >> 32);
-	else
-		return __memset64(p, v >> 32, n * 8, v);
+	union {
+		uint64_t val;
+		struct {
+			uint32_t first, second;
+		};
+	} word = { .val = v };
+
+	return __memset64(p, word.first, n * 8, word.second);
 }
 
 /*



