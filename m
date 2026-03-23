Return-Path: <stable+bounces-229824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM/1A919wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:52:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4622FA885
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3203024529
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D423B612;
	Mon, 23 Mar 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lc1nIDjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2033B0ACC;
	Mon, 23 Mar 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282964; cv=none; b=YvqsO7A7EhcDMvA9/QUOor2pSb7+qI+iKvXfrSvij1q2qmL1ZyKg3FwWcLzAaQijIx3w6Tjc4LZJBnxVIClP1T0fpRPIdxBbnWQG3LX2Fiom30Lf5oWCVA5MUYyzMQtt+X5nXNyKLurn7nD5iM7na2J+qG7w50pezlg74wQFbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282964; c=relaxed/simple;
	bh=X8KU3T/xNOIfX8VRAAtMnzSZX6Q8kicg27EVaCO3Ulg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vwb8fNdM/5HNta/9bzNNDu07/EkAX46yTqtMwr2mAlcVG1O0yPsW1StvqogyuQcwZFwHYr3lWfyyQ9h0qOFpf1fsh2uS9SVdrz11fe8yglP4qYXimMOmMkdjkTI5gQcx+eiVsybMoajb3u4QoePx9M7gWFd7cMPojdlyKG5/TQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lc1nIDjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73C1C4CEF7;
	Mon, 23 Mar 2026 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282964;
	bh=X8KU3T/xNOIfX8VRAAtMnzSZX6Q8kicg27EVaCO3Ulg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lc1nIDjfsrhzZEMVqZtDBFa574rRQADqYb4KPSj279mLnPZC8OvbwsfxdSyFRYjru
	 jDY0VDP9w7Ad0dhCtfwF89w/2Q7vZSQJnA7Cqwnd7sOROYZJIVLLsae4YnF6/YjkjO
	 5c+v2pm9zwrtUn5aab8+8AP6rQvajsmbzoo76WAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zw Tang <shicenci@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 351/481] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
Date: Mon, 23 Mar 2026 14:45:33 +0100
Message-ID: <20260323134533.657986664@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229824-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5C4622FA885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 5ef268cb7a0aac55521fd9881f1939fa94a8988e ]

Remove unneeded warnings for handled errors from __arm_kprobe_ftrace()
because all caller handled the error correctly.

Link: https://lore.kernel.org/all/177261531182.1312989.8737778408503961141.stgit@mhiramat.tok.corp.google.com/

Reported-by: Zw Tang <shicenci@gmail.com>
Closes: https://lore.kernel.org/all/CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com/
Fixes: 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1077,12 +1077,12 @@ static int __arm_kprobe_ftrace(struct kp
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



