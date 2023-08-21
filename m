Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7CE782EAC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjHUQo0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjHUQoZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C564CC
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE4EC63EDD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF49C433C7;
        Mon, 21 Aug 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692636263;
        bh=LlrlqT5YFbaVq7QjCCWPiC/vKgnJUso9K3vZdLYpSrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybRr39jV8vAJlQlMVP1ogmL+zehfOZcFpu9ASwI247gPAz+lGOtvrJ9yiJ2HT6GB8
         vnplHA6UHU27663KPl6RS44kGk70wTAlT2TLFpm0FUZNYjHSy+UAhLbbnWnu8z3HpK
         +w2ltuxxj06WyHzx6mxPz7jZHBYkK03FbidtcRIQ=
Date:   Mon, 21 Aug 2023 18:44:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        stable@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] [6.4.y] ASoC: SOF: intel: hda: Clean up link DMA for
 IPC3 during stop
Message-ID: <2023082110-stumble-founding-148d@gregkh>
References: <20230821122209.20139-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821122209.20139-1-perex@perex.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 02:22:09PM +0200, Jaroslav Kysela wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> commit 90219f1bd273055f1dc1d7bdc0965755b992c045 upstream.
> 
> With IPC3, we reset hw_params during the stop trigger, so we should also
> clean up the link DMA during the stop trigger.
> 
> Cc: <stable@vger.kernel.org> # 6.4.x
> Fixes: 1bf83fa6654c ("ASoC: SOF: Intel: hda-dai: Do not perform DMA cleanup during stop")
> Closes: https://github.com/thesofproject/linux/issues/4455
> Closes: https://github.com/thesofproject/linux/issues/4482
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217673
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Link: https://lore.kernel.org/r/20230808110627.32375-1-peter.ujfalusi@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Note that many recent Intel based laptops are affected.
> 
> Added missing code for 6.4 kernels to keep the fix simple not depending
> on the other changes. This commit is present in 6.5 tree already.
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Now queued up, thanks.

greg k-h
