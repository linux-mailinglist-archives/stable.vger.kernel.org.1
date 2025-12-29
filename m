Return-Path: <stable+bounces-203625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2348CE71B0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF4030C9019
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362E32C94E;
	Mon, 29 Dec 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBLGTpXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C832D0CD
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018715; cv=none; b=FEgb27ppuNEwuaTTinpn8iuyxaqBFfGpLgTJ91ffzUFBfH6u+L0Oc7PWwssrPsmiMGCeyd7gQbCovmzOJnhKE80ndDVfoF+Lr8c8U0x2g0iN+QTn7EMoiyKteKbeAU2RMusxe87KMpXPD8OTs9vPDN0diQeZ8Dq+I6kbyASjCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018715; c=relaxed/simple;
	bh=bfCeZpdsbaxez7wnbCCYr7tnK3iHelwMjqd4g9gqi/M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qWEmBx4BUFjsJzKWB0y4Hg2iBWUaXHvvmMPFHc6LcFgSoXaulk4ApnOsOAfw6jofw/6bjnUvoDFkEHUTF6ubqvBOsfMGukiydn+IsqY8oxI7lEr1kUv0TDt7VwXvTAXxEf3a7TXF6DuoXfcVJOBPJ2qoa4BSi6z7CvpFAtMIeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBLGTpXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0268C116C6;
	Mon, 29 Dec 2025 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018715;
	bh=bfCeZpdsbaxez7wnbCCYr7tnK3iHelwMjqd4g9gqi/M=;
	h=Subject:To:Cc:From:Date:From;
	b=MBLGTpXqr82kMi1K/zBZn1zQIaiioHDvX4uBzYWOR9cWSMbl4+PkQ+oQyV67a04Zd
	 rQ0vk0yJDbqMo4X3P4v8FcDDwAzzVOWXVvlZCKql47tcW61gGzXn+ZAiKPbRyyj+kP
	 TazbCISTK9fwj3jPDvf5FzNZWHtAXpRUBJDU70Ls=
Subject: FAILED: patch "[PATCH] NFSD: NFSv4 file creation neglects setting ACL" failed to apply to 5.15-stable tree
To: chuck.lever@oracle.com,aurelien.couderc2002@gmail.com,roland.mainz@nrubsig.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:31:42 +0100
Message-ID: <2025122942-omit-compress-a9fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 913f7cf77bf14c13cfea70e89bcb6d0b22239562
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122942-omit-compress-a9fe@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 913f7cf77bf14c13cfea70e89bcb6d0b22239562 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 18 Nov 2025 19:51:19 -0500
Subject: [PATCH] NFSD: NFSv4 file creation neglects setting ACL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An NFSv4 client that sets an ACL with a named principal during file
creation retrieves the ACL afterwards, and finds that it is only a
default ACL (based on the mode bits) and not the ACL that was
requested during file creation. This violates RFC 8881 section
6.4.1.3: "the ACL attribute is set as given".

The issue occurs in nfsd_create_setattr(), which calls
nfsd_attrs_valid() to determine whether to call nfsd_setattr().
However, nfsd_attrs_valid() checks only for iattr changes and
security labels, but not POSIX ACLs. When only an ACL is present,
the function returns false, nfsd_setattr() is skipped, and the
POSIX ACL is never applied to the inode.

Subsequently, when the client retrieves the ACL, the server finds
no POSIX ACL on the inode and returns one generated from the file's
mode bits rather than returning the originally-specified ACL.

Reported-by: Aurélien Couderc <aurelien.couderc2002@gmail.com>
Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: Roland Mainz <roland.mainz@nrubsig.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index fa46f8b5f132..1dd3ae3ceb3a 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -67,7 +67,8 @@ static inline bool nfsd_attrs_valid(struct nfsd_attrs *attrs)
 	struct iattr *iap = attrs->na_iattr;
 
 	return (iap->ia_valid || (attrs->na_seclabel &&
-		attrs->na_seclabel->len));
+		attrs->na_seclabel->len) ||
+		attrs->na_pacl || attrs->na_dpacl);
 }
 
 __be32		nfserrno (int errno);


