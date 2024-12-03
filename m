Return-Path: <stable+bounces-96969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE489E21F1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6100728172E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A81F1317;
	Tue,  3 Dec 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2AvbPCWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2F646;
	Tue,  3 Dec 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239129; cv=none; b=I/HQbO3/Ezago1i0Cyx2jSu5l3KI56feiiEijdDYj/uZU4M7yWCpQzYtK8nLdB285D3ut1l0kpjxpGsGGpQ/jy5g2ix1YpN/Zrk1fznMNZHGnbsAI2gMtEF84Bvwz6JEsvpvqlCNugu1GGSTu9OsZ+uyjP8vzY/ZN6hCmyjlWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239129; c=relaxed/simple;
	bh=pXFLoBQBBj5xDLJ5lb5NGl/dFjLvarERV62FJx1bAlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zei7nFwB+CjFY6Eq2dKcGt1Nnb0IUFvIaOxomBHWiHFzUGuRY4ONnVWYadNXgoVjUVOnwTubrhFWkyamoebGQIMRtVDBsHmWKZov5MP2Nj6Jub4R1iGPnvyvVPo25cl1nFdJkEUEUIz+DttymAZOx61Qc9aX5en7eWTZ9jTxdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2AvbPCWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC0FC4CECF;
	Tue,  3 Dec 2024 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239129;
	bh=pXFLoBQBBj5xDLJ5lb5NGl/dFjLvarERV62FJx1bAlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2AvbPCWDQJ6+dq3jcgm2bCkpVAMta25LDch4Q5ae+v0jliHEb0JxAXi2onZ/lMH5R
	 T+9831zx68qR3TQ2FTOBIxlW/kVaSLE+hagrIgKjl4zfZCd7HV3H8T99biNIqe9WPu
	 bNYvPeJPmFApzRJ3kbWUyoE/ePi4HX/gjSzwfNbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 482/817] gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
Date: Tue,  3 Dec 2024 15:40:54 +0100
Message-ID: <20241203144014.686295179@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 820ce8ed53ce2111aa5171f7349f289d7e9d0693 ]

Rename the GLF_VERIFY_EVICT flag to GLF_VERIFY_DELETE: that flag
indicates that we want to delete an inode / verify that it has been
deleted.

To match, rename gfs2_queue_verify_evict() to
gfs2_queue_verify_delete().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: 7c6f714d8847 ("gfs2: Fix unlinked inode cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c  | 14 +++++++-------
 fs/gfs2/incore.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4775c2cb8ae1b..301139db908bf 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1013,11 +1013,11 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 				  &gl->gl_delete, 0);
 }
 
-static bool gfs2_queue_verify_evict(struct gfs2_glock *gl)
+static bool gfs2_queue_verify_delete(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (test_and_set_bit(GLF_VERIFY_EVICT, &gl->gl_flags))
+	if (test_and_set_bit(GLF_VERIFY_DELETE, &gl->gl_flags))
 		return false;
 	return queue_delayed_work(sdp->sd_delete_wq,
 				  &gl->gl_delete, 5 * HZ);
@@ -1052,19 +1052,19 @@ static void delete_work_func(struct work_struct *work)
 		if (gfs2_try_evict(gl)) {
 			if (test_bit(SDF_KILL, &sdp->sd_flags))
 				goto out;
-			if (gfs2_queue_verify_evict(gl))
+			if (gfs2_queue_verify_delete(gl))
 				return;
 		}
 		goto out;
 	}
 
-	if (test_and_clear_bit(GLF_VERIFY_EVICT, &gl->gl_flags)) {
+	if (test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags)) {
 		inode = gfs2_lookup_by_inum(sdp, no_addr, gl->gl_no_formal_ino,
 					    GFS2_BLKST_UNLINKED);
 		if (IS_ERR(inode)) {
 			if (PTR_ERR(inode) == -EAGAIN &&
 			    !test_bit(SDF_KILL, &sdp->sd_flags) &&
-			    gfs2_queue_verify_evict(gl))
+			    gfs2_queue_verify_delete(gl))
 				return;
 		} else {
 			d_prune_aliases(inode);
@@ -2116,7 +2116,7 @@ static void glock_hash_walk(glock_examiner examiner, const struct gfs2_sbd *sdp)
 void gfs2_cancel_delete_work(struct gfs2_glock *gl)
 {
 	clear_bit(GLF_TRY_TO_EVICT, &gl->gl_flags);
-	clear_bit(GLF_VERIFY_EVICT, &gl->gl_flags);
+	clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags);
 	if (cancel_delayed_work(&gl->gl_delete))
 		gfs2_glock_put(gl);
 }
@@ -2369,7 +2369,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'N';
 	if (test_bit(GLF_TRY_TO_EVICT, gflags))
 		*p++ = 'e';
-	if (test_bit(GLF_VERIFY_EVICT, gflags))
+	if (test_bit(GLF_VERIFY_DELETE, gflags))
 		*p++ = 'E';
 	*p = 0;
 	return buf;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index aa4ef67a34e03..bd1348bff90eb 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -329,7 +329,7 @@ enum {
 	GLF_BLOCKING			= 15,
 	GLF_UNLOCKED			= 16, /* Wait for glock to be unlocked */
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
-	GLF_VERIFY_EVICT		= 18, /* iopen glocks only */
+	GLF_VERIFY_DELETE		= 18, /* iopen glocks only */
 };
 
 struct gfs2_glock {
-- 
2.43.0




