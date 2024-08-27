Return-Path: <stable+bounces-71009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438F961125
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27191F24467
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11B1C8FDD;
	Tue, 27 Aug 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9/YPWzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227E1C8FC4;
	Tue, 27 Aug 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771794; cv=none; b=F454aR5jgZBeOHiTaAXwtBvYulFfIjxRkR+hLBNcEmxHpNLQzmT62oMfNHseJ4UjKtWCx9yU9ilahNUU2tERR8/k1sft53UndUJ8zs5dCBhTyu+tYk0xokCkfI7FSl8JuYnSkFq76ekk6fhCFihw5XsDHb29vjJpDUL+DyDVdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771794; c=relaxed/simple;
	bh=n28mZzZLRSASG3EFkrKENjPfcCNpurvWmcf/hadaLag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlGL6myeugSsk601XlKjyn02p7tr5OW1VtJuaUuNaleP5sEs1NotKHxhWvRgE3+gIjd14S4cvzFrBy18PEyrexSRIfdT/O7QCoO2/LzNlQuc0PsfAoFCr5TKt5PsLeh3z8Yu59BihldpFTzL1mHbq6Xk7WZC8bf8JD9e8/26vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9/YPWzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AC8C4DE16;
	Tue, 27 Aug 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771793;
	bh=n28mZzZLRSASG3EFkrKENjPfcCNpurvWmcf/hadaLag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9/YPWzGI+qlloZscZVcRFi0RhibpxJTeB9hgs/CKTecYulK6AZat8fLFNmVbZtjQ
	 duxdbYBTk86NGy1XRAXrgCmQyn1Gqx9gPA6Xv9+M4A3zCFjc0J+DrtL+Y2mlTTwBzl
	 LSuxmH2fZkd9xIKejGVCseiADrARYETbMzl4WLPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 022/321] rtla/osnoise: Prevent NULL dereference in error handling
Date: Tue, 27 Aug 2024 16:35:30 +0200
Message-ID: <20240827143839.056124610@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 90574d2a675947858b47008df8d07f75ea50d0d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/tracing/rtla/src/osnoise_top.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -520,8 +520,10 @@ struct osnoise_tool *osnoise_init_top(st
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -529,11 +531,6 @@ struct osnoise_tool *osnoise_init_top(st
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;



