Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5F74F9A6
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGKVVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 17:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKVVV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 17:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0091709
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 14:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B49615AD
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 21:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CE0C433CA;
        Tue, 11 Jul 2023 21:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689110479;
        bh=pb2syncfua/cIuxL9FTXoABIuiYWz1vV+RpCpqcOOgM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B4FYs6dsSs4yyI5USmLDNke/bT3rMz4d2mrxpoaBtLSWvKmTzFRsTt4c0USDMa1HW
         AI+6eRUtz4HPUMeeU6aKR4WwpvTbXFR8aY6RJ0mzcwIMPsRljSG9oUtkvfxu7RgDDl
         x7dN00JQ8ZweRd/8wTfK/W4QAyjfLl7faiC/vcGwRvfWukBJCH0snI8r02BszumQsE
         CIfN5cmHzuM9CV5r+KmlduJ+bqGtbBTtg6j5oZZCyjFwUWY9viIih2ZerY2cIuUzul
         wCOn3IQQTjM0craVQ6ui18wWKMvJVYCeVCawetfIPGFM9s7RD2gWnlkQIRBH6wrFnn
         NdFZd0+Pau3wA==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        andreas@fatal.se, hans.soderlund@realbit.se,
        Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
In-Reply-To: <20230706221827.1938990-1-festevam@gmail.com>
References: <20230706221827.1938990-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable
 MCTL_MCLK_EN bit for master mode"
Message-Id: <168911047807.530041.5127278576693925983.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:21:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 06 Jul 2023 19:18:27 -0300, Fabio Estevam wrote:
> This reverts commit ff87d619ac180444db297f043962a5c325ded47b.
> 
> Andreas reports that on an i.MX8MP-based system where MCLK needs to be
> used as an input, the MCLK pin is actually an output, despite not having
> the 'fsl,sai-mclk-direction-output' property present in the devicetree.
> 
> This is caused by commit ff87d619ac18 ("ASoC: fsl_sai: Enable
> MCTL_MCLK_EN bit for master mode") that sets FSL_SAI_MCTL_MCLK_EN
> unconditionally for imx8mm/8mn/8mp/93, causing the MCLK to always
> be configured as output.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"
      commit: 86867aca7330e4fbcfa2a117e20b48bbb6c758a9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

