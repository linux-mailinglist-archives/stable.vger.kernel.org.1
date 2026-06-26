Return-Path: <stable+bounces-268800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eCOiNKNUPmp1DwkAu9opvQ
	(envelope-from <stable+bounces-268800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:29:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2026CC164
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZDZAqIzB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268800-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268800-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0505B300CFF5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47EB3ED124;
	Fri, 26 Jun 2026 10:29:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA33EC2DB;
	Fri, 26 Jun 2026 10:29:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469790; cv=none; b=IDSp/si6Iuo+2v2Gj3mG2R4RJ8/3ixw7Mw1grlWYsfL2wGTOpyy9AG3vdF8hfqSoPcyoKlH332HiW21HvYTBiEZ/GHlaN39uTYhLIq8Y8JEdmZ0LHL4jsjPYXD1a5q7eCR+Zr893WA16PEmeY3xzys6RnIogMybSL5AcV68cknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469790; c=relaxed/simple;
	bh=t2P4X7PKFww+Ov0Ri/ynWSZ26Z4CkGLTJzAPjs0LVjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGXcFhO/1I26KRWp3DOI0rwUzPvT5uQPT4TDkeXS0ArZE/vfE1vams436sdANUwVOX0vPQl73JQMYzrUKN9a6qC3Gls2qiRTBDcsiPxzs0Nfn8VZq+tsU8As2kC3uoH9JBv1mUphbBMSJfpOpvth8dT6W4qhCyRlv6ZRCPrwY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDZAqIzB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A501F000E9;
	Fri, 26 Jun 2026 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782469787;
	bh=ThZ+H37IqOWXAYKJMBkBHV9IlSdEnmWTDo9kFjGnK5c=;
	h=From:To:Cc:Subject:Date;
	b=ZDZAqIzBklT+O05c0xIm5MQ+g0P0CAnzNmi9pWzyM7A4bh4Md2Y7F223gIlvhlXyn
	 MpRZcwWP4C1q0zg0oDocf/eEU9GWlPitXA3BUpLe/unVmRJXU5y5CLS+S9vw6p4klH
	 eaFT9WbQf6WjwPrJYAzAhCKY3ww+bjof1I7QMNwvz51Zo9z60RoeDL6fD/X3AYlg5+
	 LMBRfoc6OBWX9KAoJ1c3VLlpKgLCxk8UpdZFNQl2chNyLiz3Rqt/Mu1BUTlb0aTmYt
	 theQzMF02M5KigdtMinvQG287mps8extuHT5JSz71+V7G7vTLM5sIyjX+bO8E894kn
	 ddecS8wWHcyFw==
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
Subject: [PATCH 0/2] Fix capabilities check
Date: Fri, 26 Jun 2026 12:29:23 +0200
Message-ID: <20260626102934.57834-1-cem@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268800-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uni-hamburg.de:email,fromorbit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2026CC164

From: Carlos Maiolino <cem@kernel.org>

First patch fixes the original replacement of capable() calls in a
straight-forward way which can be backported to stable kernels in an
easy way.

Second patch lifts the capability check into xfs_trans_dqresv Christoph
suggested.

I'm working on the capabilities code to see if a helper is worth there
too. But it's worth quickly fixing this in xfs before having all the
bits in capability.c worked out.
There are also a couple other places outside xfs which likely needs
fixing. I'll include it on the next series non-xfs related.

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


Carlos Maiolino (2):
  xfs: fix capabily check in xfs
  xfs: lift quota capability check to xfs_trans_dqresv

 fs/xfs/xfs_fsmap.c       | 2 +-
 fs/xfs/xfs_ioctl.c       | 3 +--
 fs/xfs/xfs_iops.c        | 3 +--
 fs/xfs/xfs_trans_dquot.c | 6 ++++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.54.0


