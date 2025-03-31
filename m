Return-Path: <stable+bounces-127276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3EA77138
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 01:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CE91886AE6
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E9213E8E;
	Mon, 31 Mar 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgaPMSvN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1E1C3BEE
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462221; cv=none; b=qUF/LomoZMwUQONabXweU35i6QlKOczrTDuPUGuMUC8dgouRwQGLQaCq+9tNMXFpVWylZUh15bHVv+iSM/XRSgmuILuJ1lVBB+a8z/6qsrmG6oHeyieC/yzS1/JFim+jH/mrJMSiwOUCJWc2fXd2Z27lFgEsUifbhlilnLzMdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462221; c=relaxed/simple;
	bh=7XDEm3xnBMabMie0X+xQgILFf2Y46w1GaIYi4jDRVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzG2ID8utN9JBDKW/r5Jj8e839klxsIoT2aZ0L4UX1xS+2//8PH4zj3+QvNUrfS35L67F9YHoAKkY8igvloDa1gewE5fErWA9K9kW8MoDSORaJdFhEF84UUpOrFTZp4jNrI6b2BEF2yJK+RWqHnQJrl4RrokvF/odJXGDJ2M6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgaPMSvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743462218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zt6kHulVIbJ3+AveafgybtfOEriW75akq2NhkMrNTrI=;
	b=TgaPMSvNVSSdjre//2mFcXLA08ZCvVZdLfm+Lea43gEY1Jb9Xp94IF9TwytakB2cgE+FN2
	1OoevoC+DtJYN3zAarpiTSw1fhPfXhJ2biMOG5ADqFhNA8xqgEiLQb+w5rmrBQgg30czDC
	bKHGXk8NefJXU/jJ6g0zPZDqG5hIVr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-2CXXsHeKOKGrbEFlm0lUGg-1; Mon,
 31 Mar 2025 19:03:35 -0400
X-MC-Unique: 2CXXsHeKOKGrbEFlm0lUGg-1
X-Mimecast-MFC-AGG-ID: 2CXXsHeKOKGrbEFlm0lUGg_1743462214
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E889E1955BC9;
	Mon, 31 Mar 2025 23:03:33 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0F9F180B488;
	Mon, 31 Mar 2025 23:03:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: agruenba@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	david.laight.linux@gmail.com,
	aahringo@redhat.com
Subject: [PATCHv2 gfs2/for-next] gfs2: move msleep to sleepable context
Date: Mon, 31 Mar 2025 19:03:24 -0400
Message-ID: <20250331230324.1266587-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch moves the msleep_interruptible() out of the non-sleepable
context by moving the ls->ls_recover_spin spinlock around so
msleep_interruptible() will be called in a sleepable context.

Cc: stable@vger.kernel.org
Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - move the spinlock around to avoid schedule under spinlock

 fs/gfs2/lock_dlm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..2c9172dd41e7 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -996,14 +996,15 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
+			spin_unlock(&ls->ls_recover_spin);
 			msleep_interruptible(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
 				start_gen, mount_gen, lvb_gen,
 				ls->ls_recover_flags);
+			spin_unlock(&ls->ls_recover_spin);
 		}
-		spin_unlock(&ls->ls_recover_spin);
 		goto restart;
 	}
 
-- 
2.43.0


