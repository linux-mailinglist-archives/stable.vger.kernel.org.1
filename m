Return-Path: <stable+bounces-235932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD1WCpqR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11613E7EA0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A0130160EA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D99365A0B;
	Mon, 13 Apr 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="M+4beadP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B2363C7A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062857; cv=none; b=GiqHmh4yE2yMaQbdxd4iByzNx2ZS+0e1TVL2BqQ2mQcSCaKbpVYsXl6s1DsZ/zlnw8HwVlwyY3ykHP2YYxekPIamMQyDR4ZDkGvm4YkLOedrADz2f1qC4+CtalTT7j9M/pGlYy0+vJs4JW/z9LIyGwUiPJykPqLSCU2IUJ0IJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062857; c=relaxed/simple;
	bh=8+ciwKowc9bkNI0gtJOMX6RK32gq2AuwsvDyN9JDIu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuU534sbWFwpo1oQvIFlNoBJhHdMXDvGcBR4v2XsegMwGl3E9L6xZC8+dRwTbj1/EvmXyDAt5I9pKtHHBDoEf2qvJ5uZWBORfbVUL3TEGK9HjfB00/K6dBRwV7C9cdh0BQO5/pg7IWQNhW1ZY1tmNnv85ndLZoGQOINJXCWpptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=M+4beadP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 938E23F1E0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062853;
	bh=xpLXp8+iN7qm8DmHOnfIRcxfz2aRHovgLpuZkGjGo7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=M+4beadPt81u96eN3SwlWF/8Yhq9Wv9/LtnxZ5mnXskVz7f16FSKMP4U5BOv3JkEX
	 YJ6r0NR+/zKGN2uringIY/XB45eEcsf61ENeqr95I9fRxjf06Gc67PJkIg095I2O5x
	 pwZN/FWzl0PA9HweZwZCA8xQmsVh/S6jVfr80Pr+QSz2EmLDszXEzK0WB2P9xXmxDx
	 UmD9rR5CUXJ5lga5q3nlGGK9lozQry3u84/1bN/pmPDKpnp13MSTPXnmFdsbDi8NwJ
	 36i/qxenCt3pX3SbHpO/e1v92N0EQw9htIuhWkI8rnmGBNgStAYyA3A8b/IJOXVO3W
	 chroAT5e5Ku1Kva45IzYJ9wo6ao7GYutdK6dfBYXeq8GD0tzP5ar/YVxfwhae0WBb9
	 1KVye4RO4yCG8xcE2ey/V9Xiu1Ejo34J3qP3NCEcsNbp31WBlJ6rzFPooC9kiFLbOD
	 W3EKpox3lWgi5Gn10ji7Q0Sjx2qpVAdgHKvB4LPoIzLIqZm14uZKO+XACbASWcOW09
	 y37IySvcCUI2ndiwzAN20+JFDzNQiDkemSws7Ob/iRioTtOmcE8G3udyZI3yi9wbvo
	 5w5GHHjHLzW7jI7AvWJPt6a45sBLqJrFnAj9dgpiEuliSsulsaHkHsWvEcmtqcxl44
	 A/0BAGwcDJkArLt6WXwtqCp0=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so4614879a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062852; x=1776667652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpLXp8+iN7qm8DmHOnfIRcxfz2aRHovgLpuZkGjGo7s=;
        b=ionxEsWxrc0pNvcytRiHFgdcbeTTL0qmRQc6LCViGaPD2fDmxcc/JvOkwc+YZdnTum
         2FHAfmFxlX82bq+2tCVlJx6vJNtaewTAapUaaNFBj+ZK98TBrqZ5r/bh1TXsABdVpwkD
         L9qD+naD6B6VQHMaGtK2DADSpdwixpsn/Il8gGKnEEJ9QboE9XBRfLwYeAdIm2fJgrt8
         DnKiyDo4vLlXAIhOL3fRd+hpEXijsRL93F+ZVGIFowuab5pLoutBvll4Fq4tNOG/+h48
         mAevi4moqqhThDiPiO546BbKLVKKPBcuMZjOBdiMMSvKu1F9WGO/DYDunep7TN54iYWU
         RzmA==
X-Gm-Message-State: AOJu0YzArywstmHVxnOboAVVijp2Eyu5VXy4c095/OgVp9qUnNS0/cyZ
	Mr7Dog/QcBZbRKac6glLS4HFF2jy9l7KdF9PqyAEhW20+qxusXUe9h95b5IQX33VbiH3tOad9GQ
	amMjfmcLNmZF8uGXiPkSmjGV1QeDT2PNLxZteQ2Bmxc5rsPd64u20T/0Viy15ipNNNHsdA4140e
	N/6CeKjw==
X-Gm-Gg: AeBDieuusIBvPW7H7haOKO0TlaKKg4WJuIgeZGo1a569qR433rTSELiCMHdoxTNc4dw
	sfSDJllEABJv/5yhQX8nSDkDsWLla/Uw3AXtxOFaXiZxGgbzZjW7ZFtyhArjp+Sgl5GOqlRzJ+0
	E+MidnWAjA3emErzYa4pEupHV5P6lTtbtP5QNHzv7afXkpnQBk8XyqWvKBNK9A+7ltjgbNxVUXi
	X1Fz8HVtOzV8PjBcubw8yKAOKq8HVaC1joxz2YPjcYRZTohudiD5Ssj5Jl2ZsABdBbkuWpZZuD7
	o1CyXDda7IXylDkTH1ZnoR2T12Wm9lHGRkbC5RitkNo+cJRGz/8SyAKvFUoilmpRf5kJveUV04G
	pmRwFk5/6GJFsbR2eu5l2qVc0pn4=
X-Received: by 2002:a17:90b:3f8e:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-35fb647dbbamr2739909a91.0.1776062851982;
        Sun, 12 Apr 2026 23:47:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8e:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-35fb647dbbamr2739895a91.0.1776062851549;
        Sun, 12 Apr 2026 23:47:31 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35e411fec4csm10848139a91.1.2026.04.12.23.47.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:31 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 11/11] apparmor: fix race between freeing data and fs accessing it
Date: Sun, 12 Apr 2026 23:46:36 -0700
Message-ID: <20260413064712.1581137-12-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235932-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B11613E7EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 8e135b8aee5a06c52a4347a5a6d51223c6f36ba3 upstream.

Backport for conflicts introdued by
- conversion from sha1 to sha256 introduced in
   e44a4dc4b36c ("apparmor: switch SECURITY_APPARMOR_HASH from sha1 to sha256
")

- adding of conditioanl that nests the conflicting code inside an if
  condition
  d61c57fde819 ("apparmor: make export of raw binary profile to userspace optional")

AppArmor was putting the reference to i_private data on its end after
removing the original entry from the file system. However the inode
can and does live beyond that point and it is possible that some of
the fs call back functions will be invoked after the reference has
been put, which results in a race between freeing the data and
accessing it through the fs.

While the rawdata/loaddata is the most likely candidate to fail the
race, as it has the fewest references. If properly crafted it might be
possible to trigger a race for the other types stored in i_private.

Fix this by moving the put of i_private referenced data to the correct
place which is during inode eviction.

Fixes: c961ee5f21b20 ("apparmor: convert from securityfs to apparmorfs for policy ns files")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Maxime Bélair <maxime.belair@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/apparmorfs.c            | 193 +++++++++++++---------
 security/apparmor/include/label.h         |  16 +-
 security/apparmor/include/lib.h           |  12 ++
 security/apparmor/include/policy.h        |   8 +-
 security/apparmor/include/policy_unpack.h |   6 +-
 security/apparmor/label.c                 |  12 +-
 security/apparmor/policy_unpack.c         |   6 +-
 7 files changed, 152 insertions(+), 101 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 85ad45afb0f9..65b16c6f61b7 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -32,6 +32,7 @@
 #include "include/crypto.h"
 #include "include/ipc.h"
 #include "include/label.h"
+#include "include/lib.h"
 #include "include/policy.h"
 #include "include/policy_ns.h"
 #include "include/resource.h"
@@ -61,6 +62,7 @@
  * securityfs and apparmorfs filesystems.
  */
 
+#define IREF_POISON 101
 
 /*
  * support fns
@@ -150,6 +152,71 @@ static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
+static struct aa_ns *get_ns_common_ref(struct aa_common_ref *ref)
+{
+	if (ref) {
+		struct aa_label *reflabel = container_of(ref, struct aa_label,
+							 count);
+		return aa_get_ns(labels_ns(reflabel));
+	}
+
+	return NULL;
+}
+
+static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
+{
+	if (ref)
+		return aa_get_proxy(container_of(ref, struct aa_proxy, count));
+
+	return NULL;
+}
+
+static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
+{
+	if (ref)
+		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
+						      count));
+	return NULL;
+}
+
+static void aa_put_common_ref(struct aa_common_ref *ref)
+{
+	if (!ref)
+		return;
+
+	switch (ref->reftype) {
+	case REF_RAWDATA:
+		aa_put_i_loaddata(container_of(ref, struct aa_loaddata,
+					       count));
+		break;
+	case REF_PROXY:
+		aa_put_proxy(container_of(ref, struct aa_proxy,
+					  count));
+		break;
+	case REF_NS:
+		/* ns count is held on its unconfined label */
+		aa_put_ns(labels_ns(container_of(ref, struct aa_label, count)));
+		break;
+	default:
+		AA_BUG(true, "unknown refcount type");
+		break;
+	}
+}
+
+static void aa_get_common_ref(struct aa_common_ref *ref)
+{
+	kref_get(&ref->count);
+}
+
+static void aafs_evict(struct inode *inode)
+{
+	struct aa_common_ref *ref = inode->i_private;
+
+	clear_inode(inode);
+	aa_put_common_ref(ref);
+	inode->i_private = (void *) IREF_POISON;
+}
+
 static void aafs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -159,6 +226,7 @@ static void aafs_free_inode(struct inode *inode)
 
 static const struct super_operations aafs_super_ops = {
 	.statfs = simple_statfs,
+	.evict_inode = aafs_evict,
 	.free_inode = aafs_free_inode,
 	.show_path = aafs_show_path,
 };
@@ -259,7 +327,8 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
  * aafs_remove(). Will return ERR_PTR on failure.
  */
 static struct dentry *aafs_create(const char *name, umode_t mode,
-				  struct dentry *parent, void *data, void *link,
+				  struct dentry *parent,
+				  struct aa_common_ref *data, void *link,
 				  const struct file_operations *fops,
 				  const struct inode_operations *iops)
 {
@@ -296,6 +365,9 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
 		goto fail_dentry;
 	inode_unlock(dir);
 
+	if (data)
+		aa_get_common_ref(data);
+
 	return dentry;
 
 fail_dentry:
@@ -320,7 +392,8 @@ static struct dentry *aafs_create(const char *name, umode_t mode,
  * see aafs_create
  */
 static struct dentry *aafs_create_file(const char *name, umode_t mode,
-				       struct dentry *parent, void *data,
+				       struct dentry *parent,
+				       struct aa_common_ref *data,
 				       const struct file_operations *fops)
 {
 	return aafs_create(name, mode, parent, data, NULL, fops, NULL);
@@ -446,7 +519,7 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
 			    loff_t *pos)
 {
-	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
+	struct aa_ns *ns = get_ns_common_ref(f->f_inode->i_private);
 	int error = policy_update(AA_MAY_LOAD_POLICY, buf, size, pos, ns,
 				  f->f_cred);
 
@@ -464,7 +537,7 @@ static const struct file_operations aa_fs_profile_load = {
 static ssize_t profile_replace(struct file *f, const char __user *buf,
 			       size_t size, loff_t *pos)
 {
-	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
+	struct aa_ns *ns = get_ns_common_ref(f->f_inode->i_private);
 	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
 				  buf, size, pos, ns, f->f_cred);
 	aa_put_ns(ns);
@@ -484,7 +557,7 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	struct aa_loaddata *data;
 	struct aa_label *label;
 	ssize_t error;
-	struct aa_ns *ns = aa_get_ns(f->f_inode->i_private);
+	struct aa_ns *ns = get_ns_common_ref(f->f_inode->i_private);
 
 	label = begin_current_label_crit_section();
 	/* high level check about policy management - fine grained in
@@ -574,7 +647,7 @@ static int ns_revision_open(struct inode *inode, struct file *file)
 	if (!rev)
 		return -ENOMEM;
 
-	rev->ns = aa_get_ns(inode->i_private);
+	rev->ns = get_ns_common_ref(inode->i_private);
 	if (!rev->ns)
 		rev->ns = aa_get_current_ns();
 	file->private_data = rev;
@@ -1052,7 +1125,7 @@ static const struct file_operations seq_profile_ ##NAME ##_fops = {	      \
 static int seq_profile_open(struct inode *inode, struct file *file,
 			    int (*show)(struct seq_file *, void *))
 {
-	struct aa_proxy *proxy = aa_get_proxy(inode->i_private);
+	struct aa_proxy *proxy = get_proxy_common_ref(inode->i_private);
 	int error = single_open(file, show, proxy);
 
 	if (error) {
@@ -1230,7 +1303,7 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 static int seq_rawdata_open(struct inode *inode, struct file *file,
 			    int (*show)(struct seq_file *, void *))
 {
-	struct aa_loaddata *data = aa_get_i_loaddata(inode->i_private);
+	struct aa_loaddata *data = get_loaddata_common_ref(inode->i_private);
 	int error;
 
 	if (!data)
@@ -1370,7 +1443,7 @@ static int rawdata_open(struct inode *inode, struct file *file)
 	if (!policy_view_capable(NULL))
 		return -EACCES;
 
-	loaddata = aa_get_i_loaddata(inode->i_private);
+	loaddata = get_loaddata_common_ref(inode->i_private);
 	if (!loaddata)
 		return -ENOENT;
 
@@ -1415,7 +1488,6 @@ static void remove_rawdata_dents(struct aa_loaddata *rawdata)
 		if (!IS_ERR_OR_NULL(rawdata->dents[i])) {
 			aafs_remove(rawdata->dents[i]);
 			rawdata->dents[i] = NULL;
-			aa_put_i_loaddata(rawdata);
 		}
 	}
 }
@@ -1454,45 +1526,41 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 	if (IS_ERR(dir))
 		/* ->name freed when rawdata freed */
 		return PTR_ERR(dir);
-	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_DIR] = dir;
 
-	dent = aafs_create_file("abi", S_IFREG | 0444, dir, rawdata,
+	dent = aafs_create_file("abi", S_IFREG | 0444, dir, &rawdata->count,
 				      &seq_rawdata_abi_fops);
 	if (IS_ERR(dent))
 		goto fail;
-	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_ABI] = dent;
 
-	dent = aafs_create_file("revision", S_IFREG | 0444, dir, rawdata,
-				      &seq_rawdata_revision_fops);
+	dent = aafs_create_file("revision", S_IFREG | 0444, dir,
+				&rawdata->count,
+				&seq_rawdata_revision_fops);
 	if (IS_ERR(dent))
 		goto fail;
-	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
 
 	if (aa_g_hash_policy) {
 		dent = aafs_create_file("sha1", S_IFREG | 0444, dir,
-					      rawdata, &seq_rawdata_hash_fops);
+					&rawdata->count,
+					&seq_rawdata_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
-		aa_get_i_loaddata(rawdata);
 		rawdata->dents[AAFS_LOADDATA_HASH] = dent;
 	}
 
 	dent = aafs_create_file("compressed_size", S_IFREG | 0444, dir,
-				rawdata,
+				&rawdata->count,
 				&seq_rawdata_compressed_size_fops);
 	if (IS_ERR(dent))
 		goto fail;
-	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_COMPRESSED_SIZE] = dent;
 
-	dent = aafs_create_file("raw_data", S_IFREG | 0444,
-				      dir, rawdata, &rawdata_fops);
+	dent = aafs_create_file("raw_data", S_IFREG | 0444, dir,
+				&rawdata->count, &rawdata_fops);
 	if (IS_ERR(dent))
 		goto fail;
-	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_DATA] = dent;
 	d_inode(dent)->i_size = rawdata->size;
 
@@ -1503,7 +1571,6 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 
 fail:
 	remove_rawdata_dents(rawdata);
-	aa_put_i_loaddata(rawdata);
 	return PTR_ERR(dent);
 }
 
@@ -1525,13 +1592,10 @@ void __aafs_profile_rmdir(struct aa_profile *profile)
 		__aafs_profile_rmdir(child);
 
 	for (i = AAFS_PROF_SIZEOF - 1; i >= 0; --i) {
-		struct aa_proxy *proxy;
 		if (!profile->dents[i])
 			continue;
 
-		proxy = d_inode(profile->dents[i])->i_private;
 		aafs_remove(profile->dents[i]);
-		aa_put_proxy(proxy);
 		profile->dents[i] = NULL;
 	}
 }
@@ -1561,14 +1625,7 @@ static struct dentry *create_profile_file(struct dentry *dir, const char *name,
 					  struct aa_profile *profile,
 					  const struct file_operations *fops)
 {
-	struct aa_proxy *proxy = aa_get_proxy(profile->label.proxy);
-	struct dentry *dent;
-
-	dent = aafs_create_file(name, S_IFREG | 0444, dir, proxy, fops);
-	if (IS_ERR(dent))
-		aa_put_proxy(proxy);
-
-	return dent;
+	return aafs_create_file(name, S_IFREG | 0444, dir, &profile->label.proxy->count, fops);
 }
 
 static int profile_depth(struct aa_profile *profile)
@@ -1618,7 +1675,8 @@ static const char *rawdata_get_link_base(struct dentry *dentry,
 					 struct delayed_call *done,
 					 const char *name)
 {
-	struct aa_proxy *proxy = inode->i_private;
+	struct aa_common_ref *ref = inode->i_private;
+	struct aa_proxy *proxy = container_of(ref, struct aa_proxy, count);
 	struct aa_label *label;
 	struct aa_profile *profile;
 	char *target;
@@ -1758,27 +1816,23 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 
 	if (profile->rawdata) {
 		dent = aafs_create("raw_sha1", S_IFLNK | 0444, dir,
-				   profile->label.proxy, NULL, NULL,
+				   &profile->label.proxy->count, NULL, NULL,
 				   &rawdata_link_sha1_iops);
 		if (IS_ERR(dent))
 			goto fail;
-		aa_get_proxy(profile->label.proxy);
 		profile->dents[AAFS_PROF_RAW_HASH] = dent;
-
 		dent = aafs_create("raw_abi", S_IFLNK | 0444, dir,
-				   profile->label.proxy, NULL, NULL,
+				   &profile->label.proxy->count, NULL, NULL,
 				   &rawdata_link_abi_iops);
 		if (IS_ERR(dent))
 			goto fail;
-		aa_get_proxy(profile->label.proxy);
 		profile->dents[AAFS_PROF_RAW_ABI] = dent;
 
 		dent = aafs_create("raw_data", S_IFLNK | 0444, dir,
-				   profile->label.proxy, NULL, NULL,
+				   &profile->label.proxy->count, NULL, NULL,
 				   &rawdata_link_data_iops);
 		if (IS_ERR(dent))
 			goto fail;
-		aa_get_proxy(profile->label.proxy);
 		profile->dents[AAFS_PROF_RAW_DATA] = dent;
 	}
 
@@ -1814,7 +1868,7 @@ static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
 	if (error)
 		return error;
 
-	parent = aa_get_ns(dir->i_private);
+	parent = get_ns_common_ref(dir->i_private);
 	AA_BUG(d_inode(ns_subns_dir(parent)) != dir);
 
 	/* we have to unlock and then relock to get locking order right
@@ -1864,7 +1918,7 @@ static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
 	if (error)
 		return error;
 
-	parent = aa_get_ns(dir->i_private);
+	parent = get_ns_common_ref(dir->i_private);
 	/* rmdir calls the generic securityfs functions to remove files
 	 * from the apparmor dir. It is up to the apparmor ns locking
 	 * to avoid races.
@@ -1934,27 +1988,6 @@ void __aafs_ns_rmdir(struct aa_ns *ns)
 
 	__aa_fs_list_remove_rawdata(ns);
 
-	if (ns_subns_dir(ns)) {
-		sub = d_inode(ns_subns_dir(ns))->i_private;
-		aa_put_ns(sub);
-	}
-	if (ns_subload(ns)) {
-		sub = d_inode(ns_subload(ns))->i_private;
-		aa_put_ns(sub);
-	}
-	if (ns_subreplace(ns)) {
-		sub = d_inode(ns_subreplace(ns))->i_private;
-		aa_put_ns(sub);
-	}
-	if (ns_subremove(ns)) {
-		sub = d_inode(ns_subremove(ns))->i_private;
-		aa_put_ns(sub);
-	}
-	if (ns_subrevision(ns)) {
-		sub = d_inode(ns_subrevision(ns))->i_private;
-		aa_put_ns(sub);
-	}
-
 	for (i = AAFS_NS_SIZEOF - 1; i >= 0; --i) {
 		aafs_remove(ns->dents[i]);
 		ns->dents[i] = NULL;
@@ -1979,40 +2012,40 @@ static int __aafs_ns_mkdir_entries(struct aa_ns *ns, struct dentry *dir)
 		return PTR_ERR(dent);
 	ns_subdata_dir(ns) = dent;
 
-	dent = aafs_create_file("revision", 0444, dir, ns,
+	dent = aafs_create_file("revision", 0444, dir,
+				&ns->unconfined->label.count,
 				&aa_fs_ns_revision_fops);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
-	aa_get_ns(ns);
 	ns_subrevision(ns) = dent;
 
-	dent = aafs_create_file(".load", 0640, dir, ns,
-				      &aa_fs_profile_load);
+	dent = aafs_create_file(".load", 0640, dir,
+				&ns->unconfined->label.count,
+				&aa_fs_profile_load);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
-	aa_get_ns(ns);
 	ns_subload(ns) = dent;
 
-	dent = aafs_create_file(".replace", 0640, dir, ns,
-				      &aa_fs_profile_replace);
+	dent = aafs_create_file(".replace", 0640, dir,
+				&ns->unconfined->label.count,
+				&aa_fs_profile_replace);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
-	aa_get_ns(ns);
 	ns_subreplace(ns) = dent;
 
-	dent = aafs_create_file(".remove", 0640, dir, ns,
-				      &aa_fs_profile_remove);
+	dent = aafs_create_file(".remove", 0640, dir,
+				&ns->unconfined->label.count,
+				&aa_fs_profile_remove);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
-	aa_get_ns(ns);
 	ns_subremove(ns) = dent;
 
 	  /* use create_dentry so we can supply private data */
-	dent = aafs_create("namespaces", S_IFDIR | 0755, dir, ns, NULL, NULL,
-			   &ns_dir_inode_operations);
+	dent = aafs_create("namespaces", S_IFDIR | 0755, dir,
+			   &ns->unconfined->label.count,
+			   NULL, NULL, &ns_dir_inode_operations);
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
-	aa_get_ns(ns);
 	ns_subns_dir(ns) = dent;
 
 	return 0;
diff --git a/security/apparmor/include/label.h b/security/apparmor/include/label.h
index 1e90384b1523..55986388dfae 100644
--- a/security/apparmor/include/label.h
+++ b/security/apparmor/include/label.h
@@ -103,7 +103,7 @@ enum label_flags {
 
 struct aa_label;
 struct aa_proxy {
-	struct kref count;
+	struct aa_common_ref count;
 	struct aa_label __rcu *label;
 };
 
@@ -123,7 +123,7 @@ struct label_it {
  * @ent: set of profiles for label, actual size determined by @size
  */
 struct aa_label {
-	struct kref count;
+	struct aa_common_ref count;
 	struct rb_node node;
 	struct rcu_head rcu;
 	struct aa_proxy *proxy;
@@ -373,7 +373,7 @@ int aa_label_match(struct aa_profile *profile, struct aa_label *label,
  */
 static inline struct aa_label *__aa_get_label(struct aa_label *l)
 {
-	if (l && kref_get_unless_zero(&l->count))
+	if (l && kref_get_unless_zero(&l->count.count))
 		return l;
 
 	return NULL;
@@ -382,7 +382,7 @@ static inline struct aa_label *__aa_get_label(struct aa_label *l)
 static inline struct aa_label *aa_get_label(struct aa_label *l)
 {
 	if (l)
-		kref_get(&(l->count));
+		kref_get(&(l->count.count));
 
 	return l;
 }
@@ -402,7 +402,7 @@ static inline struct aa_label *aa_get_label_rcu(struct aa_label __rcu **l)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*l);
-	} while (c && !kref_get_unless_zero(&c->count));
+	} while (c && !kref_get_unless_zero(&c->count.count));
 	rcu_read_unlock();
 
 	return c;
@@ -442,7 +442,7 @@ static inline struct aa_label *aa_get_newest_label(struct aa_label *l)
 static inline void aa_put_label(struct aa_label *l)
 {
 	if (l)
-		kref_put(&l->count, aa_label_kref);
+		kref_put(&l->count.count, aa_label_kref);
 }
 
 
@@ -452,7 +452,7 @@ void aa_proxy_kref(struct kref *kref);
 static inline struct aa_proxy *aa_get_proxy(struct aa_proxy *proxy)
 {
 	if (proxy)
-		kref_get(&(proxy->count));
+		kref_get(&(proxy->count.count));
 
 	return proxy;
 }
@@ -460,7 +460,7 @@ static inline struct aa_proxy *aa_get_proxy(struct aa_proxy *proxy)
 static inline void aa_put_proxy(struct aa_proxy *proxy)
 {
 	if (proxy)
-		kref_put(&proxy->count, aa_proxy_kref);
+		kref_put(&proxy->count.count, aa_proxy_kref);
 }
 
 void __aa_proxy_redirect(struct aa_label *orig, struct aa_label *new);
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index ac5054899f6f..624178827fd2 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -60,6 +60,18 @@ void aa_info_message(const char *str);
 /* Security blob offsets */
 extern struct lsm_blob_sizes apparmor_blob_sizes;
 
+enum reftype {
+	REF_NS,
+	REF_PROXY,
+	REF_RAWDATA,
+};
+
+/* common reference count used by data the shows up in aafs */
+struct aa_common_ref {
+	struct kref count;
+	enum reftype reftype;
+};
+
 /**
  * aa_strneq - compare null terminated @str to a non null terminated substring
  * @str: a null terminated string
diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
index 049405dad5a9..278c8ec2afd0 100644
--- a/security/apparmor/include/policy.h
+++ b/security/apparmor/include/policy.h
@@ -243,7 +243,7 @@ static inline unsigned int PROFILE_MEDIATES_AF(struct aa_profile *profile,
 static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_get(&(p->label.count));
+		kref_get(&(p->label.count.count));
 
 	return p;
 }
@@ -257,7 +257,7 @@ static inline struct aa_profile *aa_get_profile(struct aa_profile *p)
  */
 static inline struct aa_profile *aa_get_profile_not0(struct aa_profile *p)
 {
-	if (p && kref_get_unless_zero(&p->label.count))
+	if (p && kref_get_unless_zero(&p->label.count.count))
 		return p;
 
 	return NULL;
@@ -277,7 +277,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 	rcu_read_lock();
 	do {
 		c = rcu_dereference(*p);
-	} while (c && !kref_get_unless_zero(&c->label.count));
+	} while (c && !kref_get_unless_zero(&c->label.count.count));
 	rcu_read_unlock();
 
 	return c;
@@ -290,7 +290,7 @@ static inline struct aa_profile *aa_get_profile_rcu(struct aa_profile __rcu **p)
 static inline void aa_put_profile(struct aa_profile *p)
 {
 	if (p)
-		kref_put(&p->label.count, aa_label_kref);
+		kref_put(&p->label.count.count, aa_label_kref);
 }
 
 static inline int AUDIT_MODE(struct aa_profile *profile)
diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index 930b4f6132cf..61cc9b5b8a1f 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -67,7 +67,7 @@ enum {
  * fs entries and drops the associated @count ref.
  */
 struct aa_loaddata {
-	struct kref count;
+	struct aa_common_ref count;
 	struct kref pcount;
 	struct list_head list;
 	struct work_struct work;
@@ -102,7 +102,7 @@ aa_get_i_loaddata(struct aa_loaddata *data)
 {
 
 	if (data)
-		kref_get(&(data->count));
+		kref_get(&(data->count.count));
 	return data;
 }
 
@@ -130,7 +130,7 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size);
 static inline void aa_put_i_loaddata(struct aa_loaddata *data)
 {
 	if (data)
-		kref_put(&data->count, aa_loaddata_kref);
+		kref_put(&data->count.count, aa_loaddata_kref);
 }
 
 static inline void aa_put_profile_loaddata(struct aa_loaddata *data)
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 66bc4704f804..7cae71daa0f9 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -52,7 +52,8 @@ static void free_proxy(struct aa_proxy *proxy)
 
 void aa_proxy_kref(struct kref *kref)
 {
-	struct aa_proxy *proxy = container_of(kref, struct aa_proxy, count);
+	struct aa_proxy *proxy = container_of(kref, struct aa_proxy,
+					      count.count);
 
 	free_proxy(proxy);
 }
@@ -63,7 +64,8 @@ struct aa_proxy *aa_alloc_proxy(struct aa_label *label, gfp_t gfp)
 
 	new = kzalloc(sizeof(struct aa_proxy), gfp);
 	if (new) {
-		kref_init(&new->count);
+		kref_init(&new->count.count);
+		new->count.reftype = REF_PROXY;
 		rcu_assign_pointer(new->label, aa_get_label(label));
 	}
 	return new;
@@ -366,7 +368,8 @@ static void label_free_rcu(struct rcu_head *head)
 
 void aa_label_kref(struct kref *kref)
 {
-	struct aa_label *label = container_of(kref, struct aa_label, count);
+	struct aa_label *label = container_of(kref, struct aa_label,
+					      count.count);
 	struct aa_ns *ns = labels_ns(label);
 
 	if (!ns) {
@@ -403,7 +406,8 @@ bool aa_label_init(struct aa_label *label, int size, gfp_t gfp)
 
 	label->size = size;			/* doesn't include null */
 	label->vec[size] = NULL;		/* null terminate */
-	kref_init(&label->count);
+	kref_init(&label->count.count);
+	label->count.reftype = REF_NS;		/* for aafs purposes */
 	RB_CLEAR_NODE(&label->node);
 
 	return true;
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index ef02f04000d1..c670b25235a4 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -157,7 +157,8 @@ static void do_loaddata_free(struct aa_loaddata *d)
 
 void aa_loaddata_kref(struct kref *kref)
 {
-	struct aa_loaddata *d = container_of(kref, struct aa_loaddata, count);
+	struct aa_loaddata *d = container_of(kref, struct aa_loaddata,
+					     count.count);
 
 	do_loaddata_free(d);
 }
@@ -204,7 +205,8 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
 		kfree(d);
 		return ERR_PTR(-ENOMEM);
 	}
-	kref_init(&d->count);
+	kref_init(&d->count.count);
+	d->count.reftype = REF_RAWDATA;
 	kref_init(&d->pcount);
 	INIT_LIST_HEAD(&d->list);
 
-- 
2.51.0


