Return-Path: <stable+bounces-104270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402049F22CB
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF434188548F
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5792B2F2;
	Sun, 15 Dec 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGw5Qj1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23302F42
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734253331; cv=none; b=eCkVymrFkGlFTh3O4UvAl31Uwe3Rv4qYilg/xYQ1PDayE8kVuDsDxN83NlZDJiv1+2db0LEiPfOHyGQUQnvEYdAlpRpenw+tPG6U9j9/dHjqVpsKP7WG1NC1Zwcg21liAWrhNKMpPKJ7fClC4ALoIscAkI3lEfP7Sv0lLBYSt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734253331; c=relaxed/simple;
	bh=lSRNQymgMCL0KQs+WdbhQBB0cwbktLXxIO+u/1Ve8xM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dgMfbvd4OJUe2Ex8Df2wIxpjrba/84BgXubJZ9CgptKa0L1fjOvSJTn+nbZtoP6UVE8aXh3c7FY/AJDMDuIcW1sHsMz8ntmWFabw0uNdycHqIv6Xw7zGyg53ZPXW5f+8U9mA70TIA/LgZkh3mUE7dVhWC/61tSf4YXsO4yfEi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGw5Qj1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA9BC4CECE;
	Sun, 15 Dec 2024 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734253330;
	bh=lSRNQymgMCL0KQs+WdbhQBB0cwbktLXxIO+u/1Ve8xM=;
	h=Subject:To:Cc:From:Date:From;
	b=hGw5Qj1Xv6bSExEVvgUYspUDOgrdxMkbJBK9ii74aQ2+4VP+BaUuSh95nQTxefwAA
	 5gIilngMuZROADoIttpJ9sdD1SeFZu8gZU83wgUe4JiHOaUGL8v7KAQzSHU2PMN1L0
	 6YWUaukZckvTdBfgOCIMn4kmZ0FqdDy+InUqDod4=
Subject: FAILED: patch "[PATCH] bpf,perf: Fix invalid prog_array access in" failed to apply to 5.15-stable tree
To: jolsa@kernel.org,andrii@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Dec 2024 10:02:07 +0100
Message-ID: <2024121506-pancreas-mosaic-0ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121506-pancreas-mosaic-0ae0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd Mon Sep 17 00:00:00 2001
From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 8 Dec 2024 15:25:07 +0100
Subject: [PATCH] bpf,perf: Fix invalid prog_array access in
 perf_event_detach_bpf_prog

Syzbot reported [1] crash that happens for following tracing scenario:

  - create tracepoint perf event with attr.inherit=1, attach it to the
    process and set bpf program to it
  - attached process forks -> chid creates inherited event

    the new child event shares the parent's bpf program and tp_event
    (hence prog_array) which is global for tracepoint

  - exit both process and its child -> release both events
  - first perf_event_detach_bpf_prog call will release tp_event->prog_array
    and second perf_event_detach_bpf_prog will crash, because
    tp_event->prog_array is NULL

The fix makes sure the perf_event_detach_bpf_prog checks prog_array
is valid before it tries to remove the bpf program from it.

[1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad

Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")
Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241208142507.1207698-1-jolsa@kernel.org

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a403b05a7091..1b8db5aee9d3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2250,6 +2250,9 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
+	if (!old_array)
+		goto put;
+
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
@@ -2258,6 +2261,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+put:
 	/*
 	 * It could be that the bpf_prog is not sleepable (and will be freed
 	 * via normal RCU), but is called from a point that supports sleepable


