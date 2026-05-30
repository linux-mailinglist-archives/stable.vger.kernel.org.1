Return-Path: <stable+bounces-257195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKG0JngXG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC460EAD3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFBA73017BE4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381873438AE;
	Sat, 30 May 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHkf7OR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5F332919;
	Sat, 30 May 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160142; cv=none; b=OiLBnOo5HMO6ruUqtMZ63GlOrifBz1ttBOs0FCEGA5x46x72G6U/hSZtpWZQ2K9KvcigGKT99T+EOTWgxulqM3/96B0iDFnSPGCzUgd6PY7YbDMHNQ+ySi/0E9wEQVuQ6t8d4U1WPU0l+M3PDinjt1dkC7WXZqUE60LI0UspUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160142; c=relaxed/simple;
	bh=rBPR1JN9bsp4boJqTFmkWD3hnkcNtNwSGRmZdEkwOU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDc4Wl9Ufromxw35LHFU+H3XrQxZfnrQDKiGYTOZ4R15SPbCpTkbfGuAOspRTMHupVXb/o42yRxGnn+4y0Npp4WbFq377iQ1rwNGZJHzLuZ5yd+n9oq9kCg8jN0PC/TaKWDpUOGy/xCZlYsvME35F0Yr4s6NMqt6X6P8HClJYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHkf7OR/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5593A1F00893;
	Sat, 30 May 2026 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160141;
	bh=n6HJvQ/ZjKgD4XAKk8KWD2ffj1Rdlb48/XB7nTG6jOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHkf7OR/5WBKXE/b/iDjzdMpW1z6/lf0IQ+NkU5rin6PmuhSFo4yqmn1Ja/lpQNmf
	 FYJw5VvFNzArFI8RZV+3Ggf8Qh8V7H1DkJ2xR3xCAvqItJJvsVUb70lW16f5gkcbUa
	 BaIDuhHOey9/L4BA2v0HClSpTZAMYxS7VJfcJp20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 256/969] crypto: atmel-aes - Fix 3-page memory leak in atmel_aes_buff_cleanup
Date: Sat, 30 May 2026 17:56:20 +0200
Message-ID: <20260530160307.548962415@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257195-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 14EC460EAD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 3fcfff4ed35f963380a68741bcd52742baff7f76 upstream.

atmel_aes_buff_init() allocates 4 pages using __get_free_pages() with
ATMEL_AES_BUFFER_ORDER, but atmel_aes_buff_cleanup() frees only the
first page using free_page(), leaking the remaining 3 pages. Use
free_pages() with ATMEL_AES_BUFFER_ORDER to fix the memory leak.

Fixes: bbe628ed897d ("crypto: atmel-aes - improve performances of data transfer")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-aes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2329,7 +2329,7 @@ static int atmel_aes_buff_init(struct at
 
 static void atmel_aes_buff_cleanup(struct atmel_aes_dev *dd)
 {
-	free_page((unsigned long)dd->buf);
+	free_pages((unsigned long)dd->buf, ATMEL_AES_BUFFER_ORDER);
 }
 
 static int atmel_aes_dma_init(struct atmel_aes_dev *dd)



