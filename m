Return-Path: <stable+bounces-120685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A4A507E0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C61C1893EB0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B849250C14;
	Wed,  5 Mar 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s9EVfDnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818A1D6DB4;
	Wed,  5 Mar 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197678; cv=none; b=cFeUDAoWRkt2Zbdb8KriOnnxIcqpfIbvEYK9HIlLGmZQIhRQaXuqwp/MDYySCitFUAFDs6NyrzB3sxEAQ+Nk3Vt2NnEjNanSXs2U9NKiG3+GtonPpjtoTvrCnIbSPbCGFoDmDrW2h8YCvaI46gyyVXQxG4A+dlR77nbfjyh6TkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197678; c=relaxed/simple;
	bh=FJ0Oy/jftO4Fthfd1LlS38OsbywW6Zqrdbof+LG5oX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExxoLcWuHV9kUOU4Iq/kuajWrwGK6SG7nyD8NyZw7a8hVU0ZmhnZeEOlkGIf3s1oMdbPf3DF2odsWNS3qzyjnObw3xip1XTtftVH+3t3tTM5I2a1QeYbbp+pZoCUmXjx6wKKtQZd0HCHZq7qVmtChQNJc8MzNeZDmW6DpkBxlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s9EVfDnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B73C4CED1;
	Wed,  5 Mar 2025 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197676;
	bh=FJ0Oy/jftO4Fthfd1LlS38OsbywW6Zqrdbof+LG5oX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9EVfDnUXrtX2YpVVm+SMs/C2+d5eFS+ivKnB3mk+5QkWAU4u4dnxZRzupWMhkAM9
	 bTZxvEnt5YBl///3/vdsl+kXzIw9pj9HQ9hvBGXGA751NY72UjL430l3dxKNlIndUf
	 JVcIpKMz5iOfUJ0Bw8qgbd9d3DVAqoeIKzOMeCts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 061/142] tracing: Fix bad hist from corrupting named_triggers list
Date: Wed,  5 Mar 2025 18:48:00 +0100
Message-ID: <20250305174502.790136891@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Steven Rostedt <rostedt@goodmis.org>

commit 6f86bdeab633a56d5c6dccf1a2c5989b6a5e323e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_hist.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6660,27 +6660,27 @@ static int event_hist_trigger_parse(stru
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret < 0)
-		goto out_free;
+	if (!get_named_trigger_data(trigger_data)) {
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
 
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
 
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
+		ret = tracing_map_init(hist_data->map);
 		if (ret)
-			goto out_unreg;
+			goto out_free;
 	}
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;



