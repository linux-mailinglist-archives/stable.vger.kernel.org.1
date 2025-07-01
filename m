Return-Path: <stable+bounces-159098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82EAEEBF1
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843033E08FE
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805115530C;
	Tue,  1 Jul 2025 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psKdRRPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC656B660
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332531; cv=none; b=ZPrT/sbBxhmI760Ty4sZBYQLpW47E+H0IrumkqkCZAlD6FTtJ2IhJ6Rv//G76dZOIgo1PSoAw9AYprrD6zgsHMuy+ovrBV7bEId5DqeENGQ2kE1Mk39lsHYgdNcQUgMvDlkhVIG2RMDaUu/mCnQaXUfpovL/8MU9/w4c9onPKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332531; c=relaxed/simple;
	bh=WTlN70Oqlf3y5AkzQ3bVAwKdKxFZCVxJSGXTdl3lzIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpsqQ7IMUDjcOreNKrpmco+vKEFzJm6wmAGL3LcU7rRCH2fwFsq4hmhd2T9EEPmOecV+VSBzMNTAwY8DKMq2RmHsw5L5KGZ7uVsPAWfDnTDKAu4Q484hvQvYRw/pyKF3rEN3T0hsLG3nrLjAQ3JukB5sonnOjF+Bk7b8VPQ9mGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psKdRRPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13131C4CEE3;
	Tue,  1 Jul 2025 01:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332531;
	bh=WTlN70Oqlf3y5AkzQ3bVAwKdKxFZCVxJSGXTdl3lzIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psKdRRPm+0cVJmjR9c1JYoW9S1QaAYmRCGU/ZJE2pUGs6XXbYcRdTwj9DHn3FwoIh
	 DEmMW0bhr3YRh1UaOxHEIosIYOQNlTIE+g8VFCQVmNfbogWdr7OMru0AhDXl2df1KM
	 Hw40shgrCD2yjjETk23q/MYEW7HN6SPp1+142ykfNpPN6kFOFc+rhLmgcvZHA45Xph
	 qiefqjbv6mV7aNAW+LH0u8OBiQ3JXh/y7Qqv7rWgT+iBuMXyhktE7JCO9WdFjdU9Z9
	 43MNfZav89zpZbHtHcLdB3VHM7QBu7Iokcx1Za7K/iYcQIZou8m1JkvoMZ73K78Gi6
	 gotjp/rmL2JLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	khairul.anuar.romli@altera.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Date: Mon, 30 Jun 2025 21:15:29 -0400
Message-Id: <20250630151954-052b0ebe36ccd824@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630102555.16552-1-khairul.anuar.romli@altera.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: b07f349d1864abe29436f45e3047da2bdd476462

WARNING: Author mismatch between patch and found commit:
Backport author: khairul.anuar.romli@altera.com
Commit author: Khairul Anuar Romli<khairul.anuar.romli@altera.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b07f349d1864a ! 1:  42de7106f3616 spi: spi-cadence-quadspi: Fix pm runtime unbalance
    @@ Commit message
         Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
         Link: https://patch.msgid.link/4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com
         Signed-off-by: Mark Brown <broonie@kernel.org>
    +    (cherry picked from commit b07f349d1864abe29436f45e3047da2bdd476462)
     
      ## drivers/spi/spi-cadence-quadspi.c ##
     @@ drivers/spi/spi-cadence-quadspi.c: static int cqspi_probe(struct platform_device *pdev)
      			goto probe_setup_failed;
      	}
      
    --	ret = devm_pm_runtime_enable(dev);
    --	if (ret) {
    --		if (cqspi->rx_chan)
    --			dma_release_channel(cqspi->rx_chan);
     +	pm_runtime_enable(dev);
     +
     +	if (cqspi->rx_chan) {
     +		dma_release_channel(cqspi->rx_chan);
    - 		goto probe_setup_failed;
    - 	}
    - 
    ++		goto probe_setup_failed;
    ++	}
    ++
    + 	ret = spi_register_controller(host);
    + 	if (ret) {
    + 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
     @@ drivers/spi/spi-cadence-quadspi.c: static int cqspi_probe(struct platform_device *pdev)
      	return 0;
      probe_setup_failed:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

