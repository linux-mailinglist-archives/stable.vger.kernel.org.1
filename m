Return-Path: <stable+bounces-181935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C734BA9AAD
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE115188D8B5
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B56176FB1;
	Mon, 29 Sep 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od8kBMHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85710147C9B
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157167; cv=none; b=aaAXXDJdyUj3+Dh8IO1b5o209eNTXbPwCUnINUiyG+QAQRs7dUeYUkGXzClWbvvDZucqlE7WhoXpGD6Y2VYJT+S8R8e2ZgzijHAx+VFMXfu4odn53C4fIKEcBCR9lvouqNF7vNerDPBc0JJr8psRpUBGUm/BQXz2hNknl1wG9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157167; c=relaxed/simple;
	bh=lWA+dCtr16sb5aIPrkdd/9WVcYVgwDwFl36slIiIpNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbUEWLCO6ThePdpMWkwbMH0mv+IVotafLzA16F1acRTSKvHzdl7eeAbSNeX3T56Lq0vXhFosdI2DaB10lrUvhcWitncjmnTvEWXd3tlKcmCoQTO4sHy6AElCOhragMAqm6GCmbUoun5VYCmdpO/wXhbVjRn7IPATTUG3cx/nB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od8kBMHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE45C4CEF4;
	Mon, 29 Sep 2025 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157167;
	bh=lWA+dCtr16sb5aIPrkdd/9WVcYVgwDwFl36slIiIpNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od8kBMHzhcu5P3pFczabMq3d2pT92Oi4RpwvIMUYPER9u/ZRw/s8k5TqYpDe/eJGx
	 SlJLObTkFJR//yu18JLTUCGsorEalPnheEltyY8N/1NKq7NWv6W+AtsqwEEI4hph5I
	 +bodSHSyP3XACv7gjFsaBBk1trmtMuUanR9RfpA5OT5waicUJuSiQDcT0DF9O/k84s
	 aMFy/zCkZQ/gCsqIWWRdej4z3gyir8qkEf+ho05mVHKLh3wMJtN59smE2FCj4jYmvZ
	 9QZiQiP2GX6qSuTl7TsdtljgxjwAipUUpJvSDj2eQ2FH4PL/2OwYtovBZ/QC7GK8bT
	 +RGOJTqBfMY/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i40e: fix idx validation in config queues msg
Date: Mon, 29 Sep 2025 10:46:03 -0400
Message-ID: <20250929144603.106981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092936-outflank-unwoven-3758@gregkh>
References: <2025092936-outflank-unwoven-3758@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

[ Upstream commit f1ad24c5abe1eaef69158bac1405a74b3c365115 ]

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_vc_config_queues_msg().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Kamakshi Nellore <nellorex.kamakshi@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7673ce2be1c02..351499320ca56 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2386,7 +2386,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2407,7 +2407,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
-- 
2.51.0


