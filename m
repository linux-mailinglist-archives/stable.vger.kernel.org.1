Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C077D17A
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjHOSE7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbjHOSEp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 14:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F21984
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 11:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9CB963D55
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 18:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F2CC433C8;
        Tue, 15 Aug 2023 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122683;
        bh=6zTX5vK0JP+WLH94PYbAK8SJ1mxjCuXKBefI8p2LFCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfeUJ9a+zyp+3fVSDezeY2s40Ooi5caMqb5338Hx3wGeA9/S7OFg6WCBhItPy66J4
         HH2xgW5OcFyw04CoET9lg25Z1DBU/Z6u3u7iTBd+pGj0bZYrSHXN4Sh8GXW8k0RfIo
         Q6KMIervFaVJwSkyVdLg3oSHtxtd7cF1oaK5xXwxQ19e7Dr27Ife/toKwVpMn4NJA0
         +OB6a/rSNcGC8hXHPuzfY8KZFZPJttgC+h5wjz3KbxB6toykPmp+m72KCYttxkfLvb
         keUGBpiiMUVgJwxQyM63gKhgH7CTQqUK0eGCISmyfNNiolVTeLNWb6CY+AqPywGDDG
         MhPQ/RKZ9RSDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96877404DF; Tue, 15 Aug 2023 15:04:40 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:04:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     acme@redhat.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, andrii.nakryiko@gmail.com,
        asavkov@redhat.com, hawk@kernel.org, irogers@google.com,
        jolsa@kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Revert "perf report: Append inlines to
 non-DWARF callchains"" failed to apply to 6.4-stable tree
Message-ID: <ZNu+OFN4bwJ0lBir@kernel.org>
References: <2023081251-conceal-stool-53f1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081251-conceal-stool-53f1@gregkh>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Em Sat, Aug 12, 2023 at 06:50:51PM +0200, gregkh@linuxfoundation.org escreveu:
> 
> The patch below does not apply to the 6.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x c0b067588a4836b762cfc6a4c83f122ca1dbb93a
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081251-conceal-stool-53f1@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Had to add "--no-cover-letter":

[acme@quaco perf-tools-next]$ git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081251-conceal-stool-53f1@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
/tmp/5jnzQlFK3_/0000-cover-letter.patch
/tmp/5jnzQlFK3_/0001-Revert-perf-report-Append-inlines-to-non-DWARF-callc.patch
Refusing to send because the patch
	/tmp/5jnzQlFK3_/0000-cover-letter.patch
has the template subject '*** SUBJECT HERE ***'. Pass --force if you really want to send.
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$ man git-send-email
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$ git send-email --no-cover-letter

Sent.
 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From c0b067588a4836b762cfc6a4c83f122ca1dbb93a Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Date: Tue, 1 Aug 2023 18:42:47 -0300
> Subject: [PATCH] Revert "perf report: Append inlines to non-DWARF callchains"
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
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4e62843d51b7..f4cb41ee23cd 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -45,7 +45,6 @@
>  
>  static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
>  				     struct thread *th, bool lock);
> -static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
>  {
> @@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.maps = maps__get(al.maps);
>  	ms.map = map__get(al.map);
>  	ms.sym = al.sym;
> -
> -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> -		goto out;
> -
>  	srcline = callchain_srcline(&ms, al.addr);
>  	err = callchain_cursor_append(cursor, ip, &ms,
>  				      branch, flags, nr_loop_iter,
> 

-- 

- Arnaldo
