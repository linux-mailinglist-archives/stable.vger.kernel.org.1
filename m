Return-Path: <stable+bounces-4445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C3804782
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0862815C2
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C198BF7;
	Tue,  5 Dec 2023 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFttmi/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807076FB1;
	Tue,  5 Dec 2023 03:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42CCC433C7;
	Tue,  5 Dec 2023 03:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747566;
	bh=cbj+pqeBUMvPUu2e7nPMp8oWs7x9i1tM2b80WFbKmWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFttmi/6DNs8PVvqheYBC+8mrPBLmB3LmqD8e8pHlNOrJDoBUUxIgHVNV3osc1afP
	 0pcikpLPvHkum1hRMENjbgby1/sQayZ0TnQ5c/+PPMyl6JlNRYYOjy83W4iyE2+Ane
	 xBVt8LC5tQOjtHjeZTBU15sixWcIcR10ZoLsvdpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/135] scsi: qla2xxx: Fix system crash due to bad pointer access
Date: Tue,  5 Dec 2023 12:17:24 +0900
Message-ID: <20231205031538.672125105@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit 19597cad64d608aa8ac2f8aef50a50187a565223 ]

User experiences system crash when running AER error injection.  The
perturbation causes the abort-all-I/O path to trigger. The driver assumes
all I/O on this path is FCP only. If there is both NVMe & FCP traffic, a
system crash happens. Add additional check to see if I/O is FCP or not
before access.

PID: 999019  TASK: ff35d769f24722c0  CPU: 53  COMMAND: "kworker/53:1"
 0 [ff3f78b964847b58] machine_kexec at ffffffffae86973d
 1 [ff3f78b964847ba8] __crash_kexec at ffffffffae9be29d
 2 [ff3f78b964847c70] crash_kexec at ffffffffae9bf528
 3 [ff3f78b964847c78] oops_end at ffffffffae8282ab
 4 [ff3f78b964847c98] exc_page_fault at ffffffffaf2da502
 5 [ff3f78b964847cc0] asm_exc_page_fault at ffffffffaf400b62
   [exception RIP: qla2x00_abort_srb+444]
   RIP: ffffffffc07b5f8c  RSP: ff3f78b964847d78  RFLAGS: 00010046
   RAX: 0000000000000282  RBX: ff35d74a0195a200  RCX: ff35d76886fd03a0
   RDX: 0000000000000001  RSI: ffffffffc07c5ec8  RDI: ff35d74a0195a200
   RBP: ff35d76913d22080   R8: ff35d7694d103200   R9: ff35d7694d103200
   R10: 0000000100000000  R11: ffffffffb05d6630  R12: 0000000000010000
   R13: ff3f78b964847df8  R14: ff35d768d8754000  R15: ff35d768877248e0
   ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 6 [ff3f78b964847d70] qla2x00_abort_srb at ffffffffc07b5f84 [qla2xxx]
 7 [ff3f78b964847de0] __qla2x00_abort_all_cmds at ffffffffc07b6238 [qla2xxx]
 8 [ff3f78b964847e38] qla2x00_abort_all_cmds at ffffffffc07ba635 [qla2xxx]
 9 [ff3f78b964847e58] qla2x00_terminate_rport_io at ffffffffc08145eb [qla2xxx]
10 [ff3f78b964847e70] fc_terminate_rport_io at ffffffffc045987e [scsi_transport_fc]
11 [ff3f78b964847e88] process_one_work at ffffffffae914f15
12 [ff3f78b964847ed0] worker_thread at ffffffffae9154c0
13 [ff3f78b964847f10] kthread at ffffffffae91c456
14 [ff3f78b964847f50] ret_from_fork at ffffffffae8036ef

Cc: stable@vger.kernel.org
Fixes: f45bca8c5052 ("scsi: qla2xxx: Fix double scsi_done for abort path")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20231030064912.37912-1-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 136522a1c7281..0930bf996cd30 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1714,8 +1714,16 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
-			sp->done(sp, res);
+		switch (sp->type) {
+		case SRB_SCSI_CMD:
+			if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
+				sp->done(sp, res);
+			break;
+		default:
+			if (ret_cmd)
+				sp->done(sp, res);
+			break;
+		}
 	} else {
 		sp->done(sp, res);
 	}
-- 
2.42.0




