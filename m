Return-Path: <stable+bounces-226234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM4eCiKGuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB092AE7CC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0423033E0B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE93EDADF;
	Tue, 17 Mar 2026 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CrTt80RQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2853ED5C7;
	Tue, 17 Mar 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765830; cv=none; b=KK47K/G2S33Gd7Jx+tW6S4hBIRRdwI1mh7AOXJvc32sEOT/zzOJp0+DwYPzKLKF+B0ZSL84gGH1nHAuLgDqQNl/toiUR39fhUNq1ThHiHpH31oaizqIQJTwZLvxi/t7YsN1WKqOqm5hA7GekfUR0NEwdRrOdOixmuM4SS2xnrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765830; c=relaxed/simple;
	bh=WS2x6U5zPEE3DCVjACt36Cu1T0j3K1A80GQ882s6DRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogg7AVcDvZCN6e91l8ciaBC09agiZsgUzXexUZ5GVQaLOnsh76I0FeOoSyrhnkdBRIlnWamebylpMHi9Wz9dC90yjzOcY8iQPLnfL0LI45W544uwfcq/z7kZT36aFqiB/ppPLLR20Bf5g6dSxSlNhMIV0aJP0WXzMV6OPfX5ABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CrTt80RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47256C4CEF7;
	Tue, 17 Mar 2026 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765830;
	bh=WS2x6U5zPEE3DCVjACt36Cu1T0j3K1A80GQ882s6DRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrTt80RQmQZuVJK1dYznHRUKyq3KVSj3hVkOPaWmqcJsuis6u4bZp6UqygIAFZUyA
	 ElFN+PEYtW+bGBuAekCkp+c895p53922Wyykl+BLqYKCibpmIEMv8BR3PzX7rp1rN/
	 lImyTP6+r2EZ1pFjGe0jVPvitrK+E16paGxMh/U8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 105/378] net: dsa: realtek: Fix LED group port bit for non-zero LED group
Date: Tue, 17 Mar 2026 17:31:02 +0100
Message-ID: <20260317163010.880567641@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CB092AE7CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit e8f0dc024ce55451ebd54bad975134ba802e4fcc ]

The rtl8366rb_led_group_port_mask() function always returns LED port
bit in LED group 0; the switch statement returns the same thing in all
non-default cases.

This means that the driver does not currently support configuring LEDs
in non-zero LED groups.

Fix this.

Fixes: 32d617005475a71e ("net: dsa: realtek: add LED drivers for rtl8366rb")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260311111237.29002-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
index 99c890681ae60..509ffd3f8db5c 100644
--- a/drivers/net/dsa/realtek/rtl8366rb-leds.c
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -12,11 +12,11 @@ static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
 	case 0:
 		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
 	case 1:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_X_1_CTRL_MASK, BIT(port));
 	case 2:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_2_X_CTRL_MASK, BIT(port));
 	case 3:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+		return FIELD_PREP(RTL8366RB_LED_X_3_CTRL_MASK, BIT(port));
 	default:
 		return 0;
 	}
-- 
2.51.0




