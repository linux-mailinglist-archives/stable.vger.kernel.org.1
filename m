Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3A789C69
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjH0I7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjH0I7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9EAD
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B85F76147B
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25E6C433C8;
        Sun, 27 Aug 2023 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693126746;
        bh=/asIKlZ3mHBQIBpcD7zuVlVrJ8ha+u7aYfjQ0vsacRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjSk4csJI0SPbzZ9c5tqz20UsoQcwIDFdt2mKb0IaJ1fy1qqsQ6ZDYjAslL12Pa1V
         0f4zFgxRtzB+gO0ZzCKp4xve69hsSirL5lSfxWS062MFD5/OWABL5x11HXfJFNtA/Y
         Y5pN5i/7vfC57wnHPqjVhGyJX14Kqk+9ZUiEfPI8=
Date:   Sun, 27 Aug 2023 10:59:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.4.y] thunderbolt: Fix Thunderbolt 3 display flickering
 issue on 2nd hot plug onwards
Message-ID: <2023082749-stew-undamaged-9480@gregkh>
References: <20230823191825.26861-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823191825.26861-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 23, 2023 at 02:18:25PM -0500, Mario Limonciello wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Previously, on unplug events, the TMU mode was disabled first
> followed by the Time Synchronization Handshake, irrespective of
> whether the tb_switch_tmu_rate_write() API was successful or not.
> 
> However, this caused a problem with Thunderbolt 3 (TBT3)
> devices, as the TSPacketInterval bits were always enabled by default,
> leading the host router to assume that the device router's TMU was
> already enabled and preventing it from initiating the Time
> Synchronization Handshake. As a result, TBT3 monitors experienced
> display flickering from the second hot plug onwards.
> 
> To address this issue, we have modified the code to only disable the
> Time Synchronization Handshake during TMU disable if the
> tb_switch_tmu_rate_write() function is successful. This ensures that
> the TBT3 devices function correctly and eliminates the display
> flickering issue.
> 
> Co-developed-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> (cherry picked from commit 583893a66d731f5da010a3fa38a0460e05f0149b)
> 
> USB4v2 introduced support for uni-directional TMU mode as part of
> d49b4f043d63 ("thunderbolt: Add support for enhanced uni-directional TMU mode")
> This is not a stable candidate commit, so adjust the code for backport.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Both now applied, thanks.

greg k-h
