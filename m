Return-Path: <stable+bounces-194702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726EC58B1B
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA68C4A1232
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B86350A1C;
	Thu, 13 Nov 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFhRljHR"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D010350A16
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048402; cv=none; b=TDmkRb12Z7+8+6/0PYxQhUV4Q1lXy6zpIWNhbn+6VnsTjGRCNByHCElWyAwDXgJc6rJlGDIsTEY68A/F3j9/uLLUk7kphqclP1ZyV0WQK8HUx083RWXkkvDSlWjZOn+gLJrxBu8SqMcfMLzwkhCleOR2g6sWdgs+IEGdE66M9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048402; c=relaxed/simple;
	bh=IAwkvPGN1J6/ndtGV/PbZPfm2JVOjdVPyim6gdQtW9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0lvPw4CFUg6FPNgYtTpHcrZqbNRy+Pol+7GsEogHY/+mntBh+Yh7ooJf9Y3aYub+zkfcUPqTp4XVmPkeyyQvniz8FBvCK60sl173qYXeWrW9SQSuBKptdKtSvzKYpGvQJq3j9JNN1MAm62N51uzAHewnGl5b59vUw2+Xsb4hoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFhRljHR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763048388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gE+3sRbPyHtFVg+iv45yjGoy/qm9/uVMyd8LB7zMmwc=;
	b=QFhRljHRmtIGs223E59VPERVczvN2nHQAZk8qZV5OgPZgVtwzjez+vinkcRX9sBdKFUyOi
	gsIxw0nqty75c4NLgYc08QFgtLph1EoUtBEBKtxgXPPVXeIqxGAJZRVcR6SgCShaRzxSbR
	c+wLs+NVMI97YHz8Tha5UIAk6ExPYYg=
From: Dawei Li <dawei.li@linux.dev>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawei.li@linux.dev,
	set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] rpmsg: char: Remove put_device() in rpmsg_eptdev_add()
Date: Thu, 13 Nov 2025 23:39:07 +0800
Message-Id: <20251113153909.3789-2-dawei.li@linux.dev>
In-Reply-To: <20251113153909.3789-1-dawei.li@linux.dev>
References: <20251113153909.3789-1-dawei.li@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

put_device() is called on error path of rpmsg_eptdev_add() to cleanup
resource attached to eptdev->dev, unfortunately it's bogus cause
dev->release() is not set yet.

When a struct device instance is destroyed, driver core framework checks
the possible release() callback from candidates below:
- struct device::release()
- dev->type->release()
- dev->class->dev_release()

Rpmsg eptdev owns none of them so WARN() will complaint the absence of
release():

[  159.112182] ------------[ cut here ]------------
[  159.112188] Device '(null)' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[  159.112205] WARNING: CPU: 2 PID: 1975 at drivers/base/core.c:2567 device_release+0x7a/0x90

Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Li <dawei.li@linux.dev>
---
 drivers/rpmsg/rpmsg_char.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 34b35ea74aab..1b8297b373f0 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -494,7 +494,6 @@ static int rpmsg_eptdev_add(struct rpmsg_eptdev *eptdev,
 	if (cdev)
 		ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
 free_eptdev:
-	put_device(dev);
 	kfree(eptdev);
 
 	return ret;
-- 
2.25.1


