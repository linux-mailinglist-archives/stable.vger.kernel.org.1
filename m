Return-Path: <stable+bounces-241469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2UFvBB8r8GmBPQEAu9opvQ
	(envelope-from <stable+bounces-241469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:35:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67ED47D161
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8BBD30074C2
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB969274B53;
	Tue, 28 Apr 2026 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqSoftzN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C4155389
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347350; cv=none; b=VhUWjUGd0yEwo2k83UC33+v+uGjV3OAgv1015UzGRICCW14v8O0WF+rZ2es4O8FUAf1tmfv5GkE7cguJvbHXW+wcrpKgQtw1XOY6BjqkQaE8pcG2FfMTtQ069rwq+027ILtM+2qKufud79kR9Wsmt5OKO5UZx8izkKM+6Mzkiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347350; c=relaxed/simple;
	bh=y0J12bcHH3gw09ivS0lCINsQR7jOqh0wgYBn+fh62Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPl1nT3mVN/PywENw9nXyHd93/OpJ+fk74X7YT8r9FOO2DG7fGA3P8fKyavjfmBNbQ4r/ytrVID4jZjCz2X5Jk3JtNHKP8/nund+OfP7zO+sXAFV47q84HEQuWb1Ig6z3QGu3go+WSKPUM1ImsED9vI6abrZRThfYkE1ujQ5JYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqSoftzN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777347348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hNvFXywxnjCALKwv4kJWYGAWulzWtLCfvxorDYEQLjk=;
	b=JqSoftzNXL/5qyTPPWY/a+6pnG96jUapm6Y9IFqzTLd4GmOmkFKUnUC2lSJ5/c+kKuYWJj
	IIxIPQUnWTMQpOeg8JfHqo03QNx1ZQmYfwPZAAhxm/F7ISRqMr2b/ozKl+2q2NtQsTervL
	NnJU78B0jntYbjyCaDKwhrWQ2O5/2E0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-pHFbsgNcP92FF8Fg4_JsoA-1; Mon,
 27 Apr 2026 23:35:44 -0400
X-MC-Unique: pHFbsgNcP92FF8Fg4_JsoA-1
X-Mimecast-MFC-AGG-ID: pHFbsgNcP92FF8Fg4_JsoA_1777347342
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F86F19560AA;
	Tue, 28 Apr 2026 03:35:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9438719560AB;
	Tue, 28 Apr 2026 03:35:39 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Xie Maoyi <maoyi.xie@ntu.edu.sg>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not allowed without privilege
Date: Mon, 27 Apr 2026 23:34:39 -0400
Message-ID: <20260428033439.783246-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: E67ED47D161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241469-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ntu.edu.sg:email]

Creation of a cpuset partition or adding more CPUs to an existing
partition will take CPUs away from other cpusets outside of the
partition leaving less CPUs for the others. So it is a privileged
operation that non-privileged users shouldn't be allowed to do.

Currently, remote partition code has check for CAP_SYS_ADMIN capability
before allowing such operations, but not for local partition. This leaves
a security hole in case cpuset.cpus.partition of a cpuset is chown'ed
to a non-root user and its parent cpuset happens to be a partition root.

Add such privilege check for local partition too to close such a hole.
Also update Documentation/admin-guide/cgroup-v2.rst to clarify the
intention.

With this patch applied, any attempt to enable partition or add CPUs
to an existing local or remote partition by an unprivileged user will
invalidate the partition even if writing to cpuset control files are
allowed.

Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
Reported-by: Xie Maoyi <maoyi.xie@ntu.edu.sg>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++--
 kernel/cgroup/cpuset.c                  | 16 +++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..df58557902db 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2599,8 +2599,10 @@ Cpuset Interface Files
 
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
-	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
-	and is not delegatable.
+	cpuset-enabled cgroups. This file is owned by the parent cgroup
+	and is not delegatable. Any partition operations that take CPUs
+	away from other cpusets outside of a partition is not allowed
+	without privilege.
 
 	It accepts only the following input values when written to.
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..5fc8555f2046 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -57,7 +57,7 @@ static const char * const perr_strings[] = {
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
-	[PERR_ACCESS]    = "Enable partition not permitted",
+	[PERR_ACCESS]    = "Partition operation not permitted",
 	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
@@ -1740,6 +1740,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
 	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
+		if (!capable(CAP_SYS_ADMIN))
+			return PERR_ACCESS;
 		/*
 		 * Need to call compute_excpus() in case
 		 * exclusive_cpus not set. Sibling conflict should only happen
@@ -1833,12 +1835,18 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 					       parent->effective_xcpus);
 		}
 
+		/*
+		 * Taking CPUs away from parent is not allowed without privilege
+		 */
+		if (deleting && !capable(CAP_SYS_ADMIN))
+			part_error = PERR_ACCESS;
+
 		/*
 		 * TBD: Invalidate a currently valid child root partition may
 		 * still break isolated_cpus_can_update() rule if parent is an
 		 * isolated partition.
 		 */
-		if (is_partition_valid(cs) && (old_prs != parent_prs)) {
+		else if (is_partition_valid(cs) && (old_prs != parent_prs)) {
 			if ((parent_prs == PRS_ROOT) &&
 			    /* Adding to parent means removing isolated CPUs */
 			    !isolated_cpus_can_update(tmp->delmask, tmp->addmask))
@@ -1919,8 +1927,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	}
 
 write_error:
-	if (part_error)
+	if (part_error) {
 		WRITE_ONCE(cs->prs_err, part_error);
+		adding = deleting = false;
+	}
 
 	if (cmd == partcmd_update) {
 		/*
-- 
2.53.0


