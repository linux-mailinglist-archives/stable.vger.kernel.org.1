Return-Path: <stable+bounces-125670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB9A6AAA7
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CE498287C
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D8A1EEA35;
	Thu, 20 Mar 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4LFoUn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC261EB9E8
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486626; cv=none; b=AYFgC3DjiDLwmG7B1z19NSZzwsZQ5+qUGZeH2iTUubuzHftScOpVGAob+5rBzFr7DmtJUj6fq/nl1s3tZbLRXer5hcWrijllXaZRVQM2bULkuMtGs9xM+A/mrc6Hhi+PXWpy7nOUTqrvOyTwGQXBLAInZv8whKhI6jQ0zsUZAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486626; c=relaxed/simple;
	bh=YtH/kyb/JSl1xE3JZjlRcQFcuMZlFXYMfQeonq1d9sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4whMeT8PTrGJEZMCuLV1lXF+0/MyAfc/gikxgVinLLSsud3wtp6Ant3Y9UQkzGhMTM2CZp0/5XZRmstHJgK4hBBiaqD8yRXLJbJ3Byv+8/K9bfTp5FuiF2I57mWwu1fTF7FkuQbdM89vE6OB+en/NFVKQUkWH/3PHWVy3X51ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4LFoUn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833FDC4CEE7;
	Thu, 20 Mar 2025 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486626;
	bh=YtH/kyb/JSl1xE3JZjlRcQFcuMZlFXYMfQeonq1d9sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4LFoUn8pw7k6Q7kKhzwDuII2SadKB8RQu3p91N7UR3qtiG6u37I3QdE09HfcsbIJ
	 MyA4nUEOxMF0exS6mMVqkAPPErlAxGDwJwYhSGSql4+m3gnR3xRMiCx6WJF/DHPUuY
	 eVvJ9OlSlKN0E2IW+VJ6+0sUdsIF/4ghB2sv5NnQLwePULFe3tEVCD89qUGjvwe3I3
	 6/tBDyMtOtMv30RSJDpgvnhZYaVLkL/zvkercnvQQLW6P+TTcXAqt2L8bi52LZ6L/4
	 IGTon9jmPYATLG/WH2fnoTRcPX0tR6PMvAGMprVUKtCJM/qAyGXaoiMDalDFn0QJ+Y
	 OsNUdVJGop1Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
Date: Thu, 20 Mar 2025 12:03:33 -0400
Message-Id: <20250320112325-2f65926822c256bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250320132220.33536-1-emmanuel.grumbach@intel.com>
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

The upstream commit SHA1 provided is correct: b1e8102a4048003097c7054cbc00bbda91a5ced7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Emmanuel Grumbach<emmanuel.grumbach@intel.com>
Commit author: Miri Korenblit<miriam.rachel.korenblit@intel.com>

Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b1e8102a40480 < -:  ------------- wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
-:  ------------- > 1:  16be59b9ee600 wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI version 8
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

