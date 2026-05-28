Return-Path: <stable+bounces-254742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMvpDiP0F2q5WAgAu9opvQ
	(envelope-from <stable+bounces-254742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:52:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD055EDFE8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8F233007291
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A42FD7BE;
	Thu, 28 May 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h3oSpk4R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5E34D91F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954550; cv=none; b=kIifz43rHkoHvRIHbksvVKHz6ZfU8UUCEht3KlQJb9XVgy5HhUMq6haBsP3ddiFu1D8is3rXSYlDDWBjfnNUyWpTC31jAE/O0fIqF6VFn79FMS6Mr0HfZnYWR+Atum6RiEtzULFvnPPPNBqp9Lwrc/OjX3n2drPVzuoOSjjyrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954550; c=relaxed/simple;
	bh=f/7XO4wmbiP4d9LYBW7pruOr1Docn7DpN3TP2Ihz/7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CaAOBMk1o02UDyNqG4P+IX22JEoXQDhU1C7o6veYmltBUEic/ecgfEbWI+Tzj5MbkLn464Tf3HLm876m4i47FhBfgzsQXiWz7h47NwXD/2/iEy2J0ktiHQ/46JxJv2zZ4Pw/KW1PbEmQDiZSt8yoSPJtVIqm23PqbP74gKLFqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h3oSpk4R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C01F00A3E;
	Thu, 28 May 2026 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954548;
	bh=rvfkXd+an3CJI81EtbPCTdMvZT1893A0MQoidhKqbRk=;
	h=Subject:To:Cc:From:Date;
	b=h3oSpk4RbfHH2Zkd6kQfER+lJMCQxDTpM/rhGBdt1BTW4l6KSgqU6vTZdZi2qoIgG
	 0VJtPz2duBR3oxUpexJ+LeDhfejqjRNdvzUJJRImeXqJt1EOAFul908hm4W8PUJuRp
	 UbSUW7HZZKf0EpqGip4d7z+PN4rCxj0JQ8wSwceU=
Subject: FAILED: patch "[PATCH] ALSA: scarlett2: Allow flash writes ending at segment" failed to apply to 6.12-stable tree
To: cassiogabrielcontato@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:48:16 +0200
Message-ID: <2026052816-limelight-debtor-c8aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254742-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,gregkh:email]
X-Rspamd-Queue-Id: 3FD055EDFE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a69b677e47a80319ce148d61cc29a2b57006e78d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052816-limelight-debtor-c8aa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a69b677e47a80319ce148d61cc29a2b57006e78d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 19 May 2026 11:46:19 -0300
Subject: [PATCH] ALSA: scarlett2: Allow flash writes ending at segment
 boundary
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 0f83f8981213..8e80a7165faf 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9187,12 +9187,15 @@ static long scarlett2_hwdep_write(struct snd_hwdep *hw,
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


