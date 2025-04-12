Return-Path: <stable+bounces-132330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02EA86FBD
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0348017C71A
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAC22B597;
	Sat, 12 Apr 2025 21:03:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83374227B8E;
	Sat, 12 Apr 2025 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491823; cv=none; b=jB+gDBDK8JwiVDZUdY9AJ+AlRL6xLKRqmuwB4wjVTM4TX7HpOFj26AH9LJgqs72kqejobiFD+H+EQ7abPoE1i3aG7s9+V1mEADOZWGCEpX8fC//ao1MaJt6J4g/6wkb0PM6YywoZ7V9iRVWr3Khxi0vm0tOSCQpUeWilBIU+Yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491823; c=relaxed/simple;
	bh=z8sTYKbHMCcEu+d5dLCKvRyatcQgaCISPyMbtmKmOSg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cUi5qP1PWBq01LttU9PPNx3d7pjK2cThpSBxPn1OFGKBgORUPLf8kAIG+N4lP2HtzJNI/rId8M5xX62Ekg0QMHv/upp3T70QAXJZKHQBXZZQzSiyC2WMuyXxhrR0i+b6U665LMc58BLjiDA46C9Jb5JNh1TDW+QRIij3OlX8avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F91CC4CEEE;
	Sat, 12 Apr 2025 21:03:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u3i2J-0000000AEGK-1y8E;
	Sat, 12 Apr 2025 17:05:11 -0400
Message-ID: <20250412210511.320072168@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 12 Apr 2025 17:04:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-linus][PATCH 7/7] rv: Fix out-of-bound memory access in rv_is_container_monitor()
References: <20250412210446.338481957@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

When rv_is_container_monitor() is called on the last monitor in
rv_monitors_list, KASAN yells:

  BUG: KASAN: global-out-of-bounds in rv_is_container_monitor+0x101/0x110
  Read of size 8 at addr ffffffff97c7c798 by task setup/221

  The buggy address belongs to the variable:
   rv_monitors_list+0x18/0x40

This is due to list_next_entry() is called on the last entry in the list.
It wraps around to the first list_head, and the first list_head is not
embedded in struct rv_monitor_def.

Fix it by checking if the monitor is last in the list.

Cc: stable@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
Link: https://lore.kernel.org/e85b5eeb7228bfc23b8d7d4ab5411472c54ae91b.1744355018.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 968c5c3b0246..e4077500a91d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -225,7 +225,12 @@ bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
  */
 bool rv_is_container_monitor(struct rv_monitor_def *mdef)
 {
-	struct rv_monitor_def *next = list_next_entry(mdef, list);
+	struct rv_monitor_def *next;
+
+	if (list_is_last(&mdef->list, &rv_monitors_list))
+		return false;
+
+	next = list_next_entry(mdef, list);
 
 	return next->parent == mdef->monitor || !mdef->monitor->enable;
 }
-- 
2.47.2



