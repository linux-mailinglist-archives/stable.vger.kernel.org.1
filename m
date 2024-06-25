Return-Path: <stable+bounces-55345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74848916331
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DC91C22085
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1B1494DC;
	Tue, 25 Jun 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i41pU5jB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C312EBEA;
	Tue, 25 Jun 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308630; cv=none; b=NTk/Xg8ko9A/inNPYjKkX9oaFxGPxFUNWe1BtoVGAyJpmnbs/98GOJgow77fwRN7MdS/PE2/FRw69Zd4TUcowj4NNzkp/BuU2mO/y/fzwIKE/nztgUlCHa1js7sOK8q26S2DM2prvYbSQKLUyPbJSvXg1BOEBPKrjukPk706bCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308630; c=relaxed/simple;
	bh=qlwfA8XMmlnoy+xPkT9r8S4q0iejReo55RibAwklObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJc7Hd9VsMUsKtLtQ3O7Ep8najXmoVlYz8yVmMQFP96urF99WvzARvdTLbMGvyI2trNvxHLzxZ9L/Gmq6Xb1IuxQUYBTaP81IolH0ozCg+e7RLh5kLRw55TTC3PT6qTsyRvG0NRztILJrQ5by5FPrEsFDb7KIma8v1ZBE4erikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i41pU5jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C33C32781;
	Tue, 25 Jun 2024 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308630;
	bh=qlwfA8XMmlnoy+xPkT9r8S4q0iejReo55RibAwklObM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i41pU5jBaoHAZDRj2oCNhIbMcUApzWGAZZQooZ2RJRPY7kYJLIGutIBSaAuvmHAiu
	 i6VPxNpgvUoAtXWzKvV858PEA9ObbSWHyK04aCiIBHQjL0p18f8X4srBCOSe8fE4jZ
	 NexU5BeOzsk3VRnI/Gg6RTtu2CCf1hwBYWM750nM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Halaney <ahalaney@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joel Slebodnick <jslebodn@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.9 186/250] scsi: ufs: core: Free memory allocated for model before reinit
Date: Tue, 25 Jun 2024 11:32:24 +0200
Message-ID: <20240625085555.192291594@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Slebodnick <jslebodn@redhat.com>

commit 135c6eb27a85c8b261a2cc1f5093abcda6ee9010 upstream.

Under the conditions that a device is to be reinitialized within
ufshcd_probe_hba(), the device must first be fully reset.

Resetting the device should include freeing U8 model (member of dev_info)
but does not, and this causes a memory leak.  ufs_put_device_desc() is
responsible for freeing model.

unreferenced object 0xffff3f63008bee60 (size 32):
  comm "kworker/u33:1", pid 60, jiffies 4294892642
  hex dump (first 32 bytes):
    54 48 47 4a 46 47 54 30 54 32 35 42 41 5a 5a 41  THGJFGT0T25BAZZA
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ed7ff1a9):
    [<ffffb86705f1243c>] kmemleak_alloc+0x34/0x40
    [<ffffb8670511cee4>] __kmalloc_noprof+0x1e4/0x2fc
    [<ffffb86705c247fc>] ufshcd_read_string_desc+0x94/0x190
    [<ffffb86705c26854>] ufshcd_device_init+0x480/0xdf8
    [<ffffb86705c27b68>] ufshcd_probe_hba+0x3c/0x404
    [<ffffb86705c29264>] ufshcd_async_scan+0x40/0x370
    [<ffffb86704f43e9c>] async_run_entry_fn+0x34/0xe0
    [<ffffb86704f34638>] process_one_work+0x154/0x298
    [<ffffb86704f34a74>] worker_thread+0x2f8/0x408
    [<ffffb86704f3cfa4>] kthread+0x114/0x118
    [<ffffb86704e955a0>] ret_from_fork+0x10/0x20

Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
Cc: <stable@vger.kernel.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
Link: https://lore.kernel.org/r/20240613200202.2524194-1-jslebodn@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8972,6 +8972,7 @@ static int ufshcd_probe_hba(struct ufs_h
 	    (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH)) {
 		/* Reset the device and controller before doing reinit */
 		ufshcd_device_reset(hba);
+		ufs_put_device_desc(hba);
 		ufshcd_hba_stop(hba);
 		ufshcd_vops_reinit_notify(hba);
 		ret = ufshcd_hba_enable(hba);



