Return-Path: <stable+bounces-126029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62119A6F446
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA63169913
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBF255E4E;
	Tue, 25 Mar 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCWWpvTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D331F0E31
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902439; cv=none; b=ReMZmEk6/LnHGXGm7Wm1Qups4AEUrV/k9l8/zb9C3XP8F4k03d7qMZHIgVxLVVU9Ypl74h8VG1l1eyxHYRnLXdt/6mDSN4dcUSxeVNbA9R4v1YszUkFx3HNx1oR2u5qK22RzWkOSaqlEPId543yHFD5sDKkks1dfLClqw5+foso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902439; c=relaxed/simple;
	bh=xgqp0XrrU5ju97spGiL/gKX4M58758Cx59+1SIOThzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4ZqwmAjn7Nbz+AuzT88yDceluq9bQb7teWmJlUsAIMljMRSjriNs8ys/9od0Ks6FtJnmaTfIlVMIwa0d5HMTFfDrDjl40YNXUxjRRJue6+fA0YY22bUR9Edik5vv1uYiWl1Q6Ot8zo08fFFQnC3ytvO841RqQrYv62iwSnRpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCWWpvTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D410C4CEE4;
	Tue, 25 Mar 2025 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902439;
	bh=xgqp0XrrU5ju97spGiL/gKX4M58758Cx59+1SIOThzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCWWpvTtQGvkyuhw0aBYlbXBuAP+dKkW7zRt7Xr4bHDq2fsx5YbqwwD31F8T8c+ww
	 E9l4T9bx3hB9NvYPk4bAGRQCSAUkx8RvJHwnVS6HIS0GE7yTDTkZ+xCHLViYRsulzd
	 xwnS6d6mCF6GgpvOKCkxcUDW5sV3fGSTvado9jjMMOX8XSdO2rRH53yrdp2EBtXnv3
	 ZzxNncyjyVutyMnRQ9R/AriCrCig/PiX/Q8/WCjyVLXH4a+nGe/c3n3VANAK0S6Ep1
	 WLPZMocjtW/ueai1cMICjMWOqD1FTNDZ6oVMCwgopFMxJiJ38GFhokmpnfVqwRO1am
	 b92Cupr7Nnqzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] wifi: iwlwifi: mvm: ensure offloading TID queue exists
Date: Tue, 25 Mar 2025 07:33:57 -0400
Message-Id: <20250324213209-d0debd6f522b2fdb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324072404.3796160-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  78f65fbf421a6 ! 1:  68d3d313ef5fc wifi: iwlwifi: mvm: ensure offloading TID queue exists
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
    @@ drivers/net/wireless/intel/iwlwifi/mvm/sta.h
     @@
      /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
      /*
    -- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
    +- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
     + * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
       * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
       * Copyright (C) 2015-2016 Intel Deutschland GmbH
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

