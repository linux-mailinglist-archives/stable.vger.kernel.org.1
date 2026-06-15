Return-Path: <stable+bounces-263309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jkXbIKcYMGrVNQUAu9opvQ
	(envelope-from <stable+bounces-263309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2466879B2
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:22:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=seJiQ0Jb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263309-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263309-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD1DD300CD83
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8234028CC;
	Mon, 15 Jun 2026 15:21:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F23FD12E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:21:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536909; cv=none; b=PAspo2vTwSzvsghZVsirknq14JUfkq9npUBhRvA4QXNz1z5+ijrjFtGVHKMghiWteWg3FuOsiXiDlnK54x/hrdk7LQi2KfABYmhtcp0byPDfZ8M/bnA9auiwMsNBC6Ii3NQLCrysn4HLUO23MQIASv2eqhY/F50/oQBuIaEv9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536909; c=relaxed/simple;
	bh=vtJiW8QVrrUXD/eA120FDECcohZjiJgJWsadPhTiBSc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jjVyeDGWHo7NN3kIYU5CqBhSE0UGOT/JuKaWTajuiPoY295LzxbuLoO8VMSqf0nvheV2U2sFNZ+Q4bvnlIe/w+v5iD3n6tMHBxPAu0vC+7MOFNQ/OPZlZWdYki4sGi++E3GcmxpnEMi+nIdSw89dAf23F7FoqlGcu86SyZkaUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=seJiQ0Jb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F141F000E9;
	Mon, 15 Jun 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536907;
	bh=qGg/YZz66ZDoghRm9yuHYp2yZCggA24LWFq4B3WJbsE=;
	h=Subject:To:Cc:From:Date;
	b=seJiQ0JbP10xYg8NsKL9VmaXyrHrrxqdjzVWMlJ+ILPU8UfdeqkKbW6gu03EtItni
	 2KSHZMuhCZ/vuwondBWoY/cVMcBM+AuPESiEWQOKL36V9hZKOBUmngXilsQz09tlFY
	 E9DWEeDL/o3CO2rkw8dXV2nNhETSHcgR6npZOmN4=
Subject: FAILED: patch "[PATCH] firmware: samsung: acpm: Fix missing LKMM barriers in" failed to apply to 7.0-stable tree
To: tudor.ambarus@linaro.org,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:49:51 +0200
Message-ID: <2026061551-lung-clutter-0849@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263309-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tudor.ambarus@linaro.org,m:krzk@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2466879B2


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x bf296f83a3ddab1ab875edc4e8862cb10553064f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061551-lung-clutter-0849@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf296f83a3ddab1ab875edc4e8862cb10553064f Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 5 May 2026 13:13:03 +0000
Subject: [PATCH] firmware: samsung: acpm: Fix missing LKMM barriers in
 sequence allocator

Sashiko identified memory ordering races in [1].

The ACPM driver uses a globally shared 'bitmap_seqnum' to track
available sequence numbers. Even though threads now strictly free their
own sequence numbers, the allocation and freeing of these bits across
concurrent threads are effectively lockless operations and require
explicit LKMM memory barriers.

Previously, the driver used plain bitwise operators (test_bit, set_bit,
clear_bit), which lack ordering guarantees. This creates two race
conditions on weakly ordered architectures like ARM64:

1. Polling Release Violation: The polling thread copies its payload and
   calls clear_bit(). Without a release barrier, the CPU can reorder
   the memory operations, making the cleared bit globally visible
   before the payload reads have fully completed.
2. TX Acquire Violation: The TX thread loops on test_bit(), calls
   set_bit(), and then wipes the payload buffer via memset(). Without
   an acquire barrier, the CPU can speculatively execute the memset()
   before the bit is safely and formally claimed.

If these reorderings overlap, a new TX thread can claim the sequence
number and overwrite the buffer while the original polling thread is
still actively reading from it.

Fix this by upgrading the bitwise operators. Wrap the TX allocation in
test_and_set_bit_lock() to establish formal LKMM Acquire semantics, and
pair it with clear_bit_unlock() in the polling path to enforce Release
semantics.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260505-acpm-fixes-sashiko-reports-v5-6-43b5ee7f1674@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 620880d8820a..3fa9fe283be4 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -7,7 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/delay.h>
@@ -340,7 +340,7 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 				acpm_get_saved_rx(achan, xfer, seqnum);
 
 			/* Relinquish ownership of the sequence slot */
-			clear_bit(seqnum - 1, achan->bitmap_seqnum);
+			clear_bit_unlock(seqnum - 1, achan->bitmap_seqnum);
 			return 0;
 		}
 
@@ -397,11 +397,18 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	struct acpm_rx_data *rx_data;
 	u32 *txd = (u32 *)xfer->txd;
 
-	/* Prevent chan->seqnum from being re-used */
+	/*
+	 * Prevent chan->seqnum from being re-used.
+	 * test_and_set_bit_lock() provides formal LKMM Acquire semantics.
+	 * It pairs with the RX thread's clear_bit_unlock() to ensure the CPU
+	 * does not speculatively execute the rx_data buffer wipe (memset)
+	 * before the sequence number is safely claimed.
+	 */
 	do {
 		if (++achan->seqnum == ACPM_SEQNUM_MAX)
 			achan->seqnum = 1;
-	} while (test_bit(achan->seqnum - 1, achan->bitmap_seqnum));
+		/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
+	} while (test_and_set_bit_lock(achan->seqnum - 1, achan->bitmap_seqnum));
 
 	txd[0] |= FIELD_PREP(ACPM_PROTOCOL_SEQNUM, achan->seqnum);
 
@@ -411,9 +418,6 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
-
-	/* Flag the index based on seqnum. (seqnum: 1~63, bitmap: 0~62) */
-	set_bit(achan->seqnum - 1, achan->bitmap_seqnum);
 }
 
 /**


