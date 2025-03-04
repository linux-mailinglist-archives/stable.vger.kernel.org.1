Return-Path: <stable+bounces-120271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D22A4E706
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C684235DA
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6006279329;
	Tue,  4 Mar 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNJkjUNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A72580E1
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105597; cv=none; b=Kl3hG+jVmJZpH0VYF++YjE3e6srhnKTsY3WKFxiK/Z8D233dRlvlApFazKG5OF3LkrC3zP30XTUzX5VjBVuiFlAH9HNJ6PYeGeLVj+YN2lH9w6p/tOWbGRLEB0CrFT+HD5TOjr/v20JQDfON+KzP9DY0FH+SmlbezuZMsp8vaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105597; c=relaxed/simple;
	bh=X8McTPmt0BAwEqGQoLbixCIRamw5uQhaUOl6ac3CR04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lKbmqflDMY/d1iRCojKReUii0p9qlWfVvQsFV3lPI9AoO2/817KLamgmiF6bz6uKhH5U+/qUcUctjCexM1XJSKSmq677gkPMDDRo4yu14hx4OBqi619qnRv32jfCKxCSs5osRDPCfuh9HpxqrVXGRtA5jLwQ9uUuMvv3A0TjD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gNJkjUNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E4C4CEE5;
	Tue,  4 Mar 2025 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105597;
	bh=X8McTPmt0BAwEqGQoLbixCIRamw5uQhaUOl6ac3CR04=;
	h=Subject:To:Cc:From:Date:From;
	b=gNJkjUNQ5TeDwgCJSRLUdvZxN9cL8/1upZTKC84nyARHgLLG3HIo8EY2UakCL9Idf
	 rWkxORTHIEucbcpg/ETncDjOYG/vH5BKPjA8Z5YpY6h3oM0f8jjbp+p70x96UG6pM0
	 7lE1WPhOkz/QikoH2qj1fKG1tyJG/A17lWHRL1yw=
Subject: FAILED: patch "[PATCH] tracing: Fix bad hist from corrupting named_triggers list" failed to apply to 5.15-stable tree
To: rostedt@goodmis.org,mathieu.desnoyers@efficios.com,mhiramat@kernel.org,tglozar@redhat.com,zanussi@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:26:34 +0100
Message-ID: <2025030434-prepaid-glisten-ba86@gregkh>
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
git cherry-pick -x 6f86bdeab633a56d5c6dccf1a2c5989b6a5e323e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030434-prepaid-glisten-ba86@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


