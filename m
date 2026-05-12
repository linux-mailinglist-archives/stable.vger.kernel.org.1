Return-Path: <stable+bounces-246485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIbsAJRwA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 075615278D7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F5F31131DA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C8349AF5;
	Tue, 12 May 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nOagZvh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934B3EDE5C;
	Tue, 12 May 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609347; cv=none; b=Z/HWiD0bcmep8vwBQ4DuQyY/UodWYzMh2CqZy+mJta3a1Po+7VOG3wrER4ONfPpcyP9Ic8y/7Zfatx2yxwuAUjgqhRADO7rF4EKjbhmXicbalHQuqROph+3yIh7+1i+WKjAdjnERNWciSAXmjLw86g3M6qu3RsFIbA8BvS3kMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609347; c=relaxed/simple;
	bh=daL2f75cbCmtmHY4I+MtPTUVrbnsx1WCLEhrtBXXvyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOXAO7KwF6ACK4sAqfmeIAojBBuiPrCUbl72Zi2G4rz110hSpp5ylr3YEx5lwVJThHlIrTO7fSlHEMJfluBmmOtnU290USmRA0DrfWJMYnPsQhucsbePfdO1soO8hRpeIH4qgduELKsqGEWNAU8UqzdbjN3t1WjPq1PF1gDjkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nOagZvh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE2C2BCB0;
	Tue, 12 May 2026 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609347;
	bh=daL2f75cbCmtmHY4I+MtPTUVrbnsx1WCLEhrtBXXvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOagZvh2Ki7V6qp3GARWTmV/vAzUmzdfHN2pJ51jTNeW78y0XWiYGynxj1U9ESyui
	 XTxFgaEOBfHiRdY9l3TBkZMyw0ThQWS0zpKiKDvghE2qItGfxDhBpLNE+cwX383N2e
	 QJ2MGipQ/AyS1lig4D5xyIZkmO8ObcccfEh/L+m0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 118/307] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Tue, 12 May 2026 19:38:33 +0200
Message-ID: <20260512173942.616760251@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 075615278D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246485-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maoyi Xie <maoyixie.tju@gmail.com>

commit 1d324c2f43f70c965f25c58cc3611c779adbe47e upstream.

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
ip6gre hash via link_net. ip6erspan_changelink() was not converted in
that series and still uses dev_net(dev), which diverges from the
device's creation netns after IFLA_NET_NS_FD migration.

This re-inserts the tunnel into the wrong per-netns hash. The
original netns keeps a stale entry. When that netns is later
destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
slab-use-after-free reported by KASAN, followed by a kernel BUG at
net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net).

ip6gre_changelink() earlier in the same file already uses the cached
t->net; only ip6erspan_changelink() has the wrong shape.

Fixes: 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260430103318.3206018-1-maoyi.xie@ntu.edu.sg
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2261,10 +2261,11 @@ static int ip6erspan_changelink(struct n
 				struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm p;
-	struct ip6_tnl *t;
+	struct ip6gre_net *ign;
 
+	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);



