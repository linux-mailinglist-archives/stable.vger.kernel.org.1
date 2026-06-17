Return-Path: <stable+bounces-266788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FQUiE+iuMmpS3gUAu9opvQ
	(envelope-from <stable+bounces-266788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:27:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FB69A875
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:27:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hDhgvxU/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266788-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266788-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E09A3089C93
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B83F0ABE;
	Wed, 17 Jun 2026 14:27:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1144A739
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:27:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706466; cv=none; b=Ndo3Ou0HwyK2ekDKpCKF0BpZG0XSQG7dT2yziTM6b/Y5J/ulR98r48stCvEdXy4lwTMPq7E7SbZ1LvfXal1D2i2z4yK6LVV0SD96Rnmg3n2SIs8K0EPZBYJOgj2rLFM7NPS2Kh4F3CCSZbkNfs+n4X1S5QeFnLVxClXlhMp8ZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706466; c=relaxed/simple;
	bh=aQktCdjb5lwGQvya00rvIWi+5TgRtsh4QwvjWuHC0SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOzLkPzEMVqIqaYsGQucm/6I7H2WIP0xgVF7mAdwzR5dd4EjNsyiYqkZHFTu26gv+HL0DBl/8tKHNSFhbOSQ45/3Fb4/Qf3WiQXlz2wMvZT8dhdXcdPWIENp1xjBdgS4B+tI/PgXfbDZ+cCmowesOohDsxeMLAAxh6Ttf6RCHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDhgvxU/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F311F00A3D;
	Wed, 17 Jun 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706464;
	bh=TbXoQinPA4I9fDQmqsTR0eDggoTGl5FrMCaKRpD+Wtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDhgvxU/LS5Irc/LLWIUSLqTbUG8vyu/rt09tkXhh5Erxbv3qdTKvoVDHHTRvojV4
	 MvRSVfXEQlPFHkmNXI2iz+vxG3L396YltKZ6Z4Yw5Lf0EaIgZoTnBx4QlIdEH3wK45
	 sdnoySZk+8nYkKFJnje3Tbjk+aJJNyGBpCRMDwIBRPWVVN4f5dQdX7W9I4wCMlp2QB
	 7R7rypRyIU5gKUkVDOiGriJws9v7WS7QG1wuQDfCFapxgQUy9zXqWlpMOCSGsPj1cS
	 JsO1W2F/uS9HFDXTXmTZAp1/dg0Ce0ezUAh02uohQSSZCmsJ33y9tsqQbzi7/Q9eMH
	 miPuCStu2vNDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 5/5] firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator
Date: Wed, 17 Jun 2026 10:27:39 -0400
Message-ID: <20260617142739.3938338-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617142739.3938338-1-sashal@kernel.org>
References: <2026061551-lung-clutter-0849@gregkh>
 <20260617142739.3938338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:krzk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266788-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D48FB69A875

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit bf296f83a3ddab1ab875edc4e8862cb10553064f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 7eda1aff4c197b..c472569441949c 100644
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
-- 
2.53.0


