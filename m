Return-Path: <stable+bounces-140641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6660AAAE7D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A085D170673
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90A38B4F5;
	Mon,  5 May 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPlbDE/y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA62D5D09;
	Mon,  5 May 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485675; cv=none; b=h52JofGz3iG8U1rdtb0K0KrUHqc/JotpliRxEK1NVqKTkiE0aUee9F4GxYJ7F5e/PWrR4V76N5CqnKbVN3Xote4K5GuIcXqJjzpp0O3NP1IQH3Zmzh3HcHjlF9UpOYSlKkIRW5P13pEwolFx6+tmMCw/K0n798nyvMhLhKckso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485675; c=relaxed/simple;
	bh=OqbJTecH4RC60/dESl3z3Bljohguyg9o9AHFmeOnKMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvc3OQkvxPa3Idpir9jCSgGEUV7LwAbcK1wqZ4J2/6Go9BQckXXxLV0GL2Z7BX7TTbMjWfFs8+2y5yHZkIknc3MY1Iw6kTNsOduLsh7bksw3/3Nt7YrumydmX5iSd05iSUzfn17LUFJqrjSf8CqUnNboDURPrTIV+Pebvn4jl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPlbDE/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2F2C4CEE4;
	Mon,  5 May 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485674;
	bh=OqbJTecH4RC60/dESl3z3Bljohguyg9o9AHFmeOnKMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPlbDE/y/LX++VC2mIhbaYZWJVu+xHNUwlNtGNF3Ldy2Ts38TZsyo2Bzo3GLoaILl
	 nSyc4/ZSRMTcqlqnkIPF+K6aYajGywCgKdKz3HrXTJeivmjxDOn8Z50tpJ3mKA2S2w
	 rwslGE8fLRXBEvokSN3RcukglILoxCZWBNUHLPNDsoG6V6BtqxqBJ+ZIVh8dsDNXtd
	 pO7Xtp4P85L55UVsxzDTfPWXQAYZpxirCuEXDUVmpcP+l6syl3p+3ktCMXc+1+3vO5
	 3hMvZZn/N28VypRoSshsnAf1IDz8tsCVCZN1gjGoDw4MJI0rs0ffD2zdhmwVovsTXo
	 oSi6klaUloCeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 420/486] eth: fbnic: set IFF_UNICAST_FLT to avoid enabling promiscuous mode when adding unicast addrs
Date: Mon,  5 May 2025 18:38:16 -0400
Message-Id: <20250505223922.2682012-420-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@meta.com>

[ Upstream commit 09717c28b76c30b1dc8c261c855ffb2406abab2e ]

I realized when we were adding unicast addresses we were enabling
promiscuous mode. I did a bit of digging and realized we had overlooked
setting the driver private flag to indicate we supported unicast filtering.

Example below shows the table with 00deadbeef01 as the main NIC address,
and 5 additional addresses in the 00deadbeefX0 format.

  # cat $dbgfs/mac_addr
  Idx S TCAM Bitmap       Addr/Mask
  ----------------------------------
  00  0 00000000,00000000 000000000000
                          000000000000
  01  0 00000000,00000000 000000000000
                          000000000000
  02  0 00000000,00000000 000000000000
                          000000000000
  ...
  24  0 00000000,00000000 000000000000
                          000000000000
  25  1 00100000,00000000 00deadbeef50
                          000000000000
  26  1 00100000,00000000 00deadbeef40
                          000000000000
  27  1 00100000,00000000 00deadbeef30
                          000000000000
  28  1 00100000,00000000 00deadbeef20
                          000000000000
  29  1 00100000,00000000 00deadbeef10
                          000000000000
  30  1 00100000,00000000 00deadbeef01
                          000000000000
  31  0 00000000,00000000 000000000000
                          000000000000

Before rule 31 would be active. With this change it correctly sticks
to just the unicast filters.

Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250204010038.1404268-2-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index a400616a24d41..79e94632533c8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -544,6 +544,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	netdev->features |=
 		NETIF_F_RXHASH |
 		NETIF_F_SG |
-- 
2.39.5


