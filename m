Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2736179DF50
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 07:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjIMFDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 01:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjIMFDO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 01:03:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9F172A
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 22:03:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4213CC433C8;
        Wed, 13 Sep 2023 05:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694581390;
        bh=QnsiBXGK1c8kLoStD8qIDtxVU8K7YRQVwV1rf2/t87Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyqeW92nXdKhqS/LHwW608fRJk07eFfBrsSf2ubKjL0tA4d9RsA66yv4TpSyzqH4e
         eSFo/nIJmhm1nGjPyUdHN7lVz5QiDrYll272JYUdVLNMEgSpaThs/vm1ULjNdWSm4o
         J2QRbJ0HlwHgelpDJEE4m4X2AXQUAEgTyUVNwusI=
Date:   Wed, 13 Sep 2023 07:03:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Paul Grandperrin <paul.grandperrin@gmail.com>,
        stable@vger.kernel.org, Wei WANG <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Ricky WU <ricky_wu@realtek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Message-ID: <2023091333-fiftieth-trustless-d69d@gregkh>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 07:10:38PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> (CCing Greg, as he merged the culprit, and Linus, in case he wants to
> revert this from mainline directly as this apparently affects and annoys
> quite a few people)

The driver authors know about this and have said they are working on a
solution.  Let's give them a few more days on it before reverting stuff.

thanks,

greg k-h
