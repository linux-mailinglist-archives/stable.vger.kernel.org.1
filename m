Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4790F7E9ECA
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKMOdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 09:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOdE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 09:33:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC29DD59
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 06:33:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C5C433C9;
        Mon, 13 Nov 2023 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699885981;
        bh=xKfu53wQ8/LQR0nMpoegFALzSedEPyi+HMxBb8IOTeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wtwGKzvb9Mrg1vBVKcwaN+rsoO70M0O+zIv5MygBaloyGkO0yX3cRF6fJx8zo7Hid
         hHBlW5iMIEH9bAlBCoGufQFyzsnIQzIz1NmkzK7Y+B1llWJg8uLSMo5OOHZRonFfsL
         x92TgoGC+FVUBkdo3B1XjC8wDAR7rXJbws9qiksY=
Date:   Mon, 13 Nov 2023 09:32:57 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Owen T . Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: PM: Add acpi_device_fix_up_power_children()
 function
Message-ID: <2023111349-outward-rectify-cb4e@gregkh>
References: <20231112203627.34059-1-hdegoede@redhat.com>
 <20231112203627.34059-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112203627.34059-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Nov 12, 2023 at 09:36:26PM +0100, Hans de Goede wrote:
> In some cases it is necessary to fix-up the power-state of an ACPI
> device's children without touching the ACPI device itself add
> a new acpi_device_fix_up_power_children() function for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/device_pm.c | 13 +++++++++++++
>  include/acpi/acpi_bus.h  |  1 +
>  2 files changed, 14 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
