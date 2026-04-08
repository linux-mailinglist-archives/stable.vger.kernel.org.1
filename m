Return-Path: <stable+bounces-234157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBl/J+ub1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:18:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025E3C0601
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB1D303FDED
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05A2FF144;
	Wed,  8 Apr 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h2ZqjVFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF012727F3;
	Wed,  8 Apr 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672131; cv=none; b=MUyh/J48ME2MmXitUUBD5PnBiI6qpDsxKjrv8sBRqR20Ds6taGOhK5I77d3ENEhtGl8yR2jSflXLDD4GpYvmo5bgOfhYVREK272FRKuZKz52EG+i+XfXBW8Ja+h7e6RdlyQyAEW/eYVexrT4gMlgauE3n6X3OHqBgs8M8ez8KRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672131; c=relaxed/simple;
	bh=70iZ0Qfh59XvX82e71h9Ikd9JZMvYxMi9HDhgPzIvtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPI4pEa+XjuN9mXNaxEmsMIiMmoqfCOw8JkoDAUL64mo/1sjhmqFx8DUc4gfTS3OVi/3TzYFkJmt6gGPf4kMrE0rY2P8hgvYVbRLgg3sljiCQyBG/G51MeannXOZ5Wejn+KMs39wkwNp5a/+g6vglUwPXcitslReSDwgxU00UDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h2ZqjVFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36619C19421;
	Wed,  8 Apr 2026 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672131;
	bh=70iZ0Qfh59XvX82e71h9Ikd9JZMvYxMi9HDhgPzIvtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2ZqjVFrNVTo5ybQ23l7Avl/d+yqJ54uzwn4taUWdzJzAq6jkBIIrc57FAzhwX6bl
	 B5D129Lek9FzLD0P2KLeL9idiHMcCUW0aQCqPUrvhKbUM+z5wRF7XhKmRlWTlN+wtM
	 uV2K+7sSizL1igY4N/jcs/JWQZzU9Rxzi5n/tc9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Berk Cem Goksel <berkcgoksel@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 202/312] ALSA: caiaq: fix stack out-of-bounds read in init_card
Date: Wed,  8 Apr 2026 20:01:59 +0200
Message-ID: <20260408175941.305457743@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234157-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1025E3C0601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Berk Cem Goksel <berkcgoksel@gmail.com>

commit 45424e871abf2a152e247a9cff78359f18dd95c0 upstream.

The loop creates a whitespace-stripped copy of the card shortname
where `len < sizeof(card->id)` is used for the bounds check. Since
sizeof(card->id) is 16 and the local id buffer is also 16 bytes,
writing 16 non-space characters fills the entire buffer,
overwriting the terminating nullbyte.

When this non-null-terminated string is later passed to
snd_card_set_id() -> copy_valid_id_string(), the function scans
forward with `while (*nid && ...)` and reads past the end of the
stack buffer, reading the contents of the stack.

A USB device with a product name containing many non-ASCII, non-space
characters (e.g. multibyte UTF-8) will reliably trigger this as follows:

  BUG: KASAN: stack-out-of-bounds in copy_valid_id_string
       sound/core/init.c:696 [inline]
  BUG: KASAN: stack-out-of-bounds in snd_card_set_id_no_lock+0x698/0x74c
       sound/core/init.c:718

The off-by-one has been present since commit bafeee5b1f8d ("ALSA:
snd_usb_caiaq: give better shortname") from June 2009 (v2.6.31-rc1),
which first introduced this whitespace-stripping loop. The original
code never accounted for the null terminator when bounding the copy.

Fix this by changing the loop bound to `sizeof(card->id) - 1`,
ensuring at least one byte remains as the null terminator.

Fixes: bafeee5b1f8d ("ALSA: snd_usb_caiaq: give better shortname")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Reported-by: Berk Cem Goksel <berkcgoksel@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
Link: https://patch.msgid.link/20260329133825.581585-1-berkcgoksel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/caiaq/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -488,7 +488,7 @@ static int init_card(struct snd_usb_caia
 		memset(id, 0, sizeof(id));
 
 		for (c = card->shortname, len = 0;
-			*c && len < sizeof(card->id); c++)
+			*c && len < sizeof(card->id) - 1; c++)
 			if (*c != ' ')
 				id[len++] = *c;
 



