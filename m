Return-Path: <stable+bounces-258901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGZHO3UuG2oLAAkAu9opvQ
	(envelope-from <stable+bounces-258901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:37:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 778DF6121E4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F7353070547
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD864313E34;
	Sat, 30 May 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/p9BECf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A603242BA;
	Sat, 30 May 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165922; cv=none; b=AtL9nt6KetE1R9OvzDl9iKFzU1spBmEFX44DQmYXCAKM+x2uxN1epajS3RYz4h9ZG+74YYzajY6vsq+aVJBFI9yHfU6udCus4xQKeILSJKBu3MncOQfDZ94/2lTeBJdPBVlrCcMG+E/a39zKiqg3hWCfKtZbjtSFPpW0F4MmsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165922; c=relaxed/simple;
	bh=xjL1Dn3Z5NwKxPlZMZ4cYukn5A8XAq/9VpGruMaWTfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk5/DUjzADSDirFglFPhSRLkkIMsS/+N6MMK9ClyFXGp3Q141OwkDj+hLO6eFTOW3DW4GlEGvj3npNJenvveMoNE65VxM666BfRLGjouyOPY7sc8i4GyAEO8sid+IVw42DVpx5v/YzAhNtVYFZQvnzeuVhCf6jvklCFbb5yvI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/p9BECf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054BC1F00893;
	Sat, 30 May 2026 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165921;
	bh=VtIXTYTHVRw1z+PdQ1qDRYnHujRLmZ9c1bIFPC7YiaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/p9BECf9Jbut0SiA9ysdHzj6qyDbbLdQMH/LkEj0XKi75tGEc3G7l6fPiOPMbL+l
	 Osvwpqz+ZAMvoYI0vG2xRXCL1QlKG4pQcc+pJJ/9bsBsqh6kIUjOswih+m4rCftldZ
	 D02nDY8umr3WSHKON6y6FHp0C6NCPFkGnaqYQD4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 222/589] ALSA: usb-audio: Avoid potential endless loop in convert_chmap_v3()
Date: Sat, 30 May 2026 18:01:43 +0200
Message-ID: <20260530160230.813715929@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258901-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 778DF6121E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 6e7247d8f5fefeceb0bb9cc80a5388a636b219cd upstream.

The convert_chmap_v3() has a loop with its increment size of
cs_desc->wLength, but we forgot to validate cs_desc->wLength itself,
which may lead to potential endless loop by a malformed descriptor.

Add a proper size check to abort the loop for plugging the hole.

Fixes: ecfd41166b72 ("ALSA: usb-audio: Validate UAC3 cluster segment descriptors")
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260427152224.15276-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/stream.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -353,6 +353,8 @@ snd_pcm_chmap_elem *convert_chmap_v3(str
 		if (len < sizeof(*cs_desc))
 			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
+		if (cs_len < sizeof(*cs_desc))
+			break;
 		if (len < cs_len)
 			break;
 		cs_type = cs_desc->bSegmentType;



