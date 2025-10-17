Return-Path: <stable+bounces-187254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA23BEA9A1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C78B7C6185
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C77330B2D;
	Fri, 17 Oct 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TIzv3ar9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A0330B27;
	Fri, 17 Oct 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715553; cv=none; b=jwJlcq28QYE+mxGO1BT5/0nnImL2GMPuo52iAWR/ZkudG7uY7PHvvH6ZkV+fR6zscc8YzRHlZc8Woiy4kFVudsjJkNLfmvjRLfDdTyxZa0hMWDTQ2TbYX6W4fEEL6Rr5oRvdKIOrphlef4iNPRzQvCPbCnD1vk7wYxhVNrAWaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715553; c=relaxed/simple;
	bh=6wju+rbndnHaDQKcFOOV24217oREHLY8cHMThe8El1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnVPQmZ0xcDyOGRYc7Av9Mkw4BHK6M8qJmhpAbv/qASgTxMQYONo8AiyTjFAxLYl/wihcTD4mcX6qUwDWSJU9YiWMzR0d7ZCB0US9WJs9rIyrJaKdR/7geT/po+JEWfno1LvUeovxSszdAk2ljDCOaWblYaub5pwMWUAPQN1wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TIzv3ar9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA2C4CEE7;
	Fri, 17 Oct 2025 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715553;
	bh=6wju+rbndnHaDQKcFOOV24217oREHLY8cHMThe8El1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIzv3ar988RkQvvO5kW1OYKpEFfjoT8FbMiUQ8uIgQ3oSA4n57ZPcBAt9BNcePz6c
	 fKYQsA//0yNfHPTJGBAFQUqgpDwA7TMhyUKG3tJiZ81YY3fptMVuGBoIcWmefxRMjk
	 lxq3AfSKuuj5jm2+1PDl0qNRoY21MJ3V+ql/zBy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Don Brace <don.brace@microchip.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.17 256/371] scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
Date: Fri, 17 Oct 2025 16:53:51 +0200
Message-ID: <20251017145211.345394372@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit b81296591c567b12d3873b05a37b975707959b94 upstream.

Replace kmalloc() followed by copy_from_user() with memdup_user() to fix
a memory leak that occurs when copy_from_user(buff[sg_used],,) fails and
the 'cleanup1:' path does not free the memory for 'buff[sg_used]'. Using
memdup_user() avoids this by freeing the memory internally.

Since memdup_user() already allocates memory, use kzalloc() in the else
branch instead of manually zeroing 'buff[sg_used]' using memset(0).

Cc: stable@vger.kernel.org
Fixes: edd163687ea5 ("[SCSI] hpsa: add driver for HP Smart Array controllers.")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Don Brace <don.brace@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/hpsa.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6522,18 +6522,21 @@ static int hpsa_big_passthru_ioctl(struc
 	while (left) {
 		sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
 		buff_size[sg_used] = sz;
-		buff[sg_used] = kmalloc(sz, GFP_KERNEL);
-		if (buff[sg_used] == NULL) {
-			status = -ENOMEM;
-			goto cleanup1;
-		}
+
 		if (ioc->Request.Type.Direction & XFER_WRITE) {
-			if (copy_from_user(buff[sg_used], data_ptr, sz)) {
-				status = -EFAULT;
+			buff[sg_used] = memdup_user(data_ptr, sz);
+			if (IS_ERR(buff[sg_used])) {
+				status = PTR_ERR(buff[sg_used]);
+				goto cleanup1;
+			}
+		} else {
+			buff[sg_used] = kzalloc(sz, GFP_KERNEL);
+			if (!buff[sg_used]) {
+				status = -ENOMEM;
 				goto cleanup1;
 			}
-		} else
-			memset(buff[sg_used], 0, sz);
+		}
+
 		left -= sz;
 		data_ptr += sz;
 		sg_used++;



