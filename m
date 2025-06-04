Return-Path: <stable+bounces-150875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821FACD1ED
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D4F1885BC7
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A91C84D3;
	Wed,  4 Jun 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy8IorMW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431D145B16;
	Wed,  4 Jun 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998490; cv=none; b=lbGhZkUcK+/sfBbXuL/W7p/P0TNJWSBT9qiL33/pn/yyWfwGw5J232MFpaTgiiw7bs9cipNymeb1ReI69W5QEpxv8Ue4e4Rr0I887a45xO3PKPmxbsK/m8B32ZLMwbDV1qrol2VEDC5J9vNqFnOFwhvTRS3XUuifW08Z/CXjt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998490; c=relaxed/simple;
	bh=DYvO1IWNV102sNCif/OsB29SxDK2hKQlLwmPFz61b5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FURZLzi5Fd9zYp5r+LMsnERINoO40heyQA+9WFtWF/f5Wra5JGv9orLQfwapAv0TZdGI3s4vwm0IYC+dmSEH93fR4ichuh5GlXWGGvQF1n8xIQcwp5Z3gUfDt/4hLTDKR+ljTutKTqzLhgdLUuyNZi7dplIM1dnmB/G89Q+YV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy8IorMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F1C4CEEF;
	Wed,  4 Jun 2025 00:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998489;
	bh=DYvO1IWNV102sNCif/OsB29SxDK2hKQlLwmPFz61b5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qy8IorMWI6BbVnKz2LyFzgCf3XGWuXzdVzk+vs++u/Azgakaay9XSZSxi980d+L0m
	 9zJIOV22lN/6fgg0CYmoF1ChhsvBx127Lu2R0d2x6+htFF8brzBNn945rprj5AQP7G
	 hiCHvIGbF7gl6ZYOs72cxWOzKIX/MAGuaDZCHUlPKHq8RJ/EajuZgzXUItwGwWuMPS
	 KFN5rouzEY8u+ioS82jy6/Q5BGPHXjIqr+yy2WGsOnsEIZrPxGetw9uShPN1k1OPER
	 nZ+wGcxOc2Bn9ymLMM9arXC37Pya9AK6BKGQFThtdWcemv7UJp6+UN2+WHFzWFiyvA
	 5C0xb8OIosnkg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH AUTOSEL 6.15 104/118] ice: fix check for existing switch rule
Date: Tue,  3 Jun 2025 20:50:35 -0400
Message-Id: <20250604005049.4147522-104-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

[ Upstream commit a808691df39b52cd9db861b118e88e18b63e2299 ]

In case the rule already exists and another VSI wants to subscribe to it
new VSI list is being created and both VSIs are moved to it.
Currently, the check for already existing VSI with the same rule is done
based on fdw_id.hw_vsi_id, which applies only to LOOKUP_RX flag.
Change it to vsi_handle. This is software VSI ID, but it can be applied
here, because vsi_map itself is also based on it.

Additionally change return status in case the VSI already exists in the
VSI map to "Already exists". Such case should be handled by the caller.

Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Bug Fix Nature This commit fixes a legitimate
bug in the Intel ice driver's switch rule handling logic. The issue
involves incorrect VSI (Virtual Station Interface) identification when
checking for existing switch rules, which can lead to: 1. **Incorrect
duplicate detection**: Using `fwd_id.hw_vsi_id` instead of `vsi_handle`
for comparison 2. **Inconsistent error handling**: Returning `0` instead
of `-EEXIST` when a VSI already exists in the VSI map ## Code Analysis
### Primary Fix (Line 3149): ```c -if (cur_fltr->fwd_id.hw_vsi_id ==
new_fltr->fwd_id.hw_vsi_id) +if (cur_fltr->vsi_handle ==
new_fltr->vsi_handle) ``` This change fixes the comparison logic to use
`vsi_handle` (software VSI ID) instead of `hw_vsi_id` (hardware VSI ID).
The commit message explains that `hw_vsi_id` only applies to `LOOKUP_RX`
flag, while `vsi_handle` is the correct identifier since `vsi_map` is
based on it. ### Secondary Fix (Line 5981): ```c -return 0; +return
-EEXIST; ``` This change ensures consistent error reporting when a VSI
already exists in the VSI map, allowing callers to handle this case
appropriately. ## Comparison with Similar Commits Looking at the
provided similar commits: - **Similar Commit #2** (Status: YES): Also
fixes switchdev rules book keeping with proper VSI handling - **Similar
Commit #5** (Status: YES): Removes unnecessary duplicate VSI ID checks
Both approved commits deal with VSI identification and handling issues,
similar to this commit. ## Backport Suitability Criteria ✅ **Fixes a bug
affecting users**: VSI rule management is critical for network
functionality ✅ **Small and contained**: Only 4 lines changed across 2
functions ✅ **No architectural changes**: Simply corrects existing logic
✅ **Minimal regression risk**: Changes are targeted and well-understood
✅ **Critical subsystem**: Network drivers are important for system
stability ✅ **Clear side effects**: The changes have predictable
behavior improvements ## Risk Assessment - **Low risk**: The changes are
surgical fixes to specific comparison logic - **Well-tested**: The
commit includes "Tested-by" tag from Intel QA - **Subsystem-confined**:
Changes are isolated to ice driver switch handling - **Backwards
compatible**: No API or behavioral changes for users The commit follows
stable tree rules perfectly: it's an important bugfix with minimal risk
that improves the reliability of network switch rule handling in the
Intel ice driver.

 drivers/net/ethernet/intel/ice/ice_switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 4a91e0aaf0a5e..9d9a7edd3618a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3146,7 +3146,7 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 		u16 vsi_handle_arr[2];
 
 		/* A rule already exists with the new VSI being added */
-		if (cur_fltr->fwd_id.hw_vsi_id == new_fltr->fwd_id.hw_vsi_id)
+		if (cur_fltr->vsi_handle == new_fltr->vsi_handle)
 			return -EEXIST;
 
 		vsi_handle_arr[0] = cur_fltr->vsi_handle;
@@ -5978,7 +5978,7 @@ ice_adv_add_update_vsi_list(struct ice_hw *hw,
 
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
-			return 0;
+			return -EEXIST;
 
 		/* Update the previously created VSI list set with
 		 * the new VSI ID passed in
-- 
2.39.5


