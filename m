Return-Path: <stable+bounces-184363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2AEBD3D98
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9023418A1CF5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7C30FC01;
	Mon, 13 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMHKlKSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79B30FC24;
	Mon, 13 Oct 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367219; cv=none; b=sJ5YDHaHLFxZ4bFW84+7lL4oci6STvPopVn/xg5X0lawCP20MPLff+MGKhz43iRPyG577gikWe0bmKZTDy2NfxT94FRR9FvFCmmqIRN/OPusMdYBPMoYD2ZijLqFL0EcpYivd/3Tfl5EuVe+nq6UCuX/p34RshZnvUxnJglJLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367219; c=relaxed/simple;
	bh=2n7k2Twaw1LjTN3UDyvhHBa/Yt2Cpsh7sjklLR8FvQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKZANFDXe9gK4Xy5FZD78P4tQ70ByyE0mY9maBhUj2ozs2vvQa00I2COOOSNKqM4SMeQhQmC+GVM//cmU2AlYOQYur8e8m2Jm/6NWkYOAB9yzpUwrWVQMxKYLwSQvq12eMNm+hIy60dnGnPlamI9DWnHEUnS9ySxeeMsieRLNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMHKlKSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E2C19421;
	Mon, 13 Oct 2025 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367218;
	bh=2n7k2Twaw1LjTN3UDyvhHBa/Yt2Cpsh7sjklLR8FvQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMHKlKShByveW36SAdbWXXkJofanlt1Ppu7AwfMJctcVJOghqbcwkaMwdyBAbV2j+
	 HLcbKTtKZE0D0qbWIvGIEFzs/AbQ0NGHRVp1o2C+2AOZrcLQ0Hfq/0YWHi+2BoJZAg
	 26WhcGGgfXOgC1IdclBOUrQ3q4II+g9seMeISHTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Parav Pandit <parav@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/196] RDMA/core: Resolve MAC of next-hop device without ARP support
Date: Mon, 13 Oct 2025 16:45:07 +0200
Message-ID: <20251013144319.541754818@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@nvidia.com>

[ Upstream commit 200651b9b8aadfbbec852f0e5d042d9abe75e2ab ]

Currently, if the next-hop netdevice does not support ARP resolution,
the destination MAC address is silently set to zero without reporting
an error. This leads to incorrect behavior and may result in packet
transmission failures.

Fix this by deferring MAC resolution to the IP stack via neighbour
lookup, allowing proper resolution or error reporting as appropriate.

Fixes: 7025fcd36bd6 ("IB: address translation to map IP toIB addresses (GIDs)")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Link: https://patch.msgid.link/20250916111103.84069-3-edwards@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/addr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0a..cdb3b99e057cf 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -460,14 +460,10 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 {
 	int ret = 0;
 
-	if (ndev_flags & IFF_LOOPBACK) {
+	if (ndev_flags & IFF_LOOPBACK)
 		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
-	} else {
-		if (!(ndev_flags & IFF_NOARP)) {
-			/* If the device doesn't do ARP internally */
-			ret = fetch_ha(dst, addr, dst_in, seq);
-		}
-	}
+	else
+		ret = fetch_ha(dst, addr, dst_in, seq);
 	return ret;
 }
 
-- 
2.51.0




