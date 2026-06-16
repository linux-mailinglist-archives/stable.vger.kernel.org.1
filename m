Return-Path: <stable+bounces-265075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgAJKx2DMWoVlQUAu9opvQ
	(envelope-from <stable+bounces-265075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA71692C60
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EIV3ZB1r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265075-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265075-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79D623014779
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03379472767;
	Tue, 16 Jun 2026 17:02:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D113032E728;
	Tue, 16 Jun 2026 17:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629351; cv=none; b=URZmEadFOrIxbMnk+0jjQB9HzrBUI8kZP8IqevtQygN+ZD2zu0C3n87i3nPp5jqBb5fjzobNiV6DpceXw3p8QRA3ej7PSHJiu7CewmwY5gn0clMHsVH9Yuad4vcHEorv9/OtcNTQ+npIKUqqU6U2GhXBTpJsToR9qj3DvFLYrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629351; c=relaxed/simple;
	bh=v3Kpng/dMCELOkQyORMmuLHomPpw05JL64IIgxwjTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8e24leuTeR9RE+fyuMyFGeWZ3kyyaBQV+i3dchmDy+KgSVmu59gomchAutDSaiUizbgrsVj6sZz1QEi/7ewawqVbpAYY/hgikNh/EsSGieqHOuHqM4gsmtpRuUWALNEUq6z9teXN3+2oGkx8VwLki7PcHgLlpZLfBjY6XyCY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EIV3ZB1r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E61F000E9;
	Tue, 16 Jun 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629350;
	bh=iMxBym5qRUt2MeJ/HriteIOUIuTrFaOjaqQmXoDqbAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIV3ZB1rrVDg3Th9Nt2iFQxjzPiZvd5RaUgocBsQxIi1oYmo6uFnE7WGgEDEboTwo
	 kujZW6GUKWXCINzeyQTseM3VxmRLBmx5Ojz2M55D+hgUr9J2gn5OVecwn7Wko83TDE
	 CPstXZAFzS8rPe1WMUg5lhmfkwgC5IytVdYXhIBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 269/452] ipv6: sit: reload inner IPv6 header after GSO offloads
Date: Tue, 16 Jun 2026 20:28:16 +0530
Message-ID: <20260616145131.725610990@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265075-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kylebot@openai.com,m:edumazet@google.com,m:syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,6eb9ca986d80f6f88cf9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,openai.com:email,appspotmail.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AA71692C60

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit f0e42f0c4337b1f220de1ddd63f47197c7dee4de ]

ipip6_tunnel_xmit() caches the inner IPv6 header pointer at function
entry and continues using it after iptunnel_handle_offloads().

For GSO skbs, iptunnel_handle_offloads() calls skb_header_unclone().
When the skb header is cloned, skb_header_unclone() can call
pskb_expand_head(), which may move the skb head. The pskb_expand_head()
contract requires pointers into the skb header to be reloaded after the
call.

If the later skb_realloc_headroom() branch is not taken, SIT uses the
stale iph6 pointer to read the inner hop limit and DS field. That can
read from a freed skb head after the old head's remaining clone is
released.

Reload iph6 after the offload helper succeeds and before subsequent
reads from the inner IPv6 header. Keep the existing reload after
skb_realloc_headroom(), since that branch can also replace the skb.

Fixes: 14909664e4e1 ("sit: Setup and TX path for sit/UDP foo-over-udp encapsulation")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com
Link: https://patch.msgid.link/20260605073448.6524-1-kylebot@openai.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/sit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index eb4c8e2a2b12e0..aa88a41034d920 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -965,6 +965,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ip_rt_put(rt);
 		goto tx_error;
 	}
+	iph6 = ipv6_hdr(skb);
 
 	if (df) {
 		mtu = dst_mtu(&rt->dst) - t_hlen;
-- 
2.53.0




