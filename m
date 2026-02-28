Return-Path: <stable+bounces-220373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDIuNTxHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA741C76D4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20BC731E5977
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836334A3DB;
	Sat, 28 Feb 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgKAycxY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0E35AC38;
	Sat, 28 Feb 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300268; cv=none; b=RZHZrxyDOStT6rWAsCzojctsCPiYVHFjz1GchM7JWyUPRtCkpgDTelQq3ItVUAGQJY5ORzx47s+nGZh6iurfmdRtr3JpLrOO940FmQk+EM9TYhevY/AJ/aS3O5/Va97QqHjRUVpdFp19HuAQ8Wc2IhOK/MQ1wUp3ZQmzf8HjDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300268; c=relaxed/simple;
	bh=Smv77XQEJ5/xq6cT/QFfKDsGNU3NpzZ+gFapQgA2lqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH/1c6gyciWUw7ca7tShRrfN9vYVrW5tmFXMCPM38fb7dcVyB3Ch2Y78k/YXVfTCPruXPJpwlr4mW95W6B8ZEaTEBRngDF75Xd2FpZit2VpR+JLiREqymEPMakBDLvGQvAmKowFElTxbImmK2mDwpHGG2XyXnF3VboqiUqTR2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgKAycxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85ACC116D0;
	Sat, 28 Feb 2026 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300268;
	bh=Smv77XQEJ5/xq6cT/QFfKDsGNU3NpzZ+gFapQgA2lqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgKAycxY70Eyyk5bZaNN0zy9GbRZheJwklgxori7bb4M1CpZJK3WtzKAMdEtP0Gu+
	 QBaS/uTbp4dmmruS8tPUuRggXADmxK3cVFwl9ka6Ua1wjZ0L0cITjvHe7NgmFy/7YZ
	 vS0skvFN5GqkGsuhJtiAlcUUj8pFJHkuNFU61MpntU5twF9Wmy/Q3XspvAVbO6VXBb
	 d2/A6L3VDxiN8GeyQ4vWzMgzq7mt0dtZuZZABqUirx4NRr0ffRPbz1JVX4NXJZPwLC
	 QAdL2PPIzlSraVKbtSSFAboPrhja3c6CS65LF2zxvj2Jn2fkY1rbJ7AI37aZJ26NXK
	 FBOZah8xQYD5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mingj Ye <insyelu@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 294/844] net: usb: r8152: fix transmit queue timeout
Date: Sat, 28 Feb 2026 12:23:27 -0500
Message-ID: <20260228173244.1509663-295-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220373-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,realtek.com:email]
X-Rspamd-Queue-Id: 0AA741C76D4
X-Rspamd-Action: no action

From: Mingj Ye <insyelu@gmail.com>

[ Upstream commit 833dcd75d54f0bf5aa0a0781ff57456b421fbb40 ]

When the TX queue length reaches the threshold, the netdev watchdog
immediately detects a TX queue timeout.

This patch updates the trans_start timestamp of the transmit queue
on every asynchronous USB URB submission along the transmit path,
ensuring that the network watchdog accurately reflects ongoing
transmission activity.

Signed-off-by: Mingj Ye <insyelu@gmail.com>
Reviewed-by: Hayes Wang <hayeswang@realtek.com>
Link: https://patch.msgid.link/20260120015949.84996-1-insyelu@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2f3baa5f6e9c9..6b107cf5f37bd 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	ret = usb_submit_urb(agg->urb, GFP_ATOMIC);
 	if (ret < 0)
 		usb_autopm_put_interface_async(tp->intf);
+	else
+		netif_trans_update(tp->netdev);
 
 out_tx_fill:
 	return ret;
-- 
2.51.0


