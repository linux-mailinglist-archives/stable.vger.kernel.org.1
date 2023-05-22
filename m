Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6C70C569
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjEVSlb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVSlb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38BB6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC6262634
        for <stable@vger.kernel.org>; Mon, 22 May 2023 18:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA8C433D2;
        Mon, 22 May 2023 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684780885;
        bh=rixVH5KAuSdeUzadnrJqSlos3s1kbe0KHZ/+0KxyCMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlaI5E/ibedHTkKmTYgbz2arTai7m97SJ2F8h5dh4e95FoBR/0cNBZNPGNragKr52
         75MWx9aGPKu7vG/HylWh5C4GDN2fXhffnypGK4K9JfVIvABO1HKZGDdTqbeDAI1eNm
         XwHnsOrryJlVShpXcLUziUDivu8YyEVHNowFz6Eg=
Date:   Mon, 22 May 2023 19:41:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stylon Wang <stylon.wang@amd.com>
Cc:     stable@vger.kernel.org, jude.shih@amd.com,
        Yann Dirson <ydirson@free.fr>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] amdgpu: fix some kernel-doc markup
Message-ID: <2023052255-rewrite-stingray-cd04@gregkh>
References: <20230522120413.2931343-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522120413.2931343-1-stylon.wang@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 22, 2023 at 08:04:13PM +0800, Stylon Wang wrote:
> From: Yann Dirson <ydirson@free.fr>
> 
> commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5 upstream.
> 
> Those are not today pulled by the sphinx doc, but better be ready.
> 
> Two lines of the cherry-picked patch is removed because they are being
> refactored away from this file:
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> 
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302281017.9qcgLAZi-lkp@intel.com/
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5)

why is kernel doc issues stable material?  What real fix needs this?

thanks,

greg k-h
