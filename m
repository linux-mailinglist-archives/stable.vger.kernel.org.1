Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB43703993
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbjEORnt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjEORne (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E111624
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DCF62E3F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7192C433EF;
        Mon, 15 May 2023 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172461;
        bh=WzX49OhwakmUby6LoSKSVcP9ojRGrNGMXs2Kok2j3oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0W+Ly56sEurdL4bDhb1vae7mmX3HbZAD0NoFdoicUcJXUPkgtdrEUX6PgiDMAtb0
         sf/c2YaNyosel5GPgiUwPUjHAeR3eYZZpalrGQNtDj+INLZuEKOfU7/3/7Te5Se1J/
         mfo863Nz8lWFdzjwqsD8J4ZjZbyBXQfpUAe7wtQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Manivannan Sadhasivam <mani@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 159/381] net: qrtr: correct types of trace event parameters
Date:   Mon, 15 May 2023 18:26:50 +0200
Message-Id: <20230515161743.996934270@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Simon Horman <horms@kernel.org>

[ Upstream commit 054fbf7ff8143d35ca7d3bb5414bb44ee1574194 ]

The arguments passed to the trace events are of type unsigned int,
however the signature of the events used __le32 parameters.

I may be missing the point here, but sparse flagged this and it
does seem incorrect to me.

  net/qrtr/ns.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/qrtr.h):
  ./include/trace/events/qrtr.h:11:1: warning: cast to restricted __le32
  ./include/trace/events/qrtr.h:11:1: warning: restricted __le32 degrades to integer
  ./include/trace/events/qrtr.h:11:1: warning: restricted __le32 degrades to integer
  ... (a lot more similar warnings)
  net/qrtr/ns.c:115:47:    expected restricted __le32 [usertype] service
  net/qrtr/ns.c:115:47:    got unsigned int service
  net/qrtr/ns.c:115:61: warning: incorrect type in argument 2 (different base types)
  ... (a lot more similar warnings)

Fixes: dfddb54043f0 ("net: qrtr: Add tracepoint support")
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230402-qrtr-trace-types-v1-1-92ad55008dd3@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/qrtr.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/qrtr.h b/include/trace/events/qrtr.h
index b1de14c3bb934..441132c67133f 100644
--- a/include/trace/events/qrtr.h
+++ b/include/trace/events/qrtr.h
@@ -10,15 +10,16 @@
 
 TRACE_EVENT(qrtr_ns_service_announce_new,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -36,15 +37,16 @@ TRACE_EVENT(qrtr_ns_service_announce_new,
 
 TRACE_EVENT(qrtr_ns_service_announce_del,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -62,15 +64,16 @@ TRACE_EVENT(qrtr_ns_service_announce_del,
 
 TRACE_EVENT(qrtr_ns_server_add,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
-- 
2.39.2



