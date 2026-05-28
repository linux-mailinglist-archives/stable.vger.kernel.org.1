Return-Path: <stable+bounces-255563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCwTJ9ajGGrClggAu9opvQ
	(envelope-from <stable+bounces-255563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC825F8764
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E045C320A984
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFDE3F870F;
	Thu, 28 May 2026 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yYdS+G3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25533CE8A;
	Thu, 28 May 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999264; cv=none; b=HhrXeFnrPgeG28tmz2EwvKP4E8GPj3JW/RV5jEmFnD3OJ8cb8+mArBertMtOM6omwzgxQ94GyYvp7ONajXf1hOEUzCiMlvEbyUQXAGaua+p8/EEp3pH89x4t7dPzLNZUhU5W0UUKUx6Po+ER1ru+FfTxJEeMQy0BQei2xxbBKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999264; c=relaxed/simple;
	bh=7E+PHVwwaciA01Z4Ur3vDoDWhGG+4bpse/rE14PKk5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVY/yVwD9waDPph2Ii2RKjEQKiPVf9J/MN2daDU6azSEqtj0g9AlYM8qAKFVrcoligmiKmwEYcVVSRJLCcntgjVs/Uucj5m1LgaFH0tQ6egH5fVUJvRNSLMBvdY2Jm9hKoZWFMEAgaCMX1l5Q318f3qjvP0EEpsAeOMvCU27nFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yYdS+G3Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF1A1F000E9;
	Thu, 28 May 2026 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999263;
	bh=vrTn0N1onAlPPOXTMQxP4dVDpeFjMZGGyRJKtV/hCEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yYdS+G3YyOepg/e6ZeUN45fShm0+kHO5qE7NP54td3uxUfNaVets6BAQihG8OUQaO
	 Xf1LkfVQxmsy8HbGVRW7TOyZGEWCVHySgilubripoduz2rkTI2mxrkQwP8uqXSlhxP
	 xCDLqNeH3gqY86O/3fMK49ODNAMTJdFOKcXhGrlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 437/461] gpio: aggregator: fix a potential use-after-free
Date: Thu, 28 May 2026 21:49:26 +0200
Message-ID: <20260528194700.180706392@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255563-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,glider.be:email,qualcomm.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0CC825F8764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 30c073cab97afb31901f94de9605177b6b84367e ]

On error we free aggr->lookups->dev_id before removing the entry from
the lookup table. If a concurrent thread calls gpiod_find() before we
remove the entry, it could iterate over the list and call
gpiod_match_lookup_table() which unconditionally dereferences dev_id
when calling strcmp(). Reverse the order of cleanup.

Fixes: 86f162e73d2d ("gpio: aggregator: introduce basic configfs interface")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520084911.27938-1-bartosz.golaszewski@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-aggregator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 9adf3228c12a8..6c84ca3ff1b64 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -969,8 +969,8 @@ static int gpio_aggregator_activate(struct gpio_aggregator *aggr)
 	return 0;
 
 err_remove_lookup_table:
-	kfree(aggr->lookups->dev_id);
 	gpiod_remove_lookup_table(aggr->lookups);
+	kfree(aggr->lookups->dev_id);
 err_remove_swnode:
 	fwnode_remove_software_node(swnode);
 err_remove_lookups:
-- 
2.53.0




