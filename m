Return-Path: <stable+bounces-144424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF4AB7685
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832741BA3993
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96688295506;
	Wed, 14 May 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZAUVg7P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A8295510
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253610; cv=none; b=jRNj/0ZaM5u4YW3hu9OFTJq2azPX2Bh4FTpTFTIOaMaJTTz30y6tf3Od3JoBKLr2maJtA/HHRa+zJhY3e8Rdkuf9WmShCLJMDs5+yBs/GKMBoYLcqU+cI6XWyyWqSeLum9YK9W0vzXq74G0TLR08IiLoE/pQvl2FI1mAr/B9hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253610; c=relaxed/simple;
	bh=Q/SQV3LG3gPWlnHORGGVnQf1CRJwcLYpy+SPT2Ybyug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVa8IyuVISYeoB5zmUXUA/tWHWH0H2SXGmzqVw7R628SqV4qeseC21rogMiLu5PJMO0fZHa0ziUl8xxUTlMDvO7/RzdIhoHA3dSOrr31qmYSqjKla0G9qzlc3Cso5QNzT3HNfSKlfmbFLhdo5C+ytF0C1fCYQy+jCpkavFyQGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZAUVg7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36526C4CEE3;
	Wed, 14 May 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253609;
	bh=Q/SQV3LG3gPWlnHORGGVnQf1CRJwcLYpy+SPT2Ybyug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZAUVg7PRJ/VJxda0r/LEnc418TD6WIJGQ9EIAluli90DzLtNokw0y77IgDe1x3tO
	 wCR2L+r5H3pknWf94X98PHHURJxaokC3BPua4A4iw2jFEaYSKRNW5Oa6MJMdl7GLqg
	 RGXacr6ggXHb5g01F0wgYZaP/yIlZhpv0F2YTMA+6hs1yhYvFoVxZLlzM4xvsetwb0
	 RX8EPLAUVF2tQEtjgtqX1Iy6Wfocls6II/44hvXSIW+ROcDfX88wt6qVEgyd4VJZV4
	 NwXa7buGn+gU6X1AGuedfMEDP7ERkH2mRAoygCRROJghjj2KJpQLjNPzEQIsXx1cNq
	 abDpljfSM/BtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Wed, 14 May 2025 16:13:27 -0400
Message-Id: <20250514094634-014fc6f11a71ace9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-12-v1-1-612ca33e17a6@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

