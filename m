Return-Path: <stable+bounces-158572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F57AE85B7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457A46A5450
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C54264605;
	Wed, 25 Jun 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge4TYeER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9847263F27
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860440; cv=none; b=PPZ7yYQJlRu3JUPMok2OgbiaheVMS8xv2+yYjNAoKN7cKCvfiaNw40HU+ALdWANmEyM3IMHB/fyjDvccXlAQDl2h5PmKLDH6pVrVwQhab+301ocDamJcLERdGSJ8PIekBPhQVyl5SeAu4EuAtLfVSFMHcfAVXCb5wj3y6PcgESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860440; c=relaxed/simple;
	bh=VLVOzKo7hix4q8UJCySuA7ObVHMJ0F2/QqWy3PWTJPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW7yvJOlsk1Suow+2bkBlul00IqUxTKESlSIE4Si9RrZfqpGSKhpicAt0t3a455xr6+24qGeZcfU+LpjYXgTLBYJ1ugwKGllSVYoqudCMeJ6VFxHfS02nFXFGeoN4lnYyb+t2rD7XRQ6vUtOnmNP6wFdnxj2HXYHpcSZJR4T85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge4TYeER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE7C4CEEA;
	Wed, 25 Jun 2025 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860440;
	bh=VLVOzKo7hix4q8UJCySuA7ObVHMJ0F2/QqWy3PWTJPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ge4TYeERKiEcyXt0036N50WRILmo39UuPZZFR7TSP1fzAEDat6YrsY7Xy3qoONZgJ
	 CqcDpqLqbozQjD4YBsDVroJmAykp4pEY32d+AGOVO0aw7M0gEWAVNhxTktrchVyJ8T
	 ePp1ivBKF8BotJ9RqPBOFSfkSaQYgIZiAIhcqCNNjZASHAM8LcV9Nz2k9Bc1zIbnAr
	 Aw3d4qls4G1Q/vYQvkQZ9n00QgnDx7+SAjZeyRdoDQP5LKlp0CpV6jSZu+vLKm4kOq
	 YSPiPA3U37mwbJSlAV6NXXicgOxtYHVuoqlyZDKpwN5TMTVmVeB12k/WucQuH8hMGX
	 Fxs24CMeU2wyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/4] rust: completion: implement initial abstraction
Date: Wed, 25 Jun 2025 10:07:19 -0400
Message-Id: <20250624234529-286220a945e55396@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624135856.60250-2-dakr@kernel.org>
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

The upstream commit SHA1 provided is correct: 1b56e765bf8990f1f60e124926c11fc4ac63d752

Note: The patch differs from the upstream commit:
---
1:  1b56e765bf899 ! 1:  9d44ce9765ef8 rust: completion: implement initial abstraction
    @@ Metadata
      ## Commit message ##
         rust: completion: implement initial abstraction
     
    +    [ Upstream commit 1b56e765bf8990f1f60e124926c11fc4ac63d752 ]
    +
         Implement a minimal abstraction for the completion synchronization
         primitive.
     
    @@ Commit message
     
      ## rust/bindings/bindings_helper.h ##
     @@
    + #include <linux/blk-mq.h>
      #include <linux/blk_types.h>
      #include <linux/blkdev.h>
    - #include <linux/clk.h>
     +#include <linux/completion.h>
    - #include <linux/configfs.h>
    - #include <linux/cpu.h>
    - #include <linux/cpufreq.h>
    + #include <linux/cpumask.h>
    + #include <linux/cred.h>
    + #include <linux/device/faux.h>
     
      ## rust/helpers/completion.c (new) ##
     @@
    @@ rust/helpers/completion.c (new)
     
      ## rust/helpers/helpers.c ##
     @@
    + #include "bug.c"
      #include "build_assert.c"
      #include "build_bug.c"
    - #include "clk.c"
     +#include "completion.c"
    - #include "cpufreq.c"
      #include "cpumask.c"
      #include "cred.c"
    + #include "device.c"
     
      ## rust/kernel/sync.rs ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

