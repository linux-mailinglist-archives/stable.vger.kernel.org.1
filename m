Return-Path: <stable+bounces-127266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA2A76D84
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06C3166843
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDD194080;
	Mon, 31 Mar 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7KG4n26"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5BB18D
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449826; cv=none; b=VBaxcja7PhsyLAJ3qwOhpwrpQLvx3VRO6WnQRmGsmA12K4aaWxTqCS5EnK28sn3GSYeqKSuSNMalP9INA/h0uz7TUI0jJMJDcIj92kQGYXwbk0YLHjap8c3VykhAniwhL8uUSV0lAc0tmWsfGQRH5GRg7e4jYvLzRFnjuNXKQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449826; c=relaxed/simple;
	bh=wS0MPg0Vrq8XaIBsH1FRIvlQR9bNwjbFAKN8PNkcWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgbEEWnMOTdpm3Si+ULgBhNmUHcqdutafKcFVi7YK/92RpDAQLXjDhAjBuDfhvuXuIO+fhiQAzlauoHz7jdlb8r8o2JkLinMIP+FDlbrYqhOHz+RaP/bMjblzLnq5yDCIo7yTP0fVF20GlMz5APZokxGWUYfH1GQiWLFEZ37enE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7KG4n26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743449823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=49EH0YBkq80au5wcRsabywx2fTWUf9Jb0oNAUNgkQKI=;
	b=W7KG4n269CTXBG+MYuoY2bvZ5+m/zjjkRcsELn2jLFGY86fU3VLXFlJqqmL33GFUMdejFy
	87mIVwMzoeRtm19jx2P+6PgKomT/SUjHpmlRhsaPJZRPARor5Yl5bIyKbsv562dm0m27yg
	juWvwnZJ0Z+b4wRyLxXzinATGZZlZOs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-WtIWZY4ONbuvZ3mmIsBn5A-1; Mon,
 31 Mar 2025 15:37:01 -0400
X-MC-Unique: WtIWZY4ONbuvZ3mmIsBn5A-1
X-Mimecast-MFC-AGG-ID: WtIWZY4ONbuvZ3mmIsBn5A_1743449820
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED2FC180AB16;
	Mon, 31 Mar 2025 19:36:59 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C102190DB07;
	Mon, 31 Mar 2025 19:36:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: agruenba@redhat.com
Cc: stable@vger.kernel.org,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
Date: Mon, 31 Mar 2025 15:36:56 -0400
Message-ID: <20250331193656.1134507-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
held. In this case we cannot call msleep_interruptible() as we a in a
non-sleepable context. Replace it with mdelay() to busy wait for 1
second.

Cc: stable@vger.kernel.org
Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/gfs2/lock_dlm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..ac0afedff49b 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
 		if (sdp->sd_args.ar_spectator) {
 			fs_info(sdp, "Recovery is required. Waiting for a "
 				"non-spectator to mount.\n");
-			msleep_interruptible(1000);
+			mdelay(1000);
 		} else {
 			fs_info(sdp, "control_mount wait1 block %u start %u "
 				"mount %u lvb %u flags %lx\n", block_gen,
-- 
2.43.0


