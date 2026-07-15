Return-Path: <stable+bounces-274737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G9SbKQojV2oeFwEAu9opvQ
	(envelope-from <stable+bounces-274737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:04:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A875AD46
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:04:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=UNfd8vhp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274737-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274737-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADC443016ACC
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D037B003;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1330674B;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095482; cv=none; b=tuQwEc3zK8rmRvEr6EyNwTVX8K/0rMlSJKdzR3CCK2UWxPQj9sp2H9ag4AmMfzbcW3AP0v97Nkfe4MbkMUaEnTih8DhfWGTkM9wWxoiy67LL66JyucNzA+FNLe3JtvFcrJxmJnWq79McjJmD0Fus0OPHA2Uo2C069Vlxc/Uig1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095482; c=relaxed/simple;
	bh=Su3y5H+XropravPSwjmbGLXz02SfJzDuKDVzb682+LY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ifBdP0ElQsD9QehHpVSZKHOprfhI52a+MXDlRLV5SH6XNFwB6cU/7U/bc2/iVUfzME7Xs0iDFx+71l8tO09M58A+yHVwXJhbFKXFhMiQEzlnkoRHDa1tPWR/+5fAjjE2aEWEzGzjP605HG5269EO/gsJyO8zY43IvhqO4O/eu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNfd8vhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 248C3C2BCB7;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784095482;
	bh=Su3y5H+XropravPSwjmbGLXz02SfJzDuKDVzb682+LY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UNfd8vhpdBX4fTycTNbAQhcO0vD2VJY7FtRrsCM3eTtsTYAmAdPhe/HXzwm7v/NEe
	 JMhFgzObWc8n9W0u/SVPb5TTkB1QQ92AJnqVSF/22KOKuOE9/Wl/Om2NXPaHv7NXDi
	 foYe7QMYEPqZOa1Y7dIok0ZtPZ7955IRZzh2uY7WXNI6Nk12CpNnXUP2IpV4AdtNQC
	 T/rbQ16sgow0DQ9yiDLc5aXAeqihvZYQovo6tgIhxFaVr675rhaCPEpk4dHbsN4fXO
	 VV7RjZABnv/ah5Hy8mL24QTJazgQKln8HNVoL7ZmBTmti60RIDDD7CzJTjv3SeodHK
	 yuvre/9evLB4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00087C4450A;
	Wed, 15 Jul 2026 06:04:41 +0000 (UTC)
From: Haidar Lee via B4 Relay <devnull+haidar.lee.adlinktech.com@kernel.org>
Subject: [PATCH 0/2] ASoC: tas2562: fix Digital Volume Control
Date: Wed, 15 Jul 2026 14:04:39 +0800
Message-Id: <20260715-tas2562-dvc-fix-v1-0-072b13901b20@adlinktech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPciV2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3ZLEYiNTMyPdlLJk3bTMCl0zU7M0E9NkExNLIyMloK6ColSgMNj
 E6FgIv7g0KSs1uQRkjFJtLQBWZWaZcwAAAA==
X-Change-ID: 20260715-tas2562-dvc-fix-656f45c44922
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dan Murphy <dmurphy@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haidar Lee <haidar.lee@adlinktech.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784095481; l=1287;
 i=haidar.lee@adlinktech.com; s=20260715; h=from:subject:message-id;
 bh=Su3y5H+XropravPSwjmbGLXz02SfJzDuKDVzb682+LY=;
 b=8ZNmVGCGjs4EH4nTMnEyEGiWmeRhO/0vN23LgLkWVjqJu3F6zGPyjoWLlBzgml3PMA/6HdQmU
 /May/zpWfATAC9uFoAweyiiWt+CS8Kj2JTHOg+t8J9MJvqWbHIqQfjw
X-Developer-Key: i=haidar.lee@adlinktech.com; a=ed25519;
 pk=p37KzVgRl0a8om8VCM7iEwQvNuZz2fxL4lBCBp5qrno=
X-Endpoint-Received: by B4 Relay for haidar.lee@adlinktech.com/20260715
 with auth_id=872
X-Original-From: Haidar Lee <haidar.lee@adlinktech.com>
Reply-To: haidar.lee@adlinktech.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,kernel.org,perex.cz,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shenghao-ding@ti.com,m:kevin-lu@ti.com,m:baojun.xu@ti.com,m:sen@ti.com,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:perex@perex.cz,m:tiwai@suse.com,m:dmurphy@ti.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haidar.lee@adlinktech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274737-lists,stable=lfdr.de,haidar.lee.adlinktech.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[haidar.lee@adlinktech.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[adlinktech.com:mid,adlinktech.com:email,adlinktech.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A42A875AD46

The 'Digital Volume Control' added in v5.7 has never worked correctly:
the driver writes the 32-bit DVC coefficient LSB first, but the device
latches the whole coefficient on the write to the last byte (DVC_CFG4),
so every volume change applies a mix of the previous coefficient's
upper bytes and the new LSB. Depending on the sequence of values this
mutes the output entirely or plays at full volume regardless of the
requested level.

Debugged on a TAS2562 (ADLINK OSM-520 / MT8189): traced the I2C writes
with ftrace to confirm the driver writes the intended bytes, then
reproduced both behaviours by writing the same coefficients manually in
each byte order. Patch 1 fixes the write order; patch 2 fixes two wrong
entries in the volume lookup table found while debugging this.

Signed-off-by: Haidar Lee <haidar.lee@adlinktech.com>
---
Haidar Lee (2):
      ASoC: tas2562: fix DVC coefficient write order
      ASoC: tas2562: fix broken entries in the volume lookup table

 sound/soc/codecs/tas2562.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)
---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 20260715-tas2562-dvc-fix-656f45c44922

Best regards,
--  
Haidar Lee <haidar.lee@adlinktech.com>



