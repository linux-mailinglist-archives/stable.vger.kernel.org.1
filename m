Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD67D2F76
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWKHm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWKHl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E0DA
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:07:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B316AC433C7;
        Mon, 23 Oct 2023 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698055659;
        bh=lt8BOEh5YwkWBDQ9h/85DenGQ6I2yIcFj/WzTjAG3uY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2nhubDKRXJVZzVnCEfTBy4ALfaonvbbqwiJEp7DuzsH0B2HemzB/oELlPA5S6OEx
         FagLs6kAk3j8Le/nB1cawzemBIXX+3k2WsISAnQdi0p2xHzqQZkIjyAkNBI6VJHm1q
         Ug0efNwgBiD1bC7wf2/rzJMPVM4lrLKfAUj/82pI=
Date:   Mon, 23 Oct 2023 12:07:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5.4.y 1/3] driver: platform: Add helper for safer
 setting of driver_override
Message-ID: <2023102307-passably-scallion-ad80@gregkh>
References: <20231018120527.2110438-1-lee@kernel.org>
 <2023102037-subscript-negate-0f30@gregkh>
 <20231023094815.GE8909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023094815.GE8909@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 10:48:15AM +0100, Lee Jones wrote:
> On Fri, 20 Oct 2023, Greg Kroah-Hartman wrote:
> 
> > <snip>
> > 
> > Something went wrong with this 5.4 series you sent, I got the following
> > emails which look like 2 different versions of this series?:
> > 
> >   11   C Oct 18 Lee Jones       (7.0K) [PATCH v5.4.y 1/3] driver: platform: Add helper for safer setting of driver_override
> >   12   C Oct 18 Lee Jones       (2.6K) ├─>[PATCH v5.4.y 3/3] rpmsg: Fix kfree() of static memory on setting driver_override
> >   13   C Oct 18 Lee Jones       (1.1K) ├─>[PATCH v5.4.y 2/3] rpmsg: Constify local variable in field store macro
> >   14   C Oct 18 Lee Jones       (2.6K) ├─>[PATCH v5.4.y 2/2] rpmsg: Fix kfree() of static memory on setting driver_override
> >   15   C Oct 18 Lee Jones       (1.1K) └─>[PATCH v5.4.y 1/2] rpmsg: Constify local variable in field store macro
> > 
> > And you can see it here:
> > 	https://lore.kernel.org/all/20231018120527.2110438-1-lee@kernel.org/#r
> > 
> > So I don't know what patches to take for 5.4, sorry.  Can you please resend the
> > properly ones?
> 
> You're right.  They're in my inbox too.
> 
> One set was sent 1s after the other, so must be a tooling error.
> 
> The 2 sets are identical.
> 
> 1/3 == 1/3
> 2/3 == 2/3
> 3/3 == 3/3

You have 1/2 and 2/2 here, so hence my confusion :(

All of these need to be resent anyway, let's talk off-list...

thanks,

greg k-h
