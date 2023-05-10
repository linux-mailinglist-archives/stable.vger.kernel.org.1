Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392FA6FE75D
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 00:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjEJWpk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjEJWpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 18:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5737C3ABA
        for <stable@vger.kernel.org>; Wed, 10 May 2023 15:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2ABE63F31
        for <stable@vger.kernel.org>; Wed, 10 May 2023 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C7C433D2;
        Wed, 10 May 2023 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683758737;
        bh=/qVwIjwAST+6Wm3fRCZRvXzBCJoxO78ijjus+tVroeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNiF5v83aRZa2btLYRTac9E1SyU0np2i694iLFghgaXvPvkHlGfyHBWQbYzq8Ck7g
         Ovvt9/YZnmErFKrsbPB1KwjmELZUYfuAGx64DScpv2jkAvdpoI83Qp84DZK8UYB8Da
         qBfXV6zLczKSitjuG/DRL3O8FSeoxltW9+5CGd5c=
Date:   Thu, 11 May 2023 07:45:31 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Bezdeka <florian@bezdeka.de>
Cc:     yoong.siang.song@intel.com, anthony.l.nguyen@intel.com,
        brouer@redhat.com, davem@davemloft.net, jacob.e.keller@intel.com,
        leonro@nvidia.com, naamax.meir@linux.intel.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] igc: read before write to SRRCTL
 register" failed to apply to 6.1-stable tree
Message-ID: <2023051115-width-squeeze-319b@gregkh>
References: <2023050749-deskwork-snowboard-82cf@gregkh>
 <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023 at 12:01:36AM +0200, Florian Bezdeka wrote:
> Hi all,
> 
> On 07.05.23 08:44, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3ce29c17dc847bf4245e16aad78a7617afa96297
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050749-deskwork-snowboard-82cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Is someone already working on that? I would love to see this patch in
> 6.1. If no further activities are planned I might have the option/time
> to supply a backport as well.

Please supply a backport, I don't think anyone is working on it :)
