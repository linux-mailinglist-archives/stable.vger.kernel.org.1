Return-Path: <stable+bounces-222678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOvmECbepWkvHgAAu9opvQ
	(envelope-from <stable+bounces-222678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:59:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00191DE894
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4180305247D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC0377001;
	Mon,  2 Mar 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="IopU1XMI"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD3375AD8;
	Mon,  2 Mar 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477966; cv=pass; b=t6vjLlniGxt1vortLX70+lI1uRdtsI8sfFjza3ApL9huwayBgWgvoIC/UqRx8FIDnTLfC14UDZU/9efibDJ+ugAMp3UgxFSWSIrNvd+nSQyfWrPm9IAGS8mcQ5OW3Vfq7EjTHTFKJYcg2WX0Ji+atkiws7L1gmgieogNkPVH/kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477966; c=relaxed/simple;
	bh=ZmnG1mvLC+nqfqk1ivL295tgmudCFqWeCE+Ry39YMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOWVJcCYCHmwhI8O2Ee0bPtVd3viE0jsRF9G1+KDkJ64wpIs9nQDsPGqt84IXTnuulIxdRGY9n2DyUl75jRMd7HYT8HzJ0QFf7Qn1XcKDNSnw6Rg8cn0GHDXdI4ApDop6Gib1eKxWSO9y3rF9gFnFbfwreSkt844T7xcH1dyM9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=IopU1XMI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1772477951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aeA15Y/c+tit1VCdaK7rv78xw8PkK7x8I61+OTFYA4ti7W0u3E/K4SsucctGCU4kQsVgbsJFyfVfXu8idiVKC1GCFPg0zf9vM2Gt6bO7V5g7cYiBRFzYZTh/2/9TN0J+zgMOPz+NcKUysixZKOoZFi1/2wTVJHO2PhAuV+KHZow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772477951; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m5MkS0FlgjmLHAzJnS3KdKIY+xY7EDfUNnbvaa6b+l4=; 
	b=Pg6/wBX9Xu0UuSDOGVY98gKe7e6CNeXqxm2zOQzb4fo/glvvF2ovlPQljVLM+QijTPW1dyMWNEtaPRgkk5gbBCaBR85cJVW5P1rBEJv4zBvkU2/tIWL+6UrnYww/5vNhAtIgm36CftLD76hDbA5K2BR/KcHf4/C4Aaq+quJTt9I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772477951;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m5MkS0FlgjmLHAzJnS3KdKIY+xY7EDfUNnbvaa6b+l4=;
	b=IopU1XMIA+Rn5ltQhog/8UorJnmP67MUPZnrfC847Wmdpt2GcGdTnL5H40ntLpNn
	NMZT4xsQZ5zBxCpTs4of8GIy8w5XlHKGUmgJmfCuJ62QwHHFgMT0xX90tLpzFSPmZHn
	gxdSBN4rRf0jY1/rXgSRIlxj0z5D8P69JbWlSM8x+Gnyn3rIpmucfHoFI+w/oY0ngYv
	Y1e8UZsxgp8FVxQ9einMDopCMm8NqqpwJEubt/PHAYUtE+93YbiPKTsZ5dCV7nb8U7o
	z/BBk016F2i/SZUNeD4XpWKQVFCeL4bL8SRKnBMVlOHlDvtXZcrvL7gyAKp7EV0cRd3
	nJbfHKCxZw==
Received: by mx.zohomail.com with SMTPS id 1772477949830999.8581879892873;
	Mon, 2 Mar 2026 10:59:09 -0800 (PST)
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
Subject: [PATCH v2 1/8] Revert "ALSA: usb: Increase volume range that triggers a warning"
Date: Tue,  3 Mar 2026 02:58:52 +0800
Message-ID: <20260302185900.427415-2-i@rong.moe>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302185900.427415-1-i@rong.moe>
References: <20260302185900.427415-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: A00191DE894
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
	TAGGED_FROM(0.00)[bounces-222678-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:dkim,rong.moe:email,rong.moe:mid]
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


