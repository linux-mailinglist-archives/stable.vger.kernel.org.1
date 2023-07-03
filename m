Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFED746308
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGCS5C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGCS5B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F0F90
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8426660F24
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77174C433C9;
        Mon,  3 Jul 2023 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410617;
        bh=S7fQKOAAYtvGKw4Z/UMBp460D47jEEeRyq9b4SgdkoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASWkegSi8lhgJacOTKVlMZsmKXJPegEvYoMYIJdQ0+Xo468o2s/PDLOqkIuSwGaEF
         lW+q0RaGBlWqOd5mbwfMrHzYoQ/zqfAbjq8pTLibOo3tPuGLK5lTAOlOjIcKAZtX9g
         0JiW7EeK/4uGu6dCbeZ130zG7jzaeXA2EMpqicBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Reaver <me@davidreaver.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1 08/11] perf symbols: Symbol lookup with kcore can fail if multiple segments match stext
Date:   Mon,  3 Jul 2023 20:54:27 +0200
Message-ID: <20230703184519.363891736@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.121965745@linuxfoundation.org>
References: <20230703184519.121965745@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

commit 1c249565426e3a9940102c0ba9f63914f7cda73d upstream.

This problem was encountered on an arm64 system with a lot of memory.
Without kernel debug symbols installed, and with both kcore and kallsyms
available, perf managed to get confused and returned "unknown" for all
of the kernel symbols that it tried to look up.

On this system, stext fell within the vmalloc segment.  The kcore symbol
matching code tries to find the first segment that contains stext and
uses that to replace the segment generated from just the kallsyms
information.  In this case, however, there were two: a very large
vmalloc segment, and the text segment.  This caused perf to get confused
because multiple overlapping segments were inserted into the RB tree
that holds the discovered segments.  However, that alone wasn't
sufficient to cause the problem. Even when we could find the segment,
the offsets were adjusted in such a way that the newly generated symbols
didn't line up with the instruction addresses in the trace.  The most
obvious solution would be to consult which segment type is text from
kcore, but this information is not exposed to users.

Instead, select the smallest matching segment that contains stext
instead of the first matching segment.  This allows us to match the text
segment instead of vmalloc, if one is contained within the other.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Reaver <me@davidreaver.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20230125183418.GD1963@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/symbol.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,10 +1368,23 @@ static int dso__load_kcore(struct dso *d
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		u64 replacement_size = 0;
+
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			u64 new_size = new_map->end - new_map->start;
+
+			if (!(stext >= new_map->start && stext < new_map->end))
+				continue;
+
+			/*
+			 * On some architectures, ARM64 for example, the kernel
+			 * text can get allocated inside of the vmalloc segment.
+			 * Select the smallest matching segment, in case stext
+			 * falls within more than one in the list.
+			 */
+			if (!replacement_map || new_size < replacement_size) {
 				replacement_map = new_map;
-				break;
+				replacement_size = new_size;
 			}
 		}
 	}


