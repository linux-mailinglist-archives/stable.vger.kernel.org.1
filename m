Return-Path: <stable+bounces-210986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNg9KeEdcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:41:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5085B6B6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F026AF835
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6A25F78F;
	Wed, 21 Jan 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ihn7Douq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299D34A3D6;
	Wed, 21 Jan 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020052; cv=none; b=cjrhOio0hZddvHQWI6PUKgAT3pa8QUeTASXiZC59aZrlxeJIvsEJLzIRc1yg2ONVooLQOLnwqQ69HOB+dvO0WywD+zVgNTxUmz3eM7DeecyVfRCZ+8IFAwbgOdjTifoIzgLFZk290fbH3IeTRDoCcihxlOqUZpdOHXByYKtAkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020052; c=relaxed/simple;
	bh=9V7uOuhrrmollvcgTJ+F+03exQzN//Spu2pSAfydFPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIfkPnRmslfcjjJuQR8U+tV4Rh/7Oc+5VP2ZsyD1/ZROux7LvXhZh/82f/xEGkuXBxyT7/rsb+xlzggAjqC8zqtqDvxORWErcJB3fQ5WXLWe2qq8gkRt9O5Rvg/0a/AoV6ffnVTC/8KBVjH27LE/uLXjieXFjlFOV39UnfI/RnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ihn7Douq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88BDC4CEF1;
	Wed, 21 Jan 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020052;
	bh=9V7uOuhrrmollvcgTJ+F+03exQzN//Spu2pSAfydFPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ihn7DouqQoXjuHoaLhf2a+dLKokEqNBRj3Y/ToOJ+9LwqMH5BARTvVIC1VKYxpT7i
	 VKGS2eFWUcC/9JMjzgoR8qjJPiWLoN486H3JBdHKfFnai6xcH0IqXOmC/AAvED1LjF
	 3Wjij5IKh/AjAVw51lsSdnvhbKiAzMnFloGusKbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 046/198] net: phy: motorcomm: fix duplex setting error for phy leds
Date: Wed, 21 Jan 2026 19:14:34 +0100
Message-ID: <20260121181420.208496888@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210986-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,lunn.ch:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 0E5085B6B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit e02f2a0f1f9b6d4f0c620de2ce037d4436b58f70 ]

fix duplex setting error for phy leds

Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260108071409.2750607-1-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/motorcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index a3593e6630594..b49897500a592 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1741,10 +1741,10 @@ static int yt8521_led_hw_control_set(struct phy_device *phydev, u8 index,
 		val |= YT8521_LED_1000_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
-		val |= YT8521_LED_HDX_ON_EN;
+		val |= YT8521_LED_FDX_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
-		val |= YT8521_LED_FDX_ON_EN;
+		val |= YT8521_LED_HDX_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_TX, &rules) ||
 	    test_bit(TRIGGER_NETDEV_RX, &rules))
-- 
2.51.0




