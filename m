Return-Path: <stable+bounces-263134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHW+GwF7L2pPBQUAu9opvQ
	(envelope-from <stable+bounces-263134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 06:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB0683357
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 06:09:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=D82i1ka1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263134-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263134-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7CBA3006385
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DB2C0F6C;
	Mon, 15 Jun 2026 04:09:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F7249E5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 04:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496575; cv=none; b=FV7D35XTZd/xNodijYJlUYNTgky+zQZJ8KekSUHK+ot5ncO0uTuBYJqAdHV9KH0fIz29sqj9+4HxkLz+hsyjsbFflyuoOQrxCT/2ZEwPmXh8PJS9ZqIBHHvsepAi4UGZmloRwIUY/dkQSYZ5t0wwgBWU9MZ4QsN98nepN6MGWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496575; c=relaxed/simple;
	bh=2RspWB7j2nDeeANaw/RniPtdrpLbBGKo53OlkTlrdLo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HueF5am9d5jJxM9YjqXIFg799PMW14EdljWkM6z93HG3QA1mL2ogYm7jW5A0GpL8hHZCzSzGULcx8fM3a1Wa2cBQfdrRdwIBll4lKTcqBqen8VUrNyuVusv9Oq8qtAJ/HX6hIczojN4lHIvOX/8GPZSnEI2r/bSOObwts0LgV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D82i1ka1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123591F000E9;
	Mon, 15 Jun 2026 04:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781496573;
	bh=3u03sl6panyZtOz8uitanoGjcGXB8ygBdfVMKHv+/7g=;
	h=Subject:To:Cc:From:Date;
	b=D82i1ka16HGf8n+XKNHr/G0RLXSfufFy3pUwIGdayIgqqs1sj6Ac20wCgFNgLz8tA
	 h+xz6mAB0Poh+Sc8tqJG80LsWr5TIwMYIYOw4/9+GvGpvODS1G8c8BKo7jsZyiGfN8
	 1rR8qwD/R2NNrgLZ/De3N2YvLaEyo6GVITNBoxxg=
Subject: FAILED: patch "[PATCH] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf" failed to apply to 6.6-stable tree
To: leontyevantony@gmail.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 06:08:23 +0200
Message-ID: <2026061523-fragility-angler-a2a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leontyevantony@gmail.com,m:pabeni@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00CB0683357


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 004e9ecfe6c5384f9e0b2f6f6389d42ec22789af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061523-fragility-angler-a2a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 004e9ecfe6c5384f9e0b2f6f6389d42ec22789af Mon Sep 17 00:00:00 2001
From: Anton Leontev <leontyevantony@gmail.com>
Date: Thu, 4 Jun 2026 19:59:38 +0300
Subject: [PATCH] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf

netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
send buffer using phys_to_virt() on the entry PFN. Entries for the
RNDIS header and the skb linear data come from kmalloc'd memory and
are always in the kernel direct map, but entries for skb fragments
reference page cache or user pages, which on 32-bit x86 with
CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
phys_to_virt() returns an address outside the direct map and the
subsequent memcpy() faults on the transmit softirq path, which is
fatal.

Map the pages with kmap_local_page() instead, handling two properties
of the page buffer entries:

 - pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity,
   not a native PFN. Reconstruct the physical address first and derive
   the native page from it, so the mapping stays correct where
   PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g. arm64 with 64K pages).

 - Since commit 41a6328b2c55 ("hv_netvsc: Preserve contiguous PFN
   grouping in the page buffer array"), an entry describes a full
   physically contiguous fragment and pb[i].len can exceed PAGE_SIZE,
   while kmap_local_page() maps a single page. Copy page by page,
   splitting at native page boundaries.

The copy path only handles packets smaller than the send section size
(6144 bytes by default); larger packets take the cp_partial path where
only the RNDIS header is copied. So entries here are bounded by the
section size and a copy is split at most once on 4K-page systems. On
!CONFIG_HIGHMEM configs kmap_local_page() folds to page_address() and
no mapping work is added.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
Link: https://patch.msgid.link/20260604165938.32033-1-leontyevantony@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..4d319c50955e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,12 +966,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = phys_to_page(paddr);
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)


