Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45642782EA5
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjHUQmu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHUQmt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890DFF3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA8163ECA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 16:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEB3C433C7;
        Mon, 21 Aug 2023 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692636166;
        bh=Qvq9AyAV19dhuMM8THXZZHEiRqS/Ypiy5kAjwep9MNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bysd5ZUrh2Mbkem+bfEacW1gwU/DTewsk/209FtPQ4Mnw/Zm22+ddFZFWGlUxf7rK
         Yan0kZosKqEIlCoh+6Ytkp4l6QkTJGRU00b82jqkKBwiBm6JA5jfDJfQhrtA/8D8ty
         uaA35T9sT39TB7yL5xsJY9DjGZGIcYzLRyQzD8GE=
Date:   Mon, 21 Aug 2023 18:42:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     acme@kernel.org
Cc:     stable@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 6.4.y 1/1] Revert "perf report: Append inlines to
 non-DWARF callchains"
Message-ID: <2023082133-humility-quack-3c9c@gregkh>
References: <2023081251-conceal-stool-53f1@gregkh>
 <20230815180342.274263-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815180342.274263-1-acme@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 03:03:42PM -0300, acme@kernel.org wrote:
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.
> 
> The tests were made with a specific workload, further tests on a
> recently updated fedora 38 system with a system wide perf.data file
> shows 'perf report' taking excessive time resolving inlines in vmlinux,
> so lets revert this until a full investigation and improvement on the
> addr2line support code is made.
> 
> Reported-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Acked-by: Artem Savkov <asavkov@redhat.com>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Milian Wolff <milian.wolff@kdab.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/ZMl8VyhdwhClTM5g@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> (cherry picked from commit c0b067588a4836b762cfc6a4c83f122ca1dbb93a)
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Now queued up, thanks.

greg k-h
