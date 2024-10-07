Return-Path: <stable+bounces-81455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC46993512
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CFC1C2229F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99318D642;
	Mon,  7 Oct 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plk7u9wL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4EF17740
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322326; cv=none; b=NYJ/r1U2DekMF8LJ5tTn270yP8qoyNxE4h4bqT87kC3/AwiB/frXnMPTtAXqV3TAvFWoPQALokJ1UIdeBG8zGCG87yKkoeCvdKj89z+EiOYmePj0aJA1JSPvNnIPHr77swmYEQlJ9gb/8GKLzitlV30e4WlYVXmFxH6zpGhGdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322326; c=relaxed/simple;
	bh=kB8bjkoXKSuM+q03lg/jZClREtSwGo51C58RLiv9kwo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tS4QpmH9lPMWDItXYEosntHS6+bRs5XMlYw0PzO39xOdc8nHK+DyTc4pfDfs9qYAbp2MNBuLtd4yastBvL4FxFjegY9EaI9vzOu+0UPooQOqB4Xcp1wOwGyqIFiWK/oE/2tyOcZNMsF/LK6dQYW5xQUj2S2kPfU//Vv3ekYh0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plk7u9wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E60C4CEC6;
	Mon,  7 Oct 2024 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322325;
	bh=kB8bjkoXKSuM+q03lg/jZClREtSwGo51C58RLiv9kwo=;
	h=Subject:To:Cc:From:Date:From;
	b=plk7u9wLNfKHfeEJ3COjEz1ijpZAYGWcKytY5BwB35bDGD5T7ywcIF0Fxyrv3e3fV
	 O/QgHQ9h+VSGgPY837P07DGzRQCpGhJjjp6NuOqMc7MThCMBNvRd/oPEef9OCm0Wh5
	 +qVZxwG55GZZUddNGuTMtkZTi8mG132myft3KywU=
Subject: FAILED: patch "[PATCH] rtla: Fix the help text in osnoise and timerlat top tools" failed to apply to 6.1-stable tree
To: ezulian@redhat.com,rostedt@goodmis.org,tglozar@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:32:02 +0200
Message-ID: <2024100702-paradox-neurology-6048@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3d7b8ea7a8a20a45d019382c4dc6ed79e8bb95cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100702-paradox-neurology-6048@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3d7b8ea7a8a2 ("rtla: Fix the help text in osnoise and timerlat top tools")
a957cbc02531 ("rtla: Add -C cgroup support")
9fa48a2477de ("rtla/timerlat: Add auto-analysis only option")
1f428356c38d ("rtla: Add hwnoise tool")
ce6cc6f70cad ("Documentation/rtla: Add timerlat-top auto-analysis options")
5def33df84d2 ("rtla/timerlat: Add auto-analysis support to timerlat top")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d7b8ea7a8a20a45d019382c4dc6ed79e8bb95cf Mon Sep 17 00:00:00 2001
From: Eder Zulian <ezulian@redhat.com>
Date: Tue, 13 Aug 2024 17:58:31 +0200
Subject: [PATCH] rtla: Fix the help text in osnoise and timerlat top tools

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

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2f756628613d..30e3853076a0 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -442,7 +442,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..210b0f533534 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -613,7 +613,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);


