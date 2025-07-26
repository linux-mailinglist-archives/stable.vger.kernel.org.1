Return-Path: <stable+bounces-164803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB41B127F8
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB721CC3437
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF5381BA;
	Sat, 26 Jul 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPVhD2rx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412A28FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489497; cv=none; b=JV4WBKYqoYg6ql19Ra5I/G3+R58B5qtdvnlTDjZXzik4NMZ9TpJjbspqNHZjOAFpuTffDIM+bRo9Ddv9U3MSbzkzPju/XHQOLkOm6lQuaI+p1fIFldq4cYY2eS4EUZTzUW5ga0DW/7JJ0BK74ZXNGrtxPiNeWSLTYDy3oXadsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489497; c=relaxed/simple;
	bh=5otkHPajISMUWDwOJ+nKM7sPkMB0lfgpcxIDizD9C7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIdzllwLSEq1N/LQmBZCfX1tFoxFn/RdPyi/g9rFXhrQn/70wOGcaXXXrKhdi7QFh+KB+St0acS6u7bmbAK2XacJFZOIw+8KGWsHOR1wr64A38abhnNCA8Rsrjoz901563kApt/AEfoFKY0IUauWgB4/9pf131VaG0rHfS3zW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPVhD2rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FAFC4CEE7;
	Sat, 26 Jul 2025 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489497;
	bh=5otkHPajISMUWDwOJ+nKM7sPkMB0lfgpcxIDizD9C7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPVhD2rx1YsGqMIzO2lz1bPBKE+WZxMTKrfXXr8lzeFWEAMFIMFfCnatjFtSvk11k
	 yn5maHqlS+NdJorMccg9GN6Modzrgex19YUWa2ZbXHUQKIbaqVKvxqf6dNo9o/hJNd
	 l5i3cxM+QWKRXLGa9E6Ht0yXw4AQQFZng7rwX41HV2vMGa1d+UA4sFz6wKPQVGddww
	 0QhoyT63LM+ZeGNfDhmZlnLFlkIVJyNCeFIM9TyzwHBs54QAZ26inURe/to3hds/2N
	 m2PWtGi8w1eDh8HAVkM6PE1DYyme4lKpuxkJLXbR2cZKLTMnK2iZO1a4o4d7UgaoX+
	 /sbwYKNJPMo5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: das6402: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 20:24:54 -0400
Message-Id: <1753465851-c4e4e981@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-6-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 70f2b28b5243df557f51c054c20058ae207baaac

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  70f2b28b5243 ! 1:  e24d1f87963a comedi: das6402: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: das6402: Fix bit shift out of bounds
     
    +    [ Upstream commit 70f2b28b5243df557f51c054c20058ae207baaac ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 /* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707135737.77448-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/das6402.c ##
    -@@ drivers/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/das6402.c ##
    +@@ drivers/staging/comedi/drivers/das6402.c: static int das6402_attach(struct comedi_device *dev,
      	das6402_reset(dev);
      
      	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

