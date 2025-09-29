Return-Path: <stable+bounces-181943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F31BA9BAC
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514C43B2CE8
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8169302CB7;
	Mon, 29 Sep 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcTkIOff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E672E2F1A
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157920; cv=none; b=Q85tyURA7iE7w2vZvfbzSabrFaq9WqLHQY2vs9mcmcu4Z+nsNNpplXVC2udi+2Gm7+lGEPiEXkUvFXAlATY8cUwuvd0pSHFmlzImR/p/mk92L0SDqW/7r9TvFcHau/4GIVS5QBENZEQyIArETtxCkW9uz0hcpLXWXezoCjn/lU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157920; c=relaxed/simple;
	bh=0ZY1TR5SmhD3QGkFxOGfpzrMNo1/XwPCzd+6ar34p6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqrzE5ocIulXIUN9N3fbDAcyxcRp4sYVEKZyU0VB8H/bANnm94UMZGOFVApExBIonV3Q0y+dt7tQ3gJyJvDdEeMUMMeRek4zoddRpOKoCDlF6ojXjY2RjdFFOeFhMutoyvDrMZI40Wit4oNg3cP9Dls25sdxL7cAEsbxj/ndaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcTkIOff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68634C4CEF7;
	Mon, 29 Sep 2025 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157920;
	bh=0ZY1TR5SmhD3QGkFxOGfpzrMNo1/XwPCzd+6ar34p6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcTkIOffql4PQFoz5We7HcumDkRReyeD7vCpVrg9iD8vR7yUll33R7bMoTtj1HmKN
	 6yZ+jBuXzW/0q0ZoA2UtLR5Z/0m8V5L+Y1zt0Y96zcBNTFnWtbSZu8Gq9q/yfsQioU
	 NcaLBPS7T9smAe0aLvQ5mlhoHE8hN/e1Fae8OBFPpaNEU/cinXx0raaDa4sryr2ywB
	 Auw7l4POk8tVToS1EQyuJDINlodjLUK5PhqtJHsYhpvikbEeenf1gN6u1RZXR+ptdh
	 Lbzw/kqB3B3GS0WE8EV78CzuHsWf7sBS55eyYbJOFxEy4azVexpKy37Io+RR3f14dZ
	 m0DXXe6hQJNKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kamakshi Nellore <nellorex.kamakshi@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] i40e: fix idx validation in config queues msg
Date: Mon, 29 Sep 2025 10:58:37 -0400
Message-ID: <20250929145838.112568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092937-trash-dainty-32e4@gregkh>
References: <2025092937-trash-dainty-32e4@gregkh>
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
index d8ba409122032..e4b432b5a2187 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2306,7 +2306,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2327,7 +2327,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
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


