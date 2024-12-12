Return-Path: <stable+bounces-101549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16A9EED15
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4AE1627E0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779D217F34;
	Thu, 12 Dec 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/KmcR/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583C6F2FE;
	Thu, 12 Dec 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017946; cv=none; b=owbZ2MksbcFDJ3wloueFWITomqP26dwKHIFeTsywLXEr4Helf6YUyty6qZPBZqfoMwoI59YqpI6Vh9Tye3I8Pohlt2V4obGvs1RAn6h8rR2y6ruTnFPmDNve/BQpKRD19eqYqwPnLkGqiUX4uFl7PgzxahhmbjEjRQWXieHPj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017946; c=relaxed/simple;
	bh=2PXgo1iASluQyRzqA5UlFjdNu4kIgk/FHxbdhsk/nOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8RQR6lkQyOy+WjvGtcetehTE0QuZka3Jo+1L77yR75uwm1sz3p9MSMXicFykV4w7MyIHGcsl5QM8W5Dwa1UAqjrAwfWl+27jaiR7npnwq0zY6L1sqQF2+ZXbd+6sTCP6eoubPc7Dcmyg7Myj/1q9UitSloDpS3lrhkO0WmDOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/KmcR/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01254C4CED0;
	Thu, 12 Dec 2024 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017946;
	bh=2PXgo1iASluQyRzqA5UlFjdNu4kIgk/FHxbdhsk/nOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/KmcR/S2YziJwMRVSaFtCZ1ILcxov3c6B/AaYDhp2UZJ9a5S+k3gUkL4M5iJkHkd
	 Ms3hs/EkidWyIVn0veAJdYbGpedVt3pQrHRlMzuagsVCUTXWU3wp95FYNwSyJtzO6A
	 RRHpJjA+IHaYT4i3hA+8BGP1kNCj09SS4ajcO6OM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 154/356] scsi: qla2xxx: Supported speed displayed incorrectly for VPorts
Date: Thu, 12 Dec 2024 15:57:53 +0100
Message-ID: <20241212144250.725336908@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

From: Anil Gurumurthy <agurumurthy@marvell.com>

commit e4e268f898c8a08f0a1188677e15eadbc06e98f6 upstream.

The fc_function_template for vports was missing the
.show_host_supported_speeds. The base port had the same.

Add .show_host_supported_speeds to the vport template as well.

Cc: stable@vger.kernel.org
Fixes: 2c3dfe3f6ad8 ("[SCSI] qla2xxx: add support for NPIV")
Signed-off-by: Anil Gurumurthy <agurumurthy@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20241115130313.46826-7-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_attr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3311,6 +3311,7 @@ struct fc_function_template qla2xxx_tran
 	.show_host_node_name = 1,
 	.show_host_port_name = 1,
 	.show_host_supported_classes = 1,
+	.show_host_supported_speeds = 1,
 
 	.get_host_port_id = qla2x00_get_host_port_id,
 	.show_host_port_id = 1,



