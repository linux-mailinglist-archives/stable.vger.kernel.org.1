Return-Path: <stable+bounces-261189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uTNJD8hFJWp/FgIAu9opvQ
	(envelope-from <stable+bounces-261189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77264F889
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:19:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tw5hzy7+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261189-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261189-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA9D93014688
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702912DB7A3;
	Sun,  7 Jun 2026 10:19:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C44071DA;
	Sun,  7 Jun 2026 10:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827589; cv=none; b=N8EHpQBTw90pOMjRwj/MV/6FPvfunsrzCX5OsdHB6xuyUHT0B0lAxX4zpOHmiBEGyr5BENeRAQhaPxFvl0Iw+fKeJKmBo73TT0VS81x3xKYBdYd6eGqgxTNIuKcyrtZD59sN2okFc6SQpxloG9pyrXbKo/pD+zaf8F5y1CZexgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827589; c=relaxed/simple;
	bh=A2AQstxwm0d8MogqFvLOdiu/cFrVWSP+kC2HsFSJ4QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZFTErrcHvI9VrZwRRX/IsuxchTwe4gqP2H6vYoN8wR8wmNb5tJdL8RFZVRZbx+5x/zRgwr14g3ZC3838PIx2ehL6BXryhiWaMloAD3jJmfC9CHNE57oc/7Nb8AZjF1YnS2wmzEZcy6P+gb63kNa/Afowa04mU/8ytiNacoS3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tw5hzy7+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BBC1F00893;
	Sun,  7 Jun 2026 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827588;
	bh=6BaAHc/uKiKJ5S15bGB660FA2rnpskg/xIJmPaFDZvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tw5hzy7+oCkBLRd2Ff+QWLwI48bmfiM1LffRvC6OTqu+Fbd8fPMeAxzzA1pcuEMl1
	 hPJmS6Dwm9pipf1nq5xqqkp9UyEdwUI9AndawaBER9USz24BsmQFvzFLConZ3JlUXB
	 R4wMBTAeONSvXT0JBmsRx+HHcIJGiWkr1lEbUCIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/307] ethtool: eeprom: add more safeties to EEPROM Netlink fallback
Date: Sun,  7 Jun 2026 11:57:48 +0200
Message-ID: <20260607095730.369342651@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261189-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB77264F889

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 67cfdd9210b99f260b3e0afeb9525e0acc7be31e ]

The Netlink fallback path for reading module EEPROM
(fallback_set_params()) validates that offset < eeprom_len,
but does not check that offset + length stays within eeprom_len.
The ioctl equivalent (ethtool_get_any_eeprom() in ioctl.c) has
always enforced both bounds:

  if (eeprom.offset + eeprom.len > total_len)
      return -EINVAL;

This could lead to surprises in both drivers and device FW.
Add the missing offset + length validation to fallback_set_params(),
mirroring the ioctl.

Similarly - ethtool core in general, and ethtool_get_any_eeprom()
in particular tries to zero-init all buffers passed to the drivers
to avoid any extra work of zeroing things out. eeprom_fallback()
uses a plain kmalloc(), change it to zalloc.

Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-11-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 03cb418a15823b..80af38a6c76acf 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -43,6 +43,9 @@ static int fallback_set_params(struct eeprom_req_info *request,
 	if (offset >= modinfo->eeprom_len)
 		return -EINVAL;
 
+	if (length > modinfo->eeprom_len - offset)
+		return -EINVAL;
+
 	eeprom->cmd = ETHTOOL_GMODULEEEPROM;
 	eeprom->len = length;
 	eeprom->offset = offset;
@@ -68,7 +71,7 @@ static int eeprom_fallback(struct eeprom_req_info *request,
 	if (err < 0)
 		return err;
 
-	data = kmalloc(eeprom.len, GFP_KERNEL);
+	data = kzalloc(eeprom.len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	err = ethtool_get_module_eeprom_call(dev, &eeprom, data);
-- 
2.53.0




