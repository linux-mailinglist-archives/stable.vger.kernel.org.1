Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D55775614
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHIJEC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 05:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHIJEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 05:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56691FCD
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 02:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D3D63087
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 09:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEF7C433CA;
        Wed,  9 Aug 2023 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691571840;
        bh=gtNQ+vKgGq1nozXLrxGO6NMwoEz2cC2gi6NzPHGNxSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKCIe7jvrq/wiLyGw2uvKIQc+qIisUxqIBXLzp2KN8hbGozDOVSr2nIFNYd9f6zY+
         30KAHXt/qnvd5eCWz+wsdvPRS3MXEt877IoC2ZTG19r+1EL0jmTbo29aRmL4PgrUfi
         IAU+1LElmkCzNUrtyGuEqjLhsNHKLaFN98GcAztk=
Date:   Wed, 9 Aug 2023 11:03:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Stable <stable@vger.kernel.org>, william.bonnaventure@gmail.com
Subject: Re: [6.1.y] Fix a regression where Kodi stopped working on 6.1.y
Message-ID: <2023080951-lion-knelt-a210@gregkh>
References: <50a5705d-dbcb-4db4-a210-c55dabe5d7a0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a5705d-dbcb-4db4-a210-c55dabe5d7a0@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 07, 2023 at 04:03:20PM -0500, Mario Limonciello wrote:
> Hi,
> 
> It was reported that when '8d855bc67630 ("drm/amd/display: Use
> dc_update_planes_and_stream")' was backported it caused a regression where
> Kodi could no longer display.
> 
> Reported-and-tested-by: william.bonnaventure@gmail.com
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2766
> Link: https://github.com/LibreELEC/LibreELEC.tv/issues/8013
> 
> This is fixed by backporting this additional commit to 6.1.y.
> 
> bb46a6a9bab1 ("drm/amd/display: Ensure that planes are in the same order")
> 
> Can you please queue this up?

Now queued up, thanks.

greg k-h
