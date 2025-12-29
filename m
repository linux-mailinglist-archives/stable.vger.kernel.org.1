Return-Path: <stable+bounces-203619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2130CE7111
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D307630222C0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33B32B9A4;
	Mon, 29 Dec 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gY+6Vg90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861132B9A1
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018684; cv=none; b=nMeJveAD4zx+yIRVGvFHor55i4281gqELggq3lEmNTVhcYS6mt93e7skT9hJsS/pR3TafxHy9dYIj/M12nwXlxwuYJa2wTeS922q3F0KxZw0les6lDxLrA6aiGaCucQVcr3v5lyWYTYOxldDwy1JFG7PHeb4SEaZ8EZCEk81YMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018684; c=relaxed/simple;
	bh=m8IA0qJN+Ho+CapD+PPpuMZpFat2EgaJbVe8sJZYsko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gBNfeRDdJDMgZRo38sbrhzFb3Psp1mypw1mIQeN8tb/zpJFxeCAcYs7VDH++EPl5m9r4Eqyqib/266a1nYtGhXmAYgRW6PQxkmTr2KXqYVggPoELsenW1P2VHcuk0rUFweCm7CVyWnCyTMlPqJXOWQp7AbHMDCpp89++Aanzjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gY+6Vg90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23339C4CEF7;
	Mon, 29 Dec 2025 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018682;
	bh=m8IA0qJN+Ho+CapD+PPpuMZpFat2EgaJbVe8sJZYsko=;
	h=Subject:To:Cc:From:Date:From;
	b=gY+6Vg90UM8qzBVgDGWdbu9np1xQWPHYQ8jyydEc3MNjyjdNGgEaq2YzUqerAHwsN
	 2SwTyLAS3RnLKkt0OTLcDZsryKnYOFKmqe+G2al0xZ6TO38tgBu7orJLVIOuR1Xh/W
	 ntWtQ1JthpjIa+PAcGdPssxI7lOzu6fSwp/Bvu0E=
Subject: FAILED: patch "[PATCH] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap" failed to apply to 6.6-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:31:19 +0100
Message-ID: <2025122919-carried-livestock-9465@gregkh>
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
git cherry-pick -x 27d17641cacfedd816789b75d342430f6b912bd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122919-carried-livestock-9465@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27d17641cacfedd816789b75d342430f6b912bd2 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 17 Nov 2025 11:00:49 -0500
Subject: [PATCH] NFSD: Clear SECLABEL in the suppattr_exclcreat bitmap

>From RFC 8881:

5.8.1.14. Attribute 75: suppattr_exclcreat

> The bit vector that would set all REQUIRED and RECOMMENDED
> attributes that are supported by the EXCLUSIVE4_1 method of file
> creation via the OPEN operation. The scope of this attribute
> applies to all objects with a matching fsid.

There's nothing in RFC 8881 that states that suppattr_exclcreat is
or is not allowed to contain bits for attributes that are clear in
the reported supported_attrs bitmask. But it doesn't make sense for
an NFS server to indicate that it /doesn't/ implement an attribute,
but then also indicate that clients /are/ allowed to set that
attribute using OPEN(create) with EXCLUSIVE4_1.

Ensure that the SECURITY_LABEL and ACL bits are not set in the
suppattr_exclcreat bitmask when they are also not set in the
supported_attrs bitmask.

Fixes: 8c18f2052e75 ("nfsd41: SUPPATTR_EXCLCREAT attribute")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 30ce5851fe4c..51ef97c25456 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3375,6 +3375,11 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	u32 supp[3];
 
 	memcpy(supp, nfsd_suppattrs[resp->cstate.minorversion], sizeof(supp));
+	if (!IS_POSIXACL(d_inode(args->dentry)))
+		supp[0] &= ~FATTR4_WORD0_ACL;
+	if (!args->contextsupport)
+		supp[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+
 	supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
 	supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
 	supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;


