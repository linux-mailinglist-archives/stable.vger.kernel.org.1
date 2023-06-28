Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B6741C23
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 01:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjF1XE6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF1XEt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 19:04:49 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B806410FE
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:04:47 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1628B200BB9
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:04:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AE9B9200BA2
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 23:04:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687993485; a=rsa-sha256;
        cv=none;
        b=quA9YlaepaOlJ1GRjPFUVxwrco97kgG/FfeNzK7Q5nidnRo9Eaf05dVbvNsgY2pAxdrAjM
        8Ks7OuhMDW1CzFucxjYtDF8O4n25xTarphzNfOrircErzhjJMquEUYo5R5AjtHV4qerv4e
        TrjitygtEJ1ZenWcH47KvOCAXuFWeMM7K1mD1c5IwgEry6CuC4O4ufr7HFpZ7KfZYSTKpR
        0NtzXtbh27QE7vXRtyGdejveJkQ8b9ZXP+XxBMp88ehwKyqyOR4bpQIiRlXH2/VJUrlUPz
        HhaBmSpQELXGK/ggPtxshrNuqypYBmLTwOGzbO1ivxLHyGV7SskFNC7hEDveZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687993485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=1bezz8N3KbI2RDwtxQgXeC2aSa6AQr1ssVT8f/HSD7c=;
        b=JJrh1j2ZFZlBCIF9v2oBbKVIGNlbTro1T4GFuwMFqpInCPbrz3pp/VLi0A/adCDqxAcsJt
        fa52bJYXHTf5l3wHe10IUl5s9qEeplZ8DrFwGCXu/ntstRCHMiefgmeDZxDfYjPWBSjJkH
        5/4PfTOLQO73DrzCbFZJsEQ1HAk99EfhujQzrcTbrJppDc6TfgIbeZojpiiP1jJQr7M3om
        eqg/Kw7SVu0xQ/U8xN1Eon8NtoQc+AlXrd1lFLD3+gYOBp5kZUrZA3uwRri0lp7IFhuqws
        t+Uejf5sStc/h5uQO3bHN88l7iGbx3IoRuAdcOI5Vp0tNFGUmEvigo8TQiWARg==
ARC-Authentication-Results: i=1;
        rspamd-85899d6fcc-r85vc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Desert-Left: 716c4b4860b097e3_1687993485926_66195201
X-MC-Loop-Signature: 1687993485926:145886681
X-MC-Ingress-Time: 1687993485925
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.143 (trex/6.9.1);
        Wed, 28 Jun 2023 23:04:45 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4Qrxx92yZFzVH
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1687993485;
        bh=1bezz8N3KbI2RDwtxQgXeC2aSa6AQr1ssVT8f/HSD7c=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bQGKtWBVcJQXNFdt1DkrCY0yT1t953eisQY6VO81dz/dypDKC2tT1vO9UgodeZbl9
         UVoIYIQObhTv/hwNWBB7poYs4oURaceYNeO0jS9leL4HKSJWUlf+gaibTFbTQuy9Dl
         67B14oPfc11MY0REwlQSdOhHP3e7Cj5fIHppRzuE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e003b
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 28 Jun 2023 16:04:35 -0700
Date:   Wed, 28 Jun 2023 16:04:35 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Reaver <me@davidreaver.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15.y] perf symbols: Symbol lookup with kcore can fail if
 multiple segments match stext
Message-ID: <20230628230435.GD1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 tools/perf/util/symbol.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b1e5fd99e38a..80c54196e0e4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1357,10 +1357,23 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
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
-- 
2.25.1

