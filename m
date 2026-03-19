Return-Path: <stable+bounces-227309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLzhIZ8DvGmurAIAu9opvQ
	(envelope-from <stable+bounces-227309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:09:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67CC2CC6E7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31C1304E707
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7992E1758;
	Thu, 19 Mar 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1iQv2E7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154D29B8D3
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929215; cv=none; b=t0X4U8K1eZ0LCK+0Bryr/0k/rd53RjVo2OWonPKGRfMqJ1UvtYBjLPHrK2sB5ZH9FWwG0jPsSFzaEfEIsT8kT64tX2ZZr/JyYtPF0LMw/ioXsvauBGMz/ARRgYzvR4ZjQqYAHx8c7EZua+HhlBUZDIJuPTYP8QwX2CbRXCUGfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929215; c=relaxed/simple;
	bh=EWPNwmxlIoXxnPc3eyjxTnY5EGR3tvn0Btk1l0L3dvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjuG6vmKrdVROotPXUqw0IlSwHZt1LdViL8vIqWu2ZG+kSGSUZv6H3V9yDfnht7N/HVk2X0EXLOE3cIh9UViYf6N1VraWJcBph9/7/3v4Kp93Z8uptZ2QOa3WL8aQFq33f6zH5ZzhtPOx28ZzKMmhyz8SntUCw0qGs3cQUS4bF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1iQv2E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1227C19424;
	Thu, 19 Mar 2026 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929215;
	bh=EWPNwmxlIoXxnPc3eyjxTnY5EGR3tvn0Btk1l0L3dvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1iQv2E7Q+xgypdgcRW95sPuesTW7m5jW0Uz6gFpY5eAdJIl7K022OKE/iE0ltnMO
	 zrtewFac+YqClB/pIEesuzB0R+uC7AkZI6hWcwPXweP+xF1oGAD9pWpc8knUZx4Uw7
	 XphrYcZPIBbOWU7b7MXvgxwe54OWDr/+Y8Jx5yjqHUG2jU9ZYEKwC9dIQM8lWhR3u7
	 KZ4pacUyQKFptaCrax5bvv6YKzGO26fghAJeOaQxlY9C00VKsvOS8LCjtyRZA+7kKg
	 z4JWEl5lXHPLlyglnQCzuBxb77j2p1DwYMfpE/z64KD9XZbfKRP9pLL0BAJFviFq7V
	 o0OezWDUr9XUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Zw Tang <shicenci@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
Date: Thu, 19 Mar 2026 10:06:48 -0400
Message-ID: <20260319140648.2491064-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319140648.2491064-1-sashal@kernel.org>
References: <2026031702-gesture-tragedy-2d56@gregkh>
 <20260319140648.2491064-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227309-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D67CC2CC6E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c2ca192b97aea..e83a185ea90c0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1077,12 +1077,12 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
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
-- 
2.51.0


