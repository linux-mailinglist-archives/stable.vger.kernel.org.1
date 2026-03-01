Return-Path: <stable+bounces-222483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDvnEsGxpGl1pQUAu9opvQ
	(envelope-from <stable+bounces-222483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 22:38:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1C1D1A4C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 22:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C8F3013EE7
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595472F617C;
	Sun,  1 Mar 2026 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="qpQRnSDZ"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FC30BF70;
	Sun,  1 Mar 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772401077; cv=pass; b=GE22yjvPPokD8LekyMQaIg7ikOFLea7YYNFRVysBrSDWX4oL5fm7DPimgZpELMLgmyt03+qRxqIb+qQetuMQJawBkhmr344+6RiHRnkrV145TEmOSVlvLabsG6mXqgnEuIAx23T5Nfkm08porqfeJ8DwXvBXVkCLtles0EhNW14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772401077; c=relaxed/simple;
	bh=ZmnG1mvLC+nqfqk1ivL295tgmudCFqWeCE+Ry39YMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7ObEIBDFlQLhmQaPa+DvHJ1/xvGS3ZKk+M5TRvkt3cOwM6ce9f1TNYfjlzQx9eALP5RncFPYDER3jXDae5P5+2ahel3uec7+Aclc+MaIytfBaWRZXY8YnbCYOVyDS6kXz5/K/lD63Bny8WPiWrnLCwsbn5R9qHKLaM3A0VT2bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=qpQRnSDZ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1772401058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZYvFFpXWVuiqRiAiEAwiP7ZX5pQsYucoWyWb0wM8FA7Qi3EGBhVyWUfrA7Bk8YDFQyX1OFVCgPsxaX4h8wIAPDcImDn/Y5YThEJtiur2eShMtEQNkHL0jKZaF5cfvfkfURB6IiNNCRTBGs2Nt61unBO1GTHHnX7G+UTOoTodmLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772401058; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m5MkS0FlgjmLHAzJnS3KdKIY+xY7EDfUNnbvaa6b+l4=; 
	b=YCgKpb2NblOlwMfxJ5RUzwh84t4hDu1YmZYuPlQ4Od0ID6sPkGO2TApzHeeY08nM46FO9616kxfIGcFBsQBcaL/Ma8hOxZ6jRH1FghVt0dBXvd/4VXJflV/hxDpgVLMHJAr4nGIT+BcCevx4euYmZfyRYCIW7ZluzSH42gdeY/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772401058;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m5MkS0FlgjmLHAzJnS3KdKIY+xY7EDfUNnbvaa6b+l4=;
	b=qpQRnSDZ6OFlug+2D/c08eqaGUFlhi6TKvdTWqj3Y3OMM+XUpUSYe7eUUfd2v87t
	gsDq79CciDTNsp0Cvs/kjrFzyQRnmPB9sq/lMMOipEBn3Bw3imSeCwT+7Az45w2DTc/
	QrT/nslj8YTK+TAhflDZvJo6kZy/WMa8QSOMh3MBwOdfDds8DaAbMxAHhD9OhhPgEea
	LsLX14UNwAqwa+/8PskQtMj7+WhCIhWEfYB859tAlaORvMrrJmDO8rJprA8g+2jVltb
	iHQSHXjR8yescB+1YJJXanaGhVkreRMrvCh4KkfpbSrdR1Y1Xo17ZdMS8mq/SZmG11e
	In/ebz6wgA==
Received: by mx.zohomail.com with SMTPS id 1772401057166967.3911990035651;
	Sun, 1 Mar 2026 13:37:37 -0800 (PST)
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
Subject: [PATCH 1/9] Revert "ALSA: usb: Increase volume range that triggers a warning"
Date: Mon,  2 Mar 2026 05:37:17 +0800
Message-ID: <20260301213726.428505-2-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301213726.428505-1-i@rong.moe>
References: <20260301213726.428505-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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
	TAGGED_FROM(0.00)[bounces-222483-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:mid,rong.moe:dkim,rong.moe:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B1C1D1A4C
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
---
 sound/usb/mixer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ac8c71ba94834..df0d3df9c7ece 100644
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
2.51.0


