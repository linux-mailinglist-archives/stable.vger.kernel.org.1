Return-Path: <stable+bounces-206374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E038CD04117
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75CB930146F8
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4FF1ADFE4;
	Thu,  8 Jan 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX0agM4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2419C542;
	Thu,  8 Jan 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887468; cv=none; b=C5ASM8W2rVKeM1EX4Bh43bN/XxnoR0kCtm40Gb1PJS2Tzy4gdyUJr5L2YmsctsLgcDsOWqGmtiOn50qBZD/XZWslq6r1Sn6s9lOaSTgEQjapFbp+qPCgvt62EY8DcB+uQY6biYaI9x5Inh1r39o9Iqt/xTbF/YrR5V0O2OJNrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887468; c=relaxed/simple;
	bh=GqxfLbnQfCeCQ5wwG5VD+VZ0mhegohzl1/3768Fqus4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YNx2nNDJYLg8YjnPpD3Zdaei8D7gM6bDBTBir8MyojGxY+HkTn2MMJPKZIanLtorlBp7WIK8tB2EY/NMK86+aIO+WlTYXs0ZpgoIF7CxmcQ199l/ZD6Ug1Uft7jtRSt+4EzNqQg9NA5aRPHrlDrXeX2vKxV7gFG094U3xW+inT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX0agM4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF166C116D0;
	Thu,  8 Jan 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887468;
	bh=GqxfLbnQfCeCQ5wwG5VD+VZ0mhegohzl1/3768Fqus4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mX0agM4Q7i9ZzHqJC3HVKZwA8N6iF0/a7qYzyep0quYoJL9qd2DAQDMeMtSPM1QZ7
	 MCPqtdmJTIr+7IuXSvSnoAqUssTO68UG8k03h3mxQhPcFSNxzAVW1CUWEV2kQUpo7P
	 B/NhpR0uzD2vG3gbaUUWktBsaHj03ufqs+bOckm71nmb5cOGbGOm+LuTlP+mRXDbV8
	 ADVDhX749aEu3z0wYuDBUyFxfAXXTz3PbD4QmAlI40r8C4DDoHWb59FqyyfdLGc11G
	 oOZzpqm7rvBcXRJ4YzZs/brIHEQwgwF9qBJunleIJYmwfuk1Wl6Ky6SfvBynIZqoBp
	 G4pOJ+DlZwMWQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vdsIU-00000004aVY-1kAc;
	Thu, 08 Jan 2026 10:51:38 -0500
Message-ID: <20260108155138.210174240@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 08 Jan 2026 10:51:23 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [for-linus][PATCH 3/5] ftrace: Make ftrace_graph_ent depth field signed
References: <20260108155120.023038025@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code has integrity checks to make sure that depth never goes below
zero. But the depth field has recently been converted to unsigned long
from "int" (for alignment reasons). As unsigned long can never be less
than zero, the integrity checks no longer work.

Convert depth to long from unsigned long to allow the integrity checks to
work again.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: pengdonglin <pengdonglin@xiaomi.com>
Link: https://patch.msgid.link/20260102143148.251c2e16@gandalf.local.home
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aS6kGi0maWBl-MjZ@stanley.mountain/
Fixes: f83ac7544fbf7 ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 770f0dc993cc..a3a8989e3268 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1167,7 +1167,7 @@ static inline void ftrace_init(void) { }
  */
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
-	unsigned long depth;
+	long depth; /* signed to check for less than zero */
 } __packed;
 
 /*
-- 
2.51.0



