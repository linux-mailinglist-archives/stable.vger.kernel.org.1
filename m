Return-Path: <stable+bounces-167502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED25B23053
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BB35652DF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3FA2FDC2C;
	Tue, 12 Aug 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNzOA0RT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8C2FABF8;
	Tue, 12 Aug 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021037; cv=none; b=mGxf+SWg95g4frTnKpYQdr8uiRXjvWBlzv3A1zpcGIDI0QuVVG0FrGMHUTNyCdKEVkLCJPRzCXxCfs+uridsbktZzM3bmvkh5lsJfm1C9ZX8Sd10bl5XTXmrr0pGQG8QjdqQMnvu1mmgUQdTYydA38VG8Wkuq9zgKMj5kQlwZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021037; c=relaxed/simple;
	bh=1FKvvsw+z3M3SYg6ySaMNbyqv/qxJ60f8mH07CU54+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgkmaXPS95Rj44RS3GIOzuyF4lEPrlvyeBxYHSV24ZMnZ7pQOpZHqcHBOSSxO+4P5KkvF25Ey13qOkRlf8UD8sIF7pB/qOu0N//mdLp2UwhqjQhEkl7VmflgbtJpnY+HmC/fNwD2LybxoR+UDot3NrcoV14jhj0wkxnrD3B/b2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNzOA0RT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78C1C4CEF0;
	Tue, 12 Aug 2025 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021037;
	bh=1FKvvsw+z3M3SYg6ySaMNbyqv/qxJ60f8mH07CU54+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNzOA0RTsp4Huiwi4NaFHRsy4WQo69SzeMMGRaJfP7rc+0hfDnsDa+9+ez/LM1PmV
	 /xhzFcXR9NjipKSJXvn+JK6krCEpJzZe34oi3L4ASwnu7od/wraBjvpOKOo7vhArQg
	 Qbo5hORV8RGEEyyaJxonxOsxzMOeo7NxsPT9gAg0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 202/253] scsi: Revert "scsi: iscsi: Fix HW conn removal use after free"
Date: Tue, 12 Aug 2025 19:29:50 +0200
Message-ID: <20250812172957.411196654@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 7bdc68921481c19cd8c85ddf805a834211c19e61 ]

This reverts commit c577ab7ba5f3bf9062db8a58b6e89d4fe370447e.

The invocation of iscsi_put_conn() in iscsi_iter_destory_conn_fn() is
used to free the initial reference counter of iscsi_cls_conn.  For
non-qla4xxx cases, the ->destroy_conn() callback (e.g.,
iscsi_conn_teardown) will call iscsi_remove_conn() and iscsi_put_conn()
to remove the connection from the children list of session and free the
connection at last.  However for qla4xxx, it is not the case. The
->destroy_conn() callback of qla4xxx will keep the connection in the
session conn_list and doesn't use iscsi_put_conn() to free the initial
reference counter. Therefore, it seems necessary to keep the
iscsi_put_conn() in the iscsi_iter_destroy_conn_fn(), otherwise, there
will be memory leak problem.

Link: https://lore.kernel.org/all/88334658-072b-4b90-a949-9c74ef93cfd1@huawei.com/
Fixes: c577ab7ba5f3 ("scsi: iscsi: Fix HW conn removal use after free")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Link: https://lore.kernel.org/r/20250715073926.3529456-1-lilingfeng3@huawei.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index c44103752b69..ef20fea95957 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2168,6 +2168,8 @@ static int iscsi_iter_destroy_conn_fn(struct device *dev, void *data)
 		return 0;
 
 	iscsi_remove_conn(iscsi_dev_to_conn(dev));
+	iscsi_put_conn(iscsi_dev_to_conn(dev));
+
 	return 0;
 }
 
-- 
2.39.5




