Return-Path: <stable+bounces-228537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNnfN3RQwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:38:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45A2F4E8E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF17312A77B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB739890A;
	Mon, 23 Mar 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGlC/cM+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202D3C07A;
	Mon, 23 Mar 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275393; cv=none; b=rnXXu7qblA/QGIZoPRByUbwoiK6spOf407FXXj1lTQtzOIU4XXP37DGTd21b8X7E81s99ZCaLo5zTd4NMri5MHuNa8g3HhltB2wLv+C7bRNArkQXqKJIkZz2uY9J1Pj3ANBUjJoWRn4GhadNkkcgN5FXr/dnEM6mSV510V3XiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275393; c=relaxed/simple;
	bh=M0qjEZvHxJbyvlr85w7cnFRWPcknBwE5d1dFQXcbZuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3zZ5Nx926FE/tBvGIb83H8eImPwXRw5KRCFqejJfypMnen/tW4tBH90X8rdGz3epLwIFWb0VYg4rai+OGatF2D0BtEn08KFw8HD3X9cS/ErsNTNvCzdD2oO0mNET11SaW3OEKmW+HjIsiW0oKSL7bZCaFoDAOfpYY5Dt5kc+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGlC/cM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4526CC4CEF7;
	Mon, 23 Mar 2026 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275393;
	bh=M0qjEZvHxJbyvlr85w7cnFRWPcknBwE5d1dFQXcbZuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGlC/cM+e0h5y057sc9XppVwG1WrasEU1pxC0votf0kK50OI6WKNspUIY9P7Z/Pn/
	 HHquWqK+keFJDqq8CypujLGM8b4TfhDUyNCtqpjTWvouzsv76M/zycCL9VNE5rEyGa
	 Wdz4kR4geWd+5mvCafwRdxLdiX/yyoAbEsCPHM0s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 082/460] net: dsa: realtek: Fix LED group port bit for non-zero LED group
Date: Mon, 23 Mar 2026 14:41:18 +0100
Message-ID: <20260323134528.695915011@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228537-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[msgid.link:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B45A2F4E8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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




