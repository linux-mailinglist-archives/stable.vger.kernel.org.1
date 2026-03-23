Return-Path: <stable+bounces-229191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF8COjFawWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4D2F62A1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FF6F306474F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DF3B8D4B;
	Mon, 23 Mar 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWFAfSx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC03B895B;
	Mon, 23 Mar 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278348; cv=none; b=Ze3vRLizr9QEp5LsMu6Z4flDFJOpBLYtDTqn1PN7EoWprI1e/1h5hru4tplv5LxPhAWJSZCa25RaYYE0OOhax6x5nlh4M9ZFEXDPn00ANUp9PelUXaU75pwHEubJWgfRninV6E89FU8aceg+oLcPWMi/hMtVrwsfk1xdXVKZxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278348; c=relaxed/simple;
	bh=BWmuUMJWwjNP3+rdYwKaNOn5JnKdD0x6Nzpn4rB5y6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVnP+qEuzOa4QwUtIjyxCEBupOeYXu466Ltm+diuIRGW2rxFBoNwjBvz7rMbbubb1z1ONaQ30UaU1YzGKk6Fus98aCffZYay2AYBpQl7Y/T7H4YzCQlf94CGE1D/HCZa7zkEwjiri7RdhAR5pM1GmBnhFudu9BXOF6pxW/IVwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWFAfSx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4022EC2BC9E;
	Mon, 23 Mar 2026 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278348;
	bh=BWmuUMJWwjNP3+rdYwKaNOn5JnKdD0x6Nzpn4rB5y6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWFAfSx9pYKgceMc1lxmlbxgphOa0ncMTQFlvLYiZ/TyG7iY47t1eci32Lj2sA0Cb
	 3Otd7qaQfm7zOUl/rCaXFGL0KIwyx9wDyM7Y9/RHh0rQfa3ez2EbwK1qBWWDIOI/55
	 4kck0dV9bHLNciXBu929NXQRyKwhj3q5WFbJOCwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenyuan Li <2063309626@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 236/567] can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value
Date: Mon, 23 Mar 2026 14:42:36 +0100
Message-ID: <20260323134539.675092372@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229191-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qq.com,pengutronix.de,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 87E4D2F62A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenyuan Li <2063309626@qq.com>

[ Upstream commit 47bba09b14fa21712398febf36cb14fd4fc3bded ]

In hi3110_open(), the return value of hi3110_power_enable() is not checked.
If power enable fails, the device may not function correctly, while the
driver still returns success.

Add a check for the return value and propagate the error accordingly.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
Link: https://patch.msgid.link/tencent_B5E2E7528BB28AA8A2A56E16C49BD58B8B07@qq.com
Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
[mkl: adjust subject, commit message and jump label]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/hi311x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 1acd4fc7adc8b..2038b864832c9 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -756,7 +756,9 @@ static int hi3110_open(struct net_device *net)
 		return ret;
 
 	mutex_lock(&priv->hi3110_lock);
-	hi3110_power_enable(priv->transceiver, 1);
+	ret = hi3110_power_enable(priv->transceiver, 1);
+	if (ret)
+		goto out_close_candev;
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -791,6 +793,7 @@ static int hi3110_open(struct net_device *net)
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
+ out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->hi3110_lock);
 	return ret;
-- 
2.51.0




