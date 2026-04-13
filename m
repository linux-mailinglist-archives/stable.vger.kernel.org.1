Return-Path: <stable+bounces-235981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AElyJui63GljVwkAu9opvQ
	(envelope-from <stable+bounces-235981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE33E9FB4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 175C9301F498
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BB3ACF10;
	Mon, 13 Apr 2026 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="H57422gD"
X-Original-To: stable@vger.kernel.org
Received: from mx9.kaspersky-labs.com (mx9.kaspersky-labs.com [195.122.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD953A383B;
	Mon, 13 Apr 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073382; cv=none; b=khh2lrogRf+7fB90TPgIln61XhMcRGxSKOdsZWy8wlUqj87S2jQENZCyaBuH7HeIyIk29hjb9wGE51tjEa//2GeqLGhdXpjNbVc4wwML/Wd6tFezKzO45Gwgw8gEN1bejzx1gyWLOmU0v5ZmAHY0vsm8CABHMQ/L4q5eoPQdWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073382; c=relaxed/simple;
	bh=vjbVZzxCSA1t9isGeReY/yIpvFirFZEfJlFWah1o0xo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZVBIGT/5JvoKCxeGq2mTaeAmIcn3wPq5qf6GV/9K+oQ6QF1yj5nbho4i4X7OJLpMBtvWqAWtESiOBKIoKVmgKuCW52t1slhG1hU4kCwro7Y06vE8m8socKdhZkc4SbTojtCsdA8KFL9uqIkGuHu51DpbQ3PcAszE2x3/+TVwzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=H57422gD; arc=none smtp.client-ip=195.122.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1776073379;
	bh=x4lKBSdZdsxXDAjfnVaREem6d/vq6Wg3horiq03ED18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=H57422gDyYF89da/DpyAefaZZ3ZhVcjdWx0lmD+YpqIwjoC/acOTU3zK97g22AQyX
	 5Ai1Z020l/RF/MksdfU9zEzgoj8EswTTHzMiB/iMv7bNG5KrRvMNqaz7PqUKtYL+UD
	 AudhNHPFnmZN/iRDnpJKpgpMU2zTvw3TlhRbv2adDgKxIvjpLIxgXRKG00W0NWkGhD
	 GDvGgrctsRT319SdVVuyJh1SIrg9gu1V7Ze/iKwuW1h72321rUYINefba4pw1yUFBX
	 +pzNZ+9dBIYeO2Y/2scWhRw6h2gxpqKvnsXkNWdY4woUgU+BezOn/nF9ppnWwli3Gw
	 gaOaZ8JoNqL6Q==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
	by relay9.kaspersky-labs.com (Postfix) with ESMTP id 1C7418A0705;
	Mon, 13 Apr 2026 12:42:59 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id D3BCD8A061E;
	Mon, 13 Apr 2026 12:42:58 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Apr
 2026 12:42:58 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <gregkh@linuxfoundation.org>
CC: <lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<Pavel.Zhigulin@kaspersky.com>, Alexander Chesnokov
	<Alexander.Chesnokov@kaspersky.com>, <stable@vger.kernel.org>, Johan Hovold
	<johan@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: udc: renesas_usb3: Fix wrong comparison in usb3_dma_update_status()
Date: Mon, 13 Apr 2026 12:42:49 +0300
Message-ID: <20260413094256.47014-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/13/2026 09:19:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 202222 [Apr 13 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 98 0.3.98
 ca9d2f3beca9ca2a85e178af9d8e97d5fa2c38a3
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1;chesnokov.avp.ru:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/13/2026 09:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/13/2026 8:25:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/13 06:49:00 #28394185
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kaspersky.com,reject];
	R_DKIM_ALLOW(-0.20)[kaspersky.com:s=mail202505];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kaspersky.com:+];
	TAGGED_FROM(0.00)[bounces-235981-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Chesnokov@kaspersky.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url,kaspersky.com:dkim,kaspersky.com:email,kaspersky.com:mid]
X-Rspamd-Queue-Id: E2EE33E9FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

If the last PRD entry flag is not set, the condition (i + 1) < 
USB3_DMA_NUM_PRD_ENTRIES is always true on the first iteration when i
equals zero, causing the loop to break immediately and only one PRD
entry to be processed.

Fix the comparison operator from < to >= so the loop breaks when the
PRD table is exhausted.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2d4aa21a73ba ("usb: gadget: udc: renesas_usb3: add support for dedicated DMAC")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index c6f2a09f561d..22404ef40601 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -1410,7 +1410,7 @@ static int usb3_dma_update_status(struct renesas_usb3_ep *usb3_ep,
 		req->actual += len - remain;
 
 		if (cur_prd->word1 & USB3_PRD1_E ||
-		    (i + 1) < USB3_DMA_NUM_PRD_ENTRIES)
+		    (i + 1) >= USB3_DMA_NUM_PRD_ENTRIES)
 			break;
 
 		cur_prd++;
-- 
2.43.0


