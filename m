Return-Path: <stable+bounces-53616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2841E90D317
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416A41C22B85
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4EA15573D;
	Tue, 18 Jun 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XrJ8cNvD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40715573A
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717627; cv=none; b=EOq3oVaqE+FCp/G2Q9pWrrUaUk/ZMmiwKEO+JADONGgx53oohpgxxhI5RWgnCltsILcmiZ/qm7itPwoyqb5FvvvlQT34FvWnIjOvi6dDIZF6l82UsNPxg9Rs3Im2QtcJ4sO1vjQ5IjjDSay2JQ/2bKMNOn8ax7n3KqBYzbiMKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717627; c=relaxed/simple;
	bh=Tvma0SGYFvzy+pcOKVEDU2wUbY6MC18qPU4o7OOzTrA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Er2WpOi8SglwHEuNk6JJ5X4qXs2sk6xfanDHs8Vv00RdiaX0rQHXME7Reaqnld5QJIk7z3gHB30B9l3K8hHpCGLE+PuI2V6DmFw0bSz51npYarbo1kCSIBbvZcisQMEs7CAygSS8Xi1J7LsdS7MjCXPHQ+DkehHSrlBgK1wa83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XrJ8cNvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50163C3277B;
	Tue, 18 Jun 2024 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717626;
	bh=Tvma0SGYFvzy+pcOKVEDU2wUbY6MC18qPU4o7OOzTrA=;
	h=Subject:To:Cc:From:Date:From;
	b=XrJ8cNvDubaqGitaso+kMluwOtr04gqETU6pqBpYhMnuEIY3jA4jBuxdDNLjtcwYZ
	 4emT8KhDlGetE9V3afN1OzxFoErvI0DWfLCWVuXN6XZmpgGK802Bu+t+5WZiIYnk88
	 dkCaVu0K9NWULpGKmeTCiGFl7GlgHPH2QBHY3guc=
Subject: FAILED: patch "[PATCH] perf script: Show also errors for --insn-trace option" failed to apply to 6.6-stable tree
To: adrian.hunter@intel.com,acme@redhat.com,ak@linux.intel.com,irogers@google.com,jolsa@kernel.org,namhyung@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:24:30 +0200
Message-ID: <2024061830-barmaid-tassel-308b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d4a98b45fbe6d06f4b79ed90d0bb05ced8674c23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061830-barmaid-tassel-308b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d4a98b45fbe6 ("perf script: Show also errors for --insn-trace option")
6750ba4b6442 ("perf: script: add raw|disasm arguments to --insn-trace option")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4a98b45fbe6d06f4b79ed90d0bb05ced8674c23 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 15 Mar 2024 09:13:33 +0200
Subject: [PATCH] perf script: Show also errors for --insn-trace option

The trace could be misleading if trace errors are not taken into
account, so display them also by adding the itrace "e" option.

Note --call-trace and --call-ret-trace already add the itrace "e"
option.

Fixes: b585ebdb5912cf14 ("perf script: Add --insn-trace for instruction decoding")
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240315071334.3478-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 37088cc0ff1b..2e7148d667bd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3806,7 +3806,7 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	itrace_parse_synth_opts(opt, "i0ns", 0);
+	itrace_parse_synth_opts(opt, "i0nse", 0);
 	symbol_conf.nanosecs = true;
 	return 0;
 }


