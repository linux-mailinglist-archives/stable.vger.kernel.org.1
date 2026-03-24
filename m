Return-Path: <stable+bounces-230168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM7wI6Ocwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:16:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5430A038
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 048E0303144B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DF3FBEC6;
	Tue, 24 Mar 2026 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EcLx4/aj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BA3E023C
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361118; cv=none; b=l7RA+1bdA8nOio0Ck0pOmHfViO4P0moJ37tISV7XodzEniODxa/wBXwOAPaVLUHE77ObrlGxMZ6qlU+Joi7MxgkE4inEHhVcuTBl8RdIXCxI56JUR1NpRiZk1tVOh+6nebtarIyI1fx3JT+gm7iuV7FSKSXDnMaZAB2e/cJHmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361118; c=relaxed/simple;
	bh=FLq1p9lKYz/8DWQhYeeqsEumGi9H1nm33NBirS4e92c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1ud+COtF7BOK6B5yVeWJSACtg/k0dxA9XC4ynyxE8kwsvgt3pAR8F36JrCVapFZtUsoPlzAcWXGH5kQHm5T+D37eca14UABf/Ft9Z0WOSWDd9GSfW97aVnJZ9yVjQMZ6tAYjeW/rNkUVYiNSx08BElOXBfeSm7gHVpAK28e3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EcLx4/aj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCBnCm2735814;
	Tue, 24 Mar 2026 14:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lkdvEjkLuTHiT3uPaqqVoMDti8ykynVKPJCuKhUohEY=; b=
	EcLx4/aj1mfd1MZ1rjOQfaVrIKIr+dgO7YeIeyCy0oaGpw/WU/83NxDH8ts3b8UL
	TuP53GRNvXqEw4kuYUb9qdS1dgjK2P1RVlgj3q7XB17d2TTM+nXcREj7tM24CUAG
	PyF9Bry3YvE4P6ZonT3MTbNQJ17KdQYHLwm3K/FlNvrK9o/ABXIetTwTIb9jYqiN
	ws6uifre5i19Mg2TKv6eYv99eyxaYz0nTUyuyuS05JK3Juo2RRQtdRUA3+BracSn
	C5ihnrvH81qdXkfgcpNFi9rvpZ8hgpluachWPxtriLxfjYeU3SRmjvRVEHfB4IaA
	I+mXZCfLj9E1HDJkrBjOrQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khvvbkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODVlJe039936;
	Tue, 24 Mar 2026 14:05:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Ea023161;
	Tue, 24 Mar 2026 14:05:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-3;
	Tue, 24 Mar 2026 14:05:05 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Song Liu <song@kernel.org>, Tingmao Wang <m@maowtm.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 2/9] landlock: Fix handling of disconnected directories
Date: Tue, 24 Mar 2026 07:04:49 -0700
Message-ID: <20260324140456.832964-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX1zLQsqXwVy6i
 IV31nWoG8ll6iZaSrztjV4s6FDs4litohZkidQ6iUL/q7U3f1SHEmPvVcsx/217j2RIfUufzvWJ
 ElBUbudQvXfWImgL6/jnSE7s8NhZxEv6yZnJQK0/hmvi1DJ2OaYdy6uCRsPoZb95mwZTRIw/sTZ
 YDczf2ZqfXhx8l9LrKJAIgVr0SF68nqEz3oq1p6JACCDt91kFrcjUYyUyl9/UIWVLb/Uq0g0PXJ
 OkfuyrFfhqOHzYhx3ICmloXfuJnBdeNlCQeW7K9ZecNgSt7W96OA7NRszOS4aIkomVedbHSolBa
 nWK5Wvcl72xCGr6j6llS8adRKz5p94BTbAvb1/EDFFcs/AsSx78gF4clWWl6OY+esM5NONqrU1N
 1cNxBDim2Q50w/VfP6DC0VpqQWMXpMg9hk/3kHuXTgJ9eSXhAW6rfMdILu7FjBQ/gfvxIBIXZiv
 tlIhn3gN2++WUPH7kbA==
X-Authority-Analysis: v=2.4 cv=VIXQXtPX c=1 sm=1 tr=0 ts=69c29a13 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=NxYbweiWAAAA:8 a=edGIuiaXAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=4jj19unvXpAgfAoRGlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=m8HnLGj7c6ka2gUKDros:22 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-GUID: JCO6mP50JCofIUxQ_3LtZE5Fpi5WSB4E
X-Proofpoint-ORIG-GUID: JCO6mP50JCofIUxQ_3LtZE5Fpi5WSB4E
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230168-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C1D5430A038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1 ]

Disconnected files or directories can appear when they are visible and
opened from a bind mount, but have been renamed or moved from the source
of the bind mount in a way that makes them inaccessible from the mount
point (i.e. out of scope).

Previously, access rights tied to files or directories opened through a
disconnected directory were collected by walking the related hierarchy
down to the root of the filesystem, without taking into account the
mount point because it couldn't be found. This could lead to
inconsistent access results, potential access right widening, and
hard-to-debug renames, especially since such paths cannot be printed.

For a sandboxed task to create a disconnected directory, it needs to
have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
the underlying source of the bind mount, and read access to the related
mount point.   Because a sandboxed task cannot acquire more access
rights than those defined by its Landlock domain, this could lead to
inconsistent access rights due to missing permissions that should be
inherited from the mount point hierarchy, while inheriting permissions
from the filesystem hierarchy hidden by this mount point instead.

Landlock now handles files and directories opened from disconnected
directories by taking into account the filesystem hierarchy when the
mount point is not found in the hierarchy walk, and also always taking
into account the mount point from which these disconnected directories
were opened.  This ensures that a rename is not allowed if it would
widen access rights [1].

The rationale is that, even if disconnected hierarchies might not be
visible or accessible to a sandboxed task, relying on the collected
access rights from them improves the guarantee that access rights will
not be widened during a rename because of the access right comparison
between the source and the destination (see LANDLOCK_ACCESS_FS_REFER).
It may look like this would grant more access on disconnected files and
directories, but the security policies are always enforced for all the
evaluated hierarchies.  This new behavior should be less surprising to
users and safer from an access control perspective.

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix the related comment.

Because opened files have their access rights stored in the related file
security properties, there is no impact for disconnected or unlinked
files.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
Reviewed-by: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/20251128172200.760753-2-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
(cherry picked from commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 security/landlock/errata/abi-1.h | 16 +++++++++++++
 security/landlock/fs.c           | 40 ++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 12 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
new file mode 100644
index 000000000000..e8a2bff2e5b6
--- /dev/null
+++ b/security/landlock/errata/abi-1.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/**
+ * DOC: erratum_3
+ *
+ * Erratum 3: Disconnected directory handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue with disconnected directories that occur when a
+ * directory is moved outside the scope of a bind mount.  The change ensures
+ * that evaluated access rights include both those from the disconnected file
+ * hierarchy down to its filesystem root and those from the related mount point
+ * hierarchy.  This prevents access right widening through rename or link
+ * actions.
+ */
+LANDLOCK_ERRATUM(3)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f0e94cb74fca..a26199568db2 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -899,21 +899,31 @@ static bool is_access_to_paths_allowed(
 				break;
 			}
 		}
+
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
-			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
-			 */
-			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
+				/*
+				 * Stops and allows access when reaching disconnected root
+				 * directories that are part of internal filesystems (e.g. nsfs,
+				 * which is reachable through /proc/<pid>/ns/<namespace>).
+				 */
 				allowed_parent1 = true;
 				allowed_parent2 = true;
+				break;
 			}
-			break;
+
+			/*
+			 * We reached a disconnected root directory from a bind mount.
+			 * Let's continue the walk with the mount point we missed.
+			 */
+			dput(walker_path.dentry);
+			walker_path.dentry = walker_path.mnt->mnt_root;
+			dget(walker_path.dentry);
+		} else {
+			parent_dentry = dget_parent(walker_path.dentry);
+			dput(walker_path.dentry);
+			walker_path.dentry = parent_dentry;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
 
@@ -990,6 +1000,9 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
  * file.  While walking from @dir to @mnt_root, we record all the domain's
  * allowed accesses in @layer_masks_dom.
  *
+ * Because of disconnected directories, this walk may not reach @mnt_dir.  In
+ * this case, the walk will continue to @mnt_dir after this call.
+ *
  * This is similar to is_access_to_paths_allowed() but much simpler because it
  * only handles walking on the same mount point and only checks one set of
  * accesses.
@@ -1031,8 +1044,11 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/*
+		 * Stops at the mount point or the filesystem root for a disconnected
+		 * directory.
+		 */
+		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
 			break;
 
 		parent_dentry = dget_parent(dir);
-- 
2.50.1


