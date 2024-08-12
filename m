Return-Path: <stable+bounces-66465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B566494EBBE
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A57B22ADA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD57170A0F;
	Mon, 12 Aug 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVgWLp+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3A1586C0
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461837; cv=none; b=ot5jk41dwYmnWaG3J6j5Sfo0fRVwbR4WVqnI08ujMPxYwsAoEIVIYsz+/vgYVUq0OO/rLxhJQv+Fbw59rgFbZ8uE6BX+RL4dwY0z+9iU2RFSdlZf75yqEV3fbv8pQCLshTAe985SGwNeWySc7xNW2fUQO2a/1uKUhG0XeUFdg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461837; c=relaxed/simple;
	bh=gaKCGfZ/c5CyQhHiquyNUvU2ZCnyYAjog0Wo8LlSxag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ShvQ/Y/1SeYIxC+1hHvsNN0bAUz6dPm8f6jvL9pF0Tj/9xdXLRjzs3ueE6BM48bypRsEVAzWtI2WV5lc1x0mzOBVWaNM6HZDO8mI617J8UJPROMy2JSJs3Yaqi1lK+kqIzE0zknl3IqU8U85eSVMwkywi1Ja7wV+seCYjsxEwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVgWLp+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B64C32782;
	Mon, 12 Aug 2024 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723461836;
	bh=gaKCGfZ/c5CyQhHiquyNUvU2ZCnyYAjog0Wo8LlSxag=;
	h=Subject:To:Cc:From:Date:From;
	b=bVgWLp+ki6o4XJxkvyuF8gxpLuXjIosaFtdIoemBm/Dv/eNxqR0gbVTICTtmgb6aX
	 iJJjZiE4zHJ/2hPY0Fv0M7czIBG8lreOag2Ldj0SuzIbRmhWQv/7BhMu+yS+DEi6Ze
	 STQujKADm5/dgtQf/y+dW29o2CYYeFtv75Zd7mUE=
Subject: FAILED: patch "[PATCH] idpf: fix memleak in vport interrupt configuration" failed to apply to 6.10-stable tree
To: michal.kubiak@intel.com,aleksander.lobakin@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,krishneil.k.singh@intel.com,kuba@kernel.org,pavan.kumar.linga@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 13:23:53 +0200
Message-ID: <2024081253-evict-snarl-1f5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3cc88e8405b8d55e0ff035e31971aadd6baee2b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081253-evict-snarl-1f5c@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

3cc88e8405b8 ("idpf: fix memleak in vport interrupt configuration")
bf9bf7042a38 ("idpf: avoid bloating &idpf_q_vector with big %NR_CPUS")
e4891e4687c8 ("idpf: split &idpf_queue into 4 strictly-typed queue structures")
66c27e3b19d5 ("idpf: stop using macros for accessing queue descriptors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3cc88e8405b8d55e0ff035e31971aadd6baee2b6 Mon Sep 17 00:00:00 2001
From: Michal Kubiak <michal.kubiak@intel.com>
Date: Tue, 6 Aug 2024 15:09:21 -0700
Subject: [PATCH] idpf: fix memleak in vport interrupt configuration

The initialization of vport interrupt consists of two functions:
 1) idpf_vport_intr_init() where a generic configuration is done
 2) idpf_vport_intr_req_irq() where the irq for each q_vector is
   requested.

The first function used to create a base name for each interrupt using
"kasprintf()" call. Unfortunately, although that call allocated memory
for a text buffer, that memory was never released.

Fix this by removing creating the interrupt base name in 1).
Instead, always create a full interrupt name in the function 2), because
there is no need to create a base name separately, considering that the
function 2) is never called out of idpf_vport_intr_init() context.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20240806220923.3359860-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index af2879f03b8d..a2f9f252694a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3780,13 +3780,15 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 /**
  * idpf_vport_intr_req_irq - get MSI-X vectors from the OS for the vport
  * @vport: main vport structure
- * @basename: name for the vector
  */
-static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
+static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	const char *drv_name, *if_name, *vec_name;
 	int vector, err, irq_num, vidx;
-	const char *vec_name;
+
+	drv_name = dev_driver_string(&adapter->pdev->dev);
+	if_name = netdev_name(vport->netdev);
 
 	for (vector = 0; vector < vport->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[vector];
@@ -3804,8 +3806,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 		else
 			continue;
 
-		name = kasprintf(GFP_KERNEL, "%s-%s-%d", basename, vec_name,
-				 vidx);
+		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
+				 vec_name, vidx);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
@@ -4326,7 +4328,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
  */
 int idpf_vport_intr_init(struct idpf_vport *vport)
 {
-	char *int_name;
 	int err;
 
 	err = idpf_vport_intr_init_vec_idx(vport);
@@ -4340,11 +4341,7 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 	if (err)
 		goto unroll_vectors_alloc;
 
-	int_name = kasprintf(GFP_KERNEL, "%s-%s",
-			     dev_driver_string(&vport->adapter->pdev->dev),
-			     vport->netdev->name);
-
-	err = idpf_vport_intr_req_irq(vport, int_name);
+	err = idpf_vport_intr_req_irq(vport);
 	if (err)
 		goto unroll_vectors_alloc;
 


