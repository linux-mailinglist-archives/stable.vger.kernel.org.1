Return-Path: <stable+bounces-84064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FE99CDF7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379D51C22FD0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EB1AAE02;
	Mon, 14 Oct 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHogdBhm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1425632;
	Mon, 14 Oct 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916694; cv=none; b=mSmTCUiFv6AhugvOo1HVpB6Foh880A/miHbyz1Xe9oK8mUIjSsOC6pvyUCooTrZoulOi+irnVzgRQp+HWPHTUvDc/vmVNcMmVzfulPD0QlYADOt/ysWgmP4hguil2slnHLN/XwI6Zb2doOU6KuOMAu+3v7HTG2u0TCmoFfYoNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916694; c=relaxed/simple;
	bh=CihRgVg5x0fyYgOhz/khYr5zQu8ePwcpXTKINz5lVJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUev90PjeHYkAEt9kToKB8BlndUueFlZbmtSyEwRvn93iHbGUjNgi8trGpUYlN+CAinquvJE9Pkd52+FzMiLv+c5v22lMrRMvhHQkTalPyjxqf2q8V057B/55Xw6XMfKDIosF9VMY4L4gqhQdlZTYivPg0NFj2dJjBg60NJh3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HHogdBhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044CC4CEC3;
	Mon, 14 Oct 2024 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916693;
	bh=CihRgVg5x0fyYgOhz/khYr5zQu8ePwcpXTKINz5lVJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHogdBhm8KI7gV47ft42RSMzPGQzKzNQCnE0MXv2Ra8iYBVcnZvqS+UzbK9xIOCBo
	 tWHMwrFaTEWkUdvv7WKfld6dL0ByfdkWvV8OZ7pvdnFa9I8O0cfT6EZSAFpM50h1B9
	 wZ85mY33KEw3Fa2yoiqmTnOex+p27GF64FeyEqY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/213] gfs2: qd_check_sync cleanups
Date: Mon, 14 Oct 2024 16:18:34 +0200
Message-ID: <20241014141043.304538038@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 59ebc33201237bf38e5adca3794716100660c5b4 ]

Rename qd_check_sync() to qd_grab_sync() and make it return a bool.
Turn the sync_gen pointer into a regular u64 and pass in U64_MAX instead
of a NULL pointer when sync generation checking isn't needed.

Introduce a new qd_ungrab_sync() helper for undoing the effects of
qd_grab_sync() if the subsequent bh_get() on the qd object fails.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: 4b4b6374dc61 ("gfs2: Revert "ignore negated quota changes"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 62522d4011106..ed602352fe1d3 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -446,13 +446,13 @@ static void bh_put(struct gfs2_quota_data *qd)
 	mutex_unlock(&sdp->sd_quota_mutex);
 }
 
-static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
-			 u64 *sync_gen)
+static bool qd_grab_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
+			 u64 sync_gen)
 {
 	if (test_bit(QDF_LOCKED, &qd->qd_flags) ||
 	    !test_bit(QDF_CHANGE, &qd->qd_flags) ||
-	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
-		return 0;
+	    qd->qd_sync_gen >= sync_gen)
+		return false;
 
 	/*
 	 * If qd_change is 0 it means a pending quota change was negated.
@@ -462,17 +462,24 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
 		slot_put(qd);
 		qd_put(qd);
-		return 0;
+		return false;
 	}
 
 	if (!lockref_get_not_dead(&qd->qd_lockref))
-		return 0;
+		return false;
 
 	list_move_tail(&qd->qd_list, &sdp->sd_quota_list);
 	set_bit(QDF_LOCKED, &qd->qd_flags);
 	qd->qd_change_sync = qd->qd_change;
 	slot_hold(qd);
-	return 1;
+	return true;
+}
+
+static void qd_ungrab_sync(struct gfs2_quota_data *qd)
+{
+	clear_bit(QDF_LOCKED, &qd->qd_flags);
+	slot_put(qd);
+	qd_put(qd);
 }
 
 static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
@@ -488,7 +495,7 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 	spin_lock(&qd_lock);
 
 	list_for_each_entry(iter, &sdp->sd_quota_list, qd_list) {
-		if (qd_check_sync(sdp, iter, &sdp->sd_quota_sync_gen)) {
+		if (qd_grab_sync(sdp, iter, sdp->sd_quota_sync_gen)) {
 			qd = iter;
 			break;
 		}
@@ -499,9 +506,7 @@ static int qd_fish(struct gfs2_sbd *sdp, struct gfs2_quota_data **qdp)
 	if (qd) {
 		error = bh_get(qd);
 		if (error) {
-			clear_bit(QDF_LOCKED, &qd->qd_flags);
-			slot_put(qd);
-			qd_put(qd);
+			qd_ungrab_sync(qd);
 			return error;
 		}
 	}
@@ -1139,7 +1144,6 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	struct gfs2_quota_data *qda[2 * GFS2_MAXQUOTAS];
 	unsigned int count = 0;
 	u32 x;
-	int found;
 
 	if (!test_and_clear_bit(GIF_QD_LOCKED, &ip->i_flags))
 		return;
@@ -1147,6 +1151,7 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 	for (x = 0; x < ip->i_qadata->qa_qd_num; x++) {
 		struct gfs2_quota_data *qd;
 		bool sync;
+		int error;
 
 		qd = ip->i_qadata->qa_qd[x];
 		sync = need_sync(qd);
@@ -1156,17 +1161,16 @@ void gfs2_quota_unlock(struct gfs2_inode *ip)
 			continue;
 
 		spin_lock(&qd_lock);
-		found = qd_check_sync(sdp, qd, NULL);
+		sync = qd_grab_sync(sdp, qd, U64_MAX);
 		spin_unlock(&qd_lock);
 
-		if (!found)
+		if (!sync)
 			continue;
 
 		gfs2_assert_warn(sdp, qd->qd_change_sync);
-		if (bh_get(qd)) {
-			clear_bit(QDF_LOCKED, &qd->qd_flags);
-			slot_put(qd);
-			qd_put(qd);
+		error = bh_get(qd);
+		if (error) {
+			qd_ungrab_sync(qd);
 			continue;
 		}
 
-- 
2.43.0




