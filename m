Return-Path: <stable+bounces-25829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444286FA4D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D781F2162F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814811713;
	Mon,  4 Mar 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cs1vbtCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4AB667
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535308; cv=none; b=MhJzrBJvfzNK8Yj6Ko7pBsN6gdER5VFqCgNJx5kk3mCbF0AeS82J3swqNwklMtsNS+3d6uTAGGSl70k5PePCrkAcTyQK+Y/LM3jVLEC/blukeShEZmpQcmyF2giltct6DU70N7IukSwVgRuP5Q37srzTSwoV/F1cKpPMKesCHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535308; c=relaxed/simple;
	bh=U2s7bfAFOChEmDuBBVYmlvFbwDIdb75L8NWY9rEGsKA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X3OvqEnaCGM83v9PPpZoVowrRTcNNcHXd/a6DI9gUcRDvVjbpADRsv40s18hrpBfaFwJf+9H892Je0PD82BSuc93hDzFJTR1jrUGpI29MgBq5k9/hJiu3ydfmH4xrCdxMsXm7vF8bT9p1XfOJK8VwHcmFkMz+/9O/TrmRINPcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cs1vbtCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BB8C433F1;
	Mon,  4 Mar 2024 06:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709535308;
	bh=U2s7bfAFOChEmDuBBVYmlvFbwDIdb75L8NWY9rEGsKA=;
	h=Subject:To:Cc:From:Date:From;
	b=cs1vbtCE+kToakNlafRQrbYzIaf2f7J0h8XGS3/wLkPxPx4ETTzOr3kLddbTBUYZH
	 PRT+6bbs7Hr2wyT53nq9WewH55RPTj+v/5XLzfo/DU0snfOG9xjsUgLusImZ/+Nqhj
	 f1DAdNu+pQ/ebjqwIk/4I5BPNgttapFj8Jw7A/d0=
Subject: FAILED: patch "[PATCH] ceph: switch to corrected encoding of max_xattr_size in" failed to apply to 6.6-stable tree
To: xiubli@redhat.com,idryomov@gmail.com,pdonnell@ibm.com,vshankar@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 07:55:05 +0100
Message-ID: <2024030405-life-despair-ad2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 51d31149a88b5c5a8d2d33f06df93f6187a25b4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030405-life-despair-ad2e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

51d31149a88b ("ceph: switch to corrected encoding of max_xattr_size in mdsmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51d31149a88b5c5a8d2d33f06df93f6187a25b4c Mon Sep 17 00:00:00 2001
From: Xiubo Li <xiubli@redhat.com>
Date: Mon, 19 Feb 2024 13:14:32 +0800
Subject: [PATCH] ceph: switch to corrected encoding of max_xattr_size in
 mdsmap

The addition of bal_rank_mask with encoding version 17 was merged
into ceph.git in Oct 2022 and made it into v18.2.0 release normally.
A few months later, the much delayed addition of max_xattr_size got
merged, also with encoding version 17, placed before bal_rank_mask
in the encoding -- but it didn't make v18.2.0 release.

The way this ended up being resolved on the MDS side is that
bal_rank_mask will continue to be encoded in version 17 while
max_xattr_size is now encoded in version 18.  This does mean that
older kernels will misdecode version 17, but this is also true for
v18.2.0 and v18.2.1 clients in userspace.

The best we can do is backport this adjustment -- see ceph.git
commit 78abfeaff27fee343fb664db633de5b221699a73 for details.

[ idryomov: changelog ]

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/64440
Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>
Reviewed-by: Venky Shankar <vshankar@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index fae97c25ce58..8109aba66e02 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -380,10 +380,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		ceph_decode_skip_8(p, end, bad_ext);
 		/* required_client_features */
 		ceph_decode_skip_set(p, end, 64, bad_ext);
+		/* bal_rank_mask */
+		ceph_decode_skip_string(p, end, bad_ext);
+	}
+	if (mdsmap_ev >= 18) {
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
-	} else {
-		/* This forces the usage of the (sync) SETXATTR Op */
-		m->m_max_xattr_size = 0;
 	}
 bad_ext:
 	doutc(cl, "m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
index 89f1931f1ba6..1f2171dd01bf 100644
--- a/fs/ceph/mdsmap.h
+++ b/fs/ceph/mdsmap.h
@@ -27,7 +27,11 @@ struct ceph_mdsmap {
 	u32 m_session_timeout;          /* seconds */
 	u32 m_session_autoclose;        /* seconds */
 	u64 m_max_file_size;
-	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
+	/*
+	 * maximum size for xattrs blob.
+	 * Zeroed by default to force the usage of the (sync) SETXATTR Op.
+	 */
+	u64 m_max_xattr_size;
 	u32 m_max_mds;			/* expected up:active mds number */
 	u32 m_num_active_mds;		/* actual up:active mds number */
 	u32 possible_max_rank;		/* possible max rank index */


