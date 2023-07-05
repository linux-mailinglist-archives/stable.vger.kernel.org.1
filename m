Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E377488D8
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjGEQFK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjGEQFK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F110A
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 09:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8E461615
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 16:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A7FC433C8;
        Wed,  5 Jul 2023 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688573108;
        bh=MaQ9axNX26c9wxnJ0P+IdEAV6VOXIK3LAWryZ90v/Qg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l3w5MPUrUOOTkdmknB6dx2CtyE52F8JS3tBM0epQzl+7XfY9lWhN2iMZRW8obwzfE
         2OSTQTiVyWTgkJZ1X/k94tnKvPJuszNC1sD492Gept8Na3v0tjQoPiMHzmOt1y83fG
         s68wJHzlZ9RN0CRG7CPdagmeRZHbi9Xrsx88wzrORB/C5bBUGC5fH8RL0WgpnFDWaa
         4gC9pnSi/uYA+dZNAcTrj8jrhduibrdK0zNisA5ZQRLTTIuU6H2awoyad6vEsA8/hZ
         2fkuXp0LC1Xw55zACnJGJTwUfmUBfAWf8sFQDnYNULgtoqroey94oDHoPstIDJ4AMQ
         XRIUuMjx8DMpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     lgirdwood@gmail.com, vkarpovi@opensource.cirrus.com,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        alsa-devel@alsa-project.org, patches@lists.linux.dev,
        stable@vger.kernel.org, Marcus Seyfarth <m.seyfarth@gmail.com>
In-Reply-To: <20230703-cs35l45-select-regmap_irq-v1-1-37d7e838b614@kernel.org>
References: <20230703-cs35l45-select-regmap_irq-v1-1-37d7e838b614@kernel.org>
Subject: Re: [PATCH] ASoC: cs35l45: Select REGMAP_IRQ
Message-Id: <168857310652.55162.4180283376212806885.b4-ty@kernel.org>
Date:   Wed, 05 Jul 2023 17:05:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 03 Jul 2023 14:43:15 -0700, Nathan Chancellor wrote:
> After commit 6085f9e6dc19 ("ASoC: cs35l45: IRQ support"), without any
> other configuration that selects CONFIG_REGMAP_IRQ, modpost errors out
> with:
> 
>   ERROR: modpost: "regmap_irq_get_virq" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!
>   ERROR: modpost: "devm_regmap_add_irq_chip" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l45: Select REGMAP_IRQ
      commit: d9ba2975e98a4bec0a9f8d4be4c1de8883fccb71

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

