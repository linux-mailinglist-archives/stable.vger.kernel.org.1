Return-Path: <stable+bounces-140643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04EAAAE9D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD43B8F23
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A462DCB71;
	Mon,  5 May 2025 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPs1twL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997F35AED8;
	Mon,  5 May 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485712; cv=none; b=Wc2gZR9ubB8Ed8pF4hgHTDQx6gVqcnOUS8PP49A90xOfWQWFnyE1C6naQcxe/D6SgG8ok1238ywaJyZ4sfEPu9W+9Wm5ot4YC+gpWxcKa8uwuoIQhPIzoUSZhe9DO5V6i/sn/uG2XTNp79v8f7SwWyqquC92IzmGRr4OuNy4md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485712; c=relaxed/simple;
	bh=iqiwDHIIKO7VHXaGeOt334f35nJ0OWz57iOP+tsOaL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmW0tZMPlQ4zYzH0RoamqUBtIb9YPug0/oy2oMhQzEMoPhiEocZhrHH5dM4eoNUBOWVBGcwQ0mQCBQRX1GTUFmix25GnmNmWK5H5cV7HRZrU1tvJVj2ctERi3Dv/DSyZXb5QxiNW7TOgEwX+vcsf4xdvCtsLXiSewgDL3vDY0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPs1twL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93558C4CEEF;
	Mon,  5 May 2025 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485712;
	bh=iqiwDHIIKO7VHXaGeOt334f35nJ0OWz57iOP+tsOaL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPs1twL5DDzcc27XKeLdpYwwUGxyYUd4zpfiduz+NJVxh3506l8cMWxBGWQhypBra
	 4J06Lzr7ztRVHMiUZAOnWe1uwJsGCdddrkIrbFCBLPHP46kaVOl/TnxhVycFfp+wsD
	 cXLjurg6hR3XC+wbKeCRaOfg4ASdEFzxzajSWzJu8SCSrmTSMc35ifxVwkCT3QLArU
	 thx8UUXHSlPkPftoP+Zgkty5apGtu/IjIXVg6E+f4w0UOla1UAF69HShvwggqqY21Q
	 xFdUd80VjvEL3cf2Ge/ZNNeYR32aA9IwD/aB4VUe+EU5qHd/tuMwQEc7bUvCB+gn5R
	 VQqEY8YZetFGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 438/486] ice: count combined queues using Rx/Tx count
Date: Mon,  5 May 2025 18:38:34 -0400
Message-Id: <20250505223922.2682012-438-sashal@kernel.org>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit c3a392bdd31adc474f1009ee85c13fdd01fe800d ]

Previous implementation assumes that there is 1:1 matching between
vectors and queues. It isn't always true.

Get minimum value from Rx/Tx queues to determine combined queues number.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7d1feeb317be3..2a2acbeb57221 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3817,8 +3817,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.39.5


