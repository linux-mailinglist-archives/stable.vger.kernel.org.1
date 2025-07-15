Return-Path: <stable+bounces-162279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F51B05CD5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F11888202
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411B2EAB6A;
	Tue, 15 Jul 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ihpPZ/+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B32EAB64;
	Tue, 15 Jul 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586136; cv=none; b=uVZAiu05Hqfo9v66sWaEfXzkqBdLmfm3UnnJUFVV0gTLvawZUfHpKrwz1WpAlOV9Aamj7HtaMZfCfAdpNMAo5+c/S35iaD0ti2sb5J5m7NdUi/u2Fn2zgSYddRxrRcXKThibeif0pSSCRGuZsD5TVToPBKVWnLiR6HA7LjLIauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586136; c=relaxed/simple;
	bh=/d64u0hzL6EUwCOmM8E4CcUiGGHhbns6hx/IpeYeWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMZzFBd18BpyrfXAik5NcOQf8oCQCtdpquGWS8+iUeqniczFEh0qXNcFNRTgZMIaGTWzDgQjDROGAMWJhLLxP7UfS6eYnVtI31mURJHL/npiWsqZ0EZqZdnzGl5etp/1NzzE5u/a9NZCFoCVVaO7KSim0Y6XroT7SwhEfwMQAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihpPZ/+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD4EC4CEE3;
	Tue, 15 Jul 2025 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586136;
	bh=/d64u0hzL6EUwCOmM8E4CcUiGGHhbns6hx/IpeYeWsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihpPZ/+ZPBd+tdZ2icOqXfLJ9xM9+gZIwLzqPtVSTR39j2Jq0dt9fEYNn/VwAq2+0
	 oZzEhKWdDq/AZZ9DqzdXrjbZWII8ILYYnrQ+GFuG9Cx14kNgtiep0NutDlVoeLdnuQ
	 FR4FzoeYY1e0C8+hp4ikj/82srjyEBXHdUx385Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aiden Yang <ling@moedove.com>,
	Gary Guo <gary@garyguo.net>,
	Guillaume Nault <gnault@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 29/77] gre: Fix IPv6 multicast route creation.
Date: Tue, 15 Jul 2025 15:13:28 +0200
Message-ID: <20250715130752.877643186@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <gnault@redhat.com>

commit 4e914ef063de40397e25a025c70d9737a9e45a8c upstream.

Use addrconf_add_dev() instead of ipv6_find_idev() in
addrconf_gre_config() so that we don't just get the inet6_dev, but also
install the default ff00::/8 multicast route.

Before commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
generation."), the multicast route was created at the end of the
function by addrconf_add_mroute(). But this code path is now only taken
in one particular case (gre devices not bound to a local IP address and
in EUI64 mode). For all other cases, the function exits early and
addrconf_add_mroute() is not called anymore.

Using addrconf_add_dev() instead of ipv6_find_idev() in
addrconf_gre_config(), fixes the problem as it will create the default
multicast route for all gre devices. This also brings
addrconf_gre_config() a bit closer to the normal netdevice IPv6
configuration code (addrconf_dev_config()).

Cc: stable@vger.kernel.org
Fixes: 3e6a0243ff00 ("gre: Fix again IPv6 link-local address generation.")
Reported-by: Aiden Yang <ling@moedove.com>
Closes: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
Reviewed-by: Gary Guo <gary@garyguo.net>
Tested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3453,11 +3453,9 @@ static void addrconf_gre_config(struct n
 
 	ASSERT_RTNL();
 
-	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev)) {
-		pr_debug("%s: add_dev failed\n", __func__);
+	idev = addrconf_add_dev(dev);
+	if (IS_ERR(idev))
 		return;
-	}
 
 	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
 	 * unless we have an IPv4 GRE device not bound to an IP address and
@@ -3471,9 +3469,6 @@ static void addrconf_gre_config(struct n
 	}
 
 	add_v4_addrs(idev);
-
-	if (dev->flags & IFF_POINTOPOINT)
-		addrconf_add_mroute(dev);
 }
 #endif
 



