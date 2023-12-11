Return-Path: <stable+bounces-5814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89280D738
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89038B20F48
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D332A53E3C;
	Mon, 11 Dec 2023 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="moVwCp+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2B51C58;
	Mon, 11 Dec 2023 18:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EF2C433C9;
	Mon, 11 Dec 2023 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319733;
	bh=/s7gEbdJwaHW0VD1uv7csXpND0bUYxljaP+fhJAoeWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moVwCp+kTMLRyAK/s97NqVHKFGNLsPdMo6Zx629W8EzuZQ8fQrMYYBvbCfnkRjciy
	 XuSruE+wSwhajrKvOFpH9fVQlT5adBVk3C5mBLYGHFKzhazijd/2943RJtSY6KSgts
	 aU/lxkRwmHYjds1wXU8h5NQNCXxeTZ+8nanYz180=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <david@fromorbit.com>,
	Xiaoli Feng <fengxiaoli0714@gmail.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Darrick Wong <darrick.wong@oracle.com>,
	fstests@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 215/244] cifs: Fix non-availability of dedup breaking generic/304
Date: Mon, 11 Dec 2023 19:21:48 +0100
Message-ID: <20231211182055.610436726@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 691a41d8da4b34fe72f09393505f55f28a8f34ec upstream.

Deduplication isn't supported on cifs, but cifs doesn't reject it, instead
treating it as extent duplication/cloning.  This can cause generic/304 to go
silly and run for hours on end.

Fix cifs to indicate EOPNOTSUPP if REMAP_FILE_DEDUP is set in
->remap_file_range().

Note that it's unclear whether or not commit b073a08016a1 is meant to cause
cifs to return an error if REMAP_FILE_DEDUP.

Fixes: b073a08016a1 ("cifs: fix that return -EINVAL when do dedupe operation")
Cc: stable@vger.kernel.org
Suggested-by: Dave Chinner <david@fromorbit.com>
cc: Xiaoli Feng <fengxiaoli0714@gmail.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Darrick Wong <darrick.wong@oracle.com>
cc: fstests@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/3876191.1701555260@warthog.procyon.org.uk/
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1208,7 +1208,9 @@ static loff_t cifs_remap_file_range(stru
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");



