Return-Path: <stable+bounces-140291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A895FAAA711
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888017A998D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3629ACF8;
	Mon,  5 May 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj+RA3TL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EC29ACC9;
	Mon,  5 May 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484573; cv=none; b=Qatacw1OwI8JU/ZGgf9JjAsUpk2h4YO5Idly4VA1SKEKDul3Bwb3voId69roHK8nfjhX/njjkutYWTsLO9mGSRXJZVFHjn9rTlspcItP0wyfDCvd+3K3v+g48fYMEJGVFy8k+7Ltqkw/BSN2cZiNg1Z5PTh+wDOWH8wfEr0jvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484573; c=relaxed/simple;
	bh=qnlW6kW/MHKL3YI/EjqNJUQP7K40U59GY6a8zZf60PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQqCC7UN+1bovQzWhI2STU8RbhXJGCY3gA5DiApx5L0iuInly9yGw7p42lWe/pnPvwHrJ732UZH1s9f70ELgKXBT89e00IDzAduYWKbPVT6MLz+RVwA5IPEHPwB1iIAZrsriRJsD5JYuqEzMFK5Bt5vpcsaHfzTA9E8FTFduD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj+RA3TL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C21DC4CEE4;
	Mon,  5 May 2025 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484572;
	bh=qnlW6kW/MHKL3YI/EjqNJUQP7K40U59GY6a8zZf60PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tj+RA3TLziGXewaqjyk1fTVhkSVzCp3ZB8OugexVRHHfDhAa4IGMT2bL1K4/VCuFX
	 J4NcBdw/grh85E3IrAuCFIKUeBIjSzlPJxzxUPGImQEmF7ch5ckFpj5sOTNfljZPvx
	 WgIBv8Wru3cRiyjpYBFtbcxDArf0eUZVPWJwa8rOzmtbcbObhntF0yviuLyELPy/zp
	 Kqi2Z1HBIqUdxgGfcP2AY9azQq+4iCSP0qXPA+XOOfoPg6/UjEcHUEZpk+SgZuZ0tz
	 vqpjxMc1E9mMTFs27Z2ZiRzK7AL+qVlFThlv2wjqcDGxmaKh2IrweN3cQHv+gcFvxB
	 5VJGmEYT/Jsmg==
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
Subject: [PATCH AUTOSEL 6.14 543/642] eth: fbnic: set IFF_UNICAST_FLT to avoid enabling promiscuous mode when adding unicast addrs
Date: Mon,  5 May 2025 18:12:39 -0400
Message-Id: <20250505221419.2672473-543-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 7a96b6ee773f3..1db57c42333ef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -628,6 +628,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbnic_rss_key_fill(fbn->rss_key);
 	fbnic_rss_init_en_mask(fbn);
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	netdev->features |=
 		NETIF_F_RXHASH |
 		NETIF_F_SG |
-- 
2.39.5


