Return-Path: <stable+bounces-268801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pI1hOOJUPmqcDwkAu9opvQ
	(envelope-from <stable+bounces-268801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:30:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5AA6CC18F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KRmOXlfN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268801-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268801-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06863302B75A
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A03A7F4F;
	Fri, 26 Jun 2026 10:29:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4553EEAC4;
	Fri, 26 Jun 2026 10:29:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469794; cv=none; b=D/Yzwykok+X8HW54q7FCfrWC2q2e1rYfZZekmXv5g45FhBtgvQWWNJOY6eIb+AeSAKpCMHV4Tf8QnEpJS1f96w4S7Vs/oYTPpFTaCsFtLvn+dDVFXtWH72bBt+67pF/kxgUUA/of0R9KG25yjbIJSKSxHu01bNyNgYd1FUneaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469794; c=relaxed/simple;
	bh=EsCnv2zmPQtUII0ivM5AHcOr5T7brTfAfOxKCs5CIts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxgjqsPWzOiJ15krYutUewz272bL25qRac4NS4gccjnhO2/UPO+/PH7/MGewQiwS+lFBi4COd0qKF45XkfKuhQEoiP5ubXUEF/uTkoIEKZFIUK+JAuxGKgPs8BO8L1tTGCWovf1wJanky54GBa3RMBVJIEqVJczmx2zcTSCUlMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRmOXlfN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D091F00A3A;
	Fri, 26 Jun 2026 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782469790;
	bh=cvducXg29uuJnpCPgKOHgyWH7lcPyLlmDYyWrhgzOjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRmOXlfNBznIxjyH7lRRO76bIPs4WnnU4R99ybql2ZMYtGqMAaW0sojoWDwtVsofB
	 VSJk5Bh4xUPH72eYQPe4hOJVKFtzJ0cKcKIimP4TWopA2KoIcQMaM0inqTMmwPMO4v
	 o+dnQGoy1zSIoTvtzuyD0Ld57BlvXfxpgMLToMG7m+aONE+IlLxJvyQ8FtbcXj5533
	 EPvOY2eSfZrGtAJPgNFx6iA1rwQWd9ZBPbQlsuoo5tU2QFkizU1c+MpxdrMWHeTQDv
	 GPiOK+RdnJrZjZECbvRdfbNbb5VuOHf4KUGhL5fhE4a3GD0YIwibMQRGvAPY4Xbcow
	 HtVkhGgBw9kfw==
From: cem@kernel.org
To: linux-xfs@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	stable@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <david@fromorbit.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: [PATCH 1/2] xfs: fix capabily check in xfs
Date: Fri, 26 Jun 2026 12:29:24 +0200
Message-ID: <20260626102934.57834-2-cem@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626102934.57834-1-cem@kernel.org>
References: <20260626102934.57834-1-cem@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268801-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:stable@vger.kernel.org,m:djwong@kernel.org,m:sandeen@redhat.com,m:hch@lst.de,m:jack@suse.cz,m:david@fromorbit.com,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,uni-hamburg.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fromorbit.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB5AA6CC18F

From: Carlos Maiolino <cem@kernel.org>

An user reported a bug where he managed to evade group's quota
by changing a file's gid to a different group id the same user
belonged to, even though quotas were enforced on both gids and the
file's size was big enough to exceed the quota's hardlimit.

Commit eba0549bc7d1 replaced a capable() call by a
has_capability_noaudit() to prevent unnecessary selinux audit messages.
Turns out that both calls have slightly different semantics even though
their documentation seems similar. Where in a nutshell:

capable() - Tests the task's effective credentials
has_ns_capability_noaudit() - Tests the task's real credentials

This most of the time has no practical difference but in some cases like
changing attrs (specifically group id in this case) through a NFS client
this will allow the quota code to use XFS_QMOPT_FORCE_RES, effectively
bypassing quota accounting checks.

Using instead ns_capable_noaudit() should fix this issue and prevent
selinux audit messages.

This also fix the remaining calls to has_capability_noaudit()

Fixes: eba0549bc7d1 ("xfs: don't generate selinux audit messages for capability testing")
Cc: <stable@vger.kernel.org> # v5.18
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Reported-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/xfs/xfs_fsmap.c | 2 +-
 fs/xfs/xfs_ioctl.c | 2 +-
 fs/xfs/xfs_iops.c  | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index b6a3bc9f143c..7c79fbe0a74c 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -1175,7 +1175,7 @@ xfs_getfsmap(
 		return -EINVAL;
 
 	use_rmap = xfs_has_rmapbt(mp) &&
-		   has_capability_noaudit(current, CAP_SYS_ADMIN);
+		   ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 96af6b62ce39..852ff2ab4531 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -647,7 +647,7 @@ xfs_ioctl_setattr_get_trans(
 		goto out_error;
 
 	error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
-			has_capability_noaudit(current, CAP_FOWNER), &tp);
+			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
 	if (error)
 		goto out_error;
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 325c2200c501..9db9ef1d8c3a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -835,7 +835,8 @@ xfs_setattr_nonsize(
 	}
 
 	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
-			has_capability_noaudit(current, CAP_FOWNER), &tp);
+				ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
+				&tp);
 	if (error)
 		goto out_dqrele;
 
-- 
2.54.0


