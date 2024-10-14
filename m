Return-Path: <stable+bounces-83779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802399C95D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793251C2161D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5119F418;
	Mon, 14 Oct 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HK+KHKjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4113C67C
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906622; cv=none; b=GRUf3nu+rXe6CCTSu9r2424++CLECCoeD7qoAZaV/JJc90nBccDRX3IbLC87p2Y9J/aoO71N4Ntuj7gI/i1B3bRxDBuUcIHMqkggU/7Uk/QYgR+uDengEpLuCpAN//FYMD5RcI26m7St+R3qA3KjQS0ngGYSYuVtRV27evYojn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906622; c=relaxed/simple;
	bh=UsouneQISNhZ/IcZ0y+t3d2YG6r1PzCPf5Xok1+Mfbg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ibIpuA1n/qwbty7Hb4dusTASDS69r2190Picp+fqdcve7sI++/Tz3A0A7ctbEZcLQsaTjYhjOYdtd1TlPanQ0I0YjYO1r1RdzxpVbPUyUAUxT5hoiiWq8/DYSvOymhQebhmGjjzedPyGF7mJoxTIqN4R9vFSvM/5/OkP/B0gpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HK+KHKjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F30C4CEC3;
	Mon, 14 Oct 2024 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906621;
	bh=UsouneQISNhZ/IcZ0y+t3d2YG6r1PzCPf5Xok1+Mfbg=;
	h=Subject:To:Cc:From:Date:From;
	b=HK+KHKjMGIJolkT4C1mmp+HcaQLoCFWbLNJWfnNG5zyRDxiunhV+a/mfItVLG69gZ
	 mSBDvUXwTMn7xtgCXtazCJP+2o6ekHXHBWuQe9scPeRihJ7fp0IWKrnei6jFcO9ZKv
	 wyLfihJ1d+sjksHryD2Hdpt/UYdCJc2JMWukxyus=
Subject: FAILED: patch "[PATCH] scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()" failed to apply to 5.10-stable tree
To: avri.altman@wdc.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:47:37 +0200
Message-ID: <2024101436-violin-agreement-b115@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d5130c5a093257aa4542aaded8034ef116a7624a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101436-violin-agreement-b115@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d5130c5a0932 ("scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()")
06caeb536b2b ("scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()")
5149452ca662 ("scsi: ufs: core: Fix MCQ tag calculation")
f87b2c41822a ("scsi: ufs: mcq: Add completion support of a CQE")
854f84e7feeb ("scsi: ufs: core: mcq: Find hardware queue to queue request")
22a2d563de14 ("scsi: ufs: core: Prepare ufshcd_send_command() for MCQ")
2468da61ea09 ("scsi: ufs: core: mcq: Configure operation and runtime interface")
4682abfae2eb ("scsi: ufs: core: mcq: Allocate memory for MCQ mode")
7224c806876e ("scsi: ufs: core: mcq: Calculate queue depth")
c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
57b1c0ef89ac ("scsi: ufs: core: mcq: Add support to allocate multiple queues")
0cab4023ec7b ("scsi: ufs: core: Defer adding host to SCSI if MCQ is supported")
305a357d3595 ("scsi: ufs: core: Introduce multi-circular queue capability")
6e1d850acff9 ("scsi: ufs: core: Probe for EXT_IID support")
baf5ddac90dc ("scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device")
96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
c2c38c573a2e ("scsi: ufs: core: Add reinit_notify() callback")
031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
4a5bd1a928a2 ("Merge patch series "Prepare for upstreaming Pixel 6 and 7 UFS support"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d5130c5a093257aa4542aaded8034ef116a7624a Mon Sep 17 00:00:00 2001
From: Avri Altman <avri.altman@wdc.com>
Date: Tue, 10 Sep 2024 07:45:43 +0300
Subject: [PATCH] scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()

Replace manual offset calculations for response_upiu and prd_table in
ufshcd_init_lrb() with pre-calculated offsets already stored in the
utp_transfer_req_desc structure. The pre-calculated offsets are set
differently in ufshcd_host_memory_configure() based on the
UFSHCD_QUIRK_PRDT_BYTE_GRAN quirk, ensuring correct alignment and
access.

Fixes: 26f968d7de82 ("scsi: ufs: Introduce UFSHCD_QUIRK_PRDT_BYTE_GRAN quirk")
Cc: stable@vger.kernel.org
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20240910044543.3812642-1-avri.altman@wdc.com
Acked-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 24a32e2fd75e..6a71ebf953e2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2933,9 +2933,8 @@ static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
 	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
 	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
 		i * ufshcd_get_ucd_size(hba);
-	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
-				       response_upiu);
-	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
+	u16 response_offset = le16_to_cpu(utrdlp[i].response_upiu_offset);
+	u16 prdt_offset = le16_to_cpu(utrdlp[i].prd_table_offset);
 
 	lrb->utr_descriptor_ptr = utrdlp + i;
 	lrb->utrd_dma_addr = hba->utrdl_dma_addr +


