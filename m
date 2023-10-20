Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999617D13BD
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJTQLc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQLb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:11:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180BD7
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:11:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA1DC433C8;
        Fri, 20 Oct 2023 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697818289;
        bh=sXZxw5HL1Cz6/g7Hw4BMRSyOOKNwKtlxZWHcH2n62Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKVhqXIO5UNhwUvMwlZc3NwlcjPEJ7Oo8GRb+tE2sJY63/kC8SStTRTkYbF7w4TmC
         iNjP8qoIq+jENgXynhpxG7ZOLm8SX2awEDjVdi6v7qztXWL1DZENQ5ChXK6JowWrbd
         V0murwhV+KLIUUAOmZOZR9QHTZ8IPDKiPaUDdEfw=
Date:   Fri, 20 Oct 2023 18:11:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: Re: Backport Submissions for Up streamed IGC Ethernet Driver Patches
Message-ID: <2023102019-blooming-directory-73d0@gregkh>
References: <IA1PR11MB62177F23133378DB62FA49B5D7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB62177F23133378DB62FA49B5D7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 03:04:49AM +0000, Abdul Rahim, Faizal wrote:
> Dear Stable Maintainers,
> 
> I am submitting several individual patches for consideration to be applied to the Linux stable kernel v6.1. 
> Below, you will find the necessary information for each patch:
> 
> Patch 1:
> 
> Subject: igc: remove I226 Qbv BaseTime restriction
> Commit ID: b8897dc54e3b
> Reason for Application: Remove the Qbv BaseTime restriction for I226 so that the BaseTime can be scheduled to the future time
> Target Kernel Version: v6.1
> 
> Patch 2:
> 
> Subject: igc: enable Qbv configuration for 2nd GCL
> Commit ID: 5ac1231ac14d
> Reason for Application: Make reset task only executes for i225 and Qbv disabling to allow i226 configure for 2nd GCL without resetting the adapter.
> Target Kernel Version: v6.1
> 
> Patch 3:
> 
> Subject: igc: Remove reset adapter task for i226 during disable tsn config
> Commit ID: 1d1b4c63ba73
> Reason for Application: Removes the power cycle restriction so that when user configure/remove any TSN mode, it would not go into power cycle reset adapter.
> Target Kernel Version: v6.1
> 
> Patch 4:
> 
> Subject: igc: Add qbv_config_change_errors counter
> Commit ID: ae4fe4698300
> Reason for Application: Add ConfigChangeError(qbv_config_change_errors) when user try to set the AdminBaseTime to past value while the current GCL is still running.
> Target Kernel Version: v6.1
> 
> Patch 5:
> 
> Subject: igc: Add condition for qbv_config_change_errors counter
> Commit ID: ed89b74d2dc9
> Reason for Application: Fix patch ae4fe4698300 ("igc: Add qbv_config_change_errors counter")
> Target Kernel Version: v6.1
> 
> Patch 6:
> 
> Subject: igc: Fix race condition in PTP Tx code
> Commit ID: 9c50e2b150c8
> Reason for Application: Fix race condition introduced by patch 2c344ae24501 ("igc: Add support for TX timestamping")
> Target Kernel Version: v6.1
> 
> 
> Thank you for your time and consideration. 
> Please let me know if you require any additional information or have any questions regarding these patch submissions.

All now queued up, thanks.

greg k-h
