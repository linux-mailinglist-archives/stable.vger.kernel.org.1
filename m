Return-Path: <stable+bounces-111201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1330A2220A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D479188075A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F81DF254;
	Wed, 29 Jan 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6EYstxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDC1DF75D
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169251; cv=none; b=kBwlMdPH87URdCuIJBWxwpofeBuoxzeFoedSl/g9oGqn7SVXxtEBXd2q3n10lcHiOQiGcFrnqo1cY+eGgi95YjMMHfn6kzXpMwZw5MhsR2gpkQu+qEu9kLH5MKBKyXziIDfselLiISdrg7YFuJPwh36Bq3dh6FyesToOJpyGCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169251; c=relaxed/simple;
	bh=KeOtj1UDl4SbupeL823Fw2wAcI6eBjhvE3Qtue14OAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmck4+j07WvuE+s/nkyETvPswrcnVxcHw+cFzaQKkf5SQmB+x/1oeWwFsOTJD5OI1mE/m376KWpdIl2SIb11JX0AysjLTHvNdjM+83BlKt9NE/Y4IvSlRctF+2IiBQRywED+bdrR2plREQSJp8JETNfXx/jLPmg3+R00ZFk2WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6EYstxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED52C4CED3;
	Wed, 29 Jan 2025 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169251;
	bh=KeOtj1UDl4SbupeL823Fw2wAcI6eBjhvE3Qtue14OAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6EYstxHlvcEPpHY+Kw74mjFuMzsi50F0HB4IwsKWeYAl48CVA83CFbqkjsIeIi9u
	 OUi09ALtd0q/AOuIr2kolfg9FqERnlXpYTpPe9MmndwQU8i7nU+n7mqMKNPjDLhHfF
	 L/46HLONXiFFQ51iYl+btyoKgEQOUtYjPQDNq7wK+jsq8SG2aPyxXGapsREb8KoiuI
	 wb1MxkHYNdjX0P71XF2FIWC2smP1gQMAsQvwJKlUC5XnbDi8lfmb7pRPEt2AcWWJSH
	 ZfzBEfBZVTa6aglJZH5sANdRTnVXTMVtECUn/kQkDMTtx7FQU2AZ2RiB1YYQVU1NR8
	 HujPi8rUCXDmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] wifi: iwlwifi: add a few rate index validity checks
Date: Wed, 29 Jan 2025 11:47:29 -0500
Message-Id: <20250129113248-3aefa55fbfeb08b9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129143230.2449278-1-dmantipov@yandex.ru>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: efbe8f81952fe469d38655744627d860879dcde8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Dmitry Antipov<dmantipov@yandex.ru>
Commit author: Anjaneyulu<pagadala.yesu.anjaneyulu@intel.com>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  efbe8f81952fe ! 1:  bd8976ccdf328 wifi: iwlwifi: add a few rate index validity checks
    @@ Metadata
      ## Commit message ##
         wifi: iwlwifi: add a few rate index validity checks
     
    +    commit efbe8f81952fe469d38655744627d860879dcde8 upstream.
    +
         Validate index before access iwl_rate_mcs to keep rate->index
         inside the valid boundaries. Use MCS_0_INDEX if index is less
    -    than MCS_0_INDEX and MCS_9_INDEX if index is greater then
    +    than MCS_0_INDEX and MCS_9_INDEX if index is greater than
         MCS_9_INDEX.
     
         Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
         Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
         Link: https://lore.kernel.org/r/20230614123447.79f16b3aef32.If1137f894775d6d07b78cbf3a6163ffce6399507@changeid
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    +    Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
     
      ## drivers/net/wireless/intel/iwlwifi/dvm/rs.c ##
     @@
    @@ drivers/net/wireless/intel/iwlwifi/mvm/rs.c
      // SPDX-License-Identifier: GPL-2.0-only
      /******************************************************************************
       *
    -- * Copyright(c) 2005 - 2014, 2018 - 2022 Intel Corporation. All rights reserved.
    +- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
     + * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
       * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
       * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

