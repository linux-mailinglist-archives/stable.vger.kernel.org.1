Return-Path: <stable+bounces-118448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAFA3DC9F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC077861B6E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002251FC0E4;
	Thu, 20 Feb 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="E9zC/gOQ"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328635958
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061113; cv=none; b=hc+nr+nZurUvf6agW0dqmBp1YUDqCVGcuXYq1TBJPJKu4+KudxQKocYWdtLF+8Lg+OhMT9oAF/ngiBOGfNMVslT/gobAGAPrmbQBnAJU7DWUVPIti2K9irPkxGY50T9e8uuJ/K033oHEfn5xA+QcTvZWbHPqHBePTP2znAFbIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061113; c=relaxed/simple;
	bh=hlB4UciSi11RpeFBPHRSOm6Mu8yyv0oaYnrGMZP85jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ju4Ub/sQzgbrThU8jpMkUqNxNL7ZpBscFnL8ozedthkrhY6X9hMC11k2GvbCffQv4cNwQptgo0dV05atmLCg8ilEjOV46OvtkA/a1u8fzsJwuRgkI7lnnPZsJk7U2OQMuKdJc6QisdTln1Y20cD6X7t8MHSFcwKV4h6vplXY2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=E9zC/gOQ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740061111; x=1771597111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hlB4UciSi11RpeFBPHRSOm6Mu8yyv0oaYnrGMZP85jQ=;
  b=E9zC/gOQyhjmmHdeV6X3bYdlh6DwJjtWSEHjHaxb1koiTMQoaLjVQQ+p
   yyX7TuG81GqK9xTjgFusAFhFdd3KJXGduN6A3Rk/WNjZz3rQheOeaYG2k
   Q5f1R5B44uYcWKPEVxqIzJVk17yPpfh1Bx9XchAz9m8t86fVK0+loTaiM
   COpUvWQ7Psxddz13kfeiIdMLbGwMJTpQOn//gZG2HQbIG8/jy5fVBuh5y
   qli9/qC4pqcECz5VS6H9YhxYGLy1y8DGL+/pO0PO8uHs+FSZD1Nk1GBmW
   /XveZnt4LATA+vntG5PtQa8L0G6LIHudfZ0FAQAWc7WKJL5SyxdmZbHeb
   A==;
X-CSE-ConnectionGUID: 23JHTRDtRC2JcyS14OIdxw==
X-CSE-MsgGUID: 8HHZtkoLQ8+es4QUd8aDXA==
X-IronPort-AV: E=Sophos;i="6.13,301,1732550400"; 
   d="scan'208";a="38810548"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2025 22:18:25 +0800
IronPort-SDR: 67b72bf4_0D5IM+ILp9J6DaEthIv38tG0CT3mzF53mMPq3NZferzDJlo
 dB3U8qKxSZogM7un5qKaM7MvcUe71nNgL8SUE5Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2025 05:19:49 -0800
WDCIronportException: Internal
Received: from unknown (HELO WDAP-ez2C89klLd.wdc.com) ([10.137.186.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Feb 2025 06:18:24 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: arthur.simchaev@sandisk.com
Cc: stable@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3] ufs: core: bsg: Fix memory crash in case arpmb command failed
Date: Thu, 20 Feb 2025 16:18:19 +0200
Message-Id: <20250220141819.250978-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the device doesn't support arpmb, the kernel get memory crash
due to copy user data in bsg_transport_sg_io_fn level. So in case
ufs_bsg_exec_advanced_rpmb_req returned error, do not set the job's
reply_len.

Memory crash backtrace:
3,1290,531166405,-;ufshcd 0000:00:12.5: ARPMB OP failed: error code -22

4,1308,531166555,-;Call Trace:

4,1309,531166559,-; <TASK>

4,1310,531166565,-; ? show_regs+0x6d/0x80

4,1311,531166575,-; ? die+0x37/0xa0

4,1312,531166583,-; ? do_trap+0xd4/0xf0

4,1313,531166593,-; ? do_error_trap+0x71/0xb0

4,1314,531166601,-; ? usercopy_abort+0x6c/0x80

4,1315,531166610,-; ? exc_invalid_op+0x52/0x80

4,1316,531166622,-; ? usercopy_abort+0x6c/0x80

4,1317,531166630,-; ? asm_exc_invalid_op+0x1b/0x20

4,1318,531166643,-; ? usercopy_abort+0x6c/0x80

4,1319,531166652,-; __check_heap_object+0xe3/0x120

4,1320,531166661,-; check_heap_object+0x185/0x1d0

4,1321,531166670,-; __check_object_size.part.0+0x72/0x150

4,1322,531166679,-; __check_object_size+0x23/0x30

4,1323,531166688,-; bsg_transport_sg_io_fn+0x314/0x3b0

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <arthur.simchaev@sandisk.com>

---
Changes in v3:
  - changing !rpmb into rpmb and by swapping the two sizeof() expressions

---
Changes in v2:
  - Add Fixes tag
  - Elaborate commit log
---
 drivers/ufs/core/ufs_bsg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 8d4ad0a3f2cf..252186124669 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -194,10 +194,12 @@ static int ufs_bsg_request(struct bsg_job *job)
 	ufshcd_rpm_put_sync(hba);
 	kfree(buff);
 	bsg_reply->result = ret;
-	job->reply_len = !rpmb ? sizeof(struct ufs_bsg_reply) : sizeof(struct ufs_rpmb_reply);
 	/* complete the job here only if no error */
-	if (ret == 0)
+	if (ret == 0) {
+		job->reply_len = rpmb ? sizeof(struct ufs_rpmb_reply) :
+					sizeof(struct ufs_bsg_reply);
 		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
+	}
 
 	return ret;
 }
-- 
2.34.1


