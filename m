Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5F779DF5
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHLHpQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLHpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 03:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50F19A4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 00:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B446161232
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 07:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DB7C433C8;
        Sat, 12 Aug 2023 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691826319;
        bh=pF7OuD/w4XlJB13enixdWDIS9P9hP/H+9IRqaLQ/2xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hj5kOmAM3Oy0aykuvOH/H9RkWo0ceqntRCxenAzv6XwNLfhQtg86tkhoHHcI3eh9v
         z5FrKMEHlLnPhASqwdEr9HH1NwBQajm1wlAXZZ2tXqPYHT9BCMgA+g1LY0TIHFHQzI
         2HfpvaUpvc0gyXbbFtBsqLXq/L7T1tCyepVXLPuE=
Date:   Sat, 12 Aug 2023 09:45:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.4.y 0/2] Solve abrupt shutdowns from momentarily
 fluctuations
Message-ID: <2023081210-unseeing-expansive-adef@gregkh>
References: <20230811163951.24631-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811163951.24631-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 11:39:49AM -0500, Mario Limonciello wrote:
> Users have been reporting that momentary fluctuations can trigger a
> shutdown.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2779
> 
> This behavior has been fixed in kernel 6.5, and this series brings the
> solution to the stable kernel.
> 
> Evan Quan (2):
>   drm/amd/pm: expose swctf threshold setting for legacy powerplay
>   drm/amd/pm: avoid unintentional shutdown due to temperature momentary
>     fluctuation
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48 +++++++++++++++++++
>  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  4 +-
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  2 +
>  .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 10 ++++
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  4 ++
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  4 ++
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
>  .../drm/amd/pm/powerplay/inc/power_state.h    |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
>  15 files changed, 128 insertions(+), 33 deletions(-)
> 
> -- 
> 2.34.1
> 

All now queued up, thanks.

greg k-h
