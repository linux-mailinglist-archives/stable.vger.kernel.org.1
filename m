Return-Path: <stable+bounces-246361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDijGJltA2pS5wEAu9opvQ
	(envelope-from <stable+bounces-246361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F13BC527043
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84C0431C4581
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682A3EDE67;
	Tue, 12 May 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqEbTaT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6813EDE59;
	Tue, 12 May 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609028; cv=none; b=OROgoJfsf8YD5nRmDaS0B6x9FUWthFK2ah56eCIJClfVYOFJ5A0MO7h6lgXLunq4MeLnzJJ1MyFASICHcTf7d8E64mcz7uo3bd9TADAtenRawOMx751rt8rAT7tShNL5Bu64CTN9QEikBgwWxCFVHdIWkNHPI+/v9Ph9+oNR6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609028; c=relaxed/simple;
	bh=c1l6JyEkaiQbPNIVQdR6DS9eoLnZ/n6oaYjdORhJ6Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7rhSbTb5bxGr9iWmvnfwXd9l47VUxvOQXaQbYNnEPT45LYGuzW8vI3kvpLRrHueve0esvB27Z3zZg1gb7p4/TNmJIy6kweh9TOVELZXDQ95n7YI2EylThaBEvvPCyZCqbNC93FLJZZXc7mQlP7Pv8OPFxZQdqPhY7M6oDqr8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqEbTaT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A2C2BCB0;
	Tue, 12 May 2026 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609028;
	bh=c1l6JyEkaiQbPNIVQdR6DS9eoLnZ/n6oaYjdORhJ6Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqEbTaT5vz2SJcvC9e//n93GDLbiOzvMT8Bm/ixcuiztgn3XLHHqGFuCg0mmJ9/da
	 i3aOXOYnevsP1qSMt2X47sULAR6TMXqZQF8eTH8QI0ENyPERXK9pPxuXjiKpxSXra8
	 K+C8eI6P/9ilfSqph5g2aqDsaTQUPmq4R5BTD/os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7.0 038/307] ALSA: usb-audio: Fix UAC3 cluster descriptor size check
Date: Tue, 12 May 2026 19:37:13 +0200
Message-ID: <20260512173940.929359639@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F13BC527043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246361-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,suse.de:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -997,7 +997,7 @@ snd_usb_get_audioformat_uac3(struct snd_
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
-	if (wLength < sizeof(cluster))
+	if (wLength < sizeof(*cluster))
 		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)



