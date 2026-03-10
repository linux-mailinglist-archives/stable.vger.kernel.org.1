Return-Path: <stable+bounces-223908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bw4DJ37r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:08:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7627249FFB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 464A230364E9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9F838758B;
	Tue, 10 Mar 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOD6p44Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391E38236A;
	Tue, 10 Mar 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140806; cv=none; b=lzWeKCJ5bYp0sHEE8zfP5f7F0s/dL27z8ssKrkFYS5wsHZr9BIuK8y7PYe/WYzMZXv5yaCjgkZVuTBh1TElPOrQr5SK3oAts0Z32y+AqqUd9U50Yg4vaWBnG8krD6UNvIu/TsOgKqLxCyDiQMWJnx6iNecIf2Jqs0ny3wIX9fI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140806; c=relaxed/simple;
	bh=g+J0p+qY4Z94Tt5R1gOKrEWDIxC0yw7hPh/uAmP2rdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU+T5EsMTtAmcUlpd9xambmFjm+DGjxhp57MtQnx7Pf7ZYJ+YLLvKVg7O0gRsXjuOqxrdF5I/eUGyRoDdmqVbCsGKjBjQlm8DWd/efU0LlUF6usvTnKDKmdH1ISGI0FxWw29VUfK0TgUhBoaGLELkxJCwwxya3XLzmZJONNFDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOD6p44Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C8CC2BC86;
	Tue, 10 Mar 2026 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140806;
	bh=g+J0p+qY4Z94Tt5R1gOKrEWDIxC0yw7hPh/uAmP2rdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOD6p44Ql01bl7b4HLdOL8Fa9IMzir1zeM/HYeae7jtx+kZp+LqybsDTgtDavL9eD
	 NAkqOOhyC8iA+iUUbLghFORSHenicAdZWoubyeIapnXUdoJflyANtvLvtoSwepNr/r
	 Tq7SULPUPJR/QBEm8z119lO4WBpx874JfkAJDpbWIeAuZyp8JzGfzwsCCiNYwUoAAq
	 A/V02kIPaM10pFsE3Xz+/fUG7rlKHzhJtBqTPcA7bEknlquChzNgexv0CavLd1QqQc
	 Obff4RTuAeqbJr8uDpLUAyv0/LJlYpcEPfNX3KvxYniKfhNZuv+tJcVib9ntcpz4eX
	 Id9nWVl76/0RA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 044/311] cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()
Date: Tue, 10 Mar 2026 07:01:31 -0400
Message-ID: <8103d1001be2786c768d08d79acdb2d76f607e7c.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7627249FFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223908-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Waiman Long <longman@redhat.com>

[ Upstream commit 68230aac8b9aad243626fbaf3ca170012c17fec5 ]

Commit e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
incorrectly changed the 2nd parameter of cpuset_update_tasks_cpumask()
from tmp->new_cpus to cp->effective_cpus. This second parameter is just
a temporary cpumask for internal use. The cpuset_update_tasks_cpumask()
function was originally called update_tasks_cpumask() before commit
381b53c3b549 ("cgroup/cpuset: rename functions shared between v1
and v2").

This mistake can incorrectly change the effective_cpus of the
cpuset when it is the top_cpuset or in arm64 architecture where
task_cpu_possible_mask() may differ from cpu_possible_mask.  So far
top_cpuset hasn't been passed to update_cpumasks_hier() yet, but arm64
arch can still be impacted. Fix it by reverting the incorrect change.

Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aaef221a1434c..81b3165f1aaa1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2350,7 +2350,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
+		cpuset_update_tasks_cpumask(cp, tmp->new_cpus);
 
 		/*
 		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
-- 
2.51.0


