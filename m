Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185EA7EF3D5
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjKQNtU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 08:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNtU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 08:49:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08605D52
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 05:49:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F892C433C8;
        Fri, 17 Nov 2023 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700228956;
        bh=MjFrOhJtCFbeDO2PKegUmEUN+m5y+Ah3nPMU+UZJFtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL4WFYPtj3milAMCpLXLrtv+4UD9tSnv8AsPktprQrpmDylVjVqGYoia/1cBtEMX5
         31omLmPLt3TUo9Dtai+E7HqtjI7EJ6kwvwv3dSXlNHMmGF6iU2Z/Cto4rB6Q/X4oH0
         Nm+jnYMPefK5yL+j9IsLvhnAhqL0LLpp8Nn7sEOg=
Date:   Fri, 17 Nov 2023 08:49:14 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Andr=E9?= Kunz <donatusmusic@gmx.de>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-input@vger.kernel.org
Subject: Re: Found a bug with my gaming gear
Message-ID: <2023111719-excluding-spotter-ad54@gregkh>
References: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1a6eb1-a8af-4181-b9e4-c7b8d3af1eea@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Nov 16, 2023 at 11:41:34PM +0100, André Kunz wrote:
> Hey there guys,
> 
> This is my first kernel "bug" report ever, so please bear with me if I
> didn't catch the precise right way to report this.
> 
> The bug I've found:
> 
> I'm running stable kernel 6.6.1-1 and as soon as I install it, many of
> my mouse's hardware buttons stop working. I have a Logitech G502 X Plus
> (it's a wireless mouse). As soon as I install 6.6.1 the mouse's hardware
> buttons won't work, i.e. only the two side-buttons would work, not the
> buttons (and/or my created profiles/macros) would. I have a few macros
> assigned to some buttons, which work perfectly fine under 6.5.11 (and
> earlier), but as soon as I'm on 6.6 they'd stop working.
> 
> Just wanted to report this and I hope there can be a fix.

You might want to notify the linux-input mailing list, as the developers
there should be able to help you out as they are the ones working on
that portion of the kernel.

I've added them to the cc: here.

thanks,

greg k-h
