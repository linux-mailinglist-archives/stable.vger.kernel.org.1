Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A87651B9
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjG0K4g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjG0K4f (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8CB4
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 03:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CDCC61E23
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 10:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2DEC433C7;
        Thu, 27 Jul 2023 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690455393;
        bh=5ntCGHRRezOBJU62DyucRB2G6j+fqlh2SV7Q2P4YKq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eu0bj/ae54vWuMaM0fUTH4/4YsSzR6TCkZ7qMvjSz95l19VkGWYro1fDycBeL8dCY
         imlYk38QaEcmhlExC1LXmPyFixFIuSXuYt9mH0wvRY7LEoDIo0/csXPcvLnbSjHSp0
         UiEC5uCbqj/A7ZZWY3N4cYQvMmDWGg6i4MOm4kI8=
Date:   Thu, 27 Jul 2023 12:56:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: PMF EC notifications
Message-ID: <2023072723-snowsuit-gallows-92c8@gregkh>
References: <4801073d-3884-28df-4196-7a8daabba6d4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4801073d-3884-28df-4196-7a8daabba6d4@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 01:56:33PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> The following two patches fix the notification path to the EC (by way of
> SBIOS) for the PMF driver.
> 
> 33c9ab5b493a0 platform/x86/amd/pmf: Notify OS power slider update
> 839e90e75e695 platform/x86/amd/pmf: reduce verbosity of
> apmf_get_system_params
> 
> This change allows Phoenix based laptops to use software like
> power-profiles-daemon to configure the APU for power saving or for
> performance and on affected systems can significantly impact battery life.
> 
> As Phoenix systems are enabled from 6.1 onwards, can these both be brought
> to 6.1.y and 6.4.y?

Both now queued up, thanks.

greg k-h
