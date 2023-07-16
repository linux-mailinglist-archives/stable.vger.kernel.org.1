Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA97550E3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjGPTQ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPTQz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B78E48
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801E860DEA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8FCC433C8;
        Sun, 16 Jul 2023 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535013;
        bh=noq3ubvvmNLbw1q6HPLmHrANltR1jfKOJy/JqmJpQmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdFkIcxOc43k6iaoOcygRzZZ/iO0HRMcFh2jdQt2WG1ugwo5c/AC7E5/hNSdxBHiV
         QRPs7QZH6zI/ajuruHS63i4vfCbtSD19pBQMCae6aYc3XEY3RqfI4TSh5PZ16sS8wR
         n/1bqDEAlAC5C+b+tw1LgKfyQrsY6zEw0FLeGMoQ=
Date:   Sun, 16 Jul 2023 21:16:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     stable@vger.kernel.org, mario.limonciello@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Message-ID: <2023071649-gradation-reckless-5db5@gregkh>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 07, 2023 at 11:07:26AM -0400, Alex Deucher wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> We need to grab the lock of the BO or otherwise can run into a crash
> when we try to inspect the current location.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Guchun Chen <guchun.chen@amd.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
> Cc: stable@vger.kernel.org # 6.3.x
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
>  1 file changed, 39 insertions(+), 30 deletions(-)

I've applied the first 7 patches here to 6.4.y, which I am guessing is
where you want them applied to, yet you didn't really say?

The last 2 did not apply :(

And some of these should go into 6.1.y also?  Please send a patch series
and give me a hint as to where they should be applied to next time so I
don't have to guess...

thanks,

greg k-h
