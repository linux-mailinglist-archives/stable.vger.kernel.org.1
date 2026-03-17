Return-Path: <stable+bounces-226663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP++G1KNuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB32AF570
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2765230B36E5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3C336880;
	Tue, 17 Mar 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pELUh6q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1782DF152;
	Tue, 17 Mar 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767709; cv=none; b=Uvw7hQhZ4kbXnmXNETckCsRfzlr4rw1hpsImOszWZzgTqKkz2FEZrJ0qBLP5+HZqLXce1DnHjKdHwgG0PcGR/Zsr1PQ0dDeuat5bHEX4AlHRmzek+rHLeoVjbhQXmnxdHUGX6tVy872jXfapBfdabXpZcpTxwsqqUJgl6/ZaSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767709; c=relaxed/simple;
	bh=hYG4PNj9jXDqtxSfcg0U761TNuJohaBpwjbkXEF2/9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyY9GwHQ34iNzuuP/t2Px4HWoID2liC0IDeUjGylhlB1wtQNJpcp8TxydbPOq/CFIrOY8/HQdGevpyOfgKBj5vbWh6zIl8gvvm3JqbgmanHYlyZnG2/pqFI3cGq0uyK/HwmT54otUvGsibYwZqWJVPFvXyP7bDbzNBti6c0KQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pELUh6q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4CEC2BCAF;
	Tue, 17 Mar 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767709;
	bh=hYG4PNj9jXDqtxSfcg0U761TNuJohaBpwjbkXEF2/9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pELUh6q7K+dre8cYJWf3XftUXPp3Ntz2RwEYXqJvvPvoWdw8b/x1CZfdDKOzYV7/t
	 /rDnW0E9T4qO1Cz4APqTijhBDjYszh92DRHOldIM9jUje0ypoBHDEBVsentqmFdtVz
	 M5np002TH8WihS7JVFGYGyWjv3iSMaG9B6NnnIW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8f29539ef9a1c8334f42@syzkaller.appspotmail.com,
	syzbot+ae893a8901067fde2741@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 108/333] ALSA: usb-audio: Check endpoint numbers at parsing Scarlett2 mixer interfaces
Date: Tue, 17 Mar 2026 17:32:17 +0100
Message-ID: <20260317163003.374430228@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226663-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,8f29539ef9a1c8334f42,ae893a8901067fde2741];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 11FB32AF570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit df1d8abf36ca3681c21a6809eaa9a1e01ef897a6 upstream.

The Scarlett2 mixer quirk in USB-audio driver may hit a NULL
dereference when a malformed USB descriptor is passed, since it
assumes the presence of an endpoint in the parsed interface in
scarlett2_find_fc_interface(), as reported by fuzzer.

For avoiding the NULL dereference, just add the sanity check of
bNumEndpoints and skip the invalid interface.

Reported-by: syzbot+8f29539ef9a1c8334f42@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69acbbe1.050a0220.310d8.0001.GAE@google.com
Reported-by: syzbot+ae893a8901067fde2741@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69acf72a.050a0220.310d8.0004.GAE@google.com
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260309104632.141895-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer_scarlett2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -8251,6 +8251,8 @@ static int scarlett2_find_fc_interface(s
 
 		if (desc->bInterfaceClass != 255)
 			continue;
+		if (desc->bNumEndpoints < 1)
+			continue;
 
 		epd = get_endpoint(intf->altsetting, 0);
 		private->bInterfaceNumber = desc->bInterfaceNumber;



