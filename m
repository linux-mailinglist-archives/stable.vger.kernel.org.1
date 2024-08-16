Return-Path: <stable+bounces-69325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929595488C
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C8E28304D
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB41B1417;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E581A01CF;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810574; cv=none; b=XwGIjgFxcgfGru/+/sAgptH6PzHLYNKQYUXSgDxehxHAuNyiBbRfZiWQeL+r2QZybdyk7el34rwG3146kQHUzqjODIq9kt/bM4oofi/wObKknBas3TzTsDDamvQTLK309t61jJ5sFvlH8E9xXF81+IfQkstVw9O+2QZG+n4pRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810574; c=relaxed/simple;
	bh=Bpv7EIcuRzwo5wC699g8hbXTAngWqZU6pJ/cl90AzQ0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cPycHzB1fvsReRasSe65HG08Mdg4N+RkRtmm2Wv4oq6euWJc4MOExWbdxgOtqHg//D4tDJFuZFRMPiXDrX0lUuWAQhXZiU3epzGijjRv7NhQnrsO3QVMhzu0NlcQUdwnbNyvepZzbKSSJwQlxgfBVN2mW3rXSa5/sLqqECYWE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CE9C4AF10;
	Fri, 16 Aug 2024 12:16:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sevse-000000024CC-1if2;
	Fri, 16 Aug 2024 08:16:32 -0400
Message-ID: <20240816121632.274981284@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 16 Aug 2024 08:16:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [for-linus][PATCH 2/2] rtla/osnoise: Prevent NULL dereference in error handling
References: <20240816121611.805849825@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Dan Carpenter <dan.carpenter@linaro.org>

If the "tool->data" allocation fails then there is no need to call
osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Link: https://lore.kernel.org/f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f594a44df840..2f756628613d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;
-- 
2.43.0



