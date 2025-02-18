Return-Path: <stable+bounces-116705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E170A39A35
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67CB172C1D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB423C8A0;
	Tue, 18 Feb 2025 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="bhGNTk05"
X-Original-To: stable@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B423C375
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877194; cv=none; b=NFyV5wrvaiGAFzggCILfxdxaXEzymHe8z6ohmpIAzMY3WGWnqULzDl4D6mQBy5I1L5EGXtsWZPFnfU8kiKWPeMyh8R7z8pylLj1K+cGKPMenFskdBhk5T2QRxj9kG05d6t75rI36TmjNknnuS/tqL0jjZ12wlmf/Ch+x0Dt0de4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877194; c=relaxed/simple;
	bh=ufqG7XoGOJZCg/c36vHLg/i8bJImksgJs7KeU/+b6mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UV7bXlITDxlVsWeYIaWos7VOwb4i2DnySZBsclTQDArsDERcPJzK2/VhfxY60PoYdZHaLmQ+XiVJR4FznZm1rU07SfdeoqyEkLZNaON9GNTcfnQLtmGYrtiXGMvvu6v6QWnbTAnn2zobSEAcy9f5U5N2+1yFYSyVgFNwclf4c8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=bhGNTk05; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1739877192; x=1771413192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufqG7XoGOJZCg/c36vHLg/i8bJImksgJs7KeU/+b6mc=;
  b=bhGNTk05A/JGZLP3G6JqHtN11Zbn8zUfeECpnMj0lCeB/APbzOOrceha
   WuOpneCqYewkZq77K+pM2JRmp2I1DWwcV11imIjAkFHcnsz9vkyypsLGX
   jilfqAHVxiSYL8YtpXipW/vuMxYlgsChM/Bk+NjzQ4Km4Lc6iBZKb8Vbi
   scsW3bw7PxK7bxgwP38/F83WCjyT3c3yhOyT6oMMuHNxhzjaGNWbt1YpR
   mY+UQWXRk57UAz0eeUH3Es5q3jlrKVW3foCQR5tbSq5nbT0OZhqj4dp+2
   LZ6tLWK55Mjxdo99akrtK7epj5ppxbOHIOrcTOhTotxzoLP939wm4maaz
   A==;
X-CSE-ConnectionGUID: 2toLDwUMSymTROo7JgwGGQ==
X-CSE-MsgGUID: DODH//ThSw+0elAO6LZJGg==
X-IronPort-AV: E=Sophos;i="6.13,295,1732550400"; 
   d="scan'208";a="38739609"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2025 19:13:06 +0800
IronPort-SDR: 67b45d88_XOqZzKzCBNkdqas4VKw6Fi6Dt0ESE2VsRjDTUHPvYZ2EZfm
 oW39ZUyTOyJ58HTPAZUF/nQVTbXKtpFcxi9RIGw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Feb 2025 02:14:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.112.13.179])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2025 03:13:05 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: arthur.simchaev@sandisk.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] ufs: core: bsg: Fix memory crash in case arpmb command failed
Date: Tue, 18 Feb 2025 13:13:02 +0200
Message-Id: <20250218111302.246473-1-arthur.simchaev@sandisk.com>
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
Signed-off-by: Arthur Simchaev <arthur.simchaev@sandisk.com>

---
Changes in v2:
  - Add Fixes tag
  - Elaborate commit log

Signed-off-by: Arthur Simchaev <arthur.simchaev@sandisk.com>
---
 drivers/ufs/core/ufs_bsg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 8d4ad0a3f2cf..a8ed9bc6e4f1 100644
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
+		job->reply_len = !rpmb ? sizeof(struct ufs_bsg_reply) :
+					 sizeof(struct ufs_rpmb_reply);
 		bsg_job_done(job, ret, bsg_reply->reply_payload_rcv_len);
+	}
 
 	return ret;
 }
-- 
2.34.1


