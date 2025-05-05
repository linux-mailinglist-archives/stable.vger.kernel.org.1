Return-Path: <stable+bounces-140309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07915AAA75F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA016B3CF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033883380A7;
	Mon,  5 May 2025 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGcQl+g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1250293455;
	Mon,  5 May 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484611; cv=none; b=QBRepbvbeAUtPHnfFNzwMmwJbdTQRtVZSvI2uVqfYesztS+cwbBXOX8ZSGcptvkEzOx9jis0v5WwVL0jakWJfPCOTIWuASy3BZbASc4przRHHKdi3Ux2udxeolCZlheqyQWEPAyhNaBg2Q4yYvQ8Pp8YvmUzaYOputQuGOL2cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484611; c=relaxed/simple;
	bh=DZcrPpJm0WGlKa/b3sE1W3dZ54GcaR0gvKshv7RVs7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNzJQWPzgX9tBVD0y79yX9YAzxjKNJm/vBO6/QdOau1o9wD5znl0q5T+1Kfo9JV4I4Gytgms2A1nqO9MR59v6cNXuVn0FpDDQqQqywTK4W/Sctwq6FwYxZDElxKu7pBuKfg9ANBs477kZIZE4A055pYvzyXuXSDNbf0c58Y2uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGcQl+g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C672C4CEF1;
	Mon,  5 May 2025 22:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484611;
	bh=DZcrPpJm0WGlKa/b3sE1W3dZ54GcaR0gvKshv7RVs7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGcQl+g8gMs5NqsIj8LHqag+t18Nm5y5J/fyi7I4dvYkdfus/BP+TMk9pqn77ajd+
	 3FtQ4U77p4q1TavMxmaV5TM1FwcdCv3vLLj7LrTu9WRAIdblUVgKSDYmBPCPtzj1H6
	 RH7z/U09SY21TDBtJvhouZ/l/EarxYCalOxdhrnLKyS2ZZdOyGhZdmUWy2L3Em6EGp
	 HW6i/O1axXQbMljmLnLpbW8j4bp5aJY+ZCuEhJalVPZU5jUaYM4vnuMMVlxqNXIf7c
	 RTqU8aw/CeaTSo+a68ei2QhEShNDJ9rwPOmEoY3wZW4mPdd4Muvsf+n0d9oA3BXhPW
	 Gorx4/Ak2bUmw==
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
Subject: [PATCH AUTOSEL 6.14 561/642] ice: count combined queues using Rx/Tx count
Date: Mon,  5 May 2025 18:12:57 -0400
Message-Id: <20250505221419.2672473-561-sashal@kernel.org>
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
index f241493a6ac88..6bbb304ad9ab7 100644
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


