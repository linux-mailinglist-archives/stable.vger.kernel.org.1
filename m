Return-Path: <stable+bounces-245889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIoCMW5nA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:46:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DE526124
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C7513060C8C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE33E0731;
	Tue, 12 May 2026 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijz088VT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128763DB980;
	Tue, 12 May 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607816; cv=none; b=n078jV3YYgi1qNb2vy/jKV2KvPIp3qI/nEvmjAkicrwE9DsSc3aihKMc5a511eIetByEgDdaW8N3aQV4NGDA6IjrnuuLYozLBa6Tin5us8+uWSJUR8+I+M1UGsMQNZpc4cajo+Dg5Ckf+Wu9C6naepj8fLUJzQl/o04frxp8wBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607816; c=relaxed/simple;
	bh=Y6Nqp1YkX1gaHbWZeggzwQt1JbEfXDCScyJ6PAv3h00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pedESdsjR26kkSW1yIxs3fynmE80+tT04vSTTfal0O9HG8Xz3oLpGPy+zLyGqmgmX24EszKlF124fJeuotmPoNbBcWTNjgWUOuoRAkGmzoLCa2Rt4YcvfzqfWPiDSJJ33GdBDZXh0eqO7X2MRLRv4H8o1kDDQPtYuN/7j4vnm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijz088VT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614BAC2BCB0;
	Tue, 12 May 2026 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607815;
	bh=Y6Nqp1YkX1gaHbWZeggzwQt1JbEfXDCScyJ6PAv3h00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijz088VTWcXh7Wc9AMzt1BwRyhvfAakkKoMoSMzP4W7NRVxPWxgGfDtuE6Ef8SnQU
	 IHGS7nl+XFaR/88jJH/nfu1pYUPBHP+QvVedKtmpn3eY5LCWnE1gW4LTu5l/RJXaYJ
	 8TUsqnoa4nmXLIIiO4bPOsd3nDlEvxuieU8Vb5XU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 045/206] ALSA: usb-audio: Fix UAC3 cluster descriptor size check
Date: Tue, 12 May 2026 19:38:17 +0200
Message-ID: <20260512173933.789516459@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 032DE526124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245889-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit 26265dd69da32d88a88d21987853cec899d9e21f upstream.

The UAC3 cluster descriptor length check in
snd_usb_get_audioformat_uac3()was added to
make sure that the buffer is large enough for
a struct uac3_cluster_header_descriptor before the
returned data is cast and used.

However, the check uses sizeof(cluster), where cluster
is a pointer, not the size of the descriptor header.
This makes the validation depend on the architecture
pointer size and does not match the intended object size.

Check against sizeof(*cluster) instead.

Fixes: fb4e2a6e8f28 ("ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260424-alsa-usb-uac3-cluster-size-v1-1-99a5808898a3@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -998,7 +998,7 @@ snd_usb_get_audioformat_uac3(struct snd_
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
-	if (wLength < sizeof(cluster))
+	if (wLength < sizeof(*cluster))
 		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)



