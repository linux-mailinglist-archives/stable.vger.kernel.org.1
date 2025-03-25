Return-Path: <stable+bounces-126013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CDA6F41E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7221D1891BE9
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD21E7C28;
	Tue, 25 Mar 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJrL0uA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617D2561A4
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902406; cv=none; b=Wqsy9YOyzJBjlVIOYaeH+ztntdfXfKxBGqS0HVo1CPfB0a8ZyBLXIenBD9sds9qlSQDMYtfJ097i7p1NsWkAsPm0RYtPZTMjhURr2rno+QLDHf5QCvppdh3TNjmNnIVNUZ70ul1XY4CQPIPE+kR9N6feSFlNSbxKlkECfeNx02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902406; c=relaxed/simple;
	bh=OlPOQJg3xZKJu+KnZVJN2wA2JrK7hAuMzEq3banQFdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6DEDmEhU9a4hCrHUV0EdYKVOxpvbS4wQ8e+VeMWcx4lnY/lEUONC2RibQ8iRlNluFxTDBdGdi947bKpiAoi2zYS+qupK6exlciCRnd0COW1I7KDKi9M9p7txaOEDzE4FsG6Wh3J7C1RRr96weZqOwI10fH7dnVg3D4Z2Jr1EUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJrL0uA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4488AC4CEE4;
	Tue, 25 Mar 2025 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902406;
	bh=OlPOQJg3xZKJu+KnZVJN2wA2JrK7hAuMzEq3banQFdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJrL0uA8pjv4Le2hSPIKVZL3erKHeLqowk/MLxZkUtwLPaZeT8cK/2PIR/9XEnEKj
	 p7IXvC5PPjysFxx+1ESi+Ip4eRmWpPhCnpAogqP2AFJu7uxQg4bQWLFhaKYCpwaioP
	 0blsGnb7Tf8Z2Z+5yhnBB4NelYNhTz8keWuVDN0P3HqvTLIPgy8psVI3x5cQB12+qt
	 wHbO47NOrnXexM22L+BKaf3B6eqlbVsaVxgIevlZx0YlEReCjcIrK/HzoM43dmubFi
	 JP0JJI4hB720TxNbBZGJXu5LBawJw4MIyKWL/VcOGhD/+mqKYENzsimGq9LtBScBHq
	 L/zMeTGInTlJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] wifi: iwlwifi: mvm: ensure offloading TID queue exists
Date: Tue, 25 Mar 2025 07:33:25 -0400
Message-Id: <20250324232803-2a3c4228866b95ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324072433.3796220-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 78f65fbf421a61894c14a1b91fe2fb4437b3fe5f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Benjamin Berg<benjamin.berg@intel.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  78f65fbf421a6 ! 1:  dc42d7e691464 wifi: iwlwifi: mvm: ensure offloading TID queue exists
    @@ Metadata
      ## Commit message ##
         wifi: iwlwifi: mvm: ensure offloading TID queue exists
     
    +    [ Upstream commit 78f65fbf421a61894c14a1b91fe2fb4437b3fe5f ]
    +
         The resume code path assumes that the TX queue for the offloading TID
         has been configured. At resume time it then tries to sync the write
         pointer as it may have been updated by the firmware.
    @@ Commit message
         Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
         Link: https://msgid.link/20240218194912.6632e6dc7b35.Ie6e6a7488c9c7d4529f13d48f752b5439d8ac3c4@changeid
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/net/wireless/intel/iwlwifi/mvm/d3.c ##
     @@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
    @@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: static int __iwl_mvm_suspend(struct
     +			.offloading_tid = 0,
     +		};
      
    - 		wowlan_config_cmd.sta_id = mvmvif->deflink.ap_sta_id;
    + 		wowlan_config_cmd.sta_id = mvmvif->ap_sta_id;
      
     @@ drivers/net/wireless/intel/iwlwifi/mvm/d3.c: static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
      			goto out_noreset;
    @@ drivers/net/wireless/intel/iwlwifi/mvm/sta.h
     @@
      /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
      /*
    -- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
    +- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
     + * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
       * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
       * Copyright (C) 2015-2016 Intel Deutschland GmbH
       */
     @@ drivers/net/wireless/intel/iwlwifi/mvm/sta.h: void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
    + 				       struct iwl_mvm_vif *mvmvif,
      				       bool disable);
    - 
      void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
     +int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
      void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

