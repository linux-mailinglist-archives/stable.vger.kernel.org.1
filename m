Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1392679CEC3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjILKsb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjILKsC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 06:48:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27A171D
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 03:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ACEC433C7;
        Tue, 12 Sep 2023 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694515652;
        bh=G/xBCcLIEruSsm+iftUrK56ijyL93g11JK77NEtnH8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wruNePR8NSOLuIdho23Xi/dUOxZh65rXawjSwIrW87A6zZOIboTEn3gqwJvAQQvT8
         xXVqzodHYxOwu82efWy+fGEidZop/sWF4L934RWBmDwgTBQzQgPTh1cTvZdpcjxgqX
         r5QiC+B3xqcKkvLoaYLYTattE1ZmkhLSDYgVJV0k=
Date:   Tue, 12 Sep 2023 12:47:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Acid Bong <acidbong@tilde.club>
Cc:     stable@vger.kernel.org
Subject: Re: No updates in rolling branches
Message-ID: <2023091227-greedless-handwrite-1c2b@gregkh>
References: <960C7BCB-CB29-40AE-AA82-CCB470A90DBE@tilde.club>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960C7BCB-CB29-40AE-AA82-CCB470A90DBE@tilde.club>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 01:40:47PM +0300, Acid Bong wrote:
> Hi there, hello,
> 
> I noticed that v6.5.2 already has patches that are not passed to
> v6.4.y, but it's still not merged into `rolling-stable`. Do you not
> merge 6.5.y until 6.4.15 comes to its EOL? Or haven't pushed the
> merge?

We normally move to the "next" stable release for that rolling target
when the number of reports has dropped off and all looks good.  That
usually lines up with the EOL time as well.  So that means we'll
probably move this later this week.

You are always free to move to the latest release kernel if you want
sooner :)

thanks,

greg k-h
