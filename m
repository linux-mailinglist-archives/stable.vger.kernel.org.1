Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E26FBD59
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjEICo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 22:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEICo5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 22:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2C40D5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 19:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A50E62571
        for <stable@vger.kernel.org>; Tue,  9 May 2023 02:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A1C4339B;
        Tue,  9 May 2023 02:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683600295;
        bh=+iTePYyZmEtCfoEwjGqLhjI+Z6GGctQ3xl4ew7H8+tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DloIWTc9bintHQbMC99FrcDZpx44vzFclTaChQJqEM1iiQtMBppNRiNEjIyZODWwQ
         aDjExDGFb50WY4eMWxWoa03h1WAU821w7GEJ0Rr2ZsrE+NHKhF2QGnVqEuMKPoJArz
         ElOsmKdEc5WV8WhQMagBvWzffLmy/B39q3Qw4JF8=
Date:   Tue, 9 May 2023 04:44:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Ping Cheng <pinglinux@gmail.com>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] HID: wacom: Set a default resolution for older tablets
Message-ID: <2023050922-zoologist-untaken-d73d@gregkh>
References: <20230409164229.29777-1-ping.cheng@wacom.com>
 <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
 <ZFmxMO6IyJx2/R1O@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmxMO6IyJx2/R1O@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 09:34:24AM +0700, Bagas Sanjaya wrote:
> On Mon, May 08, 2023 at 06:05:02PM -0700, Ping Cheng wrote:
> > Hi Stable maintainers,
> > 
> > This patch, ID 08a46b4190d3, fixes an issue for a few older devices.
> > It can be backported as is to all the current Long Term Supported
> > kernels.
> > 
> 
> Now that your fix has been upstreamed, can you provide a backport
> for each supported stable versions (v4.14 up to v6.3)?

Why? That's not needed if the commit can be cherry-picked cleanly
everywhere.

Please do not ask people to do unnecessary things.

greg k-h
