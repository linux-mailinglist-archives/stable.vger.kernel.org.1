Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B88D779D7C
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHLGGj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHLGGi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 02:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9620330DC
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 23:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB0D614A4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4199DC433C9;
        Sat, 12 Aug 2023 06:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691820397;
        bh=3GoIWiVx3MqSDG+9XApGAq1JUN71LN2m4IjiJxEei1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaptubpHJETem2sxrs/nVWXEHlR9ZreukZcuUMiUnlw9ak7wWphH37UmiS/GMINAu
         yU604rkP0lYNNdw0kyxiVzfPUJPQ6VmtDFSXH2GVtMqXkWdAWQGoN9xBWwewBq6OVx
         KuvCU+lXIhOxRbzQAzLi+4dFgIL8f3lwszjmr3fs=
Date:   Sat, 12 Aug 2023 08:06:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Glaser <tg@mirbsd.de>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: Bug#1043437: linux: report microcode upgrade *from* version
 as well
Message-ID: <2023081202-storewide-exterior-e96c@gregkh>
References: <Pine.BSM.4.64L.2308111943090.32685@herc.mirbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSM.4.64L.2308111943090.32685@herc.mirbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 07:44:06PM +0000, Thorsten Glaser wrote:
> Hi,
> 
> would you mind backporting that patch to stables (at least 5.10
> and 6.1 are relevant for Debian)?
> 


Can you provide a working version of the commit?  As-is, it does not
apply cleanly, so obviously has never even been tested on those kernel
trees.

thanks,

greg k-h
