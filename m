Return-Path: <stable+bounces-74853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015599731BC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60541F293AF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633EB18DF88;
	Tue, 10 Sep 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQMmM0HZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A29188A0C;
	Tue, 10 Sep 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963024; cv=none; b=cvmmWn/pKHlfta/gAbPFjpHw+RsXt2n6qT+ekXHFa3NjEUVherid90FQoAO42tG40SgbInhanwIO72S1SBzy4fhfL+z+5mcDua8y7ekNQE++wajnRw0BGP/OOBiMa9vimhwJnEgsEEoSi82ggoGScZ7HtM6HLF2qwOgkZnxUS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963024; c=relaxed/simple;
	bh=5LuRBdKnTXEmlGMYHMgJVZF3E9FebiJ+jOIQZ9zMDi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk8Hhs0NCNrI85ieWERtX7ZLGC9u9wH7hh3YkOLL/0mLHRpdMlazsO89c2qgoAdr/uyZbaJwjdWEHwNWlau2RNk3VskVV8qgOlgf8aDYIlrOOjq+cNSJMt5otK8POPcupzFkY6APe7U6+1x12wSez5GUX79htVzujqyGNPfezjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQMmM0HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0BDC4CEC3;
	Tue, 10 Sep 2024 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963024;
	bh=5LuRBdKnTXEmlGMYHMgJVZF3E9FebiJ+jOIQZ9zMDi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQMmM0HZnY+oH2qshIEGmLzYIjiFVvhSc0NkHyNL9YPRmgJZB28s0YDlGYTWyPodk
	 Y/Z8WVkQS2N1s3lVNycO7nwwIwFLGY0xPmavLP7h83R/hhHZWg3FbDg1INKQ6y4gK+
	 6Mzhf4FvtxqnEJ6mEx98VK+K++6Yoz+3b+MuRRpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/192] ice: do not bring the VSI up, if it was down before the XDP setup
Date: Tue, 10 Sep 2024 11:31:46 +0200
Message-ID: <20240910092601.370125349@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit 04c7e14e5b0b6227e7b00d7a96ca2f2426ab9171 ]

After XDP configuration is completed, we bring the interface up
unconditionally, regardless of its state before the call to .ndo_bpf().

Preserve the information whether the interface had to be brought down and
later bring it up only in such case.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1973b032fe05..3f01942e4982 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2909,8 +2909,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		   struct netlink_ext_ack *extack)
 {
 	unsigned int frame_size = vsi->netdev->mtu + ICE_ETH_PKT_HDR_PAD;
-	bool if_running = netif_running(vsi->netdev);
 	int ret = 0, xdp_ring_err = 0;
+	bool if_running;
 
 	if (frame_size > ice_max_xdp_frame_size(vsi)) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for loading XDP");
@@ -2923,8 +2923,11 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		return 0;
 	}
 
+	if_running = netif_running(vsi->netdev) &&
+		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
+
 	/* need to stop netdev while setting up the program for Rx rings */
-	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
+	if (if_running) {
 		ret = ice_down(vsi);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Preparing device for XDP attach failed");
-- 
2.43.0




