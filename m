Return-Path: <stable+bounces-181080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA9B92D52
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A9019067EF
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A52EDD5D;
	Mon, 22 Sep 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjrXhjj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C2C8E6;
	Mon, 22 Sep 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569639; cv=none; b=VYoX1CXp7k3jU8+MaIKjfn7ngJkFiqPQve0eqaOvGbG3iTSgSNyvHvFFoQAduvUJ5tbV3jUXkWukMdh3jHYnA43aOut3sD1UGQYOFZydZJUY8RwjwJEjD9wYSNLHFbOxhjFZp7qCSxD2sTSK6naalGyZagNofTM0QMqFxty0UP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569639; c=relaxed/simple;
	bh=oVEq2wNXPoBTpj7ZFV7FB+GAcG6ZFqmT1Kvld+jBNSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVB873Ge2Yv49T7L1ZmkJlX8SIhPaZRk9wrQ0IiYmr56m2hQM3qvYyaRX/t6CZvUt0qtTtIMaq+EGcaamVYmVkOjj4O4apcq8GkArO8F5QJFnaEIibRLNNSFbPJNhEf32k4sg56vzBLO3SZ3+16YzCYGCUN3pd3JjaEsGml77jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjrXhjj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93935C4CEF0;
	Mon, 22 Sep 2025 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569638;
	bh=oVEq2wNXPoBTpj7ZFV7FB+GAcG6ZFqmT1Kvld+jBNSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wjrXhjj73kPYJk8C4aZuXCVCVIIgOGYFjpnZbCQ4a39B7Bbp8SkyrXQ95w6MSq5hv
	 SnIrcoAQWDGYUYB4uirLCM0JzxYt7e4qk7kTUjZkXn3jLtIRKLjsJY0fMzGh5zdN2A
	 QG12HlUxDjjmXXmOKKFee6q2T8MvltaK23pSOolk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 10/70] qed: Dont collect too many protection override GRC elements
Date: Mon, 22 Sep 2025 21:29:10 +0200
Message-ID: <20250922192404.771842995@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>

[ Upstream commit 56c0a2a9ddc2f5b5078c5fb0f81ab76bbc3d4c37 ]

In the protection override dump path, the firmware can return far too
many GRC elements, resulting in attempting to write past the end of the
previously-kmalloc'ed dump buffer.

This will result in a kernel panic with reason:

 BUG: unable to handle kernel paging request at ADDRESS

where "ADDRESS" is just past the end of the protection override dump
buffer. The start address of the buffer is:
 p_hwfn->cdev->dbg_features[DBG_FEATURE_PROTECTION_OVERRIDE].dump_buf
and the size of the buffer is buf_size in the same data structure.

The panic can be arrived at from either the qede Ethernet driver path:

    [exception RIP: qed_grc_dump_addr_range+0x108]
 qed_protection_override_dump at ffffffffc02662ed [qed]
 qed_dbg_protection_override_dump at ffffffffc0267792 [qed]
 qed_dbg_feature at ffffffffc026aa8f [qed]
 qed_dbg_all_data at ffffffffc026b211 [qed]
 qed_fw_fatal_reporter_dump at ffffffffc027298a [qed]
 devlink_health_do_dump at ffffffff82497f61
 devlink_health_report at ffffffff8249cf29
 qed_report_fatal_error at ffffffffc0272baf [qed]
 qede_sp_task at ffffffffc045ed32 [qede]
 process_one_work at ffffffff81d19783

or the qedf storage driver path:

    [exception RIP: qed_grc_dump_addr_range+0x108]
 qed_protection_override_dump at ffffffffc068b2ed [qed]
 qed_dbg_protection_override_dump at ffffffffc068c792 [qed]
 qed_dbg_feature at ffffffffc068fa8f [qed]
 qed_dbg_all_data at ffffffffc0690211 [qed]
 qed_fw_fatal_reporter_dump at ffffffffc069798a [qed]
 devlink_health_do_dump at ffffffff8aa95e51
 devlink_health_report at ffffffff8aa9ae19
 qed_report_fatal_error at ffffffffc0697baf [qed]
 qed_hw_err_notify at ffffffffc06d32d7 [qed]
 qed_spq_post at ffffffffc06b1011 [qed]
 qed_fcoe_destroy_conn at ffffffffc06b2e91 [qed]
 qedf_cleanup_fcport at ffffffffc05e7597 [qedf]
 qedf_rport_event_handler at ffffffffc05e7bf7 [qedf]
 fc_rport_work at ffffffffc02da715 [libfc]
 process_one_work at ffffffff8a319663

Resolve this by clamping the firmware's return value to the maximum
number of legal elements the firmware should return.

Fixes: d52c89f120de8 ("qed*: Utilize FW 8.37.2.0")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Link: https://patch.msgid.link/f8e1182934aa274c18d0682a12dbaf347595469c.1757485536.git.jamie.bainbridge@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index cdcead614e9fa..ae421c2707785 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -4461,10 +4461,11 @@ static enum dbg_status qed_protection_override_dump(struct qed_hwfn *p_hwfn,
 		goto out;
 	}
 
-	/* Add override window info to buffer */
+	/* Add override window info to buffer, preventing buffer overflow */
 	override_window_dwords =
-		qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
-		PROTECTION_OVERRIDE_ELEMENT_DWORDS;
+		min(qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
+		PROTECTION_OVERRIDE_ELEMENT_DWORDS,
+		PROTECTION_OVERRIDE_DEPTH_DWORDS);
 	if (override_window_dwords) {
 		addr = BYTES_TO_DWORDS(GRC_REG_PROTECTION_OVERRIDE_WINDOW);
 		offset += qed_grc_dump_addr_range(p_hwfn,
-- 
2.51.0




