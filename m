Return-Path: <stable+bounces-256286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHHUAqirGGpEmAgAu9opvQ
	(envelope-from <stable+bounces-256286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:55:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0505F9D8C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED8331A4BB5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D76352019;
	Thu, 28 May 2026 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PElGAqUv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D59349B1C;
	Thu, 28 May 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001274; cv=none; b=AtXr4vF2jaig9KuSY0a1owxspfFwRhgjRezZw++1MDJYT0e8tq7JxW/LwUE4Dbx1SHydvHGcBEbzqGsd5TuXLFJwXQ++aNt9zO9eyChN1GI+xbdOEL9ngFjyXQ7gzlZzC3PRQdBoe9StZqpQlaRQKLXWjCfkJZgCjJB1xRYOCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001274; c=relaxed/simple;
	bh=T8Gv2KuKPnTG9R74pFU8yGr0BHf59dZc9NAjaZ22YCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvjIhYx7eDiRO79Uvom4ShFcQMqdK334Pje+sGcE3is2pXO4lvzARY+NS2CKG/dgjOZEA8kHpELw51OC6qSNhq38MQ2Y/oAjgt8BPD1meCTdxR350OFi6zMDaluCP3GOeD9M9c9iwe/JUYFV3G5qlHY3Qg3Ca5KxqGektMi0Vjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PElGAqUv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD431F000E9;
	Thu, 28 May 2026 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001273;
	bh=n8r7f0U2k0bd1X6QgRlojJ69iAFCYSukU14SkfYluTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PElGAqUvmnmSKPe+gnyHgbTygxfRXGs1TXdut8ZdhfppfG7dsAcKY1UKA6ioR4A8p
	 1X1kyI3F7mDTR624aWlXhN/eLVVsWvGU0p/E6ratEwWaYlCpA/k4CzvDylrol9H+p3
	 5Z8B8bfhlrv1skTAiaKMs8hySQsWPDTbenpv2Lcg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 030/186] ALSA: pcm: Dont setup bogus iov_iter for silencing
Date: Thu, 28 May 2026 21:48:30 +0200
Message-ID: <20260528194929.776995582@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256286-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5A0505F9D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e4d3386b74fba8e01280484b67ee481ece00201e upstream.

At transition to the iov_iter for PCM data transfer, we blindly
applied the iov_iter setup also for silencing (i.e. data = NULL), and
it leads to a calculation of bogus iov_iter.  Fortunately this didn't
cause troubles on most of architectures but it goes wrong on RISC-V
now, causing a NULL dereference.

Handle the NULL data case to treat the silencing in interleaved_copy()
for addressing the bug above.  noninterleaved_copy() has already the
NULL data handling, so it doesn't need changes.

Reported-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Closes: https://lore.kernel.org/20260515051516.3103036-1-xujiakai24@mails.ucas.ac.cn
Fixes: cf393babb37a ("ALSA: pcm: Add copy ops with iov_iter")
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260517165121.31399-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_lib.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2074,6 +2074,9 @@ static int interleaved_copy(struct snd_p
 	off = frames_to_bytes(runtime, off);
 	frames = frames_to_bytes(runtime, frames);
 
+	if (!data)
+		return fill_silence(substream, 0, hwoff, NULL, frames);
+
 	return do_transfer(substream, 0, hwoff, data + off, frames, transfer,
 			   in_kernel);
 }



