Return-Path: <stable+bounces-264374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yeVXAzp3MWoakAUAu9opvQ
	(envelope-from <stable+bounces-264374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F4032691E7B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UvDqJ82g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264374-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264374-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 587D530D62BE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C04657F4;
	Tue, 16 Jun 2026 15:59:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2E450903;
	Tue, 16 Jun 2026 15:59:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625541; cv=none; b=GeEopPRZ7rEcZpD0kqA0cEzahuV08fA2FKPGDrQEK7GEc+V44jjUtfAv+bnF4u59acuojcRXPURilLGAo5hR/vIvepBtSo5pYAhXTzD1GiNoPfN34rG3isCpyXO6dAKyaoMwTclOKbOkJ53si13UxIBJxvrssNr72mgNR6X3FMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625541; c=relaxed/simple;
	bh=bxq3pRJZO41WKXCYnhffBBE/AFl/wcJ/AVK6NG09f6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG52rDeQd5qqCUYNOwnenyi3LdXVl9xyqxrnTiFXUfu8hn/jZjnU7H6Vn2l2xNELIr7xyf7xVYbqMmslq2aw7am0k9G4qFiIayD9fkf8fMc40oVRneBb/coI7GttPQ/kR834jVqouLS8KTAaP7x9peLn2LzDZsjvb0HvO834iDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvDqJ82g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA91F00A3E;
	Tue, 16 Jun 2026 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625540;
	bh=Qp03/BLK5O2mVhqD5lx4zdPrDl+ZEIMH11UjhkZBAvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvDqJ82gULypMZsg5hXyKJ4aJpnSIX4+ibp2ep8ZaQhf3M4LIMNQlJbjJ+/eXKNvF
	 hALLYc8jKbc35+8ORIoVGynRwkc7hl5AeKTO99Uc/ckvqFQKg3JG5X5S9nIT1Qm5P+
	 mqhLqaU642PwnTAPg3hq62nqYmCIxKVltpwkkgjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 6.18 163/325] mmc: litex_mmc: Use DIV_ROUND_UP for more accurate clock calculation
Date: Tue, 16 Jun 2026 20:29:19 +0530
Message-ID: <20260616145105.902436958@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264374-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:inochiama@gmail.com,m:gsomlo@gmail.com,m:ulfh@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F4032691E7B

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

commit b837e38c255dd9f8b53511d52e87f1fda32b3dfe upstream.

The previous clock uses roundup_pow_of_two() to calculate the core
clock frequency. It does not meet the actual hardware meaning.
The actual frequency is calculated by "ref_clk / ((div >> 1) << 1)".

Fix the clock divider calculation.

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/litex_mmc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/litex.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -436,11 +437,10 @@ static void litex_mmc_setclk(struct lite
 	struct device *dev = mmc_dev(host->mmc);
 	u32 div;
 
-	div = freq ? host->ref_clk / freq : 256U;
-	div = roundup_pow_of_two(div);
+	div = freq ? DIV_ROUND_UP(host->ref_clk, freq) : 256U;
 	div = clamp(div, 2U, 256U);
 	dev_dbg(dev, "sd_clk_freq=%d: set to %d via div=%d\n",
-		freq, host->ref_clk / div, div);
+		freq, host->ref_clk / ((div + 1) & ~1U), div);
 	litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
 	host->sd_clk = freq;
 }



