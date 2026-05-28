Return-Path: <stable+bounces-255635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BfCN2ejGGrClggAu9opvQ
	(envelope-from <stable+bounces-255635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE45F8658
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD4B8300E91D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876852DF6E6;
	Thu, 28 May 2026 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBV4b+NU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FA2C11F9;
	Thu, 28 May 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999466; cv=none; b=MdMjr0zKSb23y1D8N6rjRvPf4mozAGUFtTvcyVrVKCJqeovmqCy0X/vueDfgEGskd2xc2hEM6SbG+oBL33SPEPvm+kEmCLtIyjUIGqKFxLMW/EtUxi9BlFkxn5afWxQ7uZWjISs56KNSdF4oDnNVlrFQtdXPhSNuXgHU2fCayZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999466; c=relaxed/simple;
	bh=bl5dl3ySKTY/8okafL9XCzcDHFVs0xbVacWyVn6AYH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfqPiFcPvTbCfGnM8Qr60nYUpGDuuST35Art5CHvm/I72wrSyJXoTGxCHQQ71g+0rgE4H9n4M+Eu9Fp3FvfbutorbBo4fS9F8j7KslYI8qGY6ToldG9z9GaxMqPcpFa3rYCq6kccO3bTa9SbkhGCpTMiEvFfUJvlabTgMJRm0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CBV4b+NU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534731F000E9;
	Thu, 28 May 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999463;
	bh=Sqmq148e/DIapP/G7x5ZLiGDdXL6FVLcRjiRF5m1G/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CBV4b+NUtDDt4QIKCCTDYaufWo2iXsvf1GLDHRbHvpd/Dqi1vrmHX+vbrtV/vAjwk
	 H/5B0itRM8QlY08VQhRIAZYRJ+FCkw/PvxSLzv4vO7xmcY6zrKOiF/XFXe2ddVsD8r
	 UfQ8v29ExkMtFEzJRaapr6QXxzaXpjyy/3LU+o1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 040/377] ALSA: scarlett2: Allow flash writes ending at segment boundary
Date: Thu, 28 May 2026 21:44:38 +0200
Message-ID: <20260528194639.536887169@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255635-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 25DE45F8658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit a69b677e47a80319ce148d61cc29a2b57006e78d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_scarlett2.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -9186,12 +9186,15 @@ static long scarlett2_hwdep_write(struct
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



