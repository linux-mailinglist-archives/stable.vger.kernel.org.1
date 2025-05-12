Return-Path: <stable+bounces-143743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD1AB4124
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51759467CEA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286EF23BF9F;
	Mon, 12 May 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOODMu4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0A175BF;
	Mon, 12 May 2025 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072935; cv=none; b=I0PVJgsgJzgzC8mhH+VzuMBYSS0Rtp83OS8L2rnMLTpwJ1DMdkLhmVCdw7WQ/9AQeMMfSkd6HOPHB1CyFC3bL0A8dEIKhOtJs0DdyFi+WOiQMJoTGB8binCuE70Qfz8iYQVdwpQXrKSNXAKO0hMeEXX0xK6Kg+Wpm4zOVMwJ1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072935; c=relaxed/simple;
	bh=DBFaoUtKnbPcFJJorXrfPW9MGstxkjX2F/YzsxjGi1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBHT8MyslWgQDrIjtAfySNcvdTiP+i79jOv9nw0MwFcGdUcChjQq0zwPeUNlqnffno0L5kl1Ppy/Xk0AXBGGWQk3O70ofJUVF6hsMSMt2fxnALZdxivCSmNP04t0S3syRVaJqDscP//WHM9G8ACGzQhxZvUadKmQYylxqTCBF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOODMu4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E1EC4CEE7;
	Mon, 12 May 2025 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072935;
	bh=DBFaoUtKnbPcFJJorXrfPW9MGstxkjX2F/YzsxjGi1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOODMu4wqWh/IcfOaUWQF1CoGrGFau2ct04YN85cznIY77Xdom7xPIRg0czrG60MJ
	 j6Lumdm+8j3QEEenHZYZqX93Q5wzklz91hMjJIqxalp86n3QeFyKZKD73PnJtW1zRB
	 fj7YDTWE/7dV36g3cbhzOzym57E+1cs6IzPu4BxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Paul Aurich <paul@darkrain42.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 103/184] smb: client: Avoid race in open_cached_dir with lease breaks
Date: Mon, 12 May 2025 19:45:04 +0200
Message-ID: <20250512172046.016840679@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Aurich <paul@darkrain42.org>

commit 3ca02e63edccb78ef3659bebc68579c7224a6ca2 upstream.

A pre-existing valid cfid returned from find_or_create_cached_dir might
race with a lease break, meaning open_cached_dir doesn't consider it
valid, and thinks it's newly-constructed. This leaks a dentry reference
if the allocation occurs before the queued lease break work runs.

Avoid the race by extending holding the cfid_list_lock across
find_or_create_cached_dir and when the result is checked.

Cc: stable@vger.kernel.org
Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -29,7 +29,6 @@ static struct cached_fid *find_or_create
 {
 	struct cached_fid *cfid;
 
-	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry(cfid, &cfids->entries, entry) {
 		if (!strcmp(cfid->path, path)) {
 			/*
@@ -38,25 +37,20 @@ static struct cached_fid *find_or_create
 			 * being deleted due to a lease break.
 			 */
 			if (!cfid->time || !cfid->has_lease) {
-				spin_unlock(&cfids->cfid_list_lock);
 				return NULL;
 			}
 			kref_get(&cfid->refcount);
-			spin_unlock(&cfids->cfid_list_lock);
 			return cfid;
 		}
 	}
 	if (lookup_only) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	if (cfids->num_entries >= max_cached_dirs) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid = init_cached_dir(path);
 	if (cfid == NULL) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid->cfids = cfids;
@@ -74,7 +68,6 @@ static struct cached_fid *find_or_create
 	 */
 	cfid->has_lease = true;
 
-	spin_unlock(&cfids->cfid_list_lock);
 	return cfid;
 }
 
@@ -185,8 +178,10 @@ replay_again:
 	if (!utf16_path)
 		return -ENOMEM;
 
+	spin_lock(&cfids->cfid_list_lock);
 	cfid = find_or_create_cached_dir(cfids, path, lookup_only, tcon->max_cached_dirs);
 	if (cfid == NULL) {
+		spin_unlock(&cfids->cfid_list_lock);
 		kfree(utf16_path);
 		return -ENOENT;
 	}
@@ -195,7 +190,6 @@ replay_again:
 	 * Otherwise, it is either a new entry or laundromat worker removed it
 	 * from @cfids->entries.  Caller will put last reference if the latter.
 	 */
-	spin_lock(&cfids->cfid_list_lock);
 	if (cfid->has_lease && cfid->time) {
 		spin_unlock(&cfids->cfid_list_lock);
 		*ret_cfid = cfid;



