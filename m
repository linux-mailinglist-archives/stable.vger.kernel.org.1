Return-Path: <stable+bounces-271203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ODV+MsikRmqEawsAu9opvQ
	(envelope-from <stable+bounces-271203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:50:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D356FBA8C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:49:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HG3kYuEJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271203-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271203-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C1003107CF0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6737A83F;
	Thu,  2 Jul 2026 16:48:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5B3101C8;
	Thu,  2 Jul 2026 16:48:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010935; cv=none; b=ooi5aRvFlnaInsTV80WUxIJyBWe4+IzOfVuOy6k9JXSiYAmooOxSHy8Z/zrU1ijLmoZbnJFZBPeVvy3UPBvviU273Za3x0jVSs3G7vvtOBt+WrGTD9TcvRxLtfZ9oCXVgnAJB46sMPoXU3JLNHP38M09Wpv48KhRK72Pr6ZR0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010935; c=relaxed/simple;
	bh=rgJYt4MGyzEkUdzerKsGVE4poEn5lPLDqg+8bOQknlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkzOhWvWcHe41tF7iBVC8E5gDIHkKkRkWZLv9YNEO8qdgdTtWj163lEM/Iin1VFH/IhTWTAo0czFzKdfOf0BF+N0z1Py+UCmUprVregvIh5Lmv+E3a2/v+YpVkfdYxYBARlLpkvBwxJVvrVZ7msBLcQufXo+NTR4TWdsqmP51nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HG3kYuEJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BA1F00A3F;
	Thu,  2 Jul 2026 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010934;
	bh=/w47M9Iw9lFpW49tvV7teDtjDjwbxwWqxegYcCIoyJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HG3kYuEJegJQceqSNF44j32Gz148ixivC7tPUmxTDGt1dW809X89hxGyrmobVSRfA
	 F1bQ342gn+gMlEzb/C8kOHDL5W5hkInK05HZMpidRI/6BWNr77XuVD7VWqbIatIxIx
	 xS0Wic/JA0MxuJyIRnqC9M72mxnhzTqH4eAYn/kw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 091/175] batman-adv: tp_meter: keep unacked list in ascending ordered
Date: Thu,  2 Jul 2026 18:19:52 +0200
Message-ID: <20260702155117.695986348@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5D356FBA8C

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index dfc3374549921f..f350a60e6c76b9 100644
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




