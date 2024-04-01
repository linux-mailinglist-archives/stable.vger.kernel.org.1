Return-Path: <stable+bounces-35174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F28942BE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A121F267B6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0B40876;
	Mon,  1 Apr 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LymlM5Y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2ABA3F;
	Mon,  1 Apr 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990542; cv=none; b=i3jm6DJ9VAn1PpjnLbwzaPmN3xs1Bqgj5fiBJb5Ict/rdpwhNRl/BHi2xkWWo5Ftf4F/HwLSzgaeZSo07flZ71NpH3rIVO8GoYNR891CpANT5OBxNc7+Coxn5em+xi1Ho9NcOdiFtBsCGbPyTo+86aSzFHxSSEf0Lk80S5sRO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990542; c=relaxed/simple;
	bh=UBJWTWi8albX9TiPUynMgf+K9HFDxe3rkHAxohoxDNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnA5ilnZ20Epzc4eBKZKD4oOVDd22EUiXFDujY9CgRRH77ZKgb6I59Vk1CJc2ErR/c1tw8B4QYbfY8gbNJeIOEp/8STviTjtVePVFC/2t+eSSa4NFVK5QcfBCG65sDcd1/LH9jnFjCbRrlgkkJSOC6tWv6PAE+0BjF0cDm15X98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LymlM5Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC551C433F1;
	Mon,  1 Apr 2024 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990542;
	bh=UBJWTWi8albX9TiPUynMgf+K9HFDxe3rkHAxohoxDNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LymlM5Y+ROF4NwZcG1KeBkPE+O+RiXvCV1qdQ6XThrK7HYQZjYboGDWjFe/3cX6so
	 c9++XX6M9JF/23CCfPiWZMCKwi9QN++e1ZT7DhO9T6C2ODlNp2htb4DZHM/xu3IxEH
	 MH6gUTIIhFYNwcRB3VPXdBT8YOSf7TdPtA8xhQrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurav Kashyap <skashyap@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 386/396] scsi: qla2xxx: Change debug message during driver unload
Date: Mon,  1 Apr 2024 17:47:15 +0200
Message-ID: <20240401152559.423251328@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Saurav Kashyap <skashyap@marvell.com>

commit b5a30840727a3e41d12a336d19f6c0716b299161 upstream.

Upon driver unload, purge_mbox flag is set and the heartbeat monitor thread
detects this flag and does not send the mailbox command down to FW with a
debug message "Error detected: purge[1] eeh[0] cmd=0x0, Exiting".  This
being not a real error, change the debug message.

Cc: stable@vger.kernel.org
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240227164127.36465-10-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -194,7 +194,7 @@ qla2x00_mailbox_command(scsi_qla_host_t
 	if (ha->flags.purge_mbox || chip_reset != ha->chip_reset ||
 	    ha->flags.eeh_busy) {
 		ql_log(ql_log_warn, vha, 0xd035,
-		       "Error detected: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
+		       "Purge mbox: purge[%d] eeh[%d] cmd=0x%x, Exiting.\n",
 		       ha->flags.purge_mbox, ha->flags.eeh_busy, mcp->mb[0]);
 		rval = QLA_ABORTED;
 		goto premature_exit;



