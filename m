Return-Path: <stable+bounces-243089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCqpKJmm+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA64BE530
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB6A3035899
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE803D6489;
	Mon,  4 May 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGrYm3z2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDE20DD51;
	Mon,  4 May 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902989; cv=none; b=WnOMS1kOje5g3PeGelCNb94Q/lFrnF4kxbrL5ZpYI8z/vsfisdrrJJjPd1gX1CXFuDplFAH8A09n/hhGOinqfi1x+OBqgex68AuSfBFkpaNf0a4P2n6NF1qCarwL9gbfRoZi+6gyBP2Zre81FdmJ34eRhHUpB3gDyv5j07lTyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902989; c=relaxed/simple;
	bh=cVm3sHvK/npwnjMxg3xiDp59oRsbMy1oKX+WqMb6n7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5rHcOGpvsvQWLb7qDiIasVQM5jnWtlo7pTqEDiXc9YZ2VAjKMw0yzUeux1zzjdG5QCIGs36eZEfZzD60CC8Ll4fZgTnaIK4bUTNPY96vuMmqdI54EKiuaCTu7zPVN3WvyJzax+8snwj1AMGqD/vmWbY/OpYYWc9BJpn/LNo+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGrYm3z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19457C2BCB8;
	Mon,  4 May 2026 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902989;
	bh=cVm3sHvK/npwnjMxg3xiDp59oRsbMy1oKX+WqMb6n7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGrYm3z2KYILG2n4pMWc4kpd/a6+dLjJMDeMbo1V7yPobwLgqWUDrZhcAAhUgQPM8
	 EFHUrjBhoKy9Epx2kSlj2Oro8u85KnMmwTXlyLAOFPvKXUdHFaFzK8WYyNjRbefGdj
	 6D8kwpzNcwi8fpU4YFoB4L2kqqy7u0V51v2lSBuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rong Zhang <i@rong.moe>,
	Arun Raghavan <arunr@valvesoftware.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7.0 059/307] Revert "ALSA: usb: Increase volume range that triggers a warning"
Date: Mon,  4 May 2026 15:49:04 +0200
Message-ID: <20260504135145.041394919@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4CAA64BE530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243089-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[rong.moe:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valvesoftware.com:email,rong.moe:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rong Zhang <i@rong.moe>

commit 41d78cb724f4b40b7548af420ccfe524b14023bb upstream.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260303194805.266158-2-i@rong.moe
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1820,10 +1820,11 @@ static void __build_feature_ctl(struct u
 
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



