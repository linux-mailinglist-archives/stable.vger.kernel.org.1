Return-Path: <stable+bounces-110981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A6A20E4F
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083A41888C3B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B1D515B;
	Tue, 28 Jan 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwhfXNsE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737271917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081064; cv=none; b=jH1NlX2iDqr1isneZS3tl2LhT10vFlW0CygTR1nOnK8GFy2r6uRnSWt/+7OOYBlWsNFz4J0SgppYNrthSawZz140pkZBHVfH4PD1tAQNfwTZV5QHtFJDaRcwy2Ok/1ML42P3rkcmro4p0m0YT5VzAauqmbX4QfNO6+JjMQelnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081064; c=relaxed/simple;
	bh=jSvefse4emPdTtIFVWoiiOmT1omhAHJ5YcgcrFHpr+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhSmDkkLOKvtUMj8e03g1I32lQTBLeMsA+7xCT3VBMK2DVl8Dctl6tjb9EcUTy+utgapXCP6H64sXZ56oPS2jlb3D8s31M4GXbhWevgd/esVQr/FsJT1c40zzzOL7smOhi4U4+y6y0Cz1WcXVqMjd5dJLdWuoJtP+8aJXsclWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwhfXNsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DADC4CED3;
	Tue, 28 Jan 2025 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081064;
	bh=jSvefse4emPdTtIFVWoiiOmT1omhAHJ5YcgcrFHpr+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwhfXNsET379lFoZM300xaDtuJKMzvgLaeludEVoQr5ahONTpp4+xLoI2emPNcELj
	 X4LFI71zwCdZtaG4YBLBTwEwy+Od3x8Sssaf2zl6zEQJc3D5+ig8cSndaXQ4sMVbjX
	 re+t1GpJKb0GyM5QRzIYw9oaxivlY6VMkIXcOqNJJhDKDgI3Q8gs0BRY53F8eA9XEo
	 bgPapfuSFch+MGFseBfyWlfYO7zCysIdsYXylbRPrdPNGukWZ08JGQamdkYiltWpeT
	 GjGU5KFZGkGCjBJtZg+AfjyKiF8cMexUnv8PDos+B4+TXy1gSiFfub6ehEsj0WD8DV
	 4BgPy+8h7Z73A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] wifi: iwlwifi: add a few rate index validity checks
Date: Tue, 28 Jan 2025 11:17:42 -0500
Message-Id: <20250128104326-46e594b30dd10af2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128095935.1413363-1-dmantipov@yandex.ru>
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
1:  efbe8f81952fe ! 1:  434d51c97c555 wifi: iwlwifi: add a few rate index validity checks
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
    -+ * Copyright(c) 2005 - 2014, 2018 - 2023 Intel Corporation. All rights reserved.
    +- * Copyright(c) 2005 - 2014, 2018 - 2021 Intel Corporation. All rights reserved.
    ++ * Copyright(c) 2005 - 2014, 2018 - 2021, 2023 Intel Corporation.
    ++ * All rights reserved.
       * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
       * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
       *****************************************************************************/
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

