Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0C72AC96
	for <lists+stable@lfdr.de>; Sat, 10 Jun 2023 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjFJPag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 11:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFJPaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 11:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28613E
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 08:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95D1260BF9
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 15:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B97C433EF;
        Sat, 10 Jun 2023 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686411034;
        bh=QGozuMb4JB6yCw3yesjO5a23Xjmz7nTTblNSfR35qaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSEdar5dPVM7DHgRMuSd9ZZfA2xxuYlLg551mlVb4GTb7TJRzGi40m6qgr65HoR+e
         FlIp3srTFW2akwFxTiSS17a59wg+RJSvmKy2VcWybFqkbskbJd3xfa5YRdUEIkXV+p
         LbeD3oR2zrhmehfQKLR3W5qiFW38Pj+WQ9NJNYgM=
Date:   Sat, 10 Jun 2023 17:30:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Frank Reppin <frank@undermydesk.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        keescook@chromium.org, stable@vger.kernel.org,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        debian-kernel@lists.debian.org
Subject: Re: request commit for 6.1 too // scsi: megaraid_sas: Add flexible
 array member for SGLs
Message-ID: <2023061007-deferred-stench-d01d@gregkh>
References: <18d71d6f-3bb1-ff5c-d053-787492322bf6@undermydesk.org>
 <FEF61131-A089-4A5A-AE38-71DFB6B8E8B9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEF61131-A089-4A5A-AE38-71DFB6B8E8B9@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 10, 2023 at 08:00:16AM -0700, Kees Cook wrote:
> On June 9, 2023 3:42:12 PM PDT, Frank Reppin <frank@undermydesk.org> wrote:
> >Dear all,
> >
> >I've already followed the reply instructions on LKML - but it somewhat
> >messed up my message there (so probably nobody knows what I'm talking about) - however ...
> >
> >Earlier this year you've committed
> >
> >scsi: megaraid_sas: Add flexible array member for SGLs
> >https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=a9a3629592ab
> >
> >... but it only made it into 6.3 at this time.
> >
> >I hereby kindly request to see this commit in LTS 6.1 too.
> 
> Sure! These requests are handled through the stable mailing list (now added to To:).
> 
> Greg, please backport a9a3629592ab to 6.1 (and 6.2).

6.2.y is long end-of-life (as shown on the front page of kernel.org), so
now queued up for 6.1.y only.

thanks,

greg k-h
