Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3057B1982
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 13:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjI1LEh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 07:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjI1LEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 07:04:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38ACC8
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 04:04:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9F5C433C9;
        Thu, 28 Sep 2023 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899047;
        bh=iPprXvw4jW4WHx6EPjCoVbRiJsPZxysqaAJU2caWkVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeyrUaVApY+pTk92yI4D/nGaP+2VO1VcVHV/7tgdqFzv0XDIy6/nEFjrimxOpmLkI
         AYT7Visu5xorA5ILNOvpaJMO5Y9W4d6IEdK2h3GIRycUX0HTcirHEtrUAN++YMZTeL
         1KZDYfJzKhUlRDHLwik67wAC7fppOjWAaLJXyo/No3glPRKwMuqHE5yjDusGUwpSv4
         4Q5bbYeNsn85XmMBa+bN7CCNhuGlQKjVMWJWrvqN2Tr3/jN2Dwt7VkzhJZ1YJYK0fO
         PG/yN8mVbV9IAdGXgOTNrliqTRE2DpAcWpj9ukJV+eEPXHLGAwiSMQPGK1I2reJPbD
         DatLGwPnbQdnQ==
Date:   Thu, 28 Sep 2023 07:04:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: Re: 6.5 pre-emption hangs
Message-ID: <ZRVdphZSlXSiEGyr@sashalap>
References: <ff4f3163-8d3f-4dae-9bd8-1b1d22bbd61a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff4f3163-8d3f-4dae-9bd8-1b1d22bbd61a@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 27, 2023 at 02:00:15PM -0500, Mario Limonciello wrote:
>Hi,
>
>Some hangs are reported on GFX9 hardware related to pre-emption.  The 
>hangs that are root caused to this are fixed by this commit from 6.6:
>
>8cbbd11547f6 ("drm/amdgpu: set completion status as preempted for the 
>resubmission")
>
>Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2447#note_2100975
>
>Can you please bring this back to 6.5.y?

Queued up, thanks!

-- 
Thanks,
Sasha
