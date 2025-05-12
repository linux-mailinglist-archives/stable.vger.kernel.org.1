Return-Path: <stable+bounces-143576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32DDAB405B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C0E466EDA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7AF25A2C5;
	Mon, 12 May 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xOkw/Vg/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D9254879;
	Mon, 12 May 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072400; cv=none; b=L3zQAq0ror27aXGNL1bXHVjLxexPpdPPNS434mN1du4ATTPVsHgCrs9DF9uyxiEH/lPFsGoYQtdDf79llzHv6TvmMhdNnT4OWsruINEXYjbh3V91dLbYmmwB8CuanU246Fah3orle73d63Hq6a3l2YL/CW4s9BaGQ9+/xvPaFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072400; c=relaxed/simple;
	bh=S6oVhpthkkLOWPQLqW1aiTGXb2KNpZzx5ihRQx8i3UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwTDhU7qhAorHV1k8LRfXCg9Lwb30I/PQdLp93VTNzzPEEK79BDxPWm730Oef+f2FAGifZ4x2+HyJsEYW/LhM+hU4A2xWFSf2Jq3BH/AMQwf5i4b5aNuqmqYDpLq68+Uodml5FzxYLFO0LvXfRM1dcCbQlfie3N3c600+P7Hayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xOkw/Vg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69964C4CEE7;
	Mon, 12 May 2025 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072399;
	bh=S6oVhpthkkLOWPQLqW1aiTGXb2KNpZzx5ihRQx8i3UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xOkw/Vg/niA9WMUGJMSX2Nx+dhj7ssN4f/8pnK/BE3T0G0fbMFDqHrK8Su+ZFJdiy
	 f6puL0v67ixRIDHa5ndA8lEfovodoKza1SoDRqxOQt6uk+G0609ZbunsDKySb7FwSb
	 6PULOlZ6pwkLhpHlvUZOzJsklcgf1OP/nAUismf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 09/92] gre: Fix again IPv6 link-local address generation.
Date: Mon, 12 May 2025 19:44:44 +0200
Message-ID: <20250512172023.510468727@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 3e6a0243ff002ddbd7ee18a8974ae61d2e6ed00d ]

Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
devices in most cases and fall back to using add_v4_addrs() only in
case the GRE configuration is incompatible with addrconf_addr_gen().

GRE used to use addrconf_addr_gen() until commit e5dd729460ca ("ip/ip6_gre:
use the same logic as SIT interfaces when computing v6LL address")
restricted this use to gretap and ip6gretap devices, and created
add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.

The original problem came when commit 9af28511be10 ("addrconf: refuse
isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
addr parameter was 0. The commit says that this would create an invalid
address, however, I couldn't find any RFC saying that the generated
interface identifier would be wrong. Anyway, since gre over IPv4
devices pass their local tunnel address to __ipv6_isatap_ifid(), that
commit broke their IPv6 link-local address generation when the local
address was unspecified.

Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
interfaces when computing v6LL address") tried to fix that case by
defining add_v4_addrs() and calling it to generate the IPv6 link-local
address instead of using addrconf_addr_gen() (apart for gretap and
ip6gretap devices, which would still use the regular
addrconf_addr_gen(), since they have a MAC address).

That broke several use cases because add_v4_addrs() isn't properly
integrated into the rest of IPv6 Neighbor Discovery code. Several of
these shortcomings have been fixed over time, but add_v4_addrs()
remains broken on several aspects. In particular, it doesn't send any
Router Sollicitations, so the SLAAC process doesn't start until the
interface receives a Router Advertisement. Also, add_v4_addrs() mostly
ignores the address generation mode of the interface
(/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.

Fix the situation by using add_v4_addrs() only in the specific scenario
where the normal method would fail. That is, for interfaces that have
all of the following characteristics:

  * run over IPv4,
  * transport IP packets directly, not Ethernet (that is, not gretap
    interfaces),
  * tunnel endpoint is INADDR_ANY (that is, 0),
  * device address generation mode is EUI64.

In all other cases, revert back to the regular addrconf_addr_gen().

Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
since ip6gre devices now always use addrconf_addr_gen() instead.

Note:
  This patch was originally applied as commit 183185a18ff9 ("gre: Fix
  IPv6 link-local address generation."). However, it was then reverted
  by commit fc486c2d060f ("Revert "gre: Fix IPv6 link-local address
  generation."") because it uncovered another bug that ended up
  breaking net/forwarding/ip6gre_custom_multipath_hash.sh. That other
  bug has now been fixed by commit 4d0ab3a6885e ("ipv6: Start path
  selection from the first nexthop"). Therefore we can now revive this
  GRE patch (no changes since original commit 183185a18ff9 ("gre: Fix
  IPv6 link-local address generation.").

Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/a88cc5c4811af36007645d610c95102dccb360a6.1746225214.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0811cc8956a3a..40ee2d6ef2297 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3162,16 +3162,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen, offset = 0;
+	int scope, plen;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
-	if (idev->dev->addr_len == sizeof(struct in6_addr))
-		offset = sizeof(struct in6_addr) - 4;
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3481,7 +3478,13 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	if (dev->type == ARPHRD_ETHER) {
+	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
+	 * unless we have an IPv4 GRE device not bound to an IP address and
+	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
+	 * case). Such devices fall back to add_v4_addrs() instead.
+	 */
+	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
+	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
-- 
2.39.5




