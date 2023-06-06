Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30134724392
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjFFNFT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbjFFNFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 09:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F1E5D
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 06:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBBE632AC
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 13:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F8AC433EF;
        Tue,  6 Jun 2023 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686056713;
        bh=i7FoRBn4ZJhGlfg32duIdlA6fXBJvki6uZ08CPdeo6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fl+md/PWxYElJlZRJCE3p3ocO9gDMwGZXrwlv9FvcdPZBVEeJaQuQmWyWfY+vJ9dr
         qbcjLByStEav2OdrYfQjCxNdWhnwdS8EljsYv++3ANaYOQ9USkeeHFgLwo1s2qrJNY
         deZrsvGK+nj2WNlTmtieB0TH/ij8gB36mVxJtwb8=
Date:   Tue, 6 Jun 2023 15:05:11 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: ensure error propagation for non-blk
Message-ID: <2023060625-unworthy-twice-1483@gregkh>
References: <a70f433fd7754c83a7f5eda86d1cc31d@hyperstone.com>
 <2023060547-wildfowl-courier-9373@gregkh>
 <81262621f64e41a1ae417a64f47ee3fa@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81262621f64e41a1ae417a64f47ee3fa@hyperstone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 12:58:39PM +0000, Christian Loehle wrote:
> Hey Greg,
> The fix should be applied to all stable trees.
> I backported one that works for
> 4.14
> 4.19
> 5.4
> 5.10
> And one for
> 5.15

How can I know which from which?  Please give me us a hint somehow to
know this...

Can you resend these, with that hint either in the subject line (i.e.
[PATCH 5.15]), or below the --- line.

thanks,

greg k-h
