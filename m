Return-Path: <stable+bounces-128924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369FCA7FC0D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFDE7ABE70
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE22641D4;
	Tue,  8 Apr 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHAEqnqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83963263C8A
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108112; cv=none; b=hEV6N7HvBVWZxou9+zZDtkFPTgsAQik4yIeeHFYxkPh2T8gyuOPmIPni9bZOwf/fQj0bNoz3ANSxejC8FQi8b+khAQ9nt7pBp/XSvV45QSqfl9WrGNJEC6SnkjFOo7ZfgJecQYx9v1CRnYrLjYgD25DSM6qcC/B40ctil54Ns9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108112; c=relaxed/simple;
	bh=jNQJwcmTGaZrnqFKT7USEzp5TQ7ImqOekddIIRia3r8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UR5vp7Ln+01+SjVqhsOxn5hRBU343rgBCnj5fucd5ewfPRHii3LcBNWwZvMTaUikhcFnsjDTs/bYs8+FugldRClPaIuKvmdWujCaNX9wdDQeS6jDBs9/dDeGRvJ/JfSNV+IpMlL8Vxykm1118K3xoEWuZEwWC0QeHlmagnCwFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHAEqnqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10483C4CEE5;
	Tue,  8 Apr 2025 10:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744108112;
	bh=jNQJwcmTGaZrnqFKT7USEzp5TQ7ImqOekddIIRia3r8=;
	h=Subject:To:Cc:From:Date:From;
	b=GHAEqnqiAOH+zkIT0URetU2WKnIjOu8reTeA990E05xq85a1V7na9XCaU1cd/gnTP
	 cdfW4i0Gg1Py03X/UtzlA3ctFY36x6t4m9b2G0TSSU3pkaR1Ih3wz9OfJjT10yZiV7
	 X5gxAK9X0rt+k0w0IuHXAt0iVQt/g7z7H3QyoVK0=
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()" failed to apply to 6.12-stable tree
To: dan.carpenter@linaro.org,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:26:59 +0200
Message-ID: <2025040859-vocalist-germproof-0dee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5b1122fc4995f308b21d7cfc64ef9880ac834d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040859-vocalist-germproof-0dee@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b1122fc4995f308b21d7cfc64ef9880ac834d20 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 10 Mar 2025 22:48:29 +0300
Subject: [PATCH] platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are a few problems in this code:

First, if amd_pmf_tee_init() fails then the function returns directly
instead of cleaning up.  We cannot simply do a "goto error;" because
the amd_pmf_tee_init() cleanup calls tee_shm_free(dev->fw_shm_pool);
and amd_pmf_tee_deinit() calls it as well leading to a double free.
I have re-written this code to use an unwind ladder to free the
allocations.

Second, if amd_pmf_start_policy_engine() fails on every iteration though
the loop then the code calls amd_pmf_tee_deinit() twice which is also a
double free.  Call amd_pmf_tee_deinit() inside the loop for each failed
iteration.  Also on that path the error codes are not necessarily
negative kernel error codes.  Set the error code to -EINVAL.

There is a very subtle third bug which is that if the call to
input_register_device() in amd_pmf_register_input_device() fails then
we call input_unregister_device() on an input device that wasn't
registered.  This will lead to a reference counting underflow
because of the device_del(&dev->dev) in __input_unregister_device().
It's unlikely that anyone would ever hit this bug in real life.

Fixes: 376a8c2a1443 ("platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/232231fc-6a71-495e-971b-be2a76f6db4c@stanley.mountain
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index ceaff1ebb7b9..a1e43873a07b 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -510,18 +510,18 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 
 	ret = amd_pmf_set_dram_addr(dev, true);
 	if (ret)
-		goto error;
+		goto err_cancel_work;
 
 	dev->policy_base = devm_ioremap_resource(dev->dev, dev->res);
 	if (IS_ERR(dev->policy_base)) {
 		ret = PTR_ERR(dev->policy_base);
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
 	if (!dev->policy_buf) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
@@ -531,13 +531,13 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_policy;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(amd_pmf_ta_uuid); i++) {
 		ret = amd_pmf_tee_init(dev, &amd_pmf_ta_uuid[i]);
 		if (ret)
-			return ret;
+			goto err_free_prev_data;
 
 		ret = amd_pmf_start_policy_engine(dev);
 		switch (ret) {
@@ -550,27 +550,41 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 			status = false;
 			break;
 		default:
-			goto error;
+			ret = -EINVAL;
+			amd_pmf_tee_deinit(dev);
+			goto err_free_prev_data;
 		}
 
 		if (status)
 			break;
 	}
 
-	if (!status && !pb_side_load)
-		goto error;
+	if (!status && !pb_side_load) {
+		ret = -EINVAL;
+		goto err_free_prev_data;
+	}
 
 	if (pb_side_load)
 		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 
 	ret = amd_pmf_register_input_device(dev);
 	if (ret)
-		goto error;
+		goto err_pmf_remove_pb;
 
 	return 0;
 
-error:
-	amd_pmf_deinit_smart_pc(dev);
+err_pmf_remove_pb:
+	if (pb_side_load && dev->esbin)
+		amd_pmf_remove_pb(dev);
+	amd_pmf_tee_deinit(dev);
+err_free_prev_data:
+	kfree(dev->prev_data);
+err_free_policy:
+	kfree(dev->policy_buf);
+err_free_dram_buf:
+	kfree(dev->buf);
+err_cancel_work:
+	cancel_delayed_work_sync(&dev->pb_work);
 
 	return ret;
 }


