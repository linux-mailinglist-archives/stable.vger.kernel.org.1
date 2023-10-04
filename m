Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B477B7B86
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbjJDJOY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbjJDJOS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 05:14:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B39C7B0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 02:14:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10164DA7;
        Wed,  4 Oct 2023 02:14:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.95.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32593F59C;
        Wed,  4 Oct 2023 02:14:13 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:14:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: v6.5 backport request: 6d2779ecaeb56f92 ("locking/atomic:
 scripts: fix fallback ifdeffery")
Message-ID: <ZR0s4Ble4Rh99R6I@FVFF77S0Q05N>
References: <ZRw-0snchQiF5shv@FVFF77S0Q05N>
 <ZRxDWQop/3kdbObN@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRxDWQop/3kdbObN@sashalap>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 03, 2023 at 12:37:45PM -0400, Sasha Levin wrote:
> On Tue, Oct 03, 2023 at 05:18:26PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > Could we please backport commit:
> > 
> >  6d2779ecaeb56f92d7105c56772346c71c88c278
> >  ("locking/atomic: scripts: fix fallback ifdeffery")
> > 
> > ... to the 6.5.y stable tree?
> > 
> > I forgot to Cc stable when I submitted the original patch, and had (mistakenly)
> > assumed that the Fixes tag was sufficient.
> > 
> > The patch fixes a dentry cache corruption issue observed on arm64 and which is
> > in theory possible on other architectures. I've recevied an off-list report
> > from someone who's hit the issue on the v6.5.y tree specifically.
> 
> Already done, it came in via AUTOSEL.

Ah! Thanks for confirming, and sorry for the noise. :)

I see now that that's in stable-queue.git -- I'll remember to go check that too
in future.

Mark.
