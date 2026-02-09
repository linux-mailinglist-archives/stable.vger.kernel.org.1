Return-Path: <stable+bounces-215421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLDDGZr4iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:09:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B01119D8
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CCCC3124289
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98037997A;
	Mon,  9 Feb 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="15oRT2xH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26828725B;
	Mon,  9 Feb 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648736; cv=none; b=mSApPDmI7mqxk6GkF8V3t4YIU/7BTcyGDPyh9/RC8oUMy0sE3Cf9z0bzD4Mstki/8QpmSqMUEOwYkQioZ+vsZaJXfoAPBWbmTbNIE//F2Wf/lXeHMHjLaIKzJ/blDjjzCtXbZs2OrP1PbZMtCn4ZNdY8wbP7640wte3NV8pVBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648736; c=relaxed/simple;
	bh=LnUKqzFHMTnd804uPujtzNMM6tYlX01JlmVJfawHMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9maOjfo0QZD/xzmzEvHOzDXBetPmZTXz5p91N5gKdPnjmNj06MsAXNfIn/21cxhRGcPZo7MCd9VsOjYtpvZT48dPG5Qz9dvipqwEmEoVC/PhxyyqCteS/+pR+W0zQu4znuf8MEcWo0xhN9A3oVrVt2ty6pxThRvXf/fmnJGsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15oRT2xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72784C116C6;
	Mon,  9 Feb 2026 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648735;
	bh=LnUKqzFHMTnd804uPujtzNMM6tYlX01JlmVJfawHMW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=15oRT2xHW++cYy+nPDH84jeJLMrteA8B3CXrDLs7Er2CGLZFo4mXyXd6AQ9K7rxMv
	 VVGbjp5ghxfRkbwW18nBNib64oWaQAFUqotZirdRwh9KY1oZxAqPta+sGpUJWENbwD
	 K2OAccvbBJzPSoRQlUEq+QvtJE0qybzvZtmLRy24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	valis <sec@valis.email>,
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com,
	Boudewijn van der Heide <boudewijn@delta-utec.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 28/41] macvlan: fix error recovery in macvlan_common_newlink()
Date: Mon,  9 Feb 2026 15:24:49 +0100
Message-ID: <20260209142257.827343528@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215421-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,7182fbe91e58602ec1fe];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valis.email:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,delta-utec.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C12B01119D8
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f8db6475a83649689c087a8f52486fcc53e627e9 ]

valis provided a nice repro to crash the kernel:

ip link add p1 type veth peer p2
ip link set address 00:00:00:00:00:20 dev p1
ip link set up dev p1
ip link set up dev p2

ip link add mv0 link p2 type macvlan mode source
ip link add invalid% link p2 type macvlan mode source macaddr add 00:00:00:00:00:20

ping -c1 -I p1 1.2.3.4

He also gave a very detailed analysis:

<quote valis>

The issue is triggered when a new macvlan link is created  with
MACVLAN_MODE_SOURCE mode and MACVLAN_MACADDR_ADD (or
MACVLAN_MACADDR_SET) parameter, lower device already has a macvlan
port and register_netdevice() called from macvlan_common_newlink()
fails (e.g. because of the invalid link name).

In this case macvlan_hash_add_source is called from
macvlan_change_sources() / macvlan_common_newlink():

This adds a reference to vlan to the port's vlan_source_hash using
macvlan_source_entry.

vlan is a pointer to the priv data of the link that is being created.

When register_netdevice() fails, the error is returned from
macvlan_newlink() to rtnl_newlink_create():

        if (ops->newlink)
                err = ops->newlink(dev, &params, extack);
        else
                err = register_netdevice(dev);
        if (err < 0) {
                free_netdev(dev);
                goto out;
        }

and free_netdev() is called, causing a kvfree() on the struct
net_device that is still referenced in the source entry attached to
the lower device's macvlan port.

Now all packets sent on the macvlan port with a matching source mac
address will trigger a use-after-free in macvlan_forward_source().

</quote valis>

With all that, my fix is to make sure we call macvlan_flush_sources()
regardless of @create value whenever "goto destroy_macvlan_port;"
path is taken.

Many thanks to valis for following up on this issue.

Fixes: aa5fd0fb7748 ("driver: macvlan: Destroy new macvlan port if macvlan_common_newlink failed.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: valis <sec@valis.email>
Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Closes: https: //lore.kernel.org/netdev/695fb1e8.050a0220.1c677c.039f.GAE@google.com/T/#u
Cc: Boudewijn van der Heide <boudewijn@delta-utec.com>
Link: https://patch.msgid.link/20260129204359.632556-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macvlan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 49f9f75f5c121..cae48b1b7020f 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1519,9 +1519,10 @@ int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
 	/* the macvlan port may be freed by macvlan_uninit when fail to register.
 	 * so we destroy the macvlan port only when it's valid.
 	 */
-	if (create && macvlan_port_get_rtnl(lowerdev)) {
+	if (macvlan_port_get_rtnl(lowerdev)) {
 		macvlan_flush_sources(port, vlan);
-		macvlan_port_destroy(port->dev);
+		if (create)
+			macvlan_port_destroy(port->dev);
 	}
 	return err;
 }
-- 
2.51.0




