Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4F74626E
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGCScp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGCScl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E910CE
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2892160FFB
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA77C433C7;
        Mon,  3 Jul 2023 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688409154;
        bh=biAe+KgJdd4IMVjrQugbzTh6QabpKTXIPhNVezqwWGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUxsisnPmglbuQQa7POTo4w+XFzxwmJ5PxJs5lWoQpZfzAhi5XR7XuZJd8W8H0Yrb
         KRebXnmNmTVUEA0geAkuUqgC6ibjrYyEDThYxe1Fsw7tk/4aSYhBUukqjv/TkPtyuq
         QTPALA6wXWJRs92E12k0eLkNhna9vzu9OW+Z2yU4=
Date:   Mon, 3 Jul 2023 20:32:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Reaver <me@davidreaver.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5.15.y] perf symbols: Symbol lookup with kcore can fail
 if multiple segments match stext
Message-ID: <2023070314-unblock-nursery-52be@gregkh>
References: <20230628230435.GD1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628230435.GD1918@templeofstupid.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 04:04:35PM -0700, Krister Johansen wrote:
> commit 1c249565426e3a9940102c0ba9f63914f7cda73d upstream.
> 
> This problem was encountered on an arm64 system with a lot of memory.
> Without kernel debug symbols installed, and with both kcore and kallsyms
> available, perf managed to get confused and returned "unknown" for all
> of the kernel symbols that it tried to look up.
> 
> On this system, stext fell within the vmalloc segment.  The kcore symbol
> matching code tries to find the first segment that contains stext and
> uses that to replace the segment generated from just the kallsyms
> information.  In this case, however, there were two: a very large
> vmalloc segment, and the text segment.  This caused perf to get confused
> because multiple overlapping segments were inserted into the RB tree
> that holds the discovered segments.  However, that alone wasn't
> sufficient to cause the problem. Even when we could find the segment,
> the offsets were adjusted in such a way that the newly generated symbols
> didn't line up with the instruction addresses in the trace.  The most
> obvious solution would be to consult which segment type is text from
> kcore, but this information is not exposed to users.
> 
> Instead, select the smallest matching segment that contains stext
> instead of the first matching segment.  This allows us to match the text
> segment instead of vmalloc, if one is contained within the other.
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: David Reaver <me@davidreaver.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: http://lore.kernel.org/lkml/20230125183418.GD1963@templeofstupid.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  tools/perf/util/symbol.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Both now queued up, thanks.

greg k-h
