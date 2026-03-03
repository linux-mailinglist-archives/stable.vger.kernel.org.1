Return-Path: <stable+bounces-222946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKmbHm07p2mofwAAu9opvQ
	(envelope-from <stable+bounces-222946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113F1F65EC
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70FF30B7D17
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844442D23A6;
	Tue,  3 Mar 2026 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="JaX5wAbm"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048937C932;
	Tue,  3 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567318; cv=pass; b=i0mde5XSm8zcjmogTSEaFPD6L71gsfrPJLbqDylXYw84uc5eT/qEyzluweAvDrVB6/PFXYuJnOweEhIQTg3Xw+5q9cfT0jnrGb59cAWxpaAtezHTQW0xa+hJFo9RYgdWyjI1/cMvdAOQWJH4Nhef8OMkQjbdqGJeuJ+I53e6Rwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567318; c=relaxed/simple;
	bh=Ol5wfXidt2YBtsIvhP73Xs9hMxo3bigYItyn+32vSZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQyTWRKD51fQ8u++Z+hDiGw3FE5kyg+9LI/4hv5dTZFFhE3UWi4Pr1IRgL+EnUWqOAQasgA0pvVV1RRnJr+tIWrXT0O/Jo7/CyMagWxFOfGG1lcTLwbC4Jpa7WaZNWTTJSEhaNRrOz6Mq/PFhpgqrOu/sQ7nu93fFRDH/cuYBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=JaX5wAbm; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1772567297; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g76eAs3aVQHdB+1PIKmssuAXwIsNRripgKtt+l7YeeNu64AT+rbsAx38RebFCs9+D7PG3NjZSlrF/DarkekPaNWais7Kf10Y9JGdkTeZAEQuARKp9RAuCeaeEu02IM4uLHaMdXS5f8hhPq2weRADM0z+ENfUrbxKFpKFyoTRcgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772567297; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nsa1pQ/g85W+rCXtSixQQwz2hYzHYiKCiOFYkThsOOQ=; 
	b=fEgD7FFeOul+2ZT62/z8KDBsJ6jyzxNw84HE7rPRSEj9PyVgx46ixguLjvBIwJocU59bF9RFr/+J5zVNQL2clnBSE0DYApVGyhSqmfGMa/lmu1nFkkglHqNn54e14BND7RG1kvA6z2CApUpxzam+6EIN/2x8d8lUPHuzMCe6170=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772567297;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nsa1pQ/g85W+rCXtSixQQwz2hYzHYiKCiOFYkThsOOQ=;
	b=JaX5wAbmTTHKNvMB/xXGAdzFZSgo4E2+uiC+zqLSr1Awa57WMyxpC5GVBsk2z5Oo
	UUm4P9z7pLbUhDUJ3NrkMU0ibFNyX5ZbTKZD+4kVZXZK8LbUzPw4yoYKzx4FuEGPb4w
	ZZtQfPTHfufuNjotrVpvP8T8oFMQJs7IHKr6A/A4FrcfmJmb45qtlrRhsW/+kH+k3Vl
	xLwVlghf2aaV1lgULsyPwwWbhFq8ffZm+e3qpdtwMH6H768OeyKW+mzrRcs7T+2fUG9
	N+KgZwIC8/Ifrpx9UERYTmtd/2LVTSHHAQtMqcKpzOXgZVDWwdKmp1/1YLqbr2BNsEg
	A3H5mJ2wuA==
Received: by mx.zohomail.com with SMTPS id 1772567295942497.5492576939479;
	Tue, 3 Mar 2026 11:48:15 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Rong Zhang <i@rong.moe>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Cryolitia PukNgae <cryolitia@uniontech.com>,
	Arun Raghavan <arunr@valvesoftware.com>,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] Revert "ALSA: usb: Increase volume range that triggers a warning"
Date: Wed,  4 Mar 2026 03:47:56 +0800
Message-ID: <20260303194805.266158-2-i@rong.moe>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303194805.266158-1-i@rong.moe>
References: <20260303194805.266158-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 0113F1F65EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222946-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valvesoftware.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

UAC uses 2 bytes to store volume values, so the maximum volume range is
0xFFFF (65535, val = -32768/32767/1).

The reverted commit bumpped the range of triggering the warning to >
65535, effectively making the range check a no-op. It didn't fix
anything but covered any potential problems and deviated from the
original intention of the range check.

This reverts commit 6b971191fcfc9e3c2c0143eea22534f1f48dbb62.

Fixes: 6b971191fcfc ("ALSA: usb: Increase volume range that triggers a warning")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
Acked-by: Arun Raghavan <arunr@valvesoftware.com>
---
 sound/usb/mixer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ac8c71ba9483..df0d3df9c7ec 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1813,10 +1813,11 @@ static void __build_feature_ctl(struct usb_mixer_interface *mixer,
 
 	range = (cval->max - cval->min) / cval->res;
 	/*
-	 * There are definitely devices with a range of ~20,000, so let's be
-	 * conservative and allow for a bit more.
+	 * Are there devices with volume range more than 255? I use a bit more
+	 * to be sure. 384 is a resolution magic number found on Logitech
+	 * devices. It will definitively catch all buggy Logitech devices.
 	 */
-	if (range > 65535) {
+	if (range > 384) {
 		usb_audio_warn(mixer->chip,
 			       "Warning! Unlikely big volume range (=%u), cval->res is probably wrong.",
 			       range);
-- 
2.53.0


