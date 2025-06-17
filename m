Return-Path: <stable+bounces-153664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1EDADD618
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DC319E0897
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90512EA16B;
	Tue, 17 Jun 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JM6rW+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490F237162;
	Tue, 17 Jun 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176692; cv=none; b=YnV+Wk9xHaTgfda+wZTmV+to8JBMouHuRZu8xLiko0ZJ35kxA8/fN6Pjk4sQuLoXbqjucjqwpIAa3JSvWobXjqbsr3OZVwtvyZwVB9RmZ68sn9nRph68B3fEDD7lAXqQFh5mYTHTBA6HmeSsZ+jVPFe41y19tGr0Sk6Sn/c7HU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176692; c=relaxed/simple;
	bh=7k2rN39ZvdDACzcL5pvxgz66RqWUZ1jy26v5BE6ZjGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxAHN/gnV5rHEEEPR8NdOtTZcz1yaRQk3XPEFskBkgCu565dbqk48zODDUvE9LIyqLsPkESWe6jqU7FGDysW2gAmDCqFyJXyawmJ8/9LjiZUYl46cvdGKfAY63NVA4OcYPVg5v9GN9DwU7Ep08e2Ex7P0+jkoEDtN4TPD4jNM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0JM6rW+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22702C4CEE3;
	Tue, 17 Jun 2025 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176692;
	bh=7k2rN39ZvdDACzcL5pvxgz66RqWUZ1jy26v5BE6ZjGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0JM6rW+yE0DfQXuZUO9yzEGTJ9eVKYqOC47MRcXRWtzXzanD8GGzaTA5Pyi+ttnzE
	 DhlnG7Zjp/6OC7V1W6INYM1eO5Av81MCWRUDH5sHZyZMdpu0rd8szy0am4jIIAaNzC
	 j1dQCFtUAxFlNwmjeoUnNGUHpEfRNC/ZvtCenm9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 305/356] scsi: iscsi: Fix incorrect error path labels for flashnode operations
Date: Tue, 17 Jun 2025 17:27:00 +0200
Message-ID: <20250617152350.449642943@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 9b17621366d210ffee83262a8754086ebbde5e55 ]

Correct the error handling goto labels used when host lookup fails in
various flashnode-related event handlers:

 - iscsi_new_flashnode()
 - iscsi_del_flashnode()
 - iscsi_login_flashnode()
 - iscsi_logout_flashnode()
 - iscsi_logout_flashnode_sid()

scsi_host_put() is not required when shost is NULL, so jumping to the
correct label avoids unnecessary operations. These functions previously
jumped to the wrong goto label (put_host), which did not match the
intended cleanup logic.

Use the correct exit labels (exit_new_fnode, exit_del_fnode, etc.) to
ensure proper error handling.  Also remove the unused put_host label
under iscsi_new_flashnode() as it is no longer needed.

No functional changes beyond accurate error path correction.

Fixes: c6a4bb2ef596 ("[SCSI] scsi_transport_iscsi: Add flash node mgmt support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://lore.kernel.org/r/20250530193012.3312911-1-alok.a.tiwari@oracle.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 0c30fec555475..f2c31e74d8ed0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3525,7 +3525,7 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.new_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_new_fnode;
 	}
 
 	index = transport->new_flashnode(shost, data, len);
@@ -3535,7 +3535,6 @@ static int iscsi_new_flashnode(struct iscsi_transport *transport,
 	else
 		err = -EIO;
 
-put_host:
 	scsi_host_put(shost);
 
 exit_new_fnode:
@@ -3560,7 +3559,7 @@ static int iscsi_del_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.del_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_del_fnode;
 	}
 
 	idx = ev->u.del_flashnode.flashnode_idx;
@@ -3602,7 +3601,7 @@ static int iscsi_login_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.login_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_login_fnode;
 	}
 
 	idx = ev->u.login_flashnode.flashnode_idx;
@@ -3654,7 +3653,7 @@ static int iscsi_logout_flashnode(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_fnode;
 	}
 
 	idx = ev->u.logout_flashnode.flashnode_idx;
@@ -3704,7 +3703,7 @@ static int iscsi_logout_flashnode_sid(struct iscsi_transport *transport,
 		pr_err("%s could not find host no %u\n",
 		       __func__, ev->u.logout_flashnode.host_no);
 		err = -ENODEV;
-		goto put_host;
+		goto exit_logout_sid;
 	}
 
 	session = iscsi_session_lookup(ev->u.logout_flashnode_sid.sid);
-- 
2.39.5




