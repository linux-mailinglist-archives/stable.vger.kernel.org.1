Return-Path: <stable+bounces-256678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFxuEFvVGWpmzQgAu9opvQ
	(envelope-from <stable+bounces-256678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE02607050
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B442F3351321
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60F1A9FA0;
	Fri, 29 May 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaTqbnoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876629AAFD
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075504; cv=none; b=ZYtjvV2eUfhyJA9CobH5a4rufZzcUSG8xpYq9kTQzAbzric3lqk1J95PrSVovZjyQLM3WxFd3juWKUCny+oODJ35OgkuV9+1WLPpOJH7xbhIHk4JqipuEy5KVDy3da6vp6m2IymZMhiaY1e3CZwtZiEVi+OQAqJeUizB81df1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075504; c=relaxed/simple;
	bh=oEaMsr/7tY2HdpqwfH/Pu/6l+FpMb1yl6DTYKUz1ogI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7XU79nfQUdeTaeouegiqwQWPpJWxIMX+hiZR6FRWHTl3gq//9D28b8hD0vZsMAg2x04RcxucZDT8h89cpqDLbIDnHOZi4Jtl+CDOQDb4xaqQq0dwu9RqqePuOQoFX/n+0k/iDxMfknOua2+dWtioGRgjWZpRia3D6v+/s9KnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaTqbnoH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B238B1F00898;
	Fri, 29 May 2026 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075503;
	bh=4jsl8YdENI8Tq5J4/9PfRAdpw3cT80Z/7QZVkldavgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaTqbnoHJmBsOsQJ8gdeFmZaJyq8E+syp7hKQDyE3Q/PglCqWVJTQgk5r77qGTpmp
	 yqIRxSjTShUcoWldbCL14WmARUOExCo63Fnd0GGRH9dpTO8SBg+3Yl3RMmWQmB8WOj
	 lM9f/lciSfR2JgzsTzklD2tUb+FfMTs6nE7IT+sZ9KTOPsIJkI1A+FfT11VuOqjTbX
	 FxHcDF+O0VPIbcsEo5rORRrasl1lzy0K2B5qYRzNMRjr+Ew2bfkkEAGjft4mJOIAnj
	 xwto7t+cKOG5hieNZ3EL7zRe0vyQFXIgAyEBbl43lG0gLCvwQOUhF+Bv0Eiz4EVuDw
	 IlegqLKM8dpPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: scarlett2: Allow flash writes ending at segment boundary
Date: Fri, 29 May 2026 13:25:00 -0400
Message-ID: <20260529172500.1327796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529172500.1327796-1-sashal@kernel.org>
References: <2026052816-limelight-debtor-c8aa@gregkh>
 <20260529172500.1327796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256678-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 9DE02607050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit a69b677e47a80319ce148d61cc29a2b57006e78d ]

scarlett2_hwdep_write() rejects writes when offset + count is greater than
or equal to the selected flash segment size. That incorrectly treats a
write ending exactly at the end of the segment as out of space, although
the last byte written is still within the segment.

Split invalid argument checks from the segment-space check, keep
zero-length writes as no-ops, and compare count against the remaining
segment size. This permits exact-end writes and avoids relying on
offset + count before deciding whether the request is in bounds.

Fixes: 1abfbd3c9527 ("ALSA: scarlett2: Add support for uploading new firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260519-alsa-scarlett2-flash-write-boundary-v1-1-b550480e92da@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 564a9b04a443a..568bb0d4ebbd1 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9522,12 +9522,15 @@ static long scarlett2_hwdep_write(struct snd_hwdep *hw,
 	flash_size = private->flash_segment_blocks[segment_id] *
 		     SCARLETT2_FLASH_BLOCK_SIZE;
 
-	if (count < 0 || *offset < 0 || *offset + count >= flash_size)
-		return -ENOSPC;
+	if (count < 0 || *offset < 0)
+		return -EINVAL;
 
 	if (!count)
 		return 0;
 
+	if (*offset >= flash_size || count > flash_size - *offset)
+		return -ENOSPC;
+
 	/* Limit the *req size to SCARLETT2_FLASH_RW_MAX */
 	if (count > max_data_size)
 		count = max_data_size;
-- 
2.53.0


