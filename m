Return-Path: <stable+bounces-118347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B40A3CBF9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45A83B00C7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9972586D8;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EC1DC98A;
	Wed, 19 Feb 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002686; cv=none; b=D2cvBlQEoI9CjvfD86n3WGG8IGdJrpIjSoVyiOhF6b1nYwbQOVBAaFtMEiFao+nzr3/3zoeSs0y9aoXxj4kQ4dzaS/0EtnLYP1/bR51Ol+zqtBj4LhPs8X+QuZjjc9mhLaul/ltPObkuLNYSf9z/gahmZ/wQrrjlAogut06B97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002686; c=relaxed/simple;
	bh=Nc5G7cjo5t0C+ylkq05UMrUoS1JfeZk/+PH8rHYPIp0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EuVV5hM4gu4Jj5VXONLnMhbUMze0UZpYt/w/FQv0bTdRWBCLMZTgZZM5vu9bHX2fUr2oSwFhcNGS8kmHOh8o0PHAXF+IOS2Yld8zO7d/Ad/s1C1jG4Mkh3QAeO4TSsLtm/gZhV2Cpr5T2G6rPGaXXwo2iGBKqMCSliN3O/YUJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C17C4CEE7;
	Wed, 19 Feb 2025 22:04:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tksBr-00000004qce-0sAD;
	Wed, 19 Feb 2025 17:05:11 -0500
Message-ID: <20250219220511.054985490@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 17:04:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/5] ftrace: Do not add duplicate entries in subops manager ops
References: <20250219220436.498041541@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Check if a function is already in the manager ops of a subops. A manager
ops contains multiple subops, and if two or more subops are tracing the
same function, the manager ops only needs a single entry in its hash.

Cc: stable@vger.kernel.org
Fixes: 4f554e955614f ("ftrace: Add ftrace_set_filter_ips function")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 03b35a05808c..189eb0a12f4b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5717,6 +5717,9 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 			return -ENOENT;
 		free_hash_entry(hash, entry);
 		return 0;
+	} else if (__ftrace_lookup_ip(hash, ip) != NULL) {
+		/* Already exists */
+		return 0;
 	}
 
 	entry = add_hash_entry(hash, ip);
-- 
2.47.2



