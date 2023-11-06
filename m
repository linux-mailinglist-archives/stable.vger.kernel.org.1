Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830B47E1D1D
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKFJTi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 04:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjKFJTh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 04:19:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1372DDF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 01:19:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5097FC433C7;
        Mon,  6 Nov 2023 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699262374;
        bh=aHhtLAr9nrJf9m45UpSxg2nODXqnnAIz/Ob1w49xLxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yLdTx6sgvn//UnmlBRM5rtVywfF0pg9YirXq+zMSOa91z//OGhRZB6VC8RybwCEXE
         ZExs/l9D74E5EbDkaWrwLEnxPBzbiDdJ5zEJRPfJKkxLwFXG5mYMTwrnlmCs0hF1nS
         hlz+1I/Y1FqYDLJvURroxts/Inhk8Q4rR2AK+Kg8=
Date:   Mon, 6 Nov 2023 10:19:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mahmoud Adam <mngyadam@amazon.com>
Cc:     stable@vger.kernel.org
Subject: Re: backport "x86: change default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl"
Message-ID: <2023110617-had-drier-c367@gregkh>
References: <lrkyqy1g6bnqi.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
 <2023101401-boxer-grandpa-6e31@gregkh>
 <lrkyq4ji533oz.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyq4ji533oz.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 04:15:24PM +0100, Mahmoud Adam wrote:
> > Why is this required at all?  It just changes a default option, you can
> > set the "faster" option yourself if you really feel it is a good idea
> > for older kernels, why can't you do that for containers you want it
> > enabled on for these older kernels?
> 
> The patch has already motivations of why this is a better default, and
> changing this would give performance improvements
> 
> > And what exact kernel versions did you test this on?
> 
> this was tested on 5.15 and 5.10
> 
> > And how is this not a new feature?
> 
> As you mentioned it changes the default option, Why is this considered a
> new feature?

Changing the default option when booting is a new feature in that it
changes what was previously happening before.

And, anyone running those old kernels, if they are comfortable with
making this feature the default, in order to get the performance
increase you say is there, can change their command line to do so, no
kernel changes needed.

So for now, I'll leave this as-is, thanks.

greg k-h
