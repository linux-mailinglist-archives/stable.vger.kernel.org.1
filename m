Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C57CF898
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjJSMSu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMSt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 08:18:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE31A3
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 05:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C41CC433C8;
        Thu, 19 Oct 2023 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717927;
        bh=y3v4IfGSgIc8FpfyQVXiNpDGuzP2wM1wvkHAL6T5GT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPco6XOa1kuZi9AoXasi2hVstQDVEouN0SHm5PKpLLDILwezdkTae7vIiBP6M6vk+
         7jhnmDjV3VpxXdXqxHbY6Nf01eWKbvvwF7sWczqtnXYgFGsdIzwqYu2wh9y3kvr7Gd
         lqlq7Iipn1EC23y+VrMasPHlyfcuJuEiE7If2EpWlqdvkHgPZ7sU+7mH6d8+yvUSs+
         iJKlo0GFdCUVP/DksEKP07fHRaJCkhNoI5Y1tILOEdioafZB6mjFOJjJNrClXQTDvH
         PM0DgR6WMErBvLRrzzeTjr/XhRF8cX5nfHEd0p0OS4+PfDrlsbiJWGb0s6hMm3Ellt
         3w5rGGXQ+Ez9w==
Date:   Thu, 19 Oct 2023 21:18:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-Id: <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
In-Reply-To: <20231018130042.3430f000@gandalf.local.home>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
        <20231018130042.3430f000@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 18 Oct 2023 13:00:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Oct 2023 17:40:28 +0300
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> 
> > Changes since:
> >  v1:
> >   * Use EADDRNOTAVAIL instead of adding a new error code.
> >   * Correct also this behavior for sysfs kprobe.
> >  v2:
> >   * Count the number of symbols corresponding to function name and return
> >   EADDRNOTAVAIL if higher than 1.
> >   * Return ENOENT if above count is 0, as it would be returned later by while
> >   registering the kprobe.
> >  v3:
> >   * Check symbol does not contain ':' before testing its uniqueness.
> >   * Add a selftest to check this is not possible to install a kprobe for a non
> >   unique symbol.
> >  v5:
> >   * No changes, just add linux-stable as recipient.
> 
> So why is this adding stable? (and as Greg's form letter states, that's not
> how you do that)
> 
> I don't see this as a fix but a new feature.

I asked him to make this a fix since the current kprobe event' behavior is
somewhat strange. It puts the probe on only the "first symbol" if user
specifies a symbol name which has multiple instances. In this case, the
actual probe address can not be solved by name. User must specify the
probe address by unique name + offset. Unless, it can put a probe on
unexpected address, especially if it specifies non-unique symbol + offset,
the address may NOT be the instruction boundary.
To avoid this issue, it should check the given symbol is unique.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
