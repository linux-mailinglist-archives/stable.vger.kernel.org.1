Return-Path: <stable+bounces-177798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11831B4559F
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01FB1C88555
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3E321422;
	Fri,  5 Sep 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+PIEnS3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8632144A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070258; cv=none; b=FxHYKVRsgMjYqtyo+r8r90FjscxFE9jgAppEc4HUOpUD6m/ZiAPa9vEoIvR68VCYl9hnFipjr56JJQNHfXgV7AOsvSvO4p59GdXZ31IOHiHRohDiC55BArfMUxfo+ctWShCwNEq+Dd7bU1CAG9SxD6mD9bWKzUfbSUDkMBGK9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070258; c=relaxed/simple;
	bh=ZY9O1fkyrvdU63xl7nLGUlt/Wk7Kidgcv7fzLnV+IaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exCKjRCLwRe72FLrk1R2R8grAA3+b9P6YNTA+nsN67kVk9LYS5dpa8CVkxG8q0f3crvtMx8lUOIMwtsnHOD4noAcJhZNVBD+josYmutQc9Dj1KpJnRGMFX9zekHHrK3hon96DpIXbNHy41cU54nC4hk6SYDcKuMBe+gAU/2MiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+PIEnS3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Ati8B006116;
	Fri, 5 Sep 2025 11:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gKUL3
	R8pzXmlUB1xV4xpNZeL9abvHcEa6l1NhhfklG4=; b=l+PIEnS3LnPBbuDdPKN3k
	cTEQNuxeHg11oTuNnANSiQge+pvFnQlnR3UCIAGFxaqLEjPTLRSCA36EwEVH08mM
	dZW1pDfVrAvHbCABMQpgxPs8/La9mSoq5UV80FekhBZa3jO8aua0Ld/mwSzgc83o
	uem1IAcgPN7xhupiwU1w1tLg+aPbmr9smfBYVBI+LIudRnxnLgBuft33SuT7x+lJ
	T40glVSMi882Su+9Y+nr8jJo7qSEjBL3jowsoZ80bahNPahHLYUWxHBzod6epyeZ
	pkOY1NDLFobEhPD/tVTsuha7lbEdX5q6y479qJxoT3ILRaeCWrc2wHzilwrLpgDq
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxa5811v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Jc7n019800;
	Fri, 5 Sep 2025 11:04:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 11:04:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hC030057;
	Fri, 5 Sep 2025 11:04:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-2;
	Fri, 05 Sep 2025 11:04:11 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 01/15] fs/fhandle.c: fix a race in call of has_locked_children()
Date: Fri,  5 Sep 2025 04:03:52 -0700
Message-ID: <20250905110406.3021567-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=68bac3ad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=6eAFsnRBFC2Aldj7gCsA:9 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwNCBTYWx0ZWRfXywswmsyqQddF
 JXd+8BymsubA9Lu2bBRPWFHafYE6bsW4LahRUw4OH6ba1eQskxc5oKf0PIk18ufHBY4n1LifafI
 KMC3KBE+eTNGx8/8SdO6X6gMyxRNPRqjKiQ6JrmodiDKmgtIX5ZThLeWJPT3WgC0xMg0pA/4K5u
 Bj4mhSA660/9LSFYKZQ6ZBAt2hc8f6Vhb9S+v/43zeELCqvWQsipBKDsWhOB46b2sV5SzFv97hz
 a6UcsoaBYAdQtRXZoJjqGVaJ0KRKS0/SwEQoaUnXcAq9tKabEaSuVyKkHeWSM87SkbWqIbP9lY9
 hwmX6JbDMJgU6dz/OxLRcAFSlMRG/tXzy9+Dpz8YyY4OzjZ4+obX5xtpudExdDztWjl7D0MrtxY
 U2LW5jzL
X-Proofpoint-ORIG-GUID: jRRah8rUq1o91kw1lkX2i1-ogjttLPb_
X-Proofpoint-GUID: jRRah8rUq1o91kw1lkX2i1-ogjttLPb_

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 1f282cdc1d219c4a557f7009e81bc792820d9d9a ]

may_decode_fh() is calling has_locked_children() while holding no locks.
That's an oopsable race...

The rest of the callers are safe since they are holding namespace_sem and
are guaranteed a positive refcount on the mount in question.

Rename the current has_locked_children() to __has_locked_children(), make
it static and switch the fs/namespace.c users to it.

Make has_locked_children() a wrapper for __has_locked_children(), calling
the latter under read_seqlock_excl(&mount_lock).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
(cherry picked from commit 1f282cdc1d219c4a557f7009e81bc792820d9d9a)
[Harshit:Resolved conflicts due to missing commit:
db04662e2f4f ("fs: allow detached mounts in clone_private_mount()") in
linux-6.12.y
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/namespace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 962fda4fa246..c8519302f582 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2227,7 +2227,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
 	namespace_unlock();
 }
 
-bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
@@ -2241,6 +2241,16 @@ bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+{
+	bool res;
+
+	read_seqlock_excl(&mount_lock);
+	res = __has_locked_children(mnt, dentry);
+	read_sequnlock_excl(&mount_lock);
+	return res;
+}
+
 /**
  * clone_private_mount - create a private clone of a path
  * @path: path to clone
@@ -2268,7 +2278,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 		return ERR_PTR(-EPERM);
 	}
 
-	if (has_locked_children(old_mnt, path->dentry))
+	if (__has_locked_children(old_mnt, path->dentry))
 		goto invalid;
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
@@ -2762,7 +2772,7 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
 		return mnt;
 
-	if (!recurse && has_locked_children(old, old_path->dentry))
+	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return mnt;
 
 	if (recurse)
@@ -3152,7 +3162,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 		goto out;
 
 	/* From mount should not have locked children in place of To's root */
-	if (has_locked_children(from, to->mnt.mnt_root))
+	if (__has_locked_children(from, to->mnt.mnt_root))
 		goto out;
 
 	/* Setting sharing groups is only allowed on private mounts */
-- 
2.50.1


