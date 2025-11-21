Return-Path: <stable+bounces-196501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A07C7A795
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6EA635E7AA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F334CFDA;
	Fri, 21 Nov 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/YJjjXo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36233D6E2
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737980; cv=none; b=cPAOuwx/VywG6uANH/2aNKLQl2eVKzGEC+IikZIDvwYyui4e7YqU3gQAo0Ll0D2SXCRWOFYA1p6ItGPA7H98rGFtrZy7Z2wGk+M2LCxyHkVQ3Nzm2+FfCutrHF0VyLtVWZbPnfZyC9QJqFHgznVtePXyiSPYf5EH46sXN47EPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737980; c=relaxed/simple;
	bh=nPFgacPqaiw+M7MNW1xJ2mJ2k/vqIZdckb3YyMOZnGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvSZsa+sGnVLm1z5moMo+ux+JQxFT3Bsx54fpd+GYMcyF4n2BILHYYtTmLVJ9XkYZT0uCp4wXL5f+GGHK4tmVJkvaluG/FP6JsyBcnS56qmkYVMZ92cyREIFvi8rcCK/Igt/DmKnp6mr7sKi9vwHXn26McEtIe1St8banbwVHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/YJjjXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B4C4CEF1;
	Fri, 21 Nov 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737980;
	bh=nPFgacPqaiw+M7MNW1xJ2mJ2k/vqIZdckb3YyMOZnGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/YJjjXobbCZVFN5z1p4pdtazAUM3+7mrYBMi5h3SB6TC9e51pVFmI/p8fwEU0cNN
	 H184eEOBDyAtVX4D0YG40PNG6/2lq2nCkygpni3kyq2bqgvWJpucmxKaTqlDo+qt2a
	 EFEcr9EuymZBQbcIMtWm4m2M6PN2bi+isI+v7oRZaJ+HPSVl8KoDb2s/JdMvTXhfqo
	 NkWOPMGVGp8IQxA5RDmd/DkoivdION9A4pTLUTgZXt7WKj1bxuyX+iQncz45b74wAF
	 LbF3mQcGsdxfhOlipu1Fgiqwx6hAPMuswT1fyMPzhdfCKa3FSNH6/Vstn8Hqe0u5/U
	 yh73tIojdpa7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Fix potential overflow of PCM transfer buffer
Date: Fri, 21 Nov 2025 10:12:56 -0500
Message-ID: <20251121151256.2561194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112036-clever-sponsor-bfdf@gregkh>
References: <2025112036-clever-sponsor-bfdf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 05a1fc5efdd8560f34a3af39c9cf1e1526cc3ddf ]

The PCM stream data in USB-audio driver is transferred over USB URB
packet buffers, and each packet size is determined dynamically.  The
packet sizes are limited by some factors such as wMaxPacketSize USB
descriptor.  OTOH, in the current code, the actually used packet sizes
are determined only by the rate and the PPS, which may be bigger than
the size limit above.  This results in a buffer overflow, as reported
by syzbot.

Basically when the limit is smaller than the calculated packet size,
it implies that something is wrong, most likely a weird USB
descriptor.  So the best option would be just to return an error at
the parameter setup time before doing any further operations.

This patch introduces such a sanity check, and returns -EINVAL when
the packet size is greater than maxpacksize.  The comparison with
ep->packsize[1] alone should suffice since it's always equal or
greater than ep->packsize[0].

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
Link: https://lore.kernel.org/690b6b46.050a0220.3d0d33.0054.GAE@google.com
Cc: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251109091211.12739-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ changed ep->cur_rate to rate parameter and chip to ep->chip ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 80dcac5abe0c4..21bcdc811a810 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1093,6 +1093,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 	ep->sample_rem = rate % ep->pps;
 	ep->packsize[0] = rate / ep->pps;
 	ep->packsize[1] = (rate + (ep->pps - 1)) / ep->pps;
+	if (ep->packsize[1] > ep->maxpacksize) {
+		usb_audio_dbg(ep->chip, "Too small maxpacksize %u for rate %u / pps %u\n",
+			      ep->maxpacksize, rate, ep->pps);
+		return -EINVAL;
+	}
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
-- 
2.51.0


