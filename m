Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39F7D3422
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjJWLhA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjJWLg7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:36:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C86DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C7C433C9;
        Mon, 23 Oct 2023 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061016;
        bh=0CwH573QRe9laIkjVbMyk3hvEncudgkMUEzFbmv4SZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shlfP38mg8cKwzC3WuacBIWpjGZd+VL2nyaAIlk7Mwa1NSIJf60B2XcRet8wuLxdU
         KEIVqMWPnxjEKZSIXbX6muTldQzhy8Ht4u1uAds2hlWKEpQxVXBypqMZkPpPQ+kzZa
         dx7rhVHaED6uOyIJrXLR9vX8oiFA9AHuoj/Toymc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 044/137] neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
Date:   Mon, 23 Oct 2023 12:56:41 +0200
Message-ID: <20231023104822.517278043@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2915240eddba96b37de4c7e9a3d0ac6f9548454b upstream.

When CONFIG_IPV6=n, and building with W=1:

    In file included from include/trace/define_trace.h:102,
		     from include/trace/events/neigh.h:255,
		     from net/core/net-traces.c:51:
    include/trace/events/neigh.h: In function ‘trace_event_raw_event_neigh_create’:
    include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
       42 |                 struct in6_addr *pin6;
	  |                                  ^~~~
    include/trace/trace_events.h:402:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
      402 |         { assign; }                                                     \
	  |           ^~~~~~
    include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
       44 |                              PARAMS(assign),                   \
	  |                              ^~~~~~
    include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
       23 | TRACE_EVENT(neigh_create,
	  | ^~~~~~~~~~~
    include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
       41 |         TP_fast_assign(
	  |         ^~~~~~~~~~~~~~
    In file included from include/trace/define_trace.h:103,
		     from include/trace/events/neigh.h:255,
		     from net/core/net-traces.c:51:
    include/trace/events/neigh.h: In function ‘perf_trace_neigh_create’:
    include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
       42 |                 struct in6_addr *pin6;
	  |                                  ^~~~
    include/trace/perf.h:51:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
       51 |         { assign; }                                                     \
	  |           ^~~~~~
    include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
       44 |                              PARAMS(assign),                   \
	  |                              ^~~~~~
    include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
       23 | TRACE_EVENT(neigh_create,
	  | ^~~~~~~~~~~
    include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
       41 |         TP_fast_assign(
	  |         ^~~~~~~~~~~~~~

Indeed, the variable pin6 is declared and initialized unconditionally,
while it is only used and needlessly re-initialized when support for
IPv6 is enabled.

Fix this by dropping the unused variable initialization, and moving the
variable declaration inside the existing section protected by a check
for CONFIG_IPV6.

Fixes: fc651001d2c5ca4f ("neighbor: Add tracepoint to __neigh_create")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/neigh.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -39,7 +39,6 @@ TRACE_EVENT(neigh_create,
 	),
 
 	TP_fast_assign(
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->family = tbl->family;
@@ -47,7 +46,6 @@ TRACE_EVENT(neigh_create,
 		__entry->entries = atomic_read(&tbl->gc_entries);
 		__entry->created = n != NULL;
 		__entry->gc_exempt = exempt_from_gc;
-		pin6 = (struct in6_addr *)__entry->primary_key6;
 		p32 = (__be32 *)__entry->primary_key4;
 
 		if (tbl->family == AF_INET)
@@ -57,6 +55,8 @@ TRACE_EVENT(neigh_create,
 
 #if IS_ENABLED(CONFIG_IPV6)
 		if (tbl->family == AF_INET6) {
+			struct in6_addr *pin6;
+
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)pkey;
 		}


