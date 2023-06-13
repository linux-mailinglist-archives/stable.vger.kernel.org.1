Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F257F72E85F
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjFMQYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbjFMQYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 12:24:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D2137;
        Tue, 13 Jun 2023 09:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9C862985;
        Tue, 13 Jun 2023 16:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF4CC433F0;
        Tue, 13 Jun 2023 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686673469;
        bh=e0lGt4W4LRbgMJIkd2g8XPriuNT71YGvpwWLGzTcwB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTnr7CPRWfFhJ1WvvtGXqCDUKWVAxTfE22yZ6caZPpFCBynxFYMGX++KD5NVB7rFJ
         7tmp49cA/gINTGyNA9tg3qZuCs8Dn/3AmGz+RNc4a5wSD2CnyjmYDjXx5Rvn+TzcFy
         S4E78MZ3DV6SHHS8HbCYzAxO+oZVSHLAcMlPteKY=
Date:   Tue, 13 Jun 2023 18:24:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, Stephan Bolten <stephan.bolten@gmx.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix command cancellation
Message-ID: <2023061349-disobey-empathy-c1a9@gregkh>
References: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
 <977dae31-7963-d3f5-7612-6f7761b03507@leemhuis.info>
 <2023061313-headed-stumble-cf30@gregkh>
 <49292fe0-db4a-0358-1949-f0ce1c876a73@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49292fe0-db4a-0358-1949-f0ce1c876a73@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 13, 2023 at 05:36:50PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.06.23 17:09, Greg Kroah-Hartman wrote:
> > On Tue, Jun 13, 2023 at 04:51:58PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 06.06.23 13:58, Heikki Krogerus wrote:
> >>> The Cancel command was passed to the write callback as the
> >>> offset instead of as the actual command which caused NULL
> >>> pointer dereference.
> >>>
> >>> Reported-by: Stephan Bolten <stephan.bolten@gmx.net>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217517
> >>> Fixes: 094902bc6a3c ("usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >>
> >> Gentle reminder that this made no progress for a week now. Or was there
> >> and I just missed it? Then apologies in advance.
> > 
> > This just landed in my usb-linus branch a few hours before you sent
> > this, and will show up in linux-next tomorrow as:
> > 	c4a8bfabefed ("usb: typec: ucsi: Fix command cancellation")
> 
> Ahh, great! Sorry, I check next in cases like this before sending mails,
> but not the subsystem trees directly. :-/

I wouldn't expect you to look in subsystem trees, not a problem at all,
thanks for the ping, you're doing great work here.

greg k-h
