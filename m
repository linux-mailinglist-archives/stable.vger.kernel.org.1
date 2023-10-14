Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88E7C93C4
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 11:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjJNJ1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjJNJ1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 05:27:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D2AD
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 02:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01547C433C7;
        Sat, 14 Oct 2023 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697275666;
        bh=P6u2Z+EfWI6ZU89PXHo1XFKDmv2na8S9uzAG79dxKb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJ6m9JTw5CMZtYzexaj9OYblFbmJtaxpcJX6PCnhamsPaJS6Tu6mEYXQicCz8CvbH
         EVIaObX/PNyeBJoBHUoaVBQCvGOV4tfoEzegbcxPmHHB3lszO89VKpZHPofYs1yPFJ
         eiNYbXtZiad8SiOYIaWycEe283cyOedpnhs88Ftk=
Date:   Sat, 14 Oct 2023 11:27:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mahmoud Adam <mngyadam@amazon.com>
Cc:     stable@vger.kernel.org
Subject: Re: backport "x86: change default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl"
Message-ID: <2023101401-boxer-grandpa-6e31@gregkh>
References: <lrkyqy1g6bnqi.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqy1g6bnqi.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 04:28:37PM +0200, Mahmoud Adam wrote:
> 
> Hi,
> 
> commit 2f46993d83ff upstream.
> 
> Please backport this commit to the other stable kernels, since this
> patch landed on 6.1 and We've seen 30% improvement with docker
> containers running heavy cpu/mem tasks

Why is this required at all?  It just changes a default option, you can
set the "faster" option yourself if you really feel it is a good idea
for older kernels, why can't you do that for containers you want it
enabled on for these older kernels?

And what exact kernel versions did you test this on?

And how is this not a new feature?

thanks,

greg k-h
