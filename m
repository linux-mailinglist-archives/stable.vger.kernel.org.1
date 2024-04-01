Return-Path: <stable+bounces-34355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9681893EFD
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FFA2832E0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08F47A57;
	Mon,  1 Apr 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+Wvpzu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6C8F5C;
	Mon,  1 Apr 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987841; cv=none; b=J9vlDOof0pwy6l3qN2TqvW5vkeUeCdPMxT3Ka3q3QJ1klmhIAGOZ2lML3QzMPt7f528/miIJQ07Jt6ocGgxBTYV2f2YYit9/G3F95o+xywkXk9RjMRPdjf9YxfDGMhN7ReUBC0v82EebJpVIK1UkPBNSjjHI9RJ6nq4HynDlHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987841; c=relaxed/simple;
	bh=9xFTxpMoAJyzg0iD1oUI5o7gQl4Tytz5gSq2rtr8kYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks6RKFXpHEuAhQ+6n+Z6etr+Y42f7cX6HVTv96B7PhtyTodoBv7Mtw1Ph45vCGjdpqU7sSZSOu9CwXijSOa1Cv3u5igq4gMpIkETQX4EHB+dawYONOpJ9G7qySUFqBTuv7HYM7uQBz+bRiO7EPSA75ajgp4Tv1FVP6aiaMAwwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+Wvpzu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B93EC433F1;
	Mon,  1 Apr 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987840;
	bh=9xFTxpMoAJyzg0iD1oUI5o7gQl4Tytz5gSq2rtr8kYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Wvpzu4VsROlg3I0kJsjSq2nwsn8GKbgbyLEJA8nJAr+LbPhWuwT27dkYPUUSSCa
	 xvdqdt75LyZzAUBGN6hh9lNWLCqckL73ZJ2EmlI7dXEBZtzpUnqghz1aaiVu6vLK/b
	 HfKvdbHcG5+mn7i9UVgxd26nJoywS8jx4wdFzUw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.8 386/399] scsi: qla2xxx: Delay I/O Abort on PCI error
Date: Mon,  1 Apr 2024 17:45:52 +0200
Message-ID: <20240401152600.695358065@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 591c1fdf2016d118b8fbde427b796fac13f3f070 upstream.

Currently when PCI error is detected, I/O is aborted manually through the
ABORT IOCB mechanism which is not guaranteed to succeed.

Instead, wait for the OS or system to notify driver to wind down I/O
through the pci_error_handlers api.  Set eeh_busy flag to pause all traffic
and wait for I/O to drain.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240227164127.36465-11-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_attr.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2741,7 +2741,13 @@ qla2x00_dev_loss_tmo_callbk(struct fc_rp
 		return;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900c,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(fcport->vha);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+		    0, WAIT_TARGET);
 		return;
 	}
 }
@@ -2763,7 +2769,11 @@ qla2x00_terminate_rport_io(struct fc_rpo
 	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
-		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		/* Will wait for wind down of adapter */
+		ql_dbg(ql_dbg_aer, fcport->vha, 0x900b,
+		    "%s pci offline detected (id %06x)\n", __func__,
+		    fcport->d_id.b24);
+		qla_pci_set_eeh_busy(vha);
 		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
 			0, WAIT_TARGET);
 		return;



