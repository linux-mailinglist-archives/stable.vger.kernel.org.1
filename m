Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D30F7A3694
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjIQQgJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjIQQf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 12:35:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D7ED
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 09:35:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A533C433C8;
        Sun, 17 Sep 2023 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694968553;
        bh=DGAHnJejwLYKHJMrBokxHjciIAhEvemn5OzDMBLRyRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HURnTrlvOnqGgBvON46ekgwis0yJaTyyMdBEaJQl2HsxQaZynE2Yr9IKV6Aa4z8Er
         8U0YeDwjOQa4P+zmLgSlEXv4c0RtbwUUs/7u+H0wZa7T1q1TDuwk15TP7Q5atdH9K5
         dIgVF8yK9MkIWMiU5V2JKO78A04MzmwZbfimRsNs=
Date:   Sun, 17 Sep 2023 18:35:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Build failures in v{4.14, 4.19, 5.4, 5.10}.y.queue
Message-ID: <2023091739-myself-starring-dcd9@gregkh>
References: <8e198214-c12c-a921-ef7e-82b5e2f70ec2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e198214-c12c-a921-ef7e-82b5e2f70ec2@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 07:58:11AM -0700, Guenter Roeck wrote:
> Building parisc:allnoconfig ... failed
> --------------
> Error log:
> arch/parisc/kernel/processor.c: In function 'show_cpuinfo':
> arch/parisc/kernel/processor.c:443:30: error: 'cpuinfo' undeclared (first use in this function)
>   443 |                              cpuinfo->loops_per_jiffy / (500000 / HZ),
> 
> Caused by 'parisc: Fix /proc/cpuinfo output for lscpu' which
> moves the declaration of cpuinfo inside an #ifdef but still uses
> it outside of it in v5.10.y and older.
> 
> That either needs to be dropped, adjusted, or commit 93346da8ff47 ("parisc:
> Drop loops_per_jiffy from per_cpu struct") needs to be applied as well
> (tested with v5.10.y.queue).

Thanks, I've added this patch now to the queues.

greg k-h
