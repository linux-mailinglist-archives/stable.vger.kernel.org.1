Return-Path: <stable+bounces-3413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405727FF580
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721DC1C2100B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6354F9C;
	Thu, 30 Nov 2023 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ajTXsZez"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B524C2;
	Thu, 30 Nov 2023 16:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BBDC433C7;
	Thu, 30 Nov 2023 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361769;
	bh=4TheymSutGH/SlHgc3CgSevK8lGb4LpVsGOdkV+ijCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajTXsZez+6XEw81NUuGAhc/mlUpCFQI3nTQNHUI+GipOVbMmKdppA5k/67dSLswb0
	 j6r5gTz4drcac653Mg06rim/FYecY+NutkxVXt382DpQr3JSrXfRxHp7CjXKlU24/Q
	 v3MbOfDBDjm2LnU7zlUUrVM26HB+rkJXkzbaXyRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Suvanto <markus.suvanto@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 22/82] afs: Return ENOENT if no cell DNS record can be found
Date: Thu, 30 Nov 2023 16:21:53 +0000
Message-ID: <20231130162136.654888843@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0167236e7d66c5e1e85d902a6abc2529b7544539 ]

Make AFS return error ENOENT if no cell SRV or AFSDB DNS record (or
cellservdb config file record) can be found rather than returning
EDESTADDRREQ.

Also add cell name lookup info to the cursor dump.

Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/vl_rotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 488e58490b16e..eb415ce563600 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		}
 
 		/* Status load is ordered after lookup counter load */
+		if (cell->dns_status == DNS_LOOKUP_GOT_NOT_FOUND) {
+			pr_warn("No record of cell %s\n", cell->name);
+			vc->error = -ENOENT;
+			return false;
+		}
+
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			vc->error = -EDESTADDRREQ;
 			return false;
@@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
  */
 static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 {
+	struct afs_cell *cell = vc->cell;
 	static int count;
 	int i;
 
@@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
+	pr_notice("CELL: %s err=%d\n", cell->name, cell->error);
+	pr_notice("DNS: src=%u st=%u lc=%x\n",
+		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
 		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 
-- 
2.42.0




