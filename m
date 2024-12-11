Return-Path: <stable+bounces-100642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1279ED1D3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203951662A0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38391A707A;
	Wed, 11 Dec 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJmtPzhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DB38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934723; cv=none; b=gi92xddorVP+7cmLlDZPFJ9kuv0mmrtJA6ZsYNfS78O0BiRpTkVq8W4w4jYqfCFSaMOm4NybWwydm6oaOEaD0mmLAQetWlwIQcCKIG1krRTtgxeF2w5732nf6m3R1g/8KFt051MuAtf6CY0dKOldPK6Fcf15eLURBorMwouWv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934723; c=relaxed/simple;
	bh=q12Y4gpMy5qUBjeNuja0nwfkOPKorIzPzobw6CzMo/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLAjp7HOMpLStt7GDD3QP7uyPzNYFp6NaHehei4eyxAz2aP/QTsgMZtSOoonxT9K/vLm08H7QENO0ycKH7pTuZ+Rp+urvr2VLWN6pZOBbsqG/xjADspx1gTcTxjczeDQnElkOquwJY5A3mgA07HluNGGx55WwKgzMSE+99OoNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJmtPzhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6425C4CED4;
	Wed, 11 Dec 2024 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934723;
	bh=q12Y4gpMy5qUBjeNuja0nwfkOPKorIzPzobw6CzMo/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJmtPzhwuN/b3qrm+F4D/xhMURGjRp0kyUCjmPiWzNpfNL4D6gjCC7oSn7PV8H0y6
	 oWjYeN4NK1F+HmdbbyIh+CVCim0qzN83OvfF6G/HkdTeNN2AIBbpTaxa8FZb4IKRp4
	 sA8nmnW+w5DbBRAC3WS6YsyhslAPcltLjJqF7bkpYk0u4c3+9P5tObD/yuXkaR/cbd
	 PSyab86uroX1j8MtzmVOKwGpcJXi22OzuS5DkUmG0rVgVEHlX8JQVGACMY1xy2F9Yf
	 HzDTad5/AFMH0+CnDJ0GMTZLqdKroNl1gfbKOW84E2Z8EqD9FYHNo/SbtlkkCcvCZU
	 geNuAtPCKHCxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()
Date: Wed, 11 Dec 2024 11:31:59 -0500
Message-ID: <20241211102816-ad85e82e76f5c7e8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211111011.3560836-2-amadeuszx.slawinski@linux.intel.com>
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

The upstream commit SHA1 provided is correct: a0aae96be5ffc5b456ca07bfe1385b721c20e184

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Commit author: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a0aae96be5ffc ! 1:  d1a437a075512 ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()
    @@ Metadata
      ## Commit message ##
         ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()
     
    +    [ Upstream commit a0aae96be5ffc5b456ca07bfe1385b721c20e184 ]
    +
         Check for return code from avs_pcm_hw_constraints_init() in
         avs_dai_fe_startup() only checks if value is different from 0. Currently
         function can return positive value, change it to return 0 on success.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

