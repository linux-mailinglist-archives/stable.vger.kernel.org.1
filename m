Return-Path: <stable+bounces-227341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCBWDIwovGkxtgIAu9opvQ
	(envelope-from <stable+bounces-227341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:47:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E462CF0D6
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6423223369
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7D315D40;
	Thu, 19 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpc5HcQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9013ED5D9
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938021; cv=none; b=ozs2JRk0q6jxVJ6s46i9w+tznt8aYDFFKDX7ePKC+PTQnnVEB49yOwVLe02GrdCU+zjb9iy52YZEP6lG1s8co5l6UbvJhZ2aicvXbsIftwwUB4Y6SaduHUigqmTLMuE7sLhnpvmY2FgL4PLJAmX9y/F9Q+oblq1w0X8ldJz7+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938021; c=relaxed/simple;
	bh=qq9L9JdI2Or83p2kvEZVFApkyZ+yC4StaQL28ZJZ7Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pduTvvtOMjsEAqMB7FSrmS2dWaZyyLaS1h016QzzIsZcUFY0PP4BBtcKqdkhiYFrDFV16oCDIA2sk5xZ1CP1NbSllGL6sORpDocOsCMSQkadJHgsD/t+qp1ZjM6ZFdE3qoqPl2uKeLvYcOZ0ZwtiaY+82ZgSTmD1zqb2wSmO8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpc5HcQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9099FC19424;
	Thu, 19 Mar 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938021;
	bh=qq9L9JdI2Or83p2kvEZVFApkyZ+yC4StaQL28ZJZ7Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpc5HcQL2u+yT6YzDfVssIDrATTD97sK4VwIFA+FPPWEQMr6sfKfNrupnRhGHGTsv
	 738QaZd884MObfyTg5SubRDbzdM2b+YjuALsXiV6JKkZpT6rWxe3KhuYytsAZm4lBW
	 8KUmpFJWO+CwQDPc6ubJld7DDyHEhS2aMML2y7pa8pEnv3eAMSoQ3cB9RwRVzyY4HD
	 YKq2MpOFm+/j/HwYCMoammz8zEUnYFNtTj01i2GiJTLr6Ws6WjSD5zJ3ZPd5gccBSV
	 rhd0mtz1OSfAftFsV23Q6B/jM8AHvEh/ruqg36qH4o0jgtaTOr/BYnKL1OZjMZTgLW
	 N6b8Nf1N8kt1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Zw Tang <shicenci@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
Date: Thu, 19 Mar 2026 12:33:39 -0400
Message-ID: <20260319163339.2721540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031702-coyness-unbeaten-ac84@gregkh>
References: <2026031702-coyness-unbeaten-ac84@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227341-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A9E462CF0D6
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
[ adapted goto err_ftrace error handling pattern to inline error handling block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0d463859ad329..caa7382cb0748 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1049,25 +1049,23 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	int ret = 0;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
-	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
+	if (ret < 0)
 		return ret;
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret))
-			goto err_ftrace;
+		if (ret < 0) {
+			/*
+			 * At this point, sinec ops is not registered, we should be sefe from
+			 * registering empty filter.
+			 */
+			ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
+			return ret;
+		}
 	}
 
 	(*cnt)++;
 	return ret;
-
-err_ftrace:
-	/*
-	 * At this point, sinec ops is not registered, we should be sefe from
-	 * registering empty filter.
-	 */
-	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	return ret;
 }
 
 static int arm_kprobe_ftrace(struct kprobe *p)
-- 
2.51.0


