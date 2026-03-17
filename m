Return-Path: <stable+bounces-225980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG4wDlpRuWkoAgIAu9opvQ
	(envelope-from <stable+bounces-225980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:04:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D92AA67A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37822304A272
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEC3C8725;
	Tue, 17 Mar 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTBRl/l3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328C3C7DEE
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752422; cv=none; b=Hg62jpGuNPTXtylBi4mpOjKXM2IdOFFoigUwN2+ebdQdWxSYiOdzO1j2yJGnPLBxwr35fWLXKz4qmx/tXW4RXgunCXUGeZ5PwF0xWV6JzWKZoVtBySHcLxsgSt5TCXV9JaneJw+EUyYF3k80BmxIGmZE3NyyuZMz0uHhsV5Bdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752422; c=relaxed/simple;
	bh=0sRXRYh8focqQsB6bYrdVA5Zy7Lpr3Vje1yc+a/sBKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yg1YcMPj61CFlWhimhxvidIFnRx+CK1xY/X9hqCOyp8lKUTGWiufOKtDaZvhP4mjLsrxDbTIRQ06wue2t+noQRd6Xw7zKdTFfyAqwOKxdj4cPSnkf62jU/pkK4FBiSgbBC1ToRKXhInSnR/kAqdOt6z1049QzVBTbpCJT5Mj3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTBRl/l3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B21C4CEF7;
	Tue, 17 Mar 2026 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752421;
	bh=0sRXRYh8focqQsB6bYrdVA5Zy7Lpr3Vje1yc+a/sBKw=;
	h=Subject:To:Cc:From:Date:From;
	b=mTBRl/l3ZzaZNtObcDhiD9kV450dnwPi2qqbbiYOyIenpQPkqDj0+Sr/BhM7gUHMh
	 lb7WWi5CnH7F72XhustA1TUDY6uJ/Zo49mSAk4ldXIkuzsAT/Dxhgkx7LyS7ca4zsw
	 Nn5bjjgYGpUiiyy/IPJp/OChQie6Aw4yH2vkNWpE=
Subject: FAILED: patch "[PATCH] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org,shicenci@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:00:02 +0100
Message-ID: <2026031702-gesture-tragedy-2d56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225980-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 303D92AA67A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5ef268cb7a0aac55521fd9881f1939fa94a8988e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031702-gesture-tragedy-2d56@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ef268cb7a0aac55521fd9881f1939fa94a8988e Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Mar 2026 23:04:11 +0900
Subject: [PATCH] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()

Remove unneeded warnings for handled errors from __arm_kprobe_ftrace()
because all caller handled the error correctly.

Link: https://lore.kernel.org/all/177261531182.1312989.8737778408503961141.stgit@mhiramat.tok.corp.google.com/

Reported-by: Zw Tang <shicenci@gmail.com>
Closes: https://lore.kernel.org/all/CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com/
Fixes: 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 025af57ad3ed..bfc89083daa9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1144,12 +1144,12 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	lockdep_assert_held(&kprobe_mutex);
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
-	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
+	if (ret < 0)
 		return ret;
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret)) {
+		if (ret < 0) {
 			/*
 			 * At this point, sinec ops is not registered, we should be sefe from
 			 * registering empty filter.


