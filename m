Return-Path: <stable+bounces-244874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDDbK2CM/mlasgAAu9opvQ
	(envelope-from <stable+bounces-244874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:22:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168374FD40C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9011300F5EA
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE125D53B;
	Sat,  9 May 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgGnIKtL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED52417D9
	for <stable@vger.kernel.org>; Sat,  9 May 2026 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289758; cv=none; b=eqxDWhWaVWhI77bcYt7DH13p1SxHyFREKOnEDuLlIpLjWiss0Wq8pbrZBiyLx/JSibxCzY3KeHaBqjnvEUrECESk11wLWbO6b0VZN69X4y2r1XS+28Sq+j7cG1vkpKPGOGEY0V5lbl6vavJL1ANuE+cmzrg6CtrJNYCWe1Xmugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289758; c=relaxed/simple;
	bh=KoLIfUsJtE2vxPlZkT7zjeGuQ4Apxdj6qvZebaZ8m+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbLMFm1OsuP4zLj6LFoXnizV3GsynJ60ykpaxrvNZXFkxKaMYnlXyf4qab6j6FPom99kB6ILQHJPT+MJK3yB6SxyWNfuhDNfi1fsPHW9Re44+aYQ5wg8zePPnT2cQm08mzATPpf4No9fm8dtHSj066CmS6H2kedvj8fwYkF3FAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgGnIKtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3750EC2BCB0;
	Sat,  9 May 2026 01:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289757;
	bh=KoLIfUsJtE2vxPlZkT7zjeGuQ4Apxdj6qvZebaZ8m+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgGnIKtLAP9eEhkhOcwUsoR1SsWzGOao/FcZ90W6rJKuxFrFR7A+4QxPnSq7KGHy9
	 nRkzrc7F3RGoPHIMq62zV2LS2GFvl4B03zmxma4IubRu6bCKYxxliaiWB64Yy43pkU
	 m68NkQeZRWRl87dJn1wJ0MECqpKv6dMuPvBCBtFkus6BchTV1aU7f9toua3htV8UrJ
	 HA+quUGrhtlsWLuTukVnm2t3j2EALs7wq4d9S8k1Ug7C+0pj9Bn5RGPWZQEYmi/iW2
	 oaSrnxAUJRVK1FXBTDxIvrgnByh/VfYHuxwaw2ZAVGVBb8pOR/NHCOdzzKzAoiwEyr
	 LOLMz8DiwYs2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cengiz Can <cengiz.can@canonical.com>,
	Qualys Security Advisory <qsa@qualys.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] apparmor: use target task's context in apparmor_getprocattr()
Date: Fri,  8 May 2026 21:22:34 -0400
Message-ID: <20260509012234.2844474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050424-perceive-compress-fcb1@gregkh>
References: <2026050424-perceive-compress-fcb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 168374FD40C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244874-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualys.com:email]
X-Rspamd-Action: no action

From: Cengiz Can <cengiz.can@canonical.com>

[ Upstream commit 4afc61702bdcc3b9b519749ef966cf762a6e7051 ]

apparmor_getprocattr() incorrectly calls task_ctx(current) instead of
task_ctx(task) when retrieving prev and exec attributes, returning the
caller's labels rather than the target's.

Fix by passing task to task_ctx().

The issue can be reproduced when a process with an onexec transition
(e.g., configured by a container runtime) is inspected via
/proc/<pid>/attr/apparmor/exec. The reader's own value is returned
instead of the target's.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Fixes: 3b529a7600d8 ("apparmor: move task domain change info to task security")
Cc: stable@vger.kernel.org
Co-developed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 37aa1650c74eb..c1c8efd7db8c3 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -589,25 +589,23 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 				char **value)
 {
 	int error = -ENOENT;
-	/* released below */
-	const struct cred *cred = get_task_cred(task);
-	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
 
+	rcu_read_lock();
 	if (strcmp(name, "current") == 0)
-		label = aa_get_newest_label(cred_label(cred));
-	else if (strcmp(name, "prev") == 0  && ctx->previous)
-		label = aa_get_newest_label(ctx->previous);
-	else if (strcmp(name, "exec") == 0 && ctx->onexec)
-		label = aa_get_newest_label(ctx->onexec);
+		label = aa_get_newest_cred_label(__task_cred(task));
+	else if (strcmp(name, "prev") == 0  && task_ctx(task)->previous)
+		label = aa_get_newest_label(task_ctx(task)->previous);
+	else if (strcmp(name, "exec") == 0 && task_ctx(task)->onexec)
+		label = aa_get_newest_label(task_ctx(task)->onexec);
 	else
 		error = -EINVAL;
+	rcu_read_unlock();
 
 	if (label)
 		error = aa_getprocattr(label, value);
 
 	aa_put_label(label);
-	put_cred(cred);
 
 	return error;
 }
-- 
2.53.0


