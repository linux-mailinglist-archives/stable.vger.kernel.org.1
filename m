Return-Path: <stable+bounces-227295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMJlCr78u2mzqwIAu9opvQ
	(envelope-from <stable+bounces-227295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:40:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF102CC1A6
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88312304B288
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D63D47DB;
	Thu, 19 Mar 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvMKtq26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CE1F91E3
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927556; cv=none; b=hj5mLIxsopFEGZnMkIncW49G4opKXj2XcLckV2kckdcWR7jAp6SvpyrfKIQkh36ps1j6JomZW2aXzQZol+fi1KUd2xihR0zW3eZ12DnvhMby3OIF1QTsZTTFpG5fzWx8/5T21EqW0E3VnBykbyGi6wU1IDjafH3hFTdwT2yG3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927556; c=relaxed/simple;
	bh=qfMQd0vE120/+zikoJb3geCFcxE+MLsk0qrqwAhqx70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLQ1Fi/AG+tZcNoq0texVuyZiopgjF+P24xtQ6IkPpXIP0QnUexX5V/5BFA2Is32BAoYwkFrjLT/m08kWOnLKBQCHXuKktVLJ83nhOqIBxGwXFceksuN1pfM1tc1Bm24EPmdB90+sFXDwyU2eZo+qr0M1unu89zcL2A58Fhx7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvMKtq26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE2DC2BC9E;
	Thu, 19 Mar 2026 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927555;
	bh=qfMQd0vE120/+zikoJb3geCFcxE+MLsk0qrqwAhqx70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvMKtq26yph4yGXi72dDQNBk1spyD6JcRlGmgaq+rmttBQbs9bKo5ryWhX7A9zR4C
	 dKIdJ2WI8n4xoDKWepBouN8hDpnFtEDkD344IN3bcgN2UsViigJNZQzaruozYv1G+0
	 JiqZTFZEFehAV7ud0Fswb600kH65OyQJG3UaKFwKsSv0WLnUnf43ocweDBf75xAMnY
	 msQSsq79kD0omE6zh4c7detwVBmcNLMRdKxW0dBcLnx0tRdw0ZfBI4WSZ830FIN87o
	 a42lfjeU8Dk8t0fdoQxVRRW6kUsvZnEJJ5tGOkJgklO3V/lpGpso+bcOzuKLsMen0l
	 aRU423LvxZ9tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Zw Tang <shicenci@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
Date: Thu, 19 Mar 2026 09:39:13 -0400
Message-ID: <20260319133913.2477768-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319133913.2477768-1-sashal@kernel.org>
References: <2026031701-glider-ominous-ade9@gregkh>
 <20260319133913.2477768-1-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227295-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.833];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DF102CC1A6
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
index b477102b72bb2..b4a172907b03a 100644
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


