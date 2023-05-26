Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA2712AE8
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEZQmk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjEZQmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 12:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC06D9
        for <stable@vger.kernel.org>; Fri, 26 May 2023 09:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E53A65155
        for <stable@vger.kernel.org>; Fri, 26 May 2023 16:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B796C433EF;
        Fri, 26 May 2023 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685119358;
        bh=VJiG9E9yrEUc9liwwfPju9yYgcm5zlWChUWQmM1nqAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVeoxpFHvbmJIHZM9IyYODw5XTcBQM0Sji6+lgsC7y+pHc5ZO9teVbBf5+0OptSD8
         aELeLrG1zfhLygA3ktBkCFc0sPah9sC/J76ymecM9sExU/emHqODg0OmBXAKXOmfqn
         3mTkUOEOlfzhYv2INebIs4jbto00+mxQ1ng8Kr/8=
Date:   Fri, 26 May 2023 17:42:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-stable <stable@vger.kernel.org>
Subject: Re: ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15
Message-ID: <2023052618-splashed-retrieval-a1ba@gregkh>
References: <cfc2511b-51d1-771b-8cd0-5533d03c0367@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc2511b-51d1-771b-8cd0-5533d03c0367@denx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 24, 2023 at 06:12:46PM +0200, Marek Vasut wrote:
> Please backport to stable 5.10.y
> 
> ee2aacb6f3a9 ("ARM: dts: stm32: fix AV96 board SAI2 pin muxing on
> stm32mp15")
> 
> Full commit ID
> 
> ee2aacb6f3a901a95b1dd68964b69c92cdbbf213

You forgot about 5.15.y :)

Now queued up for both, thanks,

greg k-h
