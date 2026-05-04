Return-Path: <stable+bounces-243127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AWiEX2m+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 371324BE4F2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3003C30171CC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761543DDDDE;
	Mon,  4 May 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVpvgb5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD03DD519;
	Mon,  4 May 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903087; cv=none; b=WwcLzQTWQXKTcP2ASj3J43cUscpsE6pUoHaK+WJhxbcdqAAZQeMlGBbhJ+ajTIHzRJqvaIjwAZcS9eHu06G8jVcynJyILOr9/3DaVAb5Ix+FumGfnxBQcPS5++T5se/R3UXeanN0nNrLWzPs08LDDFgHNAAJKB/nAqH2gSjNYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903087; c=relaxed/simple;
	bh=7H6b5X9AOtKx1FiwwJJEBPmlGPlNAyi9faVwwQ6upIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bvd5FKWcTrTSNQv2Z50aOZZO9+KYTmxsjHwdNk2jGny2RrEhxCrR7WCikDoL6JCkQrw1DFOD2BWpdgERWl1Muitgv4bSn2UvgumGTCJkxnRYXFsrVtLUn3o9NB1XQkoRgm09ygIArGSXhZGz82VAOEpVMTeUsPQHF3Nil2BhjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVpvgb5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B07C2BCC4;
	Mon,  4 May 2026 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903087;
	bh=7H6b5X9AOtKx1FiwwJJEBPmlGPlNAyi9faVwwQ6upIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVpvgb5erNgfrGXF73W12+/NvMRVkNsCTeQo1qjqXze4pVOEKgPOW1GRNGu0s+hq7
	 cZAywJlI/v7GNialH7T3SxzpQw3tqbL9nXHvdYRd/aLL5isDslZhEv4PkD6GtUWBCo
	 CrduBy4tUALu36BlhFW5eXAWbFkSurFNsh/PzFJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shigeru Yoshida <syoshida@redhat.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 066/307] mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()
Date: Mon,  4 May 2026 15:49:11 +0200
Message-ID: <20260504135145.299464148@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 371324BE4F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243127-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,mediatek.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

commit 4fb61d95ad21c3b6f1c09f357ff49d70abb0535e upstream.

zs_page_migrate() uses copy_page() to copy the contents of a zspage page
during migration.  However, copy_page() is not instrumented by KMSAN, so
the shadow and origin metadata of the destination page are not updated.

As a result, subsequent accesses to the migrated page are reported as
use-after-free by KMSAN, despite the data being correctly copied.

Add a kmsan_copy_page_meta() call after copy_page() to propagate the KMSAN
metadata to the new page, matching what copy_highpage() does internally.

Link: https://lkml.kernel.org/r/20260321132912.93434-1-syoshida@redhat.com
Fixes: afb2d666d025 ("zsmalloc: use copy_page for full page copy")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zsmalloc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1741,6 +1741,7 @@ static int zs_page_migrate(struct page *
 	 */
 	d_addr = kmap_local_zpdesc(newzpdesc);
 	copy_page(d_addr, s_addr);
+	kmsan_copy_page_meta(zpdesc_page(newzpdesc), zpdesc_page(zpdesc));
 	kunmap_local(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;



