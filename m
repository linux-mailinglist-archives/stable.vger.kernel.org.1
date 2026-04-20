Return-Path: <stable+bounces-239033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKzuOW805mmOtQEAu9opvQ
	(envelope-from <stable+bounces-239033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:13:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984E42CC3F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C06C3113F51
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E840FD86;
	Mon, 20 Apr 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVON2lXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772140FD80;
	Mon, 20 Apr 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691639; cv=none; b=cPDczYBClZiqN5S16OBWy269X8IdOOjrD4lRgwuKY2MQ/iU9QMXuSPHnPMgiFH2ebJkXmVaIUG6fCksZ5GOsQf2dVqW6qIpx4jLyB2Rl0vTX606t4iHF85UwRttRuTegB+204FTc3bVl6BrQPByL0YMUT/rdbTkHlia0FOAqgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691639; c=relaxed/simple;
	bh=bNKGimP2bQ4TWlFxhV34GpCPsahsC2IXw8+THQGDMJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuDRsw8H/k8xUZYczda3I9c86dG9XX5NmSwnMgS2eJmsjnRfINb3J3c2+9hqCZSSkhflYR5WQo+0d+7KHkLvXeTSxlmpY76Qnty7CI2CSuYAe49IGlyXc6lSCEG3BkMVRJ8sxaEqlAGHDnN4ZqeGXzIXLNODv4TGGRC7tUOePJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVON2lXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A0AC2BCB4;
	Mon, 20 Apr 2026 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691638;
	bh=bNKGimP2bQ4TWlFxhV34GpCPsahsC2IXw8+THQGDMJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVON2lXt6G8teCC7EQ4pSrVr/YJiJS9Xnnow10TTRMI3qSbrb/MB+osCLIvHnlfMr
	 s14WGEmmzj1uaJBZ26mK0tI5kd6gnTJ1WzK2j3GCyUbfL+xlEJukdA0BOU07+aN0HK
	 KweOa+zABi/Kdu3y65/WvrSgtCCBAJkV2JdO+37HMBCIhOkE0T+KBRTE63a4yCypic
	 c4PMxTc8RJZ6ddg1Q9XARKkWNLVynmmvByWq93v24vj2L7UlaXTTH4OTtKw6wHIf4s
	 e7WjMY34RSD9WS60ZQO/0m3x0kMnknBBipQVRdEvROvBbH/qmy9I2p5/iFq97asN2d
	 32UhvppHrpakw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Andrii Kovalchuk <coderpy4@proton.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ALSA: hda/realtek: Add HP ENVY Laptop 13-ba0xxx quirk
Date: Mon, 20 Apr 2026 09:19:00 -0400
Message-ID: <20260420132314.1023554-146-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239033-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 7984E42CC3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrii Kovalchuk <coderpy4@proton.me>

[ Upstream commit 793b008cd39516385791a1d1d223d817e947a471 ]

Add a PCI quirk for HP ENVY Laptop 13-ba0xxx (PCI device ID 0x8756)
to enable proper mute LED and mic mute behavior using the
ALC245_FIXUP_HP_X360_MUTE_LEDS fixup.

Signed-off-by: Andrii Kovalchuk <coderpy4@proton.me>
Link: https://patch.msgid.link/u0s-uRVegF9BN0t-4JnOUwsIAR-mVc4U4FJfJHdEHX7ro_laErHD9y35NebWybcN16gVaVHPJo1ap3AoJ1a2gqJImPvThgeNt_SYVY1KaDw=@proton.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 0654850687447..1b64292220ac8 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6732,6 +6732,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x8756, "HP ENVY Laptop 13-ba0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8760, "HP EliteBook 8{4,5}5 G7", ALC285_FIXUP_HP_BEEP_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
-- 
2.53.0


