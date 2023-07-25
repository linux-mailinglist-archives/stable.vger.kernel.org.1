Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56397611F2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGYK6b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGYK5Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889712116
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93B86166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF429C433C8;
        Tue, 25 Jul 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282485;
        bh=iXwbbWYHtCbyGhHnwsiItwAgGDSVUNs61f2DFbQTuu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqMbBEhQuXnplj6TSYQaBnxCiSmjZGcIEaXYHkifqBZHbnWhcqeEYqX5u4wdjZiNl
         TZBk2nLmWOCK+1iT6UM8TCenz7KNQeP8c+/E9r2bPyT/Z3MeBPmnZUJwaSRuua30zE
         6qjj811TRZ4vi3zmnGfXMrqU/VFcVGDGT/aroupA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        coresight@lists.linaro.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 146/227] perf build: Fix library not found error when using CSLIBS
Date:   Tue, 25 Jul 2023 12:45:13 +0200
Message-ID: <20230725104520.926343410@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: James Clark <james.clark@arm.com>

[ Upstream commit 1feece2780ac2f8de45177fe53979726cee4b3d1 ]

-L only specifies the search path for libraries directly provided in the
link line with -l. Because -lopencsd isn't specified, it's only linked
because it's a dependency of -lopencsd_c_api. Dependencies like this are
resolved using the default system search paths or -rpath-link=... rather
than -L. This means that compilation only works if OpenCSD is installed
to the system rather than provided with the CSLIBS (-L) option.

This could be fixed by adding -Wl,-rpath-link=$(CSLIBS) but that is less
conventional than just adding -lopencsd to the link line so that it uses
-L. -lopencsd seems to have been removed in commit ed17b1914978eddb
("perf tools: Drop requirement for libstdc++.so for libopencsd check")
because it was thought that there was a chance compilation would work
even if it didn't exist, but I think that only applies to libstdc++ so
there is no harm to add it back. libopencsd.so and libopencsd_c_api.so
would always exist together.

Testing
=======

The following scenarios now all work:

 * Cross build with OpenCSD installed
 * Cross build using CSLIBS=...
 * Native build with OpenCSD installed
 * Native build using CSLIBS=...
 * Static cross build with OpenCSD installed
 * Static cross build with CSLIBS=...

Committer testing:

  ⬢[acme@toolbox perf-tools]$ alias m
  alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools -C tools/perf install-bin && git status && perf test python ;  perf record -o /dev/null sleep 0.01 ; perf stat --null sleep 0.01'
  ⬢[acme@toolbox perf-tools]$ ldd ~/bin/perf | grep csd
  	libopencsd_c_api.so.1 => /lib64/libopencsd_c_api.so.1 (0x00007fd49c44e000)
  	libopencsd.so.1 => /lib64/libopencsd.so.1 (0x00007fd49bd56000)
  ⬢[acme@toolbox perf-tools]$ cat /etc/redhat-release
  Fedora release 36 (Thirty Six)
  ⬢[acme@toolbox perf-tools]$

Fixes: ed17b1914978eddb ("perf tools: Drop requirement for libstdc++.so for libopencsd check")
Reported-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
Cc: coresight@lists.linaro.org
Closes: https://lore.kernel.org/linux-arm-kernel/56905d7a-a91e-883a-b707-9d5f686ba5f1@arm.com/
Link: https://lore.kernel.org/all/36cc4dc6-bf4b-1093-1c0a-876e368af183@kleine-koenig.org/
Link: https://lore.kernel.org/r/20230707154546.456720-1-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a794d9eca93d8..72f068682c9a2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -155,9 +155,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  OPENCSDLIBS += -lopencsd -lstdc++
+  OPENCSDLIBS += -lstdc++
 endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
-- 
2.39.2



