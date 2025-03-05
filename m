Return-Path: <stable+bounces-121060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27411A509E0
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDA6188CAB8
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B5256C71;
	Wed,  5 Mar 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nGZVSigl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD72528E4;
	Wed,  5 Mar 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198766; cv=none; b=l1unhEuCbiwj7aYR9iFdGLyhGlfx6QXqcgttF24+VSabZJm7H939nG7M/ri9JaQPCZ7mcSQphVg1UEUv3+HRJnrZRDW4NfwIG0G7Uun213MfGwJtJ31PG3DdNNDJ6LRaq9FfkaPT6zea6YbOES7o682m/y5syp2Hge4wS98Kykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198766; c=relaxed/simple;
	bh=08mc1+Re2By1+vYjxsxH5mvUXL79CBgvl1j5lcGDvv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/CfUZqJsQdTAVISLehPvopCQW8qAUo3bKO+sSp4QYSmnTn0BxRQSwi80QpmVmNrP6ETBnOyCZvQ05YIpNXHIXNsaUM7SIVCpwUZghgTP7ZYoJiENHM/Egp/froYNFCCLwITmqjeKpYhvUSgUrFeHEd/STX+8oALScNuliPk1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nGZVSigl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AC2C4CED1;
	Wed,  5 Mar 2025 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198766;
	bh=08mc1+Re2By1+vYjxsxH5mvUXL79CBgvl1j5lcGDvv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGZVSigljno+OuNKVghPLgbCTb8BTYvXyvVzMfiFu0UN6hkbwkMk6+G36JpF/po1F
	 AolKSHZoFiQVmb3Xo6oRDoMXMxEWSOAPzPzO33Y2FuIrwd9Hy4BAa5CeXjR5lVFL0U
	 1Wi9Y2SnwA1jUnYUsMHXc5itAyQDE+c6wVvGT3g8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bean Huo <beanhuo@micron.com>,
	Arthur Simchaev <arthur.simchaev@sandisk.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.13 141/157] scsi: ufs: core: bsg: Fix crash when arpmb command fails
Date: Wed,  5 Mar 2025 18:49:37 +0100
Message-ID: <20250305174510.969516564@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Simchaev <arthur.simchaev@sandisk.com>

commit f27a95845b01e86d67c8b014b4f41bd3327daa63 upstream.

If the device doesn't support arpmb we'll crash due to copying user data in
bsg_transport_sg_io_fn().

In the case where ufs_bsg_exec_advanced_rpmb_req() returns an error, do not
set the job's reply_len.

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
Link: https://lore.kernel.org/r/20250220142039.250992-1-arthur.simchaev@sandisk.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufs_bsg.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -194,10 +194,12 @@ out:
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



