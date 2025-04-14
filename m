Return-Path: <stable+bounces-132434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926CA87E78
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99D81896F54
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235628F95F;
	Mon, 14 Apr 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akmJsc4X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43062DF42
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628957; cv=none; b=Y8jn12tifqkWetxnztJyHyh2AbKCMiSLYd71xa+e62b35Zq2p8SN7um/fiFhZBqBG2bQIORJqt8QM2tu5pwwzHaLv2sQdEBrsUH1O+btaNikvGYMo9COIKPFuVvhje+dGgd6lpOsDDa5h5iYYC+Bohy6Sfv+/4HaYTjxdaT8zTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628957; c=relaxed/simple;
	bh=LA091aKcbET0LPyQm7FOxheXElQMNoKQR/VWwEAjkyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0QSwube4H8YLz9jj0id19cfobRt/RNIL5X2ar/1SeA1Y6t9+/gBVkoSO6f1GTD5YgxeJc9T2n6SO+CzmOrw4V7r6KER10LeQDWvJU+Sax6hX+cRZuDh3jbjzm4KqR/VOVEcAWTdgX9Dtx41rdGuDkK9oXwrdY7/Pa4HlUd89Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akmJsc4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956EFC4CEE2;
	Mon, 14 Apr 2025 11:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628957;
	bh=LA091aKcbET0LPyQm7FOxheXElQMNoKQR/VWwEAjkyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akmJsc4XAMtaq5wF/jpGpSmCE15NmLr2lNafV/TryNBdVkNovlrQtMOlDkGwab/Ca
	 V0iJk4URdByJxh30uXOjFxwLYObXAaMqqSfRGvzVmocoMeWOwF0HrQ8+gjl5T/0sly
	 DeS0eTOV+XqMBk/VZFG/cZfcUJEveci+ZSOIrOtRf1ZCCXF8EL9saQXvFN8CoCFbnh
	 BFm9BCKs+P6PcQCmvJ3OHtgZ0QtK0l88nNBwjR+4iTFiJ+DDX4/yVylmzKtOWvNIW0
	 tgZhw0X6WsGxNEjCWgAl9u+HRSYa2LcYPxyRWDPqP4JVSuNUf6AV+RmLZTqWSKGWpR
	 S1GoKlb0bJ8sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.14.y 7/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Mon, 14 Apr 2025 07:09:15 -0400
Message-Id: <20250414070520-d5e3ad43d911afce@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414045848.2112779-8-anshuman.khandual@arm.com>
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
ℹ️ This is part 7/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 858c7bfcb35e1100b58bb63c9f562d86e09418d9

Note: The patch differs from the upstream commit:
---
1:  858c7bfcb35e1 ! 1:  b879a2d018d84 arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250227035119.2025171-1-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## Documentation/arch/arm64/booting.rst ##
     @@ Documentation/arch/arm64/booting.rst: Before jumping into the kernel, the following conditions must be met:
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

