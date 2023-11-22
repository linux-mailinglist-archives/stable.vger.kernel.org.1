Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3A7F4577
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 13:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjKVMLs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 07:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjKVMLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 07:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C676FD40
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 04:11:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E38FC433C7;
        Wed, 22 Nov 2023 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700655103;
        bh=sMXBeQjJa1nV4FIPkndlU8+ax8tszfpfgx7UkTZwhDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGM/+aX9Y7vyAhG9pGPSbIgrWaIcBx8fWQVOddFz+HzCSCz4gPdYzObYgNP0VPJLr
         VYHXZEy4LF+cGt/0LCGZJ9EQ9E9XqshwmFmkQLZS+TRGr6IDJOTNjuO3P1NIzx8ZTN
         3frYBETZp6NbpBPBdrfjiT06yntHvge44/Gl9SyY=
Date:   Wed, 22 Nov 2023 12:11:39 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: misc: ljca: Fix enumeration error on Dell
 Latitude 9420
Message-ID: <2023112217-audacious-eccentric-3522@gregkh>
References: <20231121203205.223047-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121203205.223047-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Nov 21, 2023 at 09:32:05PM +0100, Hans de Goede wrote:
> Not all LJCA chips implement SPI and on chips without SPI reading
> the SPI descriptors will timeout.
> 
> On laptop models like the Dell Latitude 9420, this is expected behavior
> and not an error.
> 
> Modify the driver to continue without instantiating a SPI auxbus child,
> instead of failing to probe() the whole LJCA chip.
> 
> Fixes: acd6199f195d ("usb: Add support for Intel LJCA device")
> Cc: stable@vger.kernel.org

Nit, stable is not needed as the above commit only ended up in 6.7-rc1,
nothing older.  I'll drop it when I queue this up, thanks!

greg k-h
