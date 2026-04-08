Return-Path: <stable+bounces-234766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN9xCjKn1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:06:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FE3C266B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC9D319E39B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F373D8906;
	Wed,  8 Apr 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4csMCYz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160823D4134;
	Wed,  8 Apr 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673707; cv=none; b=ZQr/PFbB0ItPi06wvErL+s2Wab5co1BRmRlipZDu0+7QER365yY2l1DBBMDtJZ+HMqMlZRSSr2lNVop3EJVo1ARkF34stCYuFI42J8ryqxxH5OfEBHmsCqgfGb2n5bwIcvyjJp5Y3/RgYCPeKx/qnidC8TO1Bnmgslo46FIf4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673707; c=relaxed/simple;
	bh=LejNKrYly7KD9+OMeuwFRc8Ws+Tn1eCh4/Ob8cRbNps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4hOrVVgPmwAmBRKoHtcOzY7LAq/gNEEzq0S4wTYjW9tko9QhtNWtiskJ2xx2oE3rIF8/2rfP2vkFKi0OX+9j542CkCkQw0RDp8YkY4LOzn0ugKKGvZosXJDkkNpUmXlsymflzkfzcSlVryaHXnFtlxmzPcOoHyUPJxNutXsBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4csMCYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B5DC19421;
	Wed,  8 Apr 2026 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673707;
	bh=LejNKrYly7KD9+OMeuwFRc8Ws+Tn1eCh4/Ob8cRbNps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4csMCYzZFUgMI3VVWNqUztZ9ckvCvi82qG+ZDysX5ZbHJSgi4dsGMAQ5Sn2+t17s
	 BFIqX4Z8eF2DI97/JmnvkiUFqP7TMWDzWWdoi3UN9Y10lFlfkPekhjSzgg6OlogLM2
	 Qoayvi3VhHkXOuOZ1KbiShT3nQeEI/o5fUR4HfnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 058/242] ipv6: prevent possible UaF in addrconf_permanent_addr()
Date: Wed,  8 Apr 2026 20:01:38 +0200
Message-ID: <20260408175929.251119941@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234766-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E0FE3C266B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit fd63f185979b047fb22a0dfc6bd94d0cab6a6a70 ]

The mentioned helper try to warn the user about an exceptional
condition, but the message is delivered too late, accessing the ipv6
after its possible deletion.

Reorder the statement to avoid the possible UaF; while at it, place the
warning outside the idev->lock as it needs no protection.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://sashiko.dev/#/patchset/8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni%40redhat.com
Fixes: f1705ec197e7 ("net: ipv6: Make address flushing on ifdown optional")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/ef973c3a8cb4f8f1787ed469f3e5391b9fe95aa0.1774601542.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 63ada312061c6..e104ec8efe1c0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3642,12 +3642,12 @@ static void addrconf_permanent_addr(struct net *net, struct net_device *dev)
 		if ((ifp->flags & IFA_F_PERMANENT) &&
 		    fixup_permanent_addr(net, idev, ifp) < 0) {
 			write_unlock_bh(&idev->lock);
-			in6_ifa_hold(ifp);
-			ipv6_del_addr(ifp);
-			write_lock_bh(&idev->lock);
 
 			net_info_ratelimited("%s: Failed to add prefix route for address %pI6c; dropping\n",
 					     idev->dev->name, &ifp->addr);
+			in6_ifa_hold(ifp);
+			ipv6_del_addr(ifp);
+			write_lock_bh(&idev->lock);
 		}
 	}
 
-- 
2.53.0




