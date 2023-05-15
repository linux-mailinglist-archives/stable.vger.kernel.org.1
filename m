Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874D703225
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbjEOQGI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbjEOQGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364291FEF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC63C6116C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92136C433EF;
        Mon, 15 May 2023 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684166741;
        bh=2V00zxlcGsGYNmBR6LzR8FMBw52qYS36a+v18pCfYOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUBvd9i2lkf/K3+VGIf7/kufdCi4PiiYlQomcAopG/bRELPu7HTBsMpMjGgiaN4SJ
         JqGwgrZkLFfRh6KjrvqdmApsttN7LYIs3i7zN0h+1F51O9df/uUnBQfMQCfCa+6N2e
         yxSels4mEU/siWRxpVAJWh+x2gqlQzTh4uohJhuw=
Date:   Mon, 15 May 2023 18:05:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     stable@vger.kernel.org,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix hang when skipping modeset
Message-ID: <2023051518-frigidly-edgy-eb4b@gregkh>
References: <20230515150426.2197413-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515150426.2197413-1-alexander.deucher@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 11:04:26AM -0400, Alex Deucher wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> [Why&How]
> 
> When skipping full modeset since the only state change was a front porch
> change, the DC commit sequence requires extra checks to handle non
> existant plane states being asked to be removed from context.
> 
> Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit da5e14909776edea4462672fb4a3007802d262e7)
> Cc: stable@vger.kernel.org
> ---
> 
> Fixes a hang with freesync video enabled.

I just guessed at what trees you wanted this applied to, next time it
might be good to give us a hint :)

thanks,

greg k-h
