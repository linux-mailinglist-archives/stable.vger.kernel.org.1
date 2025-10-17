Return-Path: <stable+bounces-186496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B635BE9877
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6868C580748
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3A332905;
	Fri, 17 Oct 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D30WM9/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA9335079;
	Fri, 17 Oct 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713406; cv=none; b=k+ECd03vnzAEb57Vt+2F+zlu1pQCUJf7g2AamNsWHzwIp7N7ugCdv0ofxWRnU5bVBPpNh1Mej/LFobVOf0VgtAnD7S5BwSrLA+gZ947nRDfmKjjgAiiWZxZBMTne7R37dhZkDl6RLCE+Z9wCPvBm2//sNXuoPl6R8vqdIjUEYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713406; c=relaxed/simple;
	bh=MvggLcLor3peeyp+nShXT3t9c9JHXYksw2iXYUGg7Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+b4QXDm1ZyRKnf6ieEsWxF8YxcZDAJHGwxSG3oerC5+M5IQvDjfl3DRvpG6Lgtmz69sJl10XjPNbWnTJVZYHsosDX2AX0P73uFHkatY8tJxXLwB/4rABRJKQEPK23QEjmmVfA7qvF8p6T28Fz540WpIHVyR26TWSywTHVtb3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D30WM9/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A14C4CEE7;
	Fri, 17 Oct 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713406;
	bh=MvggLcLor3peeyp+nShXT3t9c9JHXYksw2iXYUGg7Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D30WM9/OhlSEyU/oa0MpWTajxrzJEos+y4lMmJr7A2lxQzRDpQr4bEgZSjyfmdMLG
	 oeYSGV/bNfIMf1XLuoRy41IZbbAG4+RRoF7ayDiLJl8sQGBRqwIqcNL1w9K9f6n9uO
	 Ft0BxOyClXJbEFYhTSkRmW90Uvo9sVqNBxnNBSZo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 127/168] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
Date: Fri, 17 Oct 2025 16:53:26 +0200
Message-ID: <20251017145133.703323047@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit ab1c282c010c4f327bd7addc3c0035fd8e3c1721 upstream.

Commit 5304877936c0 ("NFSD: Fix strncpy() fortify warning") replaced
strncpy(,, sizeof(..)) with strlcpy(,, sizeof(..) - 1), but strlcpy()
already guaranteed NUL-termination of the destination buffer and
subtracting one byte potentially truncated the source string.

The incorrect size was then carried over in commit 72f78ae00a8e ("NFSD:
move from strlcpy with unused retval to strscpy") when switching from
strlcpy() to strscpy().

Fix this off-by-one error by using the full size of the destination
buffer again.

Cc: stable@vger.kernel.org
Fixes: 5304877936c0 ("NFSD: Fix strncpy() fortify warning")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1334,7 +1334,7 @@ try_again:
 		return 0;
 	}
 	if (work) {
-		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
+		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);



