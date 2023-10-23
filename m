Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AD7D319A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjJWLLB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJWLLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38497FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:10:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42524C433C7;
        Mon, 23 Oct 2023 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059456;
        bh=nzRpaXyFnm1ZNeeAgkETRyZpsHCwkQNCuDFEJ9HICog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKyvddbS6RQuaWfEUvmoDTZXmoqToAouaZStMdOCeGo9Q6/aBw/c+XwoHVi3W0RRm
         iOOaTXd2DbJCfJYPdmZsmYqWsMn++tUNHLzQbt94AU4xq/KbY2tNi6HuysFpECTnJZ
         dMSxLx0leL7SWL0tw8405sox2iuS0lLxFgbQTF34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 6.5 184/241] perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
Date:   Mon, 23 Oct 2023 12:56:10 +0200
Message-ID: <20231023104838.368460241@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 7a48b58eb5ff3798f0480d2da16bf27df9654fc7 upstream.

Stop calling addr_location__exit() when addr_location__init() was not
called.

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20230928071605.17624-1-adrian.hunter@intel.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/dlfilter.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -280,13 +280,21 @@ static struct perf_event_attr *dlfilter_
 	return &d->evsel->core.attr;
 }
 
+static __s32 code_read(__u64 ip, struct map *map, struct machine *machine, void *buf, __u32 len)
+{
+	u64 offset = map__map_ip(map, ip);
+
+	if (ip + len >= map__end(map))
+		len = map__end(map) - ip;
+
+	return dso__data_read_offset(map__dso(map), machine, offset, buf, len);
+}
+
 static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 {
 	struct dlfilter *d = (struct dlfilter *)ctx;
 	struct addr_location *al;
 	struct addr_location a;
-	struct map *map;
-	u64 offset;
 	__s32 ret;
 
 	if (!d->ctx_valid)
@@ -296,27 +304,17 @@ static __s32 dlfilter__object_code(void
 	if (!al)
 		return -1;
 
-	map = al->map;
-
-	if (map && ip >= map__start(map) && ip < map__end(map) &&
+	if (al->map && ip >= map__start(al->map) && ip < map__end(al->map) &&
 	    machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
-		goto have_map;
+		return code_read(ip, al->map, d->machine, buf, len);
 
 	addr_location__init(&a);
+
 	thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
-	if (!a.map) {
-		ret = -1;
-		goto out;
-	}
-
-	map = a.map;
-have_map:
-	offset = map__map_ip(map, ip);
-	if (ip + len >= map__end(map))
-		len = map__end(map) - ip;
-	ret = dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
-out:
+	ret = a.map ? code_read(ip, a.map, d->machine, buf, len) : -1;
+
 	addr_location__exit(&a);
+
 	return ret;
 }
 


