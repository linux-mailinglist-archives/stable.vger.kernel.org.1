Return-Path: <stable+bounces-264849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lc2xNGJ9MWrVkgUAu9opvQ
	(envelope-from <stable+bounces-264849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25B692679
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Jf8sAdnR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264849-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264849-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F07FF30360B1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C2283FE5;
	Tue, 16 Jun 2026 16:43:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDD45BD6F;
	Tue, 16 Jun 2026 16:43:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628213; cv=none; b=YzJfZFbmigtyuZLHJjKMmkGjSe3ih4YzthuFjT1zeYcQlz0FhN7JLtwQVl5Qqy4ApgGDhZPh4KkFBeIDJPG6TZTbPB1QX+Xa02RtxONCEJFw4Z4ghTf7aNs8WrZeK90AUsVGBbWZK5iPodIsvADFGORbZcN6bqqr0iUperdsZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628213; c=relaxed/simple;
	bh=81DKXvtlIa3lWVHUkDvMbN4ILU/EUbfZblXl8vajaSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+S2KMeBV16U2Be5d0wNwoXgTfFH8T50YX4UK9Tm5q1i6tbLK8LfiO1/HADnaxxNuDcYIsbvx+nmIqS6z7TnUH7ho8lTfXESycr5J1tYBtbwTSao6MLsZskYXkMVtnvGDZdHxdNHnSBnOw47TddfVJMuc5b41GhHZbJIM0KD2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jf8sAdnR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8723A1F000E9;
	Tue, 16 Jun 2026 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628211;
	bh=GyQsbo3dDeJtF5UjuSRI0kpVh42Ph/6At1imwA63nu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jf8sAdnRY0VGLLFga0bMRJm3C08SLOdBN7Ca839BSXdFMFlM5lNk6HoQ6scEJfH8O
	 v38DDZ4gf90fMuWRrvyHFeR3TwEBNvxqVVK9UoY7TSe0D/N16f1EXm/WBCYfLkU0iH
	 zHm6IB62NLKklntghIHHcBy3RnCicjneDhJi29M4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/452] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
Date: Tue, 16 Jun 2026 20:24:40 +0530
Message-ID: <20260616145120.750549915@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264849-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:idosch@nvidia.com,m:syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,m:sven@narfation.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	TAGGED_RCPT(0.00)[stable,9fdcc9f05a98a540b816];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D25B692679

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24 upstream.

Without rtnl_lock held, a hardif might be retrieved as primary interface of
a meshif, but then (while operating on this interface) getting decoupled
from the mesh interface. In this case, the meshif still exists but the
pointer from the primary hardif to the meshif is set to NULL.

The mesh_iface must be checked first to be non-NULL before continuing to
send an ARP request using meshif.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
[ switch to old "mesh_iface" name "soft_iface" ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f614709e6cda74..76d8c91c156a3b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -356,12 +356,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	soft_iface = primary_if->soft_iface;
+	soft_iface = READ_ONCE(primary_if->soft_iface);
+	if (!soft_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->soft_iface,
+			 soft_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
-- 
2.53.0




