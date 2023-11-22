Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2417F4E38
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjKVRWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKVRWn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:22:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE283
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:22:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEF4C433C7;
        Wed, 22 Nov 2023 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673760;
        bh=26AO9xs2LQKrRaRm0a3FBZHA5edNXo99y6OE9oa+HLA=;
        h=Subject:To:Cc:From:Date:From;
        b=iCLPbc4kbTWOYcIJXES5Qe1CD6j9jmxR7NEuWxtYGrX4jY95cwJG0pu4Fh7AHZD6a
         CpVeEWv8RIkLPs3orTmfdTgBG0ulKslfwcE6hUesn9dn39cLFsiM8cuUcphMThzraw
         Wdag2+gD9jr21X1FL4qK6x1o6SXnXV9K1wRiaO2Y=
Subject: FAILED: patch "[PATCH] proc: sysctl: prevent aliased sysctls from getting passed to" failed to apply to 5.10-stable tree
To:     kjlx@templeofstupid.com, mcgrof@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:22:29 +0000
Message-ID: <2023112229-gosling-ditzy-fbf3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8001f49394e353f035306a45bcf504f06fca6355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112229-gosling-ditzy-fbf3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8001f49394e3 ("proc: sysctl: prevent aliased sysctls from getting passed to init")
1998f19324d2 ("fs: move pipe sysctls to is own file")
66ad398634c2 ("fs: move fs/exec.c sysctls into its own file")
d1d8ac9edf10 ("fs: move shared sysctls to fs/sysctls.c")
54771613e8a7 ("sysctl: move maxolduid as a sysctl specific const")
c8c0c239d5ab ("fs: move dcache sysctls to its own file")
204d5a24e155 ("fs: move fs stat sysctls to file_table.c")
1d67fe585049 ("fs: move inode sysctls to its own file")
b1f2aff888af ("sysctl: share unsigned long const values")
3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
2452dcb9f7f2 ("sysctl: use SYSCTL_ZERO to replace some static int zero uses")
d73840ec2f74 ("sysctl: use const for typically used max/min proc sysctls")
f628867da46f ("sysctl: make ngroups_max const")
bbe7a10ed83a ("hung_task: move hung_task sysctl interface to hung_task.c")
78e36f3b0dae ("sysctl: move some boundary constants from sysctl.c to sysctl_vals")
39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%")
6e7c1770a212 ("fs: simplify get_filesystem_list / get_all_fs_names")
f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice filesystems as root")
e24d12b7442a ("init: split get_fs_names")
08389d888287 ("bpf: Add kconfig knob for disabling unpriv bpf by default")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8001f49394e353f035306a45bcf504f06fca6355 Mon Sep 17 00:00:00 2001
From: Krister Johansen <kjlx@templeofstupid.com>
Date: Fri, 27 Oct 2023 14:46:40 -0700
Subject: [PATCH] proc: sysctl: prevent aliased sysctls from getting passed to
 init

The code that checks for unknown boot options is unaware of the sysctl
alias facility, which maps bootparams to sysctl values.  If a user sets
an old value that has a valid alias, a message about an invalid
parameter will be printed during boot, and the parameter will get passed
to init.  Fix by checking for the existence of aliased parameters in the
unknown boot parameter code.  If an alias exists, don't return an error
or pass the value to init.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 0a477e1ae21b ("kernel/sysctl: support handling command line aliases")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..1c9635dddb70 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1592,6 +1592,13 @@ static const char *sysctl_find_alias(char *param)
 	return NULL;
 }
 
+bool sysctl_is_alias(char *param)
+{
+	const char *alias = sysctl_find_alias(param);
+
+	return alias != NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 09d7429d67c0..61b40ea81f4d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -242,6 +242,7 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
+bool sysctl_is_alias(char *param);
 int do_proc_douintvec(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
@@ -287,6 +288,11 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
 static inline void do_sysctl_args(void)
 {
 }
+
+static inline bool sysctl_is_alias(char *param)
+{
+	return false;
+}
 #endif /* CONFIG_SYSCTL */
 
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
diff --git a/init/main.c b/init/main.c
index 436d73261810..e24b0780fdff 100644
--- a/init/main.c
+++ b/init/main.c
@@ -530,6 +530,10 @@ static int __init unknown_bootoption(char *param, char *val,
 {
 	size_t len = strlen(param);
 
+	/* Handle params aliased to sysctls */
+	if (sysctl_is_alias(param))
+		return 0;
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */

