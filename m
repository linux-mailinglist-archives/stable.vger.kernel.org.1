Return-Path: <stable+bounces-181940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0CBA9B78
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6BF7A5FE4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F42AD16;
	Mon, 29 Sep 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4tKxX6E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A52147C9B
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157644; cv=none; b=kTAUWC7haoBIGuUN9oE0fLkJRmo+pVdJGIIT/Sq4qpNa1KZVKt4ImE+I5nQoTsqwkd2G2LNTd9tNpVLF3Dz1q2pExNB5T8tJBT7Ct8KXzNlncVYa8hesPlfs1w5WR/ZsHcuBGoVhTx8dktYyP2pvcShw6Seug74ZtU4re3/N/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157644; c=relaxed/simple;
	bh=rN9ZoVB7IaQ5nbqiFwbSnmog6e5KcThbsollb/G+/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tatnCalzaAWvB7hqTR18UaQSyKhWS+VndX+cmsIO5jUW4NgL7jV1Mh3DtRXhqrshRpg09JhAP6a/cLpEU2gJ1CR3ymciDmJpznuwMK5utaywFqxVYnNxWpGKhgJEvDZLLmmohyHRtIIAjLqwXnpypd6U1sG9BHn/oJRBYlgQ4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4tKxX6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E348C4CEF4;
	Mon, 29 Sep 2025 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157643;
	bh=rN9ZoVB7IaQ5nbqiFwbSnmog6e5KcThbsollb/G+/yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4tKxX6Eo3QNf7ABeUrgj4KD+tlBD6ZAZihhOAmtEF/fxTUKwBT9rlWEHKzccasIg
	 BLtTbwfirBP6H83ISkrYcAr6olZHqHlOpw/EkKI9CQ5d3RxCwwk3Mworp90kwFdNsa
	 IGeRa0JQnP2mr68w6jSKmY9bWadT36HULqZaKcuRbwmrXKgWD0pbV2mz9C5BRmvxug
	 VPbYlUCKNhe9uBnW8yGKu8/GQjqDor8/KtrQCoOtTXhgMkTgNcjk/YWWYQfsD1WaCu
	 IOIR74UT+VZJHtGLsRslGgTPCEaYJ+TXwg5VIPJjF/K0e+rtqd/qYbNwtA0jyrEibd
	 N+UZP4ntr+gpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i40e: fix idx validation in config queues msg
Date: Mon, 29 Sep 2025 10:54:00 -0400
Message-ID: <20250929145400.110375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092937-unrushed-recharger-4598@gregkh>
References: <2025092937-unrushed-recharger-4598@gregkh>
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
index c86c429e9a3a3..29f8b2d9ea40b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2326,7 +2326,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2347,7 +2347,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
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


