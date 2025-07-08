Return-Path: <stable+bounces-160858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87046AFD23F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AC4165745
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBF2E2F0D;
	Tue,  8 Jul 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zytlq4LZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD852DC34C;
	Tue,  8 Jul 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992895; cv=none; b=duk59GQTJNLAmEaw0z6B89C9KzD/Bt6fOo8kkm/Velde84aoTvrz8BBOhZQEwTuI8csGKNbncr9za/6JW26y1rEMOwlOETJl0yvo6FkOp9m3yx33nilALjhFBiWrTQ9VH8qq+5PCe9QX0XQgYov84USuG+GrgfCdqQb4W46zmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992895; c=relaxed/simple;
	bh=uQWZbevTLEldSguZORfw+iGvIDF5KxMrekAGbEFAYn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVjAXgCrfYr1y2CrJ/LeeSRhnIGmHem86uk8Q4qyhEgEqfttl1/bz9boQT1foisZ+23f+hPaCD4Rc1ZCTc0f6MtHoVr3OzVOCe2cmv/yLBiBb/6o6D/U9aOOSwz9xOb7Q1ihJsEeIaja/f/Rr6x8JWB2VRFOhhlFxkoWo85SKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zytlq4LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE08C4CEED;
	Tue,  8 Jul 2025 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992894;
	bh=uQWZbevTLEldSguZORfw+iGvIDF5KxMrekAGbEFAYn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zytlq4LZpC9lPviB31AM2Ws7vEDBIP3wll3YGMUzi6pSsDN+ILPjuAfqCOgmnGwsd
	 Xn6IaW1HYwza43GlPPLQ5RwZm2tZ64GGwyMOx16NIupUr582y5mHdZpxBvw/tbPiVr
	 HK91OGfFm3dnyJ3kc+q786LA+pjAi5f5LVELfCTA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 117/232] gfs2: Dont start unnecessary transactions during log flush
Date: Tue,  8 Jul 2025 18:21:53 +0200
Message-ID: <20250708162244.502253107@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 5a90f8d499225512a385585ffe3e28f687263d47 ]

Commit 8d391972ae2d ("gfs2: Remove __gfs2_writepage()") changed the log
flush code in gfs2_ail1_start_one() to call aops->writepages() instead
of aops->writepage().  For jdata inodes, this means that we will now try
to reserve log space and start a transaction before we can determine
that the pages in question have already been journaled.  When this
happens in the context of gfs2_logd(), it can now appear that not enough
log space is available for freeing up log space, and we will lock up.

Fix that by issuing journal writes directly instead of going through
aops->writepages() in the log flush code.

Fixes: 8d391972ae2d ("gfs2: Remove __gfs2_writepage()")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/aops.c | 31 +++++++++++++++++++++++++++++++
 fs/gfs2/aops.h |  1 +
 fs/gfs2/log.c  |  7 ++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ed2c708a215a4..eb4270e82ef8e 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -117,6 +117,37 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	return gfs2_write_jdata_folio(folio, wbc);
 }
 
+/**
+ * gfs2_jdata_writeback - Write jdata folios to the log
+ * @mapping: The mapping to write
+ * @wbc: The writeback control
+ *
+ * Returns: errno
+ */
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(mapping->host);
+	struct folio *folio = NULL;
+	int error;
+
+	BUG_ON(current->journal_info);
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+		return 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		if (folio_test_checked(folio)) {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			continue;
+		}
+		error = __gfs2_jdata_write_folio(folio, wbc);
+	}
+
+	return error;
+}
+
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index f9fa41aaeaf41..bf002522a7822 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -9,5 +9,6 @@
 #include "incore.h"
 
 void adjust_fs_space(struct inode *inode);
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc);
 
 #endif /* __AOPS_DOT_H__ */
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f9c5089783d24..115c4ac457e90 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -31,6 +31,7 @@
 #include "dir.h"
 #include "trace_gfs2.h"
 #include "trans.h"
+#include "aops.h"
 
 static void gfs2_log_shutdown(struct gfs2_sbd *sdp);
 
@@ -131,7 +132,11 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = mapping->a_ops->writepages(mapping, wbc);
+		BUG_ON(GFS2_SB(mapping->host) != sdp);
+		if (gfs2_is_jdata(GFS2_I(mapping->host)))
+			ret = gfs2_jdata_writeback(mapping, wbc);
+		else
+			ret = mapping->a_ops->writepages(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
-- 
2.39.5




