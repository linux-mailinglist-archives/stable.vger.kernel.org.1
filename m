Return-Path: <stable+bounces-26549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B2870F17
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654AE1F21AEF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C178B69;
	Mon,  4 Mar 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jeq6L+zw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B81EB5A;
	Mon,  4 Mar 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589044; cv=none; b=GvkGzD+YROYcZtPJeB+q4ywXw15xs3UYV7zUx4kMA2v3N8Ol8WeLIpcQ2OGKnyI0VmArzQIMIz4HPo3pwmK+gejOZrNsdMPcZ/26g9qArCMpC7TTBH/OeOU/Q37mZXxHumazRkS1IsGUScQKMP82SBzDJkA7ygzVsQnkueZ7xE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589044; c=relaxed/simple;
	bh=cTVRviDgs4B4U2A3R+USXDh8yrqrnz4XzgWX4pWbQWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewERsHi55gdrhUM7zH7oiu7O3zQ6kObUXGwo05NRI70rkN7yzHGmJBvDFpF/EQbqEbyCS1sBlCGf8NzA2imtZMsPJ6pXKuPHhivBkeUVBuNIQUGM94giDVasL5FBeezutDOwhnaP2J/MThWpJ3WhnSPOLCPxiO391rsQ2djE4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jeq6L+zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F3C433F1;
	Mon,  4 Mar 2024 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589044;
	bh=cTVRviDgs4B4U2A3R+USXDh8yrqrnz4XzgWX4pWbQWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeq6L+zwk9Zcq1weW+RltfkI9aW5EHNQTiKmb953ky3/MbDwJBu44gaPi+aVSnyAs
	 3ypOYOaQADsZyByGJmtoHt0mT+PdfcS33j5dNKSKbzCp4303fBjrSoE50wgqjkC/Mf
	 IOOWxiAKe1YiL2idzO1i7F9NYSwqv4ZPTgapvYiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1 155/215] NFSD: Clean up nfsd4_init_file()
Date: Mon,  4 Mar 2024 21:23:38 +0000
Message-ID: <20240304211601.929515951@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 81a21fa3e7fdecb3c5b97014f0fc5a17d5806cae ]

Name this function more consistently. I'm going to use nfsd4_file_
and nfsd4_file_hash_ for these helpers.

Change the @fh parameter to be const pointer for better type safety.

Finally, move the hash insertion operation to the caller. This is
typical for most other "init_object" type helpers, and it is where
most of the other nfs4_file hash table operations are located.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4278,11 +4278,9 @@ static struct nfs4_file *nfsd4_alloc_fil
 }
 
 /* OPEN Share state helper functions */
-static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
-				struct nfs4_file *fp)
-{
-	lockdep_assert_held(&state_lock);
 
+static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
+{
 	refcount_set(&fp->fi_ref, 1);
 	spin_lock_init(&fp->fi_lock);
 	INIT_LIST_HEAD(&fp->fi_stateids);
@@ -4300,7 +4298,6 @@ static void nfsd4_init_file(struct svc_f
 	INIT_LIST_HEAD(&fp->fi_lo_states);
 	atomic_set(&fp->fi_lo_recalls, 0);
 #endif
-	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
 }
 
 void
@@ -4718,7 +4715,8 @@ static struct nfs4_file *insert_file(str
 			fp->fi_aliased = alias_found = true;
 	}
 	if (likely(ret == NULL)) {
-		nfsd4_init_file(fh, hashval, new);
+		nfsd4_file_init(fh, new);
+		hlist_add_head_rcu(&new->fi_hash, &file_hashtbl[hashval]);
 		new->fi_aliased = alias_found;
 		ret = new;
 	}



