Return-Path: <stable+bounces-271339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8H0sFEelRmqjawsAu9opvQ
	(envelope-from <stable+bounces-271339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:52:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B956FBAD5
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xlKX4Uwl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271339-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271339-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93B63327DA70
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F425B09B;
	Thu,  2 Jul 2026 16:54:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604C82866;
	Thu,  2 Jul 2026 16:54:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011284; cv=none; b=Sr5I0Bxt34cRaMyDL7UCgWM4ap3OImaC7otIMtzI3yLEGEXdvddHwyKDK6BVClt6anuqFsC6dkE8ibbxtfddq+oYAwgCC0QNyqsICZ1zstem+PV+5GXc8PiJvHd3aKV4Bcoy0GBGZnNJv3+C/qRM+mgk5stI+E9PhsSfsCbT7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011284; c=relaxed/simple;
	bh=KQI1kJUglqyfFn7XmHTMLJNbidw065/CesPmVcE/Hdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpHTQBxWV1hkOcqaNW7raumGVnXxWkvQoJZBd7+KaWKPYPzZcidn1sVreiQjxN70pgNcwwCvu359xUaIvtwcP/lTdyUAuweCKzFUO32qjjTydSp1OanUUIc9TYkXInLmefrm12HTCw719LMho/jjRbAJHmG+ppTnjXm/g/VRqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xlKX4Uwl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B091F000E9;
	Thu,  2 Jul 2026 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011283;
	bh=QQkCaVZ4N9QE3gNiSUFJ4u6bcZ0AlzegkSfHYoyNwiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xlKX4Uwl7+GZHpEapPnNCU/yYqtHCO3Bi+tfCVPvt4asu1BDEexZbiDgTt6fCWsvj
	 KeFIXR7xpT9KZM8uGG6aeL44x6j+5ifr4uCkTrWtoPrV08K4ktt2CwCWkeH6+O3gwj
	 5HICdB3OdZOUPC+VThV1BOLelz9wFKxulz93ktag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 006/108] batman-adv: tp_meter: keep unacked list in ascending ordered
Date: Thu,  2 Jul 2026 18:20:03 +0200
Message-ID: <20260702155112.244901239@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271339-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80B956FBAD5

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 5aa8651527ea0b610e7a09fb3b8204c1398b9525 upstream.

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b1629e0ac82683..f222c5093b647e 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}
-- 
2.53.0




