Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EADC79E1B7
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjIMINC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbjIMINB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:13:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C12198E
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:12:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C450C433C8;
        Wed, 13 Sep 2023 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694592777;
        bh=1Cm0DFSJ5q1YZBE8VWC6e3Sd/YUQ+lxUtxu0Er8frHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnvVZWi555Eg/fqxu1fsleUqDuVTYISHPnjRyRowPy6F8BKplJwTAO29Nz2l+ai1D
         pmc6TbNJhjqW7Kt6RD4TAKLEBjAGv+1KScRJbW9O5HG2rxfixG5UR/xtoF9i2Wi/yf
         i8sFxF4s9OdW8Nr0DLRNqLZOtl069pAsrLd8h3AY=
Date:   Wed, 13 Sep 2023 10:12:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <2023091320-chemist-dragonish-6874@gregkh>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
 <ZP/SOqa0M3RvrVEF@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP/SOqa0M3RvrVEF@westworld>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 07:51:38PM -0700, Kyle Zeng wrote:
> On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> > Great, can you use 'git bisect' to track down the commit that fiexes
> > this so we can add it to the stable trees?
> Sorry for the late reply. I think the fix was to completely retire the
> rsvp classifier and the commit is:
> 
> 265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)

Great, so if we apply this change, all will work properly again?  How
far back should this be backported to?

thanks,

greg k-h
