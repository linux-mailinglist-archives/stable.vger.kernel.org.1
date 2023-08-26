Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527FC789854
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjHZRB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjHZRBO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 13:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460219BA
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31695617E9
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 17:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10459C433C7;
        Sat, 26 Aug 2023 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693069270;
        bh=KMNSsNjBRIXr87OYfz6zydA7zQbOUmj2bwVCZwk2jPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1cpVTlKGN7xRqICdkurCigzF/AFhupxJ1TNJu/5ka63AjHNUnar4yRHliponpiPtQ
         YaNv3b7VP19eD8CzNap/aKaok73l+r/DpKrct3upioOn9eAAStkpHrek9Reetk0mh4
         ICmACGpNK3fiHZW1ta48a4Njyct5MFErOtINkoYE=
Date:   Sat, 26 Aug 2023 19:01:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Wrong patch queued up for 6.4:
 mm-disable-config_per_vma_lock-until-its-fixed.patch
Message-ID: <2023082600-defeat-nucleus-0766@gregkh>
References: <ab4017e3-31ce-f1d0-b2b4-331868f1f643@applied-asynchrony.com>
 <2023082655-designer-moistness-0a6f@gregkh>
 <afb5de81-e869-68b4-1d1d-16cd54129a21@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afb5de81-e869-68b4-1d1d-16cd54129a21@applied-asynchrony.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Aug 26, 2023 at 06:30:34PM +0200, Holger Hoffstätte wrote:
> On 2023-08-26 18:10, Greg KH wrote:
> > On Sat, Aug 26, 2023 at 05:46:40PM +0200, Holger Hoffstätte wrote:
> > > Hi Sasha
> > > 
> > > I just saw that you queued up mm-disable-config_per_vma_lock-until-its-fixed.patch for 6.4.
> > > The problems that this patch tried to prevent were fixed before it actually made it into a
> > > release, and Linus un-did the commit in his merge (at the bottom):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/Kconfig?id=7fa8a8ee9400fe8ec188426e40e481717bc5e924
> > > 
> > > Since the fixes for PER_VMA_LOCK have been in 6.4 releases for a while, this patch
> > > should not go in.
> > 
> > Thanks, I've dropped this patch from the queue now, can you provide a
> > working version?
> 
> There is no alternative version - everything is fine in 6.4. :)

Ah, good, even better :)
