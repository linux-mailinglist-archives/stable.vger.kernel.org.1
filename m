Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7784673747A
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 20:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFTSmK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjFTSmJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 14:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2A95
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 11:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C34612EE
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB98C433C8;
        Tue, 20 Jun 2023 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687286527;
        bh=2LbQVMrFIkPKkMg8CdEKat+SBbReALjAE3l2lNAOVmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmGVYPJzXL4gpYoUM+wIPUf57cojRav+DaXg1RVF3AbYayU18LYrZqtDv2OJSr19w
         V1UxiOV6/j5aa0CvEIafsScfugiA46uA8fvza/YRCj9av/dQPJV2cz7MoT6FbRp0ZL
         iwq4TUxMlZsjlvh+GLniQ8+SJW3d3pQZiwFzx0u0=
Date:   Tue, 20 Jun 2023 20:42:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     stable@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, glider@google.com
Subject: Re: [5.15-stable PATCH 0/2] Copy-on-write hwpoison recovery
Message-ID: <2023062047-confront-spleen-a9a5@gregkh>
References: <20230615015255.1260473-1-jane.chu@oracle.com>
 <2023061926-copied-glowworm-8cee@gregkh>
 <ce871e44-cd07-9f6f-8668-7ebe503b470a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce871e44-cd07-9f6f-8668-7ebe503b470a@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 20, 2023 at 11:36:13AM -0700, Jane Chu wrote:
> Hi, Greg,
> 
> On 6/19/2023 1:28 AM, Greg KH wrote:
> > On Wed, Jun 14, 2023 at 07:52:53PM -0600, Jane Chu wrote:
> > > I was able to reproduce crash on 5.15.y kernel during COW, and
> > > when the grandchild process attempts a write to a private page
> > > inherited from the child process and the private page contains
> > > a memory uncorrectable error. The way to reproduce is described
> > > in Tony's patch, using his ras-tools/einj_mem_uc.
> > > And the patch series fixed the panic issue in 5.15.y.
> > 
> > But you are skipping 6.1.y, which is not ok as it would cause
> > regressions when you upgrade.
> > 
> > I'll drop this from my review queue now, please provide working
> > backports for this and newer releases, and I'll be glad to take them.
> > 
> 
> Thanks for the guidance, will do.
> To confirm, you're looking for backport to both 6.1.y and 5.15.y, and
> nothing else, correct?  Just curious, why 6.1.y in particular?


If you don't think it needs to go to any kernels older than 5.15.y, that would
be fine.

And as for 6.1.y, look at the front page of www.kernel.org, it shows the
active kernel versions.  We can't apply a change to an older kernel tree
only because if you upgrade to a newer one (i.e. from 5.15.y to 6.1.y),
you would have a regression which we don't ever want.

thanks,

greg k-h
