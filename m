Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262E754E17
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGPJ1b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGPJ1a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF8EB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9640860C78
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A612AC433C9;
        Sun, 16 Jul 2023 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689499648;
        bh=nUeBAYTd1mDj7eHNllPdqjzD/hyaIDv6ydj+TOAAYQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVbR1KEp5vJZTCOsxYt7BiAvrxW8Ayajmrrverv8a5A5PVw0JWNuhmL7NVg2ux3m1
         6HhY3K71V69v7pyNszdQZPmUBd71+3YU7F7dTUaphwQngMS5iSCw+Gcj1ZEBK2lg6H
         TFhpECH8dAqTwr1Qvcpw9JkFIFOixbw16l0yEXnY=
Date:   Sun, 16 Jul 2023 11:26:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: Mark dGPUs as devices
Message-ID: <2023071635-profusely-latch-8f20@gregkh>
References: <050d87f7-5a77-571d-f5c9-f66f39ba2f2e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050d87f7-5a77-571d-f5c9-f66f39ba2f2e@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 04:51:24PM -0500, Limonciello, Mario wrote:
> Hi,
> 
> A problem exists where dGPUs with type-C ports are considered power supplies
> that power the system.
> This leads to poor performance of the dGPU because graphics drivers like
> amdgpu use power_supply_is_system_supplied() to decide how to configure the
> dGPU.
> This has been fixed in 6.5-rc1 by marking dGPUs as "DEVICE".
> 
> The logic to fix what to do when DEVICE is encountered was fixed in 6.4-rc4
> and already backported to stable:
> 95339f40a8b6 ("power: supply: Fix logic checking if system is running from
> battery")
> 
> So to wrap up the fix in stable kernels can you please backport:
> 
> 6.4.y:
> a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
> 
> 6.1.y:
> f510b0a3565b ("i2c: nvidia-gpu: Add ACPI property to align with
> device-tree")
> 430b38764fbb ("i2c: nvidia-gpu: Remove ccgx,firmware-build property")
> a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")

All now qeueud up, thanks.

greg k-h
