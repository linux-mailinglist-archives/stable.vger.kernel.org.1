Return-Path: <stable+bounces-260973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2TouEyBDJWolFQIAu9opvQ
	(envelope-from <stable+bounces-260973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A409364F570
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:08:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xpVscCQ4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260973-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260973-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06D3B3014125
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286602F49FD;
	Sun,  7 Jun 2026 10:07:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13913234994;
	Sun,  7 Jun 2026 10:07:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826831; cv=none; b=fowpthPtvOrV3UHsmdkx14NXtjdnk/IPajqIOK6G5EgzKq4ZYCBx996Ta65OCmyzBbkFiLHn+OcVQgfhiJK8nmzldrr84nL86X2JSYOaB1xFMwEg+NLnG9zkYEUJgZcA3Mh0Dzb3MiriUIIiTOOvqv7WlpGgrFuIAiHqJwfb7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826831; c=relaxed/simple;
	bh=LVb5PkXYrjyEBwjd9J38VSw/glzOY5jjrS50+ZrniQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFDj4maUyh0DJO4rbOvkqufMrr65BbY5YxrYbGcSK4ThQNcia4ElkDQjoXRtzs3Sntc6+mVxrFjtItDHB9cz6zFTTjXPZMRvGOAdDqzwkYzOFICJlfd0xaZwpFkbyXNxPQM2vgydewcPu1Q3uz56ZaM1HyBEgqDm8lqMMa+dzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpVscCQ4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F651F00893;
	Sun,  7 Jun 2026 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826830;
	bh=KN05UH7sdHj+GGkiyosjZum4cls9B6N1y2OnPqx7z2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xpVscCQ4pdx4uMokOEWBC3F/Kt1uPk51ryZzpNpDW7PwQWqVrJCAR5M9fGlHY5gay
	 6b1f18LClTp9KRsd1Fcz7DS9/RZcyKy63z1FrYMwGo1PnVgy4wdKrByvrK4OSGWOeG
	 lA2Q08r3FtYkeFsQDglj5MnSpCIqHr+R804qBd+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Kai <lukace97@outlook.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 012/315] HID: remove duplicate hid_warn_ratelimited definition
Date: Sun,  7 Jun 2026 11:56:39 +0200
Message-ID: <20260607095727.951400287@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260973-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lukace97@outlook.com,m:bentiss@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A409364F570

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Kai <lukace97@outlook.com>

[ Upstream commit dd2147375a8fe7c5bc3f1f1b1d3a9567c26faefa ]

The hid_warn_ratelimited macro is defined twice in include/linux/hid.h:
- first one added by commit 4051ead99888 ("HID: rate-limit hid_warn to
  prevent log flooding")
- second one added by commit 1d64624243af ("HID: core: Add
  printk_ratelimited variants to hid_warn() etc")).

The second definition is correctly grouped with other ratelimited macros.
Remove the duplicate definition.

Fixes: 1d64624243af ("HID: core: Add printk_ratelimited variants to hid_warn() etc")
Signed-off-by: Liu Kai <lukace97@outlook.com>
[bentiss: edited commit message]
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hid.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 204ada8d12e5c8..29561887bea8c0 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1276,8 +1276,6 @@ void hid_quirks_exit(__u16 bus);
 	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_warn(hid, fmt, ...)				\
 	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
-#define hid_warn_ratelimited(hid, fmt, ...)				\
-	dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_info(hid, fmt, ...)				\
 	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_dbg(hid, fmt, ...)				\
-- 
2.53.0




