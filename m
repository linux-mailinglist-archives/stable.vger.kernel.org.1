Return-Path: <stable+bounces-8786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A698F8204DE
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90F91C20E8A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A279DE;
	Sat, 30 Dec 2023 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0CfvJ+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF979DC;
	Sat, 30 Dec 2023 12:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264FC433C7;
	Sat, 30 Dec 2023 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937759;
	bh=BhkqqJ28Bs2ZJg1I/2wn/C7u+t2fREOphwsijHDOVaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0CfvJ+lrsNFe/mjGb2mfPgKCqewNBLvLSQLg3SDh5fsd12KgP+OBZ7j67IOCuCM4
	 oIVkOeipbKOXYeuOn6a2NyJnRCA2RnQ4k5WfKEHzY/eidD9QVFqmYYCA+1LcWh3R8K
	 pyITAzq/gQOgA7wc0aW2ihOt8mj5eZF0CgQKS7lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 028/156] ice: fix theoretical out-of-bounds access in ethtool link modes
Date: Sat, 30 Dec 2023 11:58:02 +0000
Message-ID: <20231230115813.289478395@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 91f9181c738101a276d9da333e0ab665ad806e6d ]

To map phy types reported by the hardware to ethtool link mode bits,
ice uses two lookup tables (phy_type_low_lkup, phy_type_high_lkup).
The "low" table has 64 elements to cover every possible bit the hardware
may report, but the "high" table has only 13. If the hardware reports a
higher bit in phy_types_high, the driver would access memory beyond the
lookup table's end.

Instead of iterating through all 64 bits of phy_types_{low,high}, use
the sizes of the respective lookup tables.

Fixes: 9136e1f1e5c3 ("ice: refactor PHY type to ethtool link mode")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ad4d4702129f0..9be13e9840917 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1757,14 +1757,14 @@ ice_phy_type_to_ethtool(struct net_device *netdev,
 	linkmode_zero(ks->link_modes.supported);
 	linkmode_zero(ks->link_modes.advertising);
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_low_lkup); i++) {
 		if (phy_types_low & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_low_lkup[i], ks,
 					     req_speeds, advert_phy_type_lo,
 					     i);
 	}
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_high_lkup); i++) {
 		if (phy_types_high & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_high_lkup[i], ks,
 					     req_speeds, advert_phy_type_hi,
-- 
2.43.0




