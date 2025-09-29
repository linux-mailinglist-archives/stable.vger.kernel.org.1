Return-Path: <stable+bounces-181953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C625CBA9EBF
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B947A49CF
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEA3081DB;
	Mon, 29 Sep 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elwJLtx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C91FBC91
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161748; cv=none; b=KewsqqbWlQhpZmFisVvWB+4zdgxUKgs/psWC1sWKX2tEJ+YtlicDTdbBlYHzSom8m08qvbcJ5N/miwu5+e0oj64TnkdiL1Kc1Qq0byU1r8hPSOcAClvDlgBnAHDEKG8qt11TGDhtddxwoyKXfYda+01fyjnhV4GaTY42l3r0pCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161748; c=relaxed/simple;
	bh=P6/NAfoHwPShMeysBWTNopFvVqgeeTgfnn5vd63zX58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS9AaFMg3k3nCdSt73H3bgUuv7sTYKovxJlEyOx4zDlqsSjVbPJRh/t1fRIIzEm41Fso083LiUep5x7aNMtKVXG01SpotOM8rB6UURhnb+3WiHMhLUpFg2ndiYGapdby9eQLC3SQIHWwwdzrvZv7bB+gUy+t9rQFOuO1o2VMAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elwJLtx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AD2C4CEF4;
	Mon, 29 Sep 2025 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161747;
	bh=P6/NAfoHwPShMeysBWTNopFvVqgeeTgfnn5vd63zX58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elwJLtx2mz/hnPKqLSejvZHPrGEXebxeqp4F4bAlTBJuv/zAygmfZU8PHl7qR7J4E
	 /uaH9vhBcvuv/9UmUv5ppPbzKxcSCzllpqE9pNn+v6R87a6BNGJdP8/UXN1KstQ9VJ
	 l4PX6xFXewqO/15MT5tL5YWvuiC1yOlDlJng1c1BTuh+XGxh30PZ0N+Adfr+1CNhbu
	 r0YnBY4iNR3OQGAoono3v8cfPqJDGyto2IVKIKSnSuEdusNFer8arzQ2lgPcq8GTuY
	 SdAWT6zcXAxL4ylTLq7pMGKK3PlA56qXZd6CdhVeghHLsKaeS9mSxiQlqfTzTGJsKp
	 n8oFAz1kP0iTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] i40e: add mask to apply valid bits for itr_idx
Date: Mon, 29 Sep 2025 12:02:25 -0400
Message-ID: <20250929160225.145538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092927-captivate-suspense-fdf7@gregkh>
References: <2025092927-captivate-suspense-fdf7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

[ Upstream commit eac04428abe9f9cb203ffae4600791ea1d24eb18 ]

The ITR index (itr_idx) is only 2 bits wide. When constructing the
register value for QINT_RQCTL, all fields are ORed together. Without
masking, higher bits from itr_idx may overwrite adjacent fields in the
register.

Apply I40E_QINT_RQCTL_ITR_INDX_MASK to ensure only the intended bits are
set.

Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ Added missing linux/bitfield.h header for FIELD_PREP macro ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index d8ba409122032..45ff778be65f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2013 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include "i40e.h"
 
 /*********************notification routines***********************/
@@ -393,7 +394,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
-- 
2.51.0


