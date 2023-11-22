Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445167F3E43
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 07:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjKVGiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 01:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVGiz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 01:38:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A419D
        for <stable@vger.kernel.org>; Tue, 21 Nov 2023 22:38:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BB3C433C8;
        Wed, 22 Nov 2023 06:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700635129;
        bh=IP+6jvyOHvlXQjC4j7EMuo7mCAPZse6yLonZRMn9sQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXaLTwE/srqb59qpUvA2wQD2L1DMMBP1coi7T1a8lnKqk5KUPg1p60O71BRxGI6GL
         lBsq9Ljl2weowG7gkzo4ifNtHx6DHIQa6ARLz06WGCYkoGqrN+z3x0IVTgnkrpRWAR
         hkjirdEThaufyItYo5iGFyTKfWV5l35s5MoV9u88=
Date:   Wed, 22 Nov 2023 07:38:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxwell Nguyen <hphyperxdev@gmail.com>
Cc:     stable@vger.kernel.org, maxwell.nguyen@hp.com
Subject: Re: [PATCH] Input: xpad - Add HyperX Clutch Gladiate Support for
 v4.19 to v5.15
Message-ID: <2023112250-spider-anyhow-f771@gregkh>
References: <20231122041246.8801-1-hphyperxdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122041246.8801-1-hphyperxdev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Nov 21, 2023 at 08:12:47PM -0800, Maxwell Nguyen wrote:
> Add HyperX controller support to xpad_device and xpad_table 
> 
> Add to LTS versions 4.19, 5.4, 5.10, 5.15.
> 
> commit e28a0974d749e5105d77233c0a84d35c37da047e upstream
> 
> Separate patch to account for added functions in later LTS version that are not present.
> ---
>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)

No signed-off-by?  That's required.  Also, you lost the authorship info
of the original developers involved.

thanks,

greg k-h
