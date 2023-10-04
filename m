Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB07B8637
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjJDRQY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjJDRQY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 13:16:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBE9E;
        Wed,  4 Oct 2023 10:16:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4273C433C8;
        Wed,  4 Oct 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696439780;
        bh=4ASCGJlKUkPzZR1q9AJsbJfWmb02kFK0srB6/vt/Sk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coVBEOSs0x81o5p23+TO4PnI3wbfyeZNM3hyWHmPK010uaxaAV1YlKPCEhOnxgkGL
         KlFn45fMrROksso7Gosni1pfQulcNKTZ45RrxLSE2Nx0COAH/dLaPN0l5ynpLZrWqk
         KqUMvTYAp5X0JKRaRCddqXkLTfkBSNV1nZ3cxZEw=
Date:   Wed, 4 Oct 2023 19:16:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     stable@vger.kernel.org, broonie@kernel.org,
        stable-commits@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        regressions@lists.linux.dev
Subject: Re: Patch "ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and
 82UG" has been added to the 6.1-stable tree
Message-ID: <2023100411-unsecured-angler-f25b@gregkh>
References: <B48DED01-5B50-4EF7-B0AC-2DC742D07890@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B48DED01-5B50-4EF7-B0AC-2DC742D07890@augustwikerfors.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 06:33:55PM +0200, August Wikerfors wrote:
> Hi Greg,
> 
> > On 4 Oct 2023, at 16:58, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿
> > This is a note to let you know that I've just added the patch titled
> > 
> >  ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
> > 
> > to the 6.1-stable tree which can be found at:
> >  http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >   asoc-amd-yc-fix-non-functional-mic-on-lenovo-82qf-and-82ug.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > From 1263cc0f414d212129c0f1289b49b7df77f92084 Mon Sep 17 00:00:00 2001
> > From: August Wikerfors <git@augustwikerfors.se>
> > Date: Mon, 11 Sep 2023 23:34:09 +0200
> > Subject: ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
> > 
> > From: August Wikerfors <git@augustwikerfors.se>
> > 
> > commit 1263cc0f414d212129c0f1289b49b7df77f92084 upstream.
> > 
> > Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
> > (Legion S7 16ARHA7) both need a quirk entry for the internal microphone to
> > function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
> > Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",
> > breaking microphone functionality on these devices. Fix this by adding
> > specific quirks for these models, as was done for the Lenovo 82TL.
> > 
> > Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
> > Closes: https://github.com/tomsom/yoga-linux/issues/51
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c780
> > Cc: stable@vger.kernel.org
> > Signed-off-by: August Wikerfors <git@augustwikerfors.se>
> > Link: https://lore.kernel.org/r/20230911213409.6106-1-git@augustwikerfors.se
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Please also add commit cfff2a7794d2 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL") to 6.1+ as it fixed the same regression for another model (but wasn’t tagged for stable).

Now queued up, thanks.

greg k-h
