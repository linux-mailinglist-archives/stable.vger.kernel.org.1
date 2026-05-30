Return-Path: <stable+bounces-257967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJklMk8iG2oN/ggAu9opvQ
	(envelope-from <stable+bounces-257967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF0610547
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15348300DF56
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7D3469FC;
	Sat, 30 May 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vwmmgnj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080542E7379;
	Sat, 30 May 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162779; cv=none; b=cWZLTmigA60JkCGyQK4146wuAPWGniRATN+RX38FLNq/8KUyC9Ny2jGgJRnAQmjSE+ED6UeL0dtcEx2WbKYZ0wpe4nokI4Yas5qi56N3ekFTR+zf+2u/z3FBBFeXjfS6fFUDYENgRn1cBwReVzKlBQ5v1Tqz/rgCJk34gMHbsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162779; c=relaxed/simple;
	bh=iKEtOjHWqCANjT/iUK+q5cv6tCQQMb549W0V/C8wAiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyVyv6/j5QSmQVBXwy1pYXTW0yDmIaeV7JOZc8HU7MWXDmBljHGgXbXgOHQkvvYVQ6Jbr2hFrspi6Gx9Xq/eMJ1u2QTxT50kMRa72z/Ab98SMgxi8+bQGcwA+7H/ttfD0QVFgyAVHUmBFEf3VHEOKbVdY5rl1KnBVgsnl0CqKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vwmmgnj9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5371F00893;
	Sat, 30 May 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162777;
	bh=0sLKUf792tJQ8It8phy+da6KwEpOPmcU6Va3DEQ2ZsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vwmmgnj96huhwYCzkCCbOnls71WvCNY1dzODJW8hgVWuYD/zdG1HGAx5zq3/j1bM9
	 1cnkpvkPSRCV5m5r/oRic40w3OKITMW3BSR1obrZ8yPR9JiKFY0S3LMRmmFVLEuvfL
	 sNJo8qBded7OkzBeVXgN+VAitFLQGU7i1zguaBL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	stable <stable@kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 060/776] ALSA: fireworks: bound device-supplied status before string array lookup
Date: Sat, 30 May 2026 17:56:14 +0200
Message-ID: <20260530160241.867143586@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257967-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,perex.cz:email,msgid.link:url,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35AF0610547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 07704bbf36f57e4379e4cadf96410dab14621e3b upstream.

The status field in an EFW response is a 32-bit value supplied by the
firewire device.  efr_status_names[] has 17 entries so a status value
outside that range goes off into the weeds when looking at the %s value.

Even worse, the status could return EFR_STATUS_INCOMPLETE which is
0x80000000, and is obviously not in that array of potential strings.

Fix this up by properly bounding the index against the array size and
printing "unknown" if it's not recognized.

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Fixes: bde8a8f23bbe ("ALSA: fireworks: Add transaction and some commands")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://patch.msgid.link/2026040953-astute-camera-1aa1@gregkh
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/fireworks/fireworks_command.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -151,10 +151,13 @@ efw_transaction(struct snd_efw *efw, uns
 	    (be32_to_cpu(header->category) != category) ||
 	    (be32_to_cpu(header->command) != command) ||
 	    (be32_to_cpu(header->status) != EFR_STATUS_OK)) {
+		u32 st = be32_to_cpu(header->status);
+
 		dev_err(&efw->unit->device, "EFW command failed [%u/%u]: %s\n",
 			be32_to_cpu(header->category),
 			be32_to_cpu(header->command),
-			efr_status_names[be32_to_cpu(header->status)]);
+			st < ARRAY_SIZE(efr_status_names) ?
+				efr_status_names[st] : "unknown");
 		err = -EIO;
 		goto end;
 	}



