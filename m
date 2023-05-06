Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3796F8EDF
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjEFFzp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEFFzp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5058B4C00
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E189E61630
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC6C433D2;
        Sat,  6 May 2023 05:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352543;
        bh=NCtNX9xO+sLczV/VJNU5aDZcwWBuWCkkCCibFhQeC+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA/vVrSoTIE5feRtjAjnlxTWSN5VP6EcDqOS3Kk4DBjGM+ojsQ2kzGWrtzF+nx1qV
         PGUvruW8WaYoHjaupfznOllFwaa2Rx4Cys4GI9A1Ka6FSyBXQTaUebt3OAQaKmer0T
         P8n6HbjBlxeZu6pZMXrlmYh2921ngbu/fg1o36ys=
Date:   Sat, 6 May 2023 11:03:46 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Please apply commit d08c84e01afa ("perf sched: Cast
 PTHREAD_STACK_MIN to int ...") to v5.10.y and older
Message-ID: <2023050638-dandelion-unspoken-d1aa@gregkh>
References: <06c93e9e-4fdf-55f2-123d-f5cc8208f3d5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06c93e9e-4fdf-55f2-123d-f5cc8208f3d5@roeck-us.net>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 28, 2023 at 07:07:31AM -0700, Guenter Roeck wrote:
> Hi Greg,
> 
> Observed with Ubuntu-22.04:
> 
> In v5.10.y and older kernels, perf may fail to compile with the following error.
> 
> In file included from util/evlist.h:6,
>                  from builtin-sched.c:6:
> builtin-sched.c: In function ‘create_tasks’:
> tools/include/linux/kernel.h:45:17: error: comparison of distinct pointer types lacks a cast [-Werror]
>    45 |  (void) (&_max1 == &_max2);  \
>       |                 ^~
> builtin-sched.c:662:13: note: in expansion of macro ‘max’
>   662 |    (size_t) max(16 * 1024, PTHREAD_STACK_MIN));
> 
> The problem is fixed upstream with commit d08c84e01afa ("perf sched: Cast PTHREAD_STACK_MIN
> to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)". Please apply this commit
> to v5.10.y and older kernel branches.

Now queued up, thanks,

greg k-h
