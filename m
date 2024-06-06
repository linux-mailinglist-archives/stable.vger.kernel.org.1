Return-Path: <stable+bounces-48283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC748FE372
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 11:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F985B2C242
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DDF178CDE;
	Thu,  6 Jun 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KwtcGPPV"
X-Original-To: stable@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686819D898
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667273; cv=none; b=GCGcgT17+0bbjgOpeA4ocYYNfz0M4MRVnBVf3KvfJoeLTDGAZZ1QW7HDyTqSibGjtvhmjOaNtscZCY8FwRQryUYYCrDSPm7hGHXnRWPgFXdPmBDBUxERmxr6gG25JUn2XlFD9xe6KOUDRXMJuvFBqvoup5XUjpbX6zTgwC4IwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667273; c=relaxed/simple;
	bh=ksyT3LO4rqew+a9ZMehfmpmJD6Us2vKHWKnaVV9r9OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9goOmC4Mt1S2i34TM/4dPrIlP/gzSXj4aQJtKe6tkXkZSotVGkDazfu4akRqsFKlKycw6DEhXUGX8KWX+fzf4inFFH66vtF/Z5Pwa15keJsq8MVGKlIzk0L2iOKRKMSZaU00l7QOOo9SOq+lZhuNFbCm6sUxOdF8sfLPnDl2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KwtcGPPV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8wJDSwWLK+zQOzPNTarCU0o1hfikdPKbDDJ/7UCuNHw=; b=KwtcGPPVwM1a2OwBC1knt937Tx
	SH2F5Ucy/fdNS2nC4f+gL2CU81ixr3fgjeZNcPcfuFhug8rvZJZo+6GvwlKmiUsRw7gkifJWb8Sg6
	BR923esqFGQZHmmUdNwFE2Kfl7FwnpdyocNw+GD7oWGerqRn0RhkmLhXPYkv/NmjVlmjfQRh/a6Ba
	wDTAdriyEZN9R2POB/UHKoUM+DnXh1xbrVbqBFiwLzmNJ3hU0OVpazd3sLLdFIkQyiy5YHRXUl0oJ
	gooSknwa9HPqLhi3uxestubzrDAOf5+H3xj7FamZiSRtyo+34LJ9LWwg/Lxdgr7IqYyFXBs/7B622
	HkT9/iAg==;
Received: from 25.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.25] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sF9iZ-000LUF-Ay; Thu, 06 Jun 2024 11:47:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Bauer <mail@david-bauer.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 4.19 up to 6.8] vxlan: Fix regression when dropping packets due to invalid src addresses
Date: Thu,  6 Jun 2024 11:47:33 +0200
Message-Id: <20240606094733.14589-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27298/Thu Jun  6 10:30:08 2024)

[ Upstream commit 1cd4bc987abb2823836cbb8f887026011ccddc8a ]

Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
has recently been added to vxlan mainly in the context of source
address snooping/learning so that when it is enabled, an entry in the
FDB is not being created for an invalid address for the corresponding
tunnel endpoint.

Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
that it passed through whichever macs were set in the L2 header. It
turns out that this change in behavior breaks setups, for example,
Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
passing before the change in f58f45c1e5b9 for both vxlan and geneve.
After mentioned change it is only passing for geneve as in case of
vxlan packets are dropped due to vxlan_set_mac() returning false as
source and destination macs are zero which for E/W traffic via tunnel
is totally fine.

Fix it by only opting into the is_valid_ether_addr() check in
vxlan_set_mac() when in fact source address snooping/learning is
actually enabled in vxlan. This is done by moving the check into
vxlan_snoop(). With this change, the Cilium connectivity test suite
passes again for both tunnel flavors.

Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Bauer <mail@david-bauer.net>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: David Bauer <mail@david-bauer.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Backport note: vxlan snooping/learning not supported in 6.8 or older,
  so commit is simply a revert. ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/vxlan/vxlan_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0a0b4a9717ce..1d0688610189 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1615,10 +1615,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
-	/* Ignore packets from invalid src-address */
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-		return false;
-
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-- 
2.34.1


