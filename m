Return-Path: <stable+bounces-126811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CBA727A9
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 01:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0608817A498
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BCD1FC8;
	Thu, 27 Mar 2025 00:07:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94B36C;
	Thu, 27 Mar 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743034060; cv=none; b=RF+JbFlgnUBkCZhDWXodj5xwQWSg0LZAv0N8QiVnbAxm5EHIal69F2s6fJLPq/CmMqdyGF9YamUAy8gDcYk7D4h6KHfUhc7ph8mneBrN6dSX2J9Wz6rnCEVf+NbmbMNwm80wJLXSx6ZwW/b9nWjrfTqtSquIyIvOPAsmj8Yoj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743034060; c=relaxed/simple;
	bh=aWvBjCZrlZvpVpFDKgRmt1yjKxZq3Ipzl2MvNHRgijc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vmoerhoj5WKFbQkJE7FPAqlSnPV5AHV8HWWBuzhKpkasUwQsZdf1cpq+TBW7gbKGiYuvjhdICpc+sAyT/8amSon15DuDfwkv/BLtHV5KkSiVvpNTwvcCSyxKp/4FRVc2FoLCuT3EKm2Yovgo5Hv7zaytxwF+63sox7rskaxKBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699A0C4CEEA;
	Thu, 27 Mar 2025 00:07:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txanM-00000002uyu-0WXF;
	Wed, 26 Mar 2025 20:08:28 -0400
Message-ID: <20250327000827.980585561@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 20:08:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-next][PATCH 1/2] tracing: Fix synth event printk format for str fields
References: <20250327000811.879041980@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Douglas Raillard <douglas.raillard@arm.com>

The printk format for synth event uses "%.*s" to print string fields,
but then only passes the pointer part as var arg.

Replace %.*s with %s as the C string is guaranteed to be null-terminated.

The output in print fmt should never have been updated as __get_str()
handles the string limit because it can access the length of the string in
the string meta data that is saved in the ring buffer.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 8db4d6bfbbf92 ("tracing: Change synthetic event string format to limit printed length")
Link: https://lore.kernel.org/20250325165202.541088-1-douglas.raillard@arm.com
Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index a5c5f34c207a..6d592cbc38e4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -305,7 +305,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%.*s";
+		fmt = "%s";
 	else if (synth_field_is_stack(type))
 		fmt = "%s";
 
-- 
2.47.2



