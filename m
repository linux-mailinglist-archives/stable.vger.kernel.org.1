Return-Path: <stable+bounces-141446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D95AAB38B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45658189DEC3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5F244670;
	Tue,  6 May 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ccgp1oNu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF8281528;
	Mon,  5 May 2025 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486337; cv=none; b=jHH7krzHEDre0sFhO5qD3GyyqeZ/5fO2eCT29LuVUfoZK3sUSPOc3UOQZoHbZPABCtKAdP+lPEn9rJUmduCqG0MfQl1SO6qgpdT3ftfYCYE0C0WSVvE2BTmmhDjylltswl3LYxAp+32Vgu08GulAfFdXelOyQNJfeJPgcZ7o6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486337; c=relaxed/simple;
	bh=vR9UdQFD1o/mCj7FtwHmH7swjhDzZpe9g0jGy7hXCWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InL//JBPHQor2Pq/vmlOzMNbwOkGgsBI8a/PuOz3jaKb9AIXxzF+B1J3P/V+mWA5vbUYvp04NyYdTQRBEbxUB0iVYl7BqN+sG2nJihM+tbuBFIcBK01JSg1Z/P0W+5gq0j060XhlawaSx5x+ugCM0NUQL+wLCdOoAI20Et/Jg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ccgp1oNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A595C4CEEE;
	Mon,  5 May 2025 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486336;
	bh=vR9UdQFD1o/mCj7FtwHmH7swjhDzZpe9g0jGy7hXCWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ccgp1oNumI6wO05JNkLvYj874GJgHlAf/pwB2zJLElEG14GO0P4w30nUO6zapLbj0
	 Ak3L0vNntqoMrgmoMvCwlWqMBzmHhAOFrIBnS3QFgCVNg6lnY4vD2J8Jun5wKxB/pH
	 OIc/XRWfx02f402kbrJGerqroRvzO+5tea/rUv/miw6rWxUJEE0AHDuelWGNfUcV3d
	 ZFnPcKVl56mgGn4awkbk7w5rYZQlB7esHNTmaWz/MtQ9V91LAQgDVQKGuvZ0CLH+/p
	 Yv80HNOdC9oCSodkUyjmS64q9nsz8DuhHOQ+kKknaiH5prPIYrOQbmnOP49Ag6LuUz
	 aWYaAa88vX4Bg==
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
Subject: [PATCH AUTOSEL 6.6 266/294] ice: count combined queues using Rx/Tx count
Date: Mon,  5 May 2025 18:56:06 -0400
Message-Id: <20250505225634.2688578-266-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 39b5f24be7e4f..dd58b2372dc0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3329,8 +3329,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.39.5


