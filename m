Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD3E701535
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEMIKJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIKI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 04:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419759DA
        for <stable@vger.kernel.org>; Sat, 13 May 2023 01:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A29760E83
        for <stable@vger.kernel.org>; Sat, 13 May 2023 08:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B3C433D2;
        Sat, 13 May 2023 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683965406;
        bh=42MHozBLuGT2Qtni/7+z4jwuDEZSHaOXaJgTCIPf9Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owo0V5Wr7/ob0rS/WR5nWWS7b12hjVZQbSSioezbUp5P5V5YLBg1EHS2UzF1cBQQM
         qcdXyYjyxfKbFqwYfedQ5DqiYgEN55FZfpCdF96mVZV5jUjzl5pMEV7irdFhfGlohZ
         Wr9gJfnmlBbkqs0yG2FP+NnIYZM8GDVseEZuJ7Kc=
Date:   Sat, 13 May 2023 16:51:47 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ping Cheng <pinglinux@gmail.com>
Cc:     "stable # v4 . 10" <stable@vger.kernel.org>
Subject: Re: HID: wacom: insert timestamp to packed Bluetooth (BT) events
Message-ID: <2023051337-dejected-trapped-9965@gregkh>
References: <CAF8JNhLT+Gk76Wwo6c3xE-7aLPTLvdfc2P-+0okpQodn3d6YCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8JNhLT+Gk76Wwo6c3xE-7aLPTLvdfc2P-+0okpQodn3d6YCg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023 at 01:23:14PM -0700, Ping Cheng wrote:
> Hi Stable maintainers,
> 
> This patch, ID 17d793f3ed53, inserts timestamps to Wacom bluetooth
> device events. The upstream patch applies to kernels 6.1 and later as
> is.
> 
> The attached patch applies to kernel 5.4 to 5.15 stable versions. Let
> me know if you have other questions.

All now queued up, thanks.

greg k-h
