Return-Path: <stable+bounces-261834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4pAEn9VJWpxHAIAu9opvQ
	(envelope-from <stable+bounces-261834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D76506C7
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:26:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hIcNmFPh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261834-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261834-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFD830A3B73
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC0314D15;
	Sun,  7 Jun 2026 11:00:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A736F8E7;
	Sun,  7 Jun 2026 11:00:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830026; cv=none; b=kxRAqjUvzrbpqGB8IroUOsrhh54hdZIwn/CREoq7XI2cP8LkYx75Tz/xwFsqeQxJqGgaYTwsxZCAtRt6c3ayAe/x+oQBpZS/HZn9KTv9KjMUyzLp5ct2vQQNWg/DM7/voblAH/pOqJYFKcsLCZ9eeXrAnk8OY8FgaQjR7LmEXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830026; c=relaxed/simple;
	bh=tPq2G3I5eYEGW40QX+ImwzuQqpoambKP8tQbY1pZDX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dargv2Giavk/anNcI1Fw9xaDmgSZt7UP/ZOZjdGLmNu6h3UsSCITvAch9cFWaFh7zce450fgI2HcoeL7+GlzWdon/rzAsZPOXN2ziiNKS/bnq9fVaH2e9YoMIYayPHi+aZRThHR+J64E/p8VwO1FMBF40xosLbsOex4b5xyx6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIcNmFPh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA121F00893;
	Sun,  7 Jun 2026 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830024;
	bh=VZ17EeCGbz8lVxwj1guxWqAv4zZi+9n4I2EIqmfRO8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hIcNmFPhwkvRrIpoNdyYsN7oSBPkYRG6A5yoQBvLStYrNgyi+4qGEisDQEkbmIPVh
	 bGz2wyBUcN+r6DiC7i+plBvalqkPsIHoVeMmzr4aA6vJ3IFwziMt8JyJoVkU+pl9iX
	 GwVrhYjZRi0+zomipQ6x0QraLRWeWnAO5Q174KS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 274/307] ALSA: scarlett2: Allow flash writes ending at segment boundary
Date: Sun,  7 Jun 2026 12:01:11 +0200
Message-ID: <20260607095737.778682524@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261834-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:cassiogabrielcontato@gmail.com,m:tiwai@suse.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C94D76506C7

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_scarlett2.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9549,12 +9549,15 @@ static long scarlett2_hwdep_write(struct
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



