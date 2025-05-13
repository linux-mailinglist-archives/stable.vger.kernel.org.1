Return-Path: <stable+bounces-144262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C35AB5CDC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970FE3A8FD5
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120149620;
	Tue, 13 May 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh/4fQhu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5220E032
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162282; cv=none; b=FOEaAMI19f1AsXmCT2ek/SkGFhDPnT0X6Cx/Jgox0IHbf+mfys25dlEVHOxcjikxj0raSJSjhhEfLjKE1JnKHLmtM5hvKekdNqwgZXRmqw5FnbBH+xsYXi83BkuxKm8JyoDER1bopGEpp9ehZ6y8T0KG3iPzML5x+LYFAFvlMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162282; c=relaxed/simple;
	bh=DECtrXZW35yyD3peF85uIMtk/963pS28Zy+wg8lEdbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJhtExoYTsW6rrKEX1QBn6xUISjIe/cUXBu9YO7JkD6k32ghIlC7bmlhyx6TV4a1ld6vVWPXA50Qqy5Jje2cUCsU42aR3bmtBfmz7vQmRHo50nQumKw1ZuJXLCcr6Fvu063imbrbFKt0FyKaoK3SwI85EsqZP93c7gsdda+odZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh/4fQhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA7BC4CEE4;
	Tue, 13 May 2025 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162281;
	bh=DECtrXZW35yyD3peF85uIMtk/963pS28Zy+wg8lEdbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dh/4fQhuWmGf9Y2bOq1oa9gNvz69OAAr68X13leEbil8vIA/C4ijDDai1TZlcJ4s4
	 7CrbHdkC+6xdG7v07tNitTOiJZNqaVnf/xf3cpiu8QJjnXPS04I43YF83Ky2mI8HHn
	 Yji/NaKC2sr5aqdnm/Sm2IkoNKp2DSkSwnzu8HEEsDAXSP7PYH+ehv8pcMthYTsb9A
	 qsO/t0g3oc07JLyEsuj2f5G7908ilz+tbDiBjbHlU4nSszFTXGcPCn4c3DdcAlOm4/
	 xNFv7eo5K3oaGR2JLER/9A4zerR/zDZtiqZVl260x25V6622fsny7o9E8uyXezJf3S
	 8JaZ9+K4I4rkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] wifi: cfg80211: check A-MSDU format more carefully
Date: Tue, 13 May 2025 14:51:17 -0400
Message-Id: <20250513095419-51d121afa8dba725@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513020938.3361430-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 9ad7974856926129f190ffbe3beea78460b3b7cc

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Johannes Berg<johannes.berg@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5d7a8585fbb3)
6.1.y | Present (different SHA1: 9eb3bc0973d0)

Note: The patch differs from the upstream commit:
---
1:  9ad7974856926 < -:  ------------- wifi: cfg80211: check A-MSDU format more carefully
-:  ------------- > 1:  af32816746f4e wifi: cfg80211: check A-MSDU format more carefully
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

