Return-Path: <stable+bounces-229176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEbYD3dZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:17:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3942F6156
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 182EC305D0E3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9103B19DA;
	Mon, 23 Mar 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIKQ9+7G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1031A26B2DA;
	Mon, 23 Mar 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278301; cv=none; b=p1i0ukzquQw0UCPfC7vNx1rGPT132WCz11M+gtFQdORCYS8oM3bsvdON/rhSpAo6FGXW/grXpce1c1hA9XyuTEtR0IDpc32hmufsbqCoOXmy4cy5W8HChJ/Q4myT+qjmMgimLLZX0e9eh/ZI7uziCEJv6kOVsm/8YzibYT0Ymsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278301; c=relaxed/simple;
	bh=ynwjM3cJ+1z5x4ci2DHABlQqA038fU6Jpg70wLnkAtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGyPJxTSKSbZgsn8TiMptybjuNj5xQyECwyLdDgBl7TYbTMp1YLuUgsY5gaOBVjvmxwz99gsa6mhMTqJqXNGosmgB4iBgUf36ErgCvllbyjXtKoOPl8l4/15IieN/BT+I22H6WUEQLBExYq2GBLM7iTXUkjhkK+fUIX98pv4hGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIKQ9+7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54F1C4CEF7;
	Mon, 23 Mar 2026 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278300;
	bh=ynwjM3cJ+1z5x4ci2DHABlQqA038fU6Jpg70wLnkAtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIKQ9+7GLWkF4me543T1lCx3UTUfKcq/BHmAIR33c1EIkHy4G1oBhyakAmnfPfris
	 htdGw0EJ6tNufT7wBW30rFhSBAUdt2uA7wOpAY5VUFj4w4upwuE2dwzxPA9g6Q8ut2
	 zhvIFGThVR08/UVmlcjROhyYFOteqoWmJ9gP7cug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8f29539ef9a1c8334f42@syzkaller.appspotmail.com,
	syzbot+ae893a8901067fde2741@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 263/567] ALSA: usb-audio: Check endpoint numbers at parsing Scarlett2 mixer interfaces
Date: Mon, 23 Mar 2026 14:43:03 +0100
Message-ID: <20260323134540.338808357@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229176-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8f29539ef9a1c8334f42,ae893a8901067fde2741];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC3942F6156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3898,6 +3898,8 @@ static int scarlett2_find_fc_interface(s
 
 		if (desc->bInterfaceClass != 255)
 			continue;
+		if (desc->bNumEndpoints < 1)
+			continue;
 
 		epd = get_endpoint(intf->altsetting, 0);
 		private->bInterfaceNumber = desc->bInterfaceNumber;



