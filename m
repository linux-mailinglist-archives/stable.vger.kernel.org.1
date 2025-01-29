Return-Path: <stable+bounces-111221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8AA22437
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D725A3A96C7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFF1E1A3D;
	Wed, 29 Jan 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKF5Ei03"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286A1E0DE3
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176464; cv=none; b=FI6LwUwa8ORLqrbWhA5Ncr4T6LxzHW0+KDGqlsnufxxAAYAhgI3L2rlaH+heSWIkc1tcKY4ShPNvEcCvqYrAlxCBSCtgEE0v3WI24iUHM8xuznZEVevtKkCqnjz9gZxVxkaBw9BuOzZhrZgkYBAFWkVRysf+OA5luHUoEDWZz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176464; c=relaxed/simple;
	bh=L4Ol4OT4NOv8S38AY3syFtI3idmOxKHo2YflCq6AGKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8cMi/ImpD3r87LEQs+lwfLG0z4RHWR7o4TE+VgqBM5P+QvlQsiZDY07KrGXLnA3mcbnjQa+PN2BATSTotFE1362GGmLC7+0yDaWCxUgZ2tCqa+GXAjvQW/NZ0sAPOBqRJ/XkNTLMwq+Q0MjbbOAL6sXews7ChQXC8nNwkXANhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKF5Ei03; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so17017305ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176462; x=1738781262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNK+v1z0/QyWa9hypk7D4jQcoMsN9/XcrnkQrlQ6VRE=;
        b=dKF5Ei034ivNEvpwBuinejlu35nH1ZKbKkc9I7oGo4XwH4jtcMWmeFZCTN1zhaZzZ5
         O8sAPyk6r/YqDtrGauBRa2igHDIeD7bqtDOcbXagE3w4jrSRD4FJ+VAsvlf3k4wrp5mB
         +ZFpTSJzpT9kAb9SvWHvun9dfZqgwPhP1nZnHF+mPGGTwuDHAY4RRhMgZiir3ibdrL2G
         axTKfTRFbzfPawzxxAZwWHs4gL7hRYbSUyoZ0/wViDv3NxBoE4VSpJ5siKOCeElLQbAG
         Jp0Af5rblaAUCMz5zsEccVlXR/U3bAfjh3dC2r28hJ60JmMxuN724ehh07Zxbu9XdA5p
         SceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176462; x=1738781262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNK+v1z0/QyWa9hypk7D4jQcoMsN9/XcrnkQrlQ6VRE=;
        b=J+qcTKfbRnKHEPa3suXE3J4ea8Tti1snfe/njQdM17RmcSt88bcTHuyHIdIPR4P3eI
         Wye40TzRFH3y7aE7b/xa8WehLYf5eHQS24v9OVfQtcdBgev4rOBIWKh8Fk7lsAslOsm3
         LArYbMhmBbez3vjxY43088M1XKQBuYJZh2m6XA6i9J8oe4GPwD6PjCzfdHueYkLh0nGW
         EYiLlI1W8HSGw1uLzr8PFXjM18rn97m/oWzQSWzaTfy+49fGd8hVb/eC5EY87SCITIwE
         ybBfaAr08iLaJk3y+XvDVA/udVc3R7uBjuQNWf1/Y9WMDx/pZmiJwm9niHyBragIRtH/
         AMqg==
X-Gm-Message-State: AOJu0Yw3oQ1Q506dR5teCMs0iBubCMpTJZaS2GiqQLM6TEIPvwqdmC4P
	P6ep9s9nj8tYwNLgcZE9QKLJLWYcYrrT9LjBjg8LmgBabe5P+3sdC4kmL6W4
X-Gm-Gg: ASbGncvE56kQVOLCAhQrQ8Bl795mk8kJew/BlLtTFmuHH//JNzL7v9jokVnoNG3hSlG
	rRtv5HqsAFqgwPkVBeT76EX2TEM82i65gWpSbqFx+Im7VK4H+85ZINhFtReSygCJXmYOZDXObYM
	aTDnY++FbnCkEh5pOts2tUUzPmz2vsOqecpnLj66evOLohJYY/cLJWTBUleGTD19Fy1R1oMmiBk
	dus82yH/NC39ButUfd1GVVQq3jnsys/7YiVw5qIMlweVW3pgS5t8PWCvKQUkDYRs3jCO7Gye4gg
	R6EbH+nM0oftOtEUvM+ngBKvnfPNkGXUuuUVJJLCKuA=
X-Google-Smtp-Source: AGHT+IHAmvwnzsaiFOi+X+fEaxVePsMQvyxpyhpMSBT5GH6oLDPPiiN4dZi1iYTSgfu5v3MUWbcZiQ==
X-Received: by 2002:a17:902:e801:b0:216:61d2:46b8 with SMTP id d9443c01a7336-21dd7d79136mr64490485ad.23.1738176460768;
        Wed, 29 Jan 2025 10:47:40 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:40 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 10/19] xfs: factor out xfs_defer_pending_abort
Date: Wed, 29 Jan 2025 10:47:08 -0800
Message-ID: <20250129184717.80816-11-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 2a5db859c6825b5d50377dda9c3cc729c20cad43 ]

Factor out xfs_defer_pending_abort() from xfs_defer_trans_abort(), which
not use transaction parameter, so it can be used after the transaction
life cycle.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_defer.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 5a321b783398..c9adb649e9b3 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -243,32 +243,39 @@ xfs_defer_create_intents(
 		ret |= ret2;
 	}
 	return ret;
 }
 
-/* Abort all the intents that were committed. */
 STATIC void
-xfs_defer_trans_abort(
-	struct xfs_trans		*tp,
-	struct list_head		*dop_pending)
+xfs_defer_pending_abort(
+	struct xfs_mount		*mp,
+	struct list_head		*dop_list)
 {
 	struct xfs_defer_pending	*dfp;
 	const struct xfs_defer_op_type	*ops;
 
-	trace_xfs_defer_trans_abort(tp, _RET_IP_);
-
 	/* Abort intent items that don't have a done item. */
-	list_for_each_entry(dfp, dop_pending, dfp_list) {
+	list_for_each_entry(dfp, dop_list, dfp_list) {
 		ops = defer_op_types[dfp->dfp_type];
-		trace_xfs_defer_pending_abort(tp->t_mountp, dfp);
+		trace_xfs_defer_pending_abort(mp, dfp);
 		if (dfp->dfp_intent && !dfp->dfp_done) {
 			ops->abort_intent(dfp->dfp_intent);
 			dfp->dfp_intent = NULL;
 		}
 	}
 }
 
+/* Abort all the intents that were committed. */
+STATIC void
+xfs_defer_trans_abort(
+	struct xfs_trans		*tp,
+	struct list_head		*dop_pending)
+{
+	trace_xfs_defer_trans_abort(tp, _RET_IP_);
+	xfs_defer_pending_abort(tp->t_mountp, dop_pending);
+}
+
 /*
  * Capture resources that the caller said not to release ("held") when the
  * transaction commits.  Caller is responsible for zero-initializing @dres.
  */
 static int
-- 
2.48.1.362.g079036d154-goog


