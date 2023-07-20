Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAF775B685
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGTSUf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGTSUe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508AF272A
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E298E61BA6
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 18:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FBC433C8;
        Thu, 20 Jul 2023 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689877226;
        bh=LWFZziknRm/zRcDgxsvqEh8nsnNvcykvlzWkR3BatEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmcTkkFO1iM2n0p7JEn0SFrIwpCbOvI3rxldaWdbaFF0A9ZMi2iJlznOjsPrHK3Ee
         4hMq2CpG45gnLzPkaCpdOfu9fwsUhU9jjwhbCoMShRJnXZ14L265mMwA5DLTsZK8FK
         K3aAqrk0+nTcfMAEjuN58o8hsCR2aBpKXewWhXks=
Date:   Thu, 20 Jul 2023 20:20:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: 6.1 amdgpu backports
Message-ID: <2023072006-issue-gopher-d063@gregkh>
References: <e593a25b-175c-89f8-d178-095bcddddaea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e593a25b-175c-89f8-d178-095bcddddaea@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 08:20:11PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> As a follow up to
> https://lore.kernel.org/stable/2023071654-flattery-fidgety-0e31@gregkh/ I've
> sorted out the parts of this series that make sense for 6.1.y.
> Here are the ones that come back as clean patches you can directly queue up
> to 6.1.y
> 
> fd2198727446 ("drm/amd/pm: revise the ASPM settings for thunderbolt attached
> scenario")
> ef5fca9f7294 ("drm/amdgpu: add the fan abnormal detection feature")
> abd51738fe75 ("drm/amdgpu: Fix minmax warning")
> 2da0036ea99b ("drm/amd/pm: add abnormal fan detection for smu 13.0.0")
> 570b295248b0 ("drm/amdgpu: fix number of fence calculations")
> 
> Any others that need manual fix up will be sent separately.

The last one is already in 6.1.39, but I've queued all the others up
now, thanks.

greg k-h
