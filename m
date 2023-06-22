Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417273A6EF
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFVRGQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVRGP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 13:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD8110F1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 10:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF69618C4
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 17:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C81FC433C0;
        Thu, 22 Jun 2023 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687453573;
        bh=6GvtUrtLTssv9DRrYF3fRhGi7Hx3agxOVe4R6hxQYoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVLOj+7iAOmhJai9DrhaO55pXoW2mI/q7G/f2rsAnqh+HhoMcadNe5VsE6oTqd2Kd
         sx/3CALLvU3yLap0iSvGRbxMM3V19TzCd+wllSc2SviW8sldSHgS1sKaMV4znOBDtg
         DFI4xTLIdKZnYwy8g6pxtSuAyTFkfcQimQk0l6xI=
Date:   Thu, 22 Jun 2023 19:06:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     kuba@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: pm nl: remove hardcoded
 default limits" failed to apply to 5.4-stable tree
Message-ID: <2023062249-frisbee-omen-5757@gregkh>
References: <2023062218-porous-squiggle-d837@gregkh>
 <36b7e220-3f9f-726d-62d7-af05eededeab@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b7e220-3f9f-726d-62d7-af05eededeab@tessares.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 03:38:45PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 22/06/2023 09:57, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> 
> (...)
> 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 2177d0b08e421971e035672b70f3228d9485c650 Mon Sep 17 00:00:00 2001
> > From: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Date: Thu, 8 Jun 2023 18:38:49 +0200
> > Subject: [PATCH] selftests: mptcp: pm nl: remove hardcoded default limits
> > 
> > Selftests are supposed to run on any kernels, including the old ones not
> > supporting all MPTCP features.
> > 
> > One of them is the checks of the default limits returned by the MPTCP
> > in-kernel path-manager. The default values have been modified by commit
> > 72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
> > Instead of comparing with hardcoded values, we can get the default one
> > and compare with them.
> > 
> > Note that if we expect to have the latest version, we continue to check
> > the hardcoded values to avoid unexpected behaviour changes.
> > 
> > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> > Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
> 
> Thank you for this notification!
> 
> I'm not sure why this patch got picked up for v5.4-stable tree because
> it is fixing code that is not in v5.4 but introduced in v5.7. The commit
> mentioned here above has not been backported in v5.4. That seems to be
> confirmed by:
> 
>   https://kernel.dance/#eedbc685321b
> 
> So no need to do anything here.

Yes, my fault, I sent out too many "this failed" messages for some of
these, sorry about that.

greg k-h
