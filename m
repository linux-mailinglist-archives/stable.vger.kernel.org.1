Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5D775618
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHIJFM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHIJFL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 05:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022F1BD9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 02:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BCBE6307D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B62C433C7;
        Wed,  9 Aug 2023 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691571910;
        bh=XculevqQ+XjpCCjVURcHhqp8lBJLEpZlKQIELYKfs1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAGDp6k3jBzLs662EYduAB30GqJCqmE6N+eBkVcLyrbh7o5yr56p8Tb/8Ut9nyD21
         d+S4k1HA6X035L9RVpKYGa+MtlntwGK9yskuvFj1nINBLQsfY7TqnTwjHuHamtZzCG
         h/HRSq4Gb12PMWbVEXtZJniUP97phBuCCTkYGaJc=
Date:   Wed, 9 Aug 2023 11:05:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Peichen Huang <PeiChen.Huang@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amd/display: skip CLEAR_PAYLOAD_ID_TABLE if
 device mst_en is 0
Message-ID: <2023080959-unfair-reusable-2c4c@gregkh>
References: <20230807151656.27881-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807151656.27881-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 07, 2023 at 10:16:56AM -0500, Mario Limonciello wrote:
> From: Peichen Huang <PeiChen.Huang@amd.com>
> 
> [Why]
> Some dock and mst monitor don't like to receive CLEAR_PAYLOAD_ID_TABLE
> when mst_en is set to 0. It doesn't make sense to do so in source
> side, either.
> 
> [How]
> Don't send CLEAR_PAYLOAD_ID_TABLE if mst_en is 0
> 
> Reviewed-by: George Shen <George.Shen@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit a1c9a1e27022d13c70a14c4faeab6ce293ad043b)
> 6.1.y doesn't have the file rename from
> 54618888d1ea7 ("drm/amd/display: break down dc_link.c")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
