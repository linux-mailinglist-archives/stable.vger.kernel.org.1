Return-Path: <stable+bounces-248036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LDLEtVGB2r6wAIAu9opvQ
	(envelope-from <stable+bounces-248036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB8552E9D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4751432AED7E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AE17C220;
	Fri, 15 May 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eEUGGGWI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8B35AC09;
	Fri, 15 May 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860704; cv=none; b=GrBbvDiOQ7jUaYEWdivcM+jQx306vqxP2rNx0f1GdA0An3NPZh1ddSFhHjTwCHr4qkh/kHhZB6o8wTRsonn+ywlrdl+0/cdtRPPfb/rqO+2EU5ARD346zmXdyVNzjI/KXtVoGKRVx/5+Abx64dD0ASD86yf2Nxa0fW6AKm5bNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860704; c=relaxed/simple;
	bh=8bNy+Tqsm+Fuc3nLrK76n9YMV6Ly5s95DYgTuQ/b0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ohj83r4GKI4y3dqm5vPsD49Mkgx+GTsjIwjlvS2rOlym3U5MpaSwTMy+G6zrGE93xSlUK6OeCVgNzJ3j28LLPRECVhL60dpTKrrMhQePO50A5r+iT5OmTx8popykdOSp3/5PERzhtLbTdTztelh3tCl3L0jHrbwDTWGQNo+ahXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eEUGGGWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F81FC2BCB0;
	Fri, 15 May 2026 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860704;
	bh=8bNy+Tqsm+Fuc3nLrK76n9YMV6Ly5s95DYgTuQ/b0eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEUGGGWIfgG7XNJ2WgZBvf/T9H98sJRHzgVMtElKJOe8+V2yvBt/W+6PSgWHkv6Ak
	 JZ3MGEKTU04I7bkLYKw3DvoWJ3d0d9sGz9ho3GxaNwbZTcNnDX9ZsVURZeNLMqZY+4
	 qPBTzpHCfdICc+lK6CGc6D6EahIELb5cTDvi2xf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.6 047/474] mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
Date: Fri, 15 May 2026 17:42:36 +0200
Message-ID: <20260515154716.066025735@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D6BB8552E9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248036-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

commit ffdc5c51f8bcd0e5e8255ca275a0a3b958475d99 upstream.

Attempt to shut down again, in case the first attempt failed.
The STPMIC1 might get confused and the first regmap_update_bits()
returns with -ETIMEDOUT / -110 . If that or similar transient
failure occurs, try to shut down again. If the second attempt
fails, there is some bigger problem, report it to user.

Cc: stable@vger.kernel.org
Fixes: 6e9df38f359a ("mfd: stpmic1: Add PMIC poweroff via sys-off handler")
Signed-off-by: Marek Vasut <marex@nabladev.com>
Link: https://patch.msgid.link/20260122111423.62591-1-marex@nabladev.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/stpmic1.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -16,6 +16,8 @@
 
 #include <dt-bindings/mfd/st,stpmic1.h>
 
+#define STPMIC1_MAX_RETRIES 2
+
 #define STPMIC1_MAIN_IRQ 0
 
 static const struct regmap_range stpmic1_readable_ranges[] = {
@@ -121,9 +123,23 @@ static const struct regmap_irq_chip stpm
 static int stpmic1_power_off(struct sys_off_data *data)
 {
 	struct stpmic1 *ddata = data->cb_data;
+	int ret;
+
+	/*
+	 * Attempt to shut down again, in case the first attempt failed.
+	 * The STPMIC1 might get confused and the first regmap_update_bits()
+	 * returns with -ETIMEDOUT / -110 . If that or similar transient
+	 * failure occurs, try to shut down again. If the second attempt
+	 * fails, there is some bigger problem, report it to user.
+	 */
+	for (int retries = 0; retries < STPMIC1_MAX_RETRIES; retries++) {
+		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
+					 SOFTWARE_SWITCH_OFF);
+		if (!ret)
+			return NOTIFY_DONE;
+	}
 
-	regmap_update_bits(ddata->regmap, MAIN_CR,
-			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
+	dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);
 
 	return NOTIFY_DONE;
 }



