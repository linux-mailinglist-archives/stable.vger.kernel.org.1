Return-Path: <stable+bounces-103466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CBE9EF7D8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA4E16D148
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44524213E6F;
	Thu, 12 Dec 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmzsXh8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C720A5EE;
	Thu, 12 Dec 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024654; cv=none; b=WISZ1FSvUwovVInexei0jsavc//BEZbIG+z7Yfs8JctiucP1S6lUzqGAzeBDnAiIeRNlvV1B4ZcW4BjUzpdOMZD9J77n7vqc/3sXpECPyVVUBoOBK7NigT4ekRxlT3o6sHKz6VMCzfMfvyFFmVdYV1PMCQ10DoPD9cdXIj4WuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024654; c=relaxed/simple;
	bh=vbXb5VsXcP1Zxm55m+D4NGyjOwb1lmMH7xZVOmgHDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCdrAvyiCKKVVdZvNz/l/mKraU6+77V7rZGomTyHlfllBhg2fIoWrPHPmuh/Egll2dPWlf/4L16aJOvQv7ry3roD1Z5ULLTH4jB5L6pFrH22nDVUXSUaA43IaSgaFGJL386iw4F8ES7EO/2xlHI2kyFQDhTDy4mMjgQ0edmrnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmzsXh8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F484C4CECE;
	Thu, 12 Dec 2024 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024653;
	bh=vbXb5VsXcP1Zxm55m+D4NGyjOwb1lmMH7xZVOmgHDJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmzsXh8GK1eFPhrtYQAHmGKKpOVtUOjQ6SyeKVfKwOgGuU0V3zEhnwT1JXgxCiCE1
	 hAtdg7L5jQ4Pdx/HYPE3BIvC2uaV67e26Faf7p88txqTmhxzWNX9V87mzZAmpYHpKk
	 xJSa6JL1MIQ2hntiJo8315XUPcbqqFqV+I22tyEo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anil Gurumurthy <agurumurthy@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 367/459] scsi: qla2xxx: Supported speed displayed incorrectly for VPorts
Date: Thu, 12 Dec 2024 16:01:45 +0100
Message-ID: <20241212144308.170106728@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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
@@ -3244,6 +3244,7 @@ struct fc_function_template qla2xxx_tran
 	.show_host_node_name = 1,
 	.show_host_port_name = 1,
 	.show_host_supported_classes = 1,
+	.show_host_supported_speeds = 1,
 
 	.get_host_port_id = qla2x00_get_host_port_id,
 	.show_host_port_id = 1,



