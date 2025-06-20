Return-Path: <stable+bounces-154914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83980AE1335
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2803B1733F7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155391F09BF;
	Fri, 20 Jun 2025 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etpHBMfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94381DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398179; cv=none; b=mEYy1yLFXRJjNINtvtVWa+HURiHVyAKV99Lj5utrIl1doa/XDCuTPOwAQP1Xf2XUVidxvEYGXzvwwMu2f10myjYd3fByY0SEQlJWr1D0jL/ma6+CaiaSDMI8x+tj2I8Bj+vUWPdRel8uVosWIIpBaRXqZh/FfIWMmeAfQ19i3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398179; c=relaxed/simple;
	bh=VqgmuJM2NnfcBj0ipJQJUfKAYXhjnPRoGH/eytIhq8Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gVESyIJZS5hJkCgSgGJxVOgru9HsikYzHZBsWLw2mzid3dikbPirBz8X4Fvp9OjA4v1pZZSZ/SFLA92bplWZ/mJrXpoOQcPqpwmiSBF9G63wvjHEshCy1Ks7gz64Exhmkp7IzajV/EUAmWpkx1NQYBj6xsRJrl1AjnhjsBDPtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etpHBMfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B7C4CEE3;
	Fri, 20 Jun 2025 05:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750398179;
	bh=VqgmuJM2NnfcBj0ipJQJUfKAYXhjnPRoGH/eytIhq8Y=;
	h=Subject:To:Cc:From:Date:From;
	b=etpHBMfDu/bDKG4iolCEzhyX85kekFjmcbq8zEeddRudzVe/QcrdFm5RxKWJYLnYS
	 e0zo4UwIMNKwih5/Ug9n/5I6pP8AdlBq6kKbiOHxTz3FVk0DS3ci1Z7HwKot/vWUXY
	 1Z3hOVO/+NNlGknrOO0s+uY7tGIXKU8K9Bn9NlJ8=
Subject: FAILED: patch "[PATCH] net/mlx5_core: Add error handling" failed to apply to 5.4-stable tree
To: vulab@iscas.ac.cn,pabeni@redhat.com,tariqt@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:42:56 +0200
Message-ID: <2025062056-duct-nurture-9a3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f0b50730bdd8f2734e548de541e845c0d40dceb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062056-duct-nurture-9a3b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0b50730bdd8f2734e548de541e845c0d40dceb6 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 21 May 2025 21:36:20 +0800
Subject: [PATCH] net/mlx5_core: Add error handling
 inmlx5_query_nic_vport_qkey_viol_cntr()

The function mlx5_query_nic_vport_qkey_viol_cntr() calls the function
mlx5_query_nic_vport_context() but does not check its return value. This
could lead to undefined behavior if the query fails. A proper
implementation can be found in mlx5_nic_vport_query_local_lb().

Add error handling for mlx5_query_nic_vport_context(). If it fails, free
the out buffer via kvfree() and return error code.

Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250521133620.912-1-vulab@iscas.ac.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index d10d4c396040..a3c57bb8b521 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -519,19 +519,22 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int err;
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (err)
+		goto out;
 
 	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
 				   nic_vport_context.qkey_violation_counter);
-
+out:
 	kvfree(out);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
 


