Return-Path: <stable+bounces-120272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A1A4E9A7
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A18C2CE2
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA9279349;
	Tue,  4 Mar 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PFRqhZxI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54372580E1
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105607; cv=none; b=KVZt77vgZYIrl+8+QfhsG4ZttoWBLGiW0RsPOekhJvx70GNyZa7+0ZHO3z7gQu4MTcM6IU5IZLFB07KDYxEJ66OahD+cubgvhMmSCmuVMyqbYQYznYh92HcR1ZW9vPsvC5DJPHU/npRa8mkkSy9mkb8BYWYl/QWVSMKP+87LeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105607; c=relaxed/simple;
	bh=W+DW7yAVVTrVQKOc+UGJiak7A4BgcHjybDHl/YSKSzw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UXGt3uwlf0t9yJc0iLNoFd+H1QwiPIAQSyGOofS6v2Qu7J+wWp4xYdwk/ZulVsJbrSKB2hByi1TJcsUiFaq4KOJ53miBx+7mGsOsHk7JGtZ2Yg+lt/ObD6dLSAeOPpRhjbA/BU2J3s+DHgehRHDRH9sYBS8FjxPMGsao9gLrQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PFRqhZxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5BC4CEE5;
	Tue,  4 Mar 2025 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105606;
	bh=W+DW7yAVVTrVQKOc+UGJiak7A4BgcHjybDHl/YSKSzw=;
	h=Subject:To:Cc:From:Date:From;
	b=PFRqhZxICXAm1tehkSZz5z0wlqAbJa94tGsKxNVxMPSYS95VZ6IRAEiR9DckCL1q9
	 ZtU+71qtmOUEEYwrc1jXq3HK9Ck57Sv1+AqJaDu0fGcD3ZV1GK/vJxZy+TuX7ItnCZ
	 a9VpmYDPQyt559SxA5k7qnxO5mT+lt7G2p+0rV2o=
Subject: FAILED: patch "[PATCH] tracing: Fix bad hist from corrupting named_triggers list" failed to apply to 5.10-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,tglozar@redhat.com,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:26:35 +0100
Message-ID: <2025030435-impurity-modular-98f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6f86bdeab633a56d5c6dccf1a2c5989b6a5e323e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030435-impurity-modular-98f0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f86bdeab633a56d5c6dccf1a2c5989b6a5e323e Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 27 Feb 2025 16:39:44 -0500
Subject: [PATCH] tracing: Fix bad hist from corrupting named_triggers list

The following commands causes a crash:

 ~# cd /sys/kernel/tracing/events/rcu/rcu_callback
 ~# echo 'hist:name=bad:keys=common_pid:onmax(bogus).save(common_pid)' > trigger
 bash: echo: write error: Invalid argument
 ~# echo 'hist:name=bad:keys=common_pid' > trigger

Because the following occurs:

event_trigger_write() {
  trigger_process_regex() {
    event_hist_trigger_parse() {

      data = event_trigger_alloc(..);

      event_trigger_register(.., data) {
        cmd_ops->reg(.., data, ..) [hist_register_trigger()] {
          data->ops->init() [event_hist_trigger_init()] {
            save_named_trigger(name, data) {
              list_add(&data->named_list, &named_triggers);
            }
          }
        }
      }

      ret = create_actions(); (return -EINVAL)
      if (ret)
        goto out_unreg;
[..]
      ret = hist_trigger_enable(data, ...) {
        list_add_tail_rcu(&data->list, &file->triggers); <<<---- SKIPPED!!! (this is important!)
[..]
 out_unreg:
      event_hist_unregister(.., data) {
        cmd_ops->unreg(.., data, ..) [hist_unregister_trigger()] {
          list_for_each_entry(iter, &file->triggers, list) {
            if (!hist_trigger_match(data, iter, named_data, false))   <- never matches
                continue;
            [..]
            test = iter;
          }
          if (test && test->ops->free) <<<-- test is NULL

            test->ops->free(test) [event_hist_trigger_free()] {
              [..]
              if (data->name)
                del_named_trigger(data) {
                  list_del(&data->named_list);  <<<<-- NEVER gets removed!
                }
              }
           }
         }

         [..]
         kfree(data); <<<-- frees item but it is still on list

The next time a hist with name is registered, it causes an u-a-f bug and
the kernel can crash.

Move the code around such that if event_trigger_register() succeeds, the
next thing called is hist_trigger_enable() which adds it to the list.

A bunch of actions is called if get_named_trigger_data() returns false.
But that doesn't need to be called after event_trigger_register(), so it
can be moved up, allowing event_trigger_register() to be called just
before hist_trigger_enable() keeping them together and allowing the
file->triggers to be properly populated.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250227163944.1c37f85f@gandalf.local.home
Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist triggers")
Reported-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Closes: https://lore.kernel.org/all/CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 261163b00137..ad7419e24055 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6724,27 +6724,27 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
+	if (!get_named_trigger_data(trigger_data)) {
+
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
+
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
+
+		ret = tracing_map_init(hist_data->map);
+		if (ret)
+			goto out_free;
+	}
+
 	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
 	if (ret < 0)
 		goto out_free;
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
-
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
-
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
-		if (ret)
-			goto out_unreg;
-	}
-
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;


