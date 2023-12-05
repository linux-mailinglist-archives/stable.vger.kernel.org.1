Return-Path: <stable+bounces-4046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CB8045C7
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566131F21377
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5556FB1;
	Tue,  5 Dec 2023 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wDnM4GMh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2166AA0;
	Tue,  5 Dec 2023 03:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CDC433C7;
	Tue,  5 Dec 2023 03:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746481;
	bh=a52F9SnDMMi81qixtL2LSfmhWQ9mUlkyVt27SgG8mIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wDnM4GMh9SjGbjG3/Ge7w93OArPEASIaj5p/xQdqhLbwQgelascrB8RxSXGCfLfsX
	 WygN+vYA8u1Tf4SutLclz95jo99U4hKMaPVKe1ZLd0CVUEy35nAloONdjXznGHcgK1
	 XvIaoawyoyCAJGjyFThD4aA5HV7VQYauo6OR+tfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ewan D. Milne" <emilne@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.6 039/134] nvme: check for valid nvme_identify_ns() before using it
Date: Tue,  5 Dec 2023 12:15:11 +0900
Message-ID: <20231205031537.978659468@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

From: Ewan D. Milne <emilne@redhat.com>

commit d8b90d600aff181936457f032d116dbd8534db06 upstream.

When scanning namespaces, it is possible to get valid data from the first
call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
call in nvme_update_ns_info_block().  In particular, if the NSID becomes
inactive between the two commands, a storage device may return a buffer
filled with zero as per 4.1.5.1.  In this case, we can get a kernel crash
due to a divide-by-zero in blk_stack_limits() because ns->lba_shift will
be set to zero.

PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:10"
 #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
 #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
 #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
 #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
 #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
 #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
 #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
 #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
    [exception RIP: blk_stack_limits+434]
    RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
    RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [nvme_core]
 #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]

This happened when the check for valid data was moved out of nvme_identify_ns()
into one of the callers.  Fix this by checking in both callers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218186
Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespaces during sequential scan")
Cc: stable@vger.kernel.org
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2026,6 +2026,13 @@ static int nvme_update_ns_info_block(str
 	if (ret)
 		return ret;
 
+	if (id->ncap == 0) {
+		/* namespace not allocated or attached */
+		info->is_removed = true;
+		ret = -ENODEV;
+		goto error;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -2083,6 +2090,8 @@ out:
 		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
+
+error:
 	kfree(id);
 	return ret;
 }



