Return-Path: <stable+bounces-274054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 83DDC+iNVWoPqAAAu9opvQ
	(envelope-from <stable+bounces-274054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8A3750080
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AGlXC4Nb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274054-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274054-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 989513005651
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0220DD51;
	Tue, 14 Jul 2026 01:16:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43D1EEA31
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991781; cv=none; b=plU55Y9lldCgt/LTF+Ae2H0EzUMDCb012ks7hH0cNttJgnyfup/vpABcdFbr/bLXJ9TCpssQcqsjPQmXtc1kThShaTqE1+HvEOfom2r9djs45ZlvZltfdBxMlAS4cXvT8PAPNOr071H+pU2Z7mJr5SGw0btNllLUjiS2dlfFgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991781; c=relaxed/simple;
	bh=StH0vzlI/EjLkJlwsWWI3V1nF1jOBllaXKp2w58gWyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iclN1nNHyw2MAsLipARhYlooSRfXcayG6tGoTOHsiN1+YCIRYFITbGDkg5SKFpz++OK/JfxI18TYhSgtlmqnK15g5rmANrWcQVc68HWdNpxnQV2jGOGlYw6klMG0/eo1WgIeSBOUlmczDsmUQwAzAwe4NUWy4HldAV/xeLe0IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGlXC4Nb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489351F000E9;
	Tue, 14 Jul 2026 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991780;
	bh=jdgOtrLuBpm1HuaiqGcPtTwl8Auh6SAN5ZFBB7VpTZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGlXC4Nb043aGNXMncmxE9hSTkolcT+3tzHf/E7c/2Sm6jRFcWT3Qaq37jfZmiegS
	 5KGwVOKnlgLapGqhtWqGSaZOZrWlLTeDSb1JWF9lstgsIIKoS66+xyhtE6xVRD8HBh
	 8uAIgmAclnT/cBafp5VagxNkF6mYmdekOCiE7W4S1EkYt6TuZWAqK+f3kWlwcHCWuS
	 +MfG7dLRzojKnnf75M8ezJQD6TJuV0FC7WYdkrYK9Tjy7uaQF4qR17p79C8FUnwbTW
	 No5QSRWdf4TK8kbBKaqnGEyG4IpHuxWgfdBxsDcxe/AuLHDzsC7JThnyQyff2fpa25
	 QXM3zRMqvR+qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 21:16:17 -0400
Message-ID: <20260714011617.2188420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071300-unstitch-evident-5dde@gregkh>
References: <2026071300-unstitch-evident-5dde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274054-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:zhaodongdong@kylinos.cn,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C8A3750080

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

[ Upstream commit 8df560fefe6fed6a20b7e06720eeaeccec349ac0 ]

snd_ctl_new1() can return NULL when memory allocation fails. In
layout.c, the function does not check the return value before
dereferencing ctl->id.name or passing to aoa_snd_ctl_add(), which can
lead to a NULL pointer dereference.

Add NULL checks after snd_ctl_new1() calls and return early if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
Link: https://patch.msgid.link/tencent_35F3A25FEEBF190A2E15ED787754C57E3708@qq.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/aoa/fabrics/layout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index ec4ef18555bc90..58b60fdc4c52ba 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -947,6 +947,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name,
 					"Headphone Switch", sizeof(ctl->id.name));
@@ -961,6 +963,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch",
@@ -968,6 +972,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detected",
-- 
2.53.0


