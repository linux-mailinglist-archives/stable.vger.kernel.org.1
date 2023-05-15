Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD2703BE7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbjEOSIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbjEOSHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B54222222
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE6E630A4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B2C433EF;
        Mon, 15 May 2023 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173887;
        bh=vhJbw+03avHVyCltzDRAQfywqkct5JjC8kU5BqUgtQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00ul+FNMu5+T/SYGjVy+cy6r5MExKclcNIE5/naanmL1Bcs5bn+cvyGJsvFZcge5X
         2NccNGyB2eNCmH3TDoEB2EctGQOaeIAPvueyJBUWKeQdotqkfVwxQKtcmK79bmkgjn
         Qg3aNZ2mDVRY0XV+77OUf03XOFC0Adev0E6dnKeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 207/282] perf auxtrace: Fix address filter entire kernel size
Date:   Mon, 15 May 2023 18:29:45 +0200
Message-Id: <20230515161728.451691555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit 1f9f33ccf0320be21703d9195dd2b36a1c9a07cb upstream.

kallsyms is not completely in address order.

In find_entire_kern_cb(), calculate the kernel end from the maximum
address not the last symbol.

Example:

 Before:

    $ sudo cat /proc/kallsyms | grep ' [twTw] ' | tail -1
    ffffffffc00b8bd0 t bpf_prog_6deef7357e7b4530    [bpf]
    $ sudo cat /proc/kallsyms | grep ' [twTw] ' | sort | tail -1
    ffffffffc15e0cc0 t iwl_mvm_exit [iwlmvm]
    $ perf.d093603a05aa record -v --kcore -e intel_pt// --filter 'filter *' -- uname |& grep filter
    Address filter: filter 0xffffffff93200000/0x2ceba000

 After:

    $ perf.8fb0f7a01f8e record -v --kcore -e intel_pt// --filter 'filter *' -- uname |& grep filter
    Address filter: filter 0xffffffff93200000/0x2e3e2000

Fixes: 1b36c03e356936d6 ("perf record: Add support for using symbols in address filters")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230403154831.8651-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/auxtrace.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1825,6 +1825,7 @@ static int find_entire_kern_cb(void *arg
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!kallsyms__is_function(type))
 		return 0;
@@ -1834,7 +1835,9 @@ static int find_entire_kern_cb(void *arg
 		args->start = start;
 	}
 	/* Don't know exactly where the kernel ends, so we add a page */
-	args->size = round_up(start, page_size) + page_size - args->start;
+	size = round_up(start, page_size) + page_size - args->start;
+	if (size > args->size)
+		args->size = size;
 
 	return 0;
 }


