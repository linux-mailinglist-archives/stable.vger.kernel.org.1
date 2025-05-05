Return-Path: <stable+bounces-141576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B92AAB4C5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B4C3A3D75
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DD295510;
	Tue,  6 May 2025 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5JhGqDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E222F1CC2;
	Mon,  5 May 2025 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486770; cv=none; b=KYSAS7Q+LotgGa0DucDmAcB5yhYqMgErZWawyFzlPvyfIIwGkpD2yFBvTpNOWw8I4eVb0wFekw1GZbsWXSsWXXoOmqpaZxlszVZbl7B11IugnD0z0UytjEZO/zu8nxh31/WUTQsuJy3eiMWSssXwxlukVEiHa8ZButEE0vWEaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486770; c=relaxed/simple;
	bh=KUORKRFxLRLeo2nK01Rulv/sfPY/dQT8RgV35mjwmBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/I794mYD+gP6vwLFA8C9Gsf3jKfIwfvno1Od7Qnw8Gv80mTo4sx8jkM46z33LdPZ5VGDY74ASgJUcIyjpYbIVEDJaM5pbrktttksMm7IK4+Zpjt+m3lJlXwsuWKw2laG3Cthm9ClI5HKzqpcOxDco4IL/xlfk96AQjARjpRV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5JhGqDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E3DC4CEED;
	Mon,  5 May 2025 23:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486770;
	bh=KUORKRFxLRLeo2nK01Rulv/sfPY/dQT8RgV35mjwmBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5JhGqDoRPeTJegD0ycJJ0ttvWLbiVbwUszPZMZ6PKpOwGmDTZoHCV/Lar7mpPKgS
	 l16CEkzP17/vlIsGxWhI4DG0DRga+IOXwHm6HJxMd4fOOSZBxM2surGGmqhVLOaTeW
	 I+nuxfF4amEIGrbx1A8xznSOTo0TuxUydkuhWeShwoaUzk7ij8qZxu1h3a4WMhLx0P
	 tETnNiZndOsjADcRPC7Q2Ff3lfZqV3G3a6y/283iB0o77FHrF2azjeZ78bWT02aVl8
	 vQiKN8hAs+C42adBzVWHpgiFBsU0EqP+q6AQqJ+uPtvqbf7tGLB5cGAKYItYtqyRA9
	 BI/fzM1D29RKA==
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
Subject: [PATCH AUTOSEL 6.1 194/212] ice: count combined queues using Rx/Tx count
Date: Mon,  5 May 2025 19:06:06 -0400
Message-Id: <20250505230624.2692522-194-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index a163e7717a534..1f62d11831567 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3373,8 +3373,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.39.5


