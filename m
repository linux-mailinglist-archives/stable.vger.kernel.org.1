Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B97F3196
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjKUOuc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 09:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjKUOub (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 09:50:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3990
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 06:50:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8523CC433C8;
        Tue, 21 Nov 2023 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700578228;
        bh=Mom/uC6Xa4g03z0XsCPWTrFvQs4pu4XVYH3eMVVBFXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExxxlYa4duwMtmfWUxhC74eaNFQJyb7g22u6RspUvKR1ddyylNPwyyZRolCAuiyp2
         C7jvQH2KCmnE2O4EmSm4Lt1qD/UKCFGhH0G6VyexoGJ8aPjrGjv6B7C/OBCnKzOXWK
         PdGhTURi+pP5Jaqcl1yfyC/z5rOeLLvBxhRr76Eg=
Date:   Tue, 21 Nov 2023 15:05:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: misc: ljca: Fix enumeration error on Dell
 Latitude 9420
Message-ID: <2023112109-talon-atrocious-ad46@gregkh>
References: <20231104175104.38786-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104175104.38786-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Nov 04, 2023 at 06:51:04PM +0100, Hans de Goede wrote:
> Not all LJCA chips implement SPI and on chips without SPI reading
> the SPI descriptors will timeout.
> 
> On laptop models like the Dell Latitude 9420, this is expected behavior
> and not an error.
> 
> Modify the driver to continue without instantiating a SPI auxbus child,
> instead of failing to probe() the whole LJCA chip.
> 
> Fixes: 54f225fa5b58 ("usb: Add support for Intel LJCA device")

That commit id isn't in Linus's tree, are you sure it's correct?

thanks,

greg k-h
