Return-Path: <stable+bounces-132436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30126A87E84
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748191897021
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F129344E;
	Mon, 14 Apr 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hij8FY26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11753290BD4
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628962; cv=none; b=NDzbMQXWyYtQZSV+5jOEEoB+Krs4TUnObY3nnQ3B58yhFV3uo7LrD2vuMeCme1zlEulgm5vYDFRsgf6Wdvoo6gWMdQDCm+pqu12JG6QGMhCuMqVN8xOJpYzlZk9KMji1UvvaDKmltEfL1VHhf2516/CNZuozL4c/4Tq7N1V88Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628962; c=relaxed/simple;
	bh=G7dIPj7ZjmR34AOQ4XmHccn4c61SDJsjLbMqj1IRULw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow3ZNO/EDaOzRVliLTCPKu8ig1JXeAlVPyziIM2SIl97YfXJ4F+MzwOg5hYyBnEYTzwYOziZCjMoRa1SbnGSF7ge+qXL92fbgDjUkFcYKPAyvk9BcxN+uxjmiovK0KH8exYsbfIOH9iDmjCkWg6S2ALRDBv7znJ5N27A3uiNPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hij8FY26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB63C4CEEF;
	Mon, 14 Apr 2025 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628961;
	bh=G7dIPj7ZjmR34AOQ4XmHccn4c61SDJsjLbMqj1IRULw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hij8FY26VqJZecWdpESQx7a9ODHhp5kJzbKDm/sNZYp+iTI4wPFaGSsciznxj1KPg
	 wkslTMqa74Jt/zwb5KQmNKjc0md0PhapulN/1+C9gSD+ax7rCv3sCmSp8EnwXvSDSn
	 AfEeMYde9YrzGG/4m0a2KfwQEGyQBLO7Y1mJcoTDcfewVO5FFae++7NPwVdX3WH4cW
	 cfyzUOpSP2WhDpHLcmg6JR5fMXBgn+Lv+QHsPJJkGS3zm6Hx+JINzBSiNm2HnKPk/6
	 pbSliaIMIJl4R3a9ccni1HDe0gxwz4vp1OGApaKivVTvtj/aaCVJQ5quXuLkG8sBrj
	 MQ+tG1lXFP5PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 2/7] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Mon, 14 Apr 2025 07:09:19 -0400
Message-Id: <20250414064953-4246eddd28219b7b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-3-anshuman.khandual@arm.com>
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

Summary of potential issues:
ℹ️ This is part 2/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 44844551670cff70a8aa5c1cde27ad1e0367e009

Note: The patch differs from the upstream commit:
---
1:  44844551670cf ! 1:  461a657e32a15 arm64/sysreg: Add register fields for HDFGRTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-3-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 44844551670cff70a8aa5c1cde27ad1e0367e009)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	0	E0HTRE
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

