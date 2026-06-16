Return-Path: <stable+bounces-263850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V89LGTZoMWqBigUAu9opvQ
	(envelope-from <stable+bounces-263850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:13:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E51690D87
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Haz/iAQu";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263850-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263850-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8FEB301AF13
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226943D4E9;
	Tue, 16 Jun 2026 15:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD83264FF;
	Tue, 16 Jun 2026 15:13:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622802; cv=none; b=gHB+u34M/9TCw5quwvXrV7uIEPzqQ47R47iH6rBt1JZrxpv6Pp8JwtXc+jLaJ8qV98ql2mAr1PDGpaNIWjXJ8fu75LUXH2wWyL618vl2upYyNbLtUI96alaABuuLIKgtG0rQzmtrTuoTzWiitw2AK8YS4hpSy6xVBqkKAY1ImrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622802; c=relaxed/simple;
	bh=TI0H2KUrbAuYLQLR0bP619M4uhP7Ns+mOgtMbekfn8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J97eHu2uHsl78nYaRo4wcH1FWXDebeaRC2FHYy6ymX1KluOYZi6FQ8AGF5WdkHtiSWCaNrxp3wy0y0CXQtjYGTN54yvP27dXSiT9mD/PUlAhd5j4nn0JT2BZYL9xYe15uH55R/55KBN864vvkrprSD12F4L2CDgN8i15vRRuS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Haz/iAQu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB61F000E9;
	Tue, 16 Jun 2026 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622800;
	bh=3PPS5aTyep09Gv/ky9gwCWxqTw89Ub9pSVr+/z384e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Haz/iAQuZNjqkNjlcko9GHqC7pqKwDBUhKwc7NwYpHnEDiqd5YkkCelqVQVp+rGot
	 TiPHin4DJY3QPRKg50u6QXUzGGqNIS07pyeFvoj6pE9TkbW1m8CgnHfLhwi/lI4TW1
	 eX4iP37RYVffAE4QYeDI5N686rBnMWpSMXGQpXiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 031/378] wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap
Date: Tue, 16 Jun 2026 20:24:22 +0530
Message-ID: <20260616145111.503332253@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263850-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com,m:kartikey406@gmail.com,m:johannes.berg@intel.com,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8e0622f6d9446420271f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53E51690D87

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 6c0cf89f36ac0c0fd8687a4ccdce2efb23a9c663 ]

When parsing the radiotap header of an injected frame,
ieee80211_parse_tx_radiotap() uses the IEEE80211_RADIOTAP_ANTENNA value
directly as a shift count:

	info->control.antennas |= BIT(*iterator.this_arg);

*iterator.this_arg is an 8-bit value taken straight from the frame
supplied by userspace, so BIT() can be asked to shift by up to 255. That
is undefined behaviour on the unsigned long and is reported by UBSAN:

  UBSAN: shift-out-of-bounds in net/mac80211/tx.c:2174:30
  shift exponent 235 is too large for 64-bit type 'unsigned long'
  Call Trace:
   ieee80211_parse_tx_radiotap+0xadb/0x1950 net/mac80211/tx.c:2174
   ieee80211_monitor_start_xmit+0xb1f/0x1250 net/mac80211/tx.c:2451
   ...
   packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3109

info->control.antennas is a 2-bit bitmap (u8 antennas:2), so only antenna
indices 0 and 1 can ever be represented. Ignore any larger value instead
of shifting out of bounds.

Reported-by: syzbot+8e0622f6d9446420271f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8e0622f6d9446420271f
Fixes: ef246a1480cc ("wifi: mac80211: support antenna control in injection")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260531011721.102941-1-kartikey406@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b7aedaab848386..d2ba2d81224f97 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2172,7 +2172,9 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 
 		case IEEE80211_RADIOTAP_ANTENNA:
 			/* this can appear multiple times, keep a bitmap */
-			info->control.antennas |= BIT(*iterator.this_arg);
+			/* control.antennas is only a 2-bit bitmap */
+			if (*iterator.this_arg < 2)
+				info->control.antennas |= BIT(*iterator.this_arg);
 			break;
 
 		case IEEE80211_RADIOTAP_DATA_RETRIES:
-- 
2.53.0




