Return-Path: <stable+bounces-82962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC6994FAB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876081F23D26
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0941DEFF6;
	Tue,  8 Oct 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lB5v8uQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CA1D9A43;
	Tue,  8 Oct 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394018; cv=none; b=CmmSaRMdRBIxo92iZAB6BVIiwKVyYYQNcD76H4q4XmdaeuT6/kNR8E0pMa2BklfxX+wZ5oC0mU2eiDjFRMNS0MPzpNWiM+lZrFq6d87F8uOIYq6IQdDzTqSfqTpfjaIomHZGhSdVoqPEne2W2/uN+0nRZAWLLgeW+Pn4FAVfsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394018; c=relaxed/simple;
	bh=/OjirSvEQhU6eEPAGIqwjEpean7Sf4rf1A6bsBOerKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpfR09pujPMxQNfKMsevo2F/xZwjcSdTgS0WPGSuCzDojSKydS189/0/z/oDeNm2aWxNt+y0BABG0lKQFeCG8ccno+hQvEoKoCGUcIgKEjPEH5MkwHdSglXLVzVSmg9d6DCK4Q1WamsRK5pSfGOjl7rFugOjRqPH4F/4qrGNg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lB5v8uQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89018C4CEC7;
	Tue,  8 Oct 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728394018;
	bh=/OjirSvEQhU6eEPAGIqwjEpean7Sf4rf1A6bsBOerKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lB5v8uQjbZeKTB2is2mwVokjwRu9G80uRDIJz1ARSGm32eKuaW5F+wgOhm1bqrFqw
	 pwaCkXcX2IMQykXiiJbgJiv5TWoWGEWyBD0BIsoTBQexLL5d5iQgnJklyPn/X+E71l
	 UaghDTvE0naAUKDMnZpv9NA/JquTa1nlMSjYICVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 321/386] rtla: Fix the help text in osnoise and timerlat top tools
Date: Tue,  8 Oct 2024 14:09:26 +0200
Message-ID: <20241008115642.017184716@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eder Zulian <ezulian@redhat.com>

commit 3d7b8ea7a8a20a45d019382c4dc6ed79e8bb95cf upstream.

The help text in osnoise top and timerlat top had some minor errors
and omissions. The -d option was missing the 's' (second) abbreviation and
the error message for '-d' used '-D'.

Cc: stable@vger.kernel.org
Fixes: 1eceb2fc2ca54 ("rtla/osnoise: Add osnoise top mode")
Fixes: a828cd18bc4ad ("rtla: Add timerlat tool and timelart top mode")
Link: https://lore.kernel.org/20240813155831.384446-1-ezulian@redhat.com
Suggested-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/tracing/rtla/src/osnoise_top.c  |    2 +-
 tools/tracing/rtla/src/timerlat_top.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -428,7 +428,7 @@ struct osnoise_top_params *osnoise_top_p
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -339,7 +339,7 @@ static void timerlat_top_usage(char *usa
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -485,7 +485,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);



