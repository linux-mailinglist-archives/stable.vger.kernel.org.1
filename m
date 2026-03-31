Return-Path: <stable+bounces-232067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIbYBDkCzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:19:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD136E7F5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4518731E5DBC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B473F8E04;
	Tue, 31 Mar 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WCbZGn0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BC423A9B;
	Tue, 31 Mar 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975790; cv=none; b=gohQ7QfCVepCIHZYyuIwttrMHpgskQw0nh2Rfl37JyI/bozppRVKw96ukxacDDbE7jKZdV/0UaoZq2d3vwnj9NcBHyQBhIjVfhpPDDcYSpJnC87RqR6cFrySWW5Kd+LyI490hAwP3CNn44RyQm2o3RzGA9T79ymPpopJBl0FDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975790; c=relaxed/simple;
	bh=UWToa2C/NDajB1eYKY9DVyVdE54v+krVqEDR+3RH64E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbCKEGNFFoohQaSUdnZ8HjzXfEoqMyoc5f9dVVwmNeywPd8d/2Flpu2LUdSu4Puhp2UfCd0RyXuj4FkdoECz9ySagQk8+XuDKf1x051Czko3iPd6qa9WDN1YHfVwBjwqcyYPXEZZUvgczPfNwaIqeq6RRX7aWwe5BrwwhwWumqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WCbZGn0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE872C2BCB2;
	Tue, 31 Mar 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975790;
	bh=UWToa2C/NDajB1eYKY9DVyVdE54v+krVqEDR+3RH64E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCbZGn0gyLOpta24NqxswHkBDKm/bSx3A9HfTA4F5/VoZ0edSnOa8RyRWZj0vIwri
	 WEHsOEunk/csC3BoWf47+Q/n9hu/YXrOC1UG2XXjh3LJ1zauJznIQRwKuM/NJeK9D6
	 pcy6Qv+Sb1CL4fiB8V8HYKIkex1qF+wg5EMCYplI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 087/244] net: fix fanout UAF in packet_release() via NETDEV_UP race
Date: Tue, 31 Mar 2026 18:20:37 +0200
Message-ID: <20260331161744.892893188@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232067-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,calif.io:url]
X-Rspamd-Queue-Id: 88BD136E7F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yochai Eisenrich <echelonh@gmail.com>

[ Upstream commit 42156f93d123436f2a27c468f18c966b7e5db796 ]

`packet_release()` has a race window where `NETDEV_UP` can re-register a
socket into a fanout group's `arr[]` array. The re-registration is not
cleaned up by `fanout_release()`, leaving a dangling pointer in the fanout
array.
`packet_release()` does NOT zero `po->num` in its `bind_lock` section.
After releasing `bind_lock`, `po->num` is still non-zero and `po->ifindex`
still matches the bound device. A concurrent `packet_notifier(NETDEV_UP)`
that already found the socket in `sklist` can re-register the hook.
For fanout sockets, this re-registration calls `__fanout_link(sk, po)`
which adds the socket back into `f->arr[]` and increments `f->num_members`,
but does NOT increment `f->sk_ref`.

The fix sets `po->num` to zero in `packet_release` while `bind_lock` is
held to prevent NETDEV_UP from linking, preventing the race window.

This bug was found following an additional audit with Claude Code based
on CVE-2025-38617.

Fixes: ce06b03e60fc ("packet: Add helpers to register/unregister ->prot_hook")
Link: https://blog.calif.io/p/a-race-within-a-race-exploiting-cve
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260319200610.25101-1-echelonh@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e8589fede4d4c..10de44530362c 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3189,6 +3189,7 @@ static int packet_release(struct socket *sock)
 
 	spin_lock(&po->bind_lock);
 	unregister_prot_hook(sk, false);
+	WRITE_ONCE(po->num, 0);
 	packet_cached_dev_reset(po);
 
 	if (po->prot_hook.dev) {
-- 
2.51.0




