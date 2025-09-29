Return-Path: <stable+bounces-181931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9EBA9A61
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D4F166822
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA93081AF;
	Mon, 29 Sep 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLVztG1C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9092ECD19
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156966; cv=none; b=EKLk83KNYaapXdmAZQYvuvVpNOwjaKmWPfcE4VoDWPD4d0hUhDUUiXn/rkAERpcDTQy9622RsWYxTJOqnjfOBo8s9bAlRQcNoKtZ9Y1LyNtKL5VW0OTqyqU96jzQ9g0cDNdYRxbXC6cAyeDuvQK8BjS5DJMBk3XFX441/PwCJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156966; c=relaxed/simple;
	bh=T4bZ0RqIifj1qRdHxcIwsqVvLzqWia5kpA7NcxvOG+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX6N9pwudQxhMYDv9edwmi6nDv966QWvP+1jK4kB5XYdw6/XZSKyDeWMIRjeuiBfgcEvsHaEaqFnsAZnCTP6e0rxt6iC76Xjrer7knIblQdfE6z0rrA/jdhvlNi4D5883+P44gtN/leCh70tF6zYuQmov6tWQi2AnKpHlO8J5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLVztG1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F7AC4CEF4;
	Mon, 29 Sep 2025 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156965;
	bh=T4bZ0RqIifj1qRdHxcIwsqVvLzqWia5kpA7NcxvOG+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLVztG1C3f93JWY6bzTm+EzF8xHVTpDmb9Vww3JrmXRx+P8/fMNKoio/jXGhIqFMf
	 d1a9yfOd7XWV93/5iCwFLKYjo6VTC2VvN8eASYph63MM3eg9opklGecqeDg0s0LRdB
	 TNbItU3UphPioQSyO+umouKeAydviS7eMgBQYqTR8F/UFJxvN7VxwzKjiD6oOoPHAX
	 mh8Slv6w6rVGyjo+10RUdLMp7TwbvnxkR/nmq7+FJL4kEZ9HjYBim6Mo+cyJaLKOHN
	 CykPGPLz4vmecbWFW38DdCinNl1IntnQtkeXqylO/lPnIGv/n6lKhMyutR8jfOQouH
	 KSspb9HaLVSrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i40e: fix idx validation in config queues msg
Date: Mon, 29 Sep 2025 10:42:43 -0400
Message-ID: <20250929144243.104777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092935-lethargy-falcon-de3b@gregkh>
References: <2025092935-lethargy-falcon-de3b@gregkh>
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
index 7cfcb16c30911..c8ba3710837f9 100644
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


