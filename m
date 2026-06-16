Return-Path: <stable+bounces-266054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZ6/FZiVMWq/nQUAu9opvQ
	(envelope-from <stable+bounces-266054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E52694232
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wHEUUA77;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266054-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266054-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D542301B1EC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8EC477E33;
	Tue, 16 Jun 2026 18:26:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1733D810C;
	Tue, 16 Jun 2026 18:26:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634419; cv=none; b=oClDJVtJP4+Z81vXD3lcYDK2zSt8OKCdQbqcU7hXRkO5mr3L3mjFA1J9jiGRAKGsw6HhzKJCH664/CCmN9yliSszQpo9B1O7YxHhUs00AftQubt8MC8O1bZYHcPcdc7XKZ4PGbVcZgtDPdztc779nVtbkZ+Cpseo+Hk9tUWH570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634419; c=relaxed/simple;
	bh=fLvz4FEjKVYbD57fqZacLoOhvf3n6Iit2yF1PaaO2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM5XK3QpZp+jO2HAjMspHkwT2iOkaYuu/FOnxhzD3FZanoID9SDZz/B9PVqGCA5NhShfuUcP/SoJbgtxPYqC6yuQ0vnWbEz55X0Zrl4c5YZsNxiheiSQrN3TCbcyxqU7PepbZsvecJrst0Hy7zYkwJ+18G/QTT8X7TR2xdapGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHEUUA77; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3A1F000E9;
	Tue, 16 Jun 2026 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634418;
	bh=ZgWImIPq6MYaAHJDlxEVHaJe4sF4xrYAgR2sBerHE50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wHEUUA773Y5ZA9zlnM4gyBsiqaPmaEJKotNEu1HhFX/bC2LYPeUCUS0f8T3J/hIsH
	 eFRkCQne8bzi4JQPbevK5SHxpx0Qt0ebWjvIq1Vd2QYtGuqX8U7jYASfYfxkc+k6+c
	 9kGZ/N3oXjckIqpENxM0u6/AwYFhZNjBkKMQCnN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 5.15 228/411] misc: fastrpc: fix DMA address corruption due to find_vma misuse
Date: Tue, 16 Jun 2026 20:27:46 +0530
Message-ID: <20260616145112.936603730@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,oss.qualcomm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-266054-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:dmitry.baryshkov@oss.qualcomm.com,m:srini@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,outlook.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70E52694232

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit 464c6ad2aa16e1e1df9d559289199356493d1e00 upstream.

fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
pointer and compute a DMA address offset. When the address falls in a gap
before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
corrupting the DMA address sent to the DSP.

Replace find_vma() with vma_lookup(), which returns NULL when the address
is not contained within any VMA.

Cc: stable@vger.kernel.org
Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204528.116920-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -875,7 +875,7 @@ static int fastrpc_get_args(u32 kernel,
 			pages[i].addr = ctx->maps[i]->phys;
 
 			mmap_read_lock(current->mm);
-			vma = find_vma(current->mm, ctx->args[i].ptr);
+			vma = vma_lookup(current->mm, ctx->args[i].ptr);
 			if (vma)
 				pages[i].addr += (ctx->args[i].ptr & PAGE_MASK) -
 						 vma->vm_start;



