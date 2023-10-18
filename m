Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E57CE33D
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRQ7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRQ7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 12:59:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B66DB0
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 09:59:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7434FC433C8;
        Wed, 18 Oct 2023 16:59:03 +0000 (UTC)
Date:   Wed, 18 Oct 2023 13:00:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-ID: <20231018130042.3430f000@gandalf.local.home>
In-Reply-To: <20231018144030.86885-1-flaniel@linux.microsoft.com>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 18 Oct 2023 17:40:28 +0300
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Changes since:
>  v1:
>   * Use EADDRNOTAVAIL instead of adding a new error code.
>   * Correct also this behavior for sysfs kprobe.
>  v2:
>   * Count the number of symbols corresponding to function name and return
>   EADDRNOTAVAIL if higher than 1.
>   * Return ENOENT if above count is 0, as it would be returned later by while
>   registering the kprobe.
>  v3:
>   * Check symbol does not contain ':' before testing its uniqueness.
>   * Add a selftest to check this is not possible to install a kprobe for a non
>   unique symbol.
>  v5:
>   * No changes, just add linux-stable as recipient.

So why is this adding stable? (and as Greg's form letter states, that's not
how you do that)

I don't see this as a fix but a new feature.

-- Steve
