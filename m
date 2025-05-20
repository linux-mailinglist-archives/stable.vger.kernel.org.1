Return-Path: <stable+bounces-145346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD74ABDB0A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B241A7AA349
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412C24676B;
	Tue, 20 May 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="neIWdEe7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33624418D;
	Tue, 20 May 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749908; cv=none; b=ZZ2ettBk/ZpY8YaMTjBXtsuwfXulmrO3mDn8YbXC39zVXr9am9nBNPVA2Dg/Py2bvyMclgLZKhCdmZMJ4NYMdWvq8bNU8+ceaicpXkaKfB2aOOfFsIM/ObVoVqCq0oX89nBlvo5+8bXZN+BYBNRfWuyCqF5Dy2Qp06rPB1EYk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749908; c=relaxed/simple;
	bh=gz/npWoWIqbI4jCV8MHuHU11XfYpDGD97UqnrLBgDWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5LD290Mbes1YZGi6aKh3C+mRaDkMdOcFXqdTDeKsnPwjymRwIxuJsFu82Lb7CAKxln7JUSXjG/ABbsBRaqXrNa7ylwlOYpiGsrPUJEjdyQmCpO7k0ppjQs/FxtzmpLdAP8xu1hP/tXf1jODZo13/dq3QS3q8UB6QosnyBev7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=neIWdEe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D4C4CEE9;
	Tue, 20 May 2025 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749908;
	bh=gz/npWoWIqbI4jCV8MHuHU11XfYpDGD97UqnrLBgDWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neIWdEe7ZUkF8VIN6avM+TVcBb2mBL/uVf1EgetVPeLsheIg+nR41WcXzmYo0Dn50
	 3a//f0EXcEG/vxilLYBDW+h/5BZCKF1v7aJT+BYFtnMktGOA8CieJ8X3O5uAVpvJgE
	 I/nupdYYUO8Gq7MXeFD1OEaacEhnvVhYEymv8qKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6 099/117] dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
Date: Tue, 20 May 2025 15:51:04 +0200
Message-ID: <20250520125807.918445820@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
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

From: Shuai Xue <xueshuai@linux.alibaba.com>

commit d5449ff1b04dfe9ed8e455769aa01e4c2ccf6805 upstream.

The remove call stack is missing idxd cleanup to free bitmap, ida and
the idxd_device. Call idxd_free() helper routines to make sure we exit
gracefully.

Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
Cc: stable@vger.kernel.org
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250404120217.48772-9-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/idxd/init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -901,6 +901,7 @@ static void idxd_remove(struct pci_dev *
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
 }
 
 static struct pci_driver idxd_pci_driver = {



