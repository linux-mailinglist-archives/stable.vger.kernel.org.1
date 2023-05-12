Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9F6FFDE0
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 02:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjELAXV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 20:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELAXU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 20:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357B1FE9
        for <stable@vger.kernel.org>; Thu, 11 May 2023 17:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B57652B6
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5547DC433D2;
        Fri, 12 May 2023 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683850998;
        bh=5L5SEdcmusEBTMOvKg2u4JT43OPbxYxrmeo7PfjWR3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qcz0AikLWh5pOx39/bTEMa5BElYGdAJJI3X3lNd9wwQYGEvsdYnislO7m0ZgxWzJ1
         I35FR1DU3ZJNfp4plSzsU3m3Ea4vpczgzJWhh7N/YtPkFScIcWr5iOzGQCibvLRK19
         HohRpNl7akURUNFWVC/lcD/fDd0P3U1jSfkvnPzTChpuvtoPO/yxGZ+5do866TUQeO
         xtlDXeLwlh0s7okBey5314sXpj5ji+FynAuGiAc8or0EM2L3dpfibq4jtS9K/E1x+j
         Sbg9MzmfmJ0KmWSnhuEB7j/rsR+8WB5rsIUIsLY5sdGB7693fSrSAEQS3nH4zuli8z
         doRbz4nuvK0DA==
Date:   Thu, 11 May 2023 20:23:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15] drm/hyperv: Don't overwrite dirt_needed value set
 by host
Message-ID: <ZF2G9drD1lqK7m8C@sashalap>
References: <1683541802-14002-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1683541802-14002-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 03:30:02AM -0700, Saurabh Sengar wrote:
>[ Upstream commit 19b5e6659eaf537ebeac90ae30c7df0296fe5ab9 ]
>
>Existing code is causing a race condition where dirt_needed value is
>already set by the host and gets overwritten with default value. Remove
>this default setting of dirt_needed, to avoid overwriting the value
>received in the channel callback set by vmbus_open. Removing this
>setting also means the default value for dirt_needed is changed to false
>as it's allocated by kzalloc which is similar to legacy hyperv_fb driver.
>
>Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>

Queued up, thanks!

-- 
Thanks,
Sasha
