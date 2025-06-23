Return-Path: <stable+bounces-156334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74DAE4F29
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074197ACC23
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FB221727;
	Mon, 23 Jun 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mnNZRCZ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB81ACEDA;
	Mon, 23 Jun 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713160; cv=none; b=LYx4K8Sp8Z/myOc8cYLimTc4RScUWbuu8KsV+KwRePm8p3A2SqYsz2btKclHfMaPByDUHpGo3mISFyZajE8F7UNG/g1EEgMIuJiAtca3ce6GRygtlBzXhAE+XRmx/OwesedLbbMzK/otGqdmgXTaVMTj+Q4/55DI8MKCWQjtH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713160; c=relaxed/simple;
	bh=e1LDS9iP/xy7WnBRog3WbF7VzSPoBTbLZ1pLQHubc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw5K6i/N4SMP37F+NCAJBLWud32s7xYlwM2k9hC8yy/ayfAwMy4jqJ/YQIyhAUCW9/n7EIGH94UicH9jlzipCtYL7EPPmjDU6eJAemCVd1ecXVl9pbAIX9UGAIaf8Dv7PG9KtU2bRN74+xcFHRoZnJUkdACwH2zM4PmDX4c3y7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mnNZRCZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5106C4CEEA;
	Mon, 23 Jun 2025 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713160;
	bh=e1LDS9iP/xy7WnBRog3WbF7VzSPoBTbLZ1pLQHubc7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnNZRCZ1oMDMmk1VCG0zxSNTIZP5dykrN4eF/7X/NjEjvITP76cB7bX2Tef/Pz1/R
	 AJUUibk0mVNjPg0hHDofUcxaeIWCCKj4o+w6mhpDS89A0qwIvd+nRevgKZvnRThBFX
	 Dt4VEIvXtFV1tTUxycNAlA47fMjFIprmUGR+SA8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	M Nikhil <nikh1092@linux.ibm.com>,
	Nihar Panda <niharp@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 191/222] scsi: s390: zfcp: Ensure synchronous unit_add
Date: Mon, 23 Jun 2025 15:08:46 +0200
Message-ID: <20250623130617.976103357@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oberparleiter <oberpar@linux.ibm.com>

commit 9697ca0d53e3db357be26d2414276143c4a2cd49 upstream.

Improve the usability of the unit_add sysfs attribute by ensuring that
the associated FCP LUN scan processing is completed synchronously.  This
enables configuration tooling to consistently determine the end of the
scan process to allow for serialization of follow-on actions.

While the scan process associated with unit_add typically completes
synchronously, it is deferred to an asynchronous background process if
unit_add is used before initial remote port scanning has completed.  This
occurs when unit_add is used immediately after setting the associated FCP
device online.

To ensure synchronous unit_add processing, wait for remote port scanning
to complete before initiating the FCP LUN scan.

Cc: stable@vger.kernel.org
Reviewed-by: M Nikhil <nikh1092@linux.ibm.com>
Reviewed-by: Nihar Panda <niharp@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Nihar Panda <niharp@linux.ibm.com>
Link: https://lore.kernel.org/r/20250603182252.2287285-2-niharp@linux.ibm.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/scsi/zfcp_sysfs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -355,6 +355,8 @@ static ssize_t zfcp_sysfs_unit_add_store
 	if (kstrtoull(buf, 0, (unsigned long long *) &fcp_lun))
 		return -EINVAL;
 
+	flush_work(&port->rport_work);
+
 	retval = zfcp_unit_add(port, fcp_lun);
 	if (retval)
 		return retval;



