Return-Path: <stable+bounces-271226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 69quMZKaRmqTZwsAu9opvQ
	(envelope-from <stable+bounces-271226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:06:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA856FAFCF
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="M/eE9u2z";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271226-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E06C309889B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7F34389B;
	Thu,  2 Jul 2026 16:49:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB0340408;
	Thu,  2 Jul 2026 16:49:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010995; cv=none; b=G8YYFtRXvDh8+SD2av0RygCXqWbYck19Cjn4SAkQhf2SPffhYyOnGBE1/ntcDNYow5FNtMSS2tYUnbpuhTle6H3H+fKU6uGJjMiGtu4r9pzFLWiVzyTP8QJ0Wb8O3+WgVEnpBaKaknrycg7BMGMkO7aGe2BgzMmW1/SII/3KtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010995; c=relaxed/simple;
	bh=HnVpnKO47X6x8JwLrXIfrbtdKPCyWwgS5nwTp13edgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0fiuFuY9jx4tGzqMiWZjkk1b8kToXq/x3v7BT3LI9b3RBNUjiYhx179ie5KImzCG7KhqSMIhk2Up5xtlX+gg4Abu6rW/SrdT0rnahXp62kKjW0U5wYdkiKHWTi7MVR5xyv69Ks05JGjogtkEBV86lrHcHNmsz+cj1TdfTTnWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/eE9u2z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D331F000E9;
	Thu,  2 Jul 2026 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010994;
	bh=371ycpx2EplN4HmslgZXqoHXX1s+FzFFgoudGXH311g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/eE9u2zoWU9VRiUfRtcFotMglfnMmqhhp617brtyyvH7a046Y/whu3lTJOOGL6nz
	 T0BKsp9Qk922MIc2+ref+HCzNMLT20hatsb6F6tsxmrhJZ/tPMs5D6aNeAaM2Oj47t
	 GNGqroVZCFNZiqShSX6p3anNIE14f3imBayeVifw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jungwoo Lee <jwlee2217@gmail.com>,
	Wongi Lee <qw3rtyp0@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 116/175] ipv6: account for fraggap on the paged allocation path
Date: Thu,  2 Jul 2026 18:20:17 +0200
Message-ID: <20260702155118.200459332@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-271226-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jwlee2217@gmail.com,m:qw3rtyp0@gmail.com,m:idosch@nvidia.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA856FAFCF

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wongi Lee <qw3rtyp0@gmail.com>

commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5 upstream.

In __ip6_append_data(), when the paged-allocation branch is taken
(MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
computed as

	alloclen = fragheaderlen + transhdrlen;
	pagedlen = datalen - transhdrlen;

datalen already includes fraggap (datalen = length + fraggap). When
fraggap is non-zero, this is not the first skb and transhdrlen is zero.
The fraggap bytes carried over from the previous skb are copied just past
the fragment headers in the new skb's linear area. The linear area is
therefore undersized by fraggap bytes while pagedlen is overstated by the
same amount, and the copy writes past skb->end into the trailing
skb_shared_info.

An unprivileged user can trigger this via a UDPv6 socket using
MSG_MORE together with MSG_SPLICE_PAGES.

The bad accounting was introduced by commit 773ba4fe9104 ("ipv6:
avoid partial copy for zc"). Before commit ce650a166335 ("udp6: Fix
__ip6_append_data()'s handling of MSG_SPLICE_PAGES"), the negative
copy value caused -EINVAL to be returned. That later commit allowed
MSG_SPLICE_PAGES to proceed in this case, making the corruption
triggerable.

The non-paged branch sets alloclen to fraglen, which already accounts
for fraggap because datalen does. Bring the paged branch in line by
adding fraggap to alloclen and subtracting it from pagedlen.

After this adjustment, copy no longer collapses to -fraggap on the
paged path, so remove the stale comment describing that old arithmetic.
Since a negative copy is no longer expected for a valid MSG_SPLICE_PAGES
case, remove the MSG_SPLICE_PAGES exception from the negative copy check.

Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/ajFTqRljatR17fFy@DESKTOP-19IMU7U.localdomain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1633,8 +1633,8 @@ alloc_new_skb:
 				  !(rt->dst.dev->features & NETIF_F_SG)))
 				alloclen = fraglen;
 			else {
-				alloclen = fragheaderlen + transhdrlen;
-				pagedlen = datalen - transhdrlen;
+				alloclen = fragheaderlen + transhdrlen + fraggap;
+				pagedlen = datalen - transhdrlen - fraggap;
 			}
 			alloclen += alloc_extra;
 
@@ -1649,10 +1649,7 @@ alloc_new_skb:
 			fraglen = datalen + fragheaderlen;
 
 			copy = datalen - transhdrlen - fraggap - pagedlen;
-			/* [!] NOTE: copy may be negative if pagedlen>0
-			 * because then the equation may reduces to -fraggap.
-			 */
-			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {
+			if (copy < 0) {
 				err = -EINVAL;
 				goto error;
 			}



