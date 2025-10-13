Return-Path: <stable+bounces-184222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3CBD2D6D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 715A834B2CF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C51E5B95;
	Mon, 13 Oct 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TO5fK+ZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54121514DC
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355986; cv=none; b=O8gBYrLko0GSZq/qr8i7PyKLWq4KdfDjasJRBvktmeMNm2zxAEtL7pTBKYAGd+ENgHgKpMhmT6bgHKWfzmshdOCiCyJvf9d1iyXWMrThhoX13pydLEAg0N92yAxltf8Sd/fL3fK2A+AQyZKitQNmTfCJ/uQBMgP6k5AjqPfwYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355986; c=relaxed/simple;
	bh=qYCSzMfY0ZBPfALP2Ziyb7+jP0opDGgacyDq83Pd4/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=exGuXEs3mEEIVpUNl7wBK/HBAm5geNhPCzuE2Jv0vpH003Mmz9tt/zEoFs1qEgQ1a3SIoXMj/faq/Ez+IeiHGY1YGQ4r6f9TN8MeBrSitwwrlmKb6VDv7B2y5oEcthFG6nRBth+L3stsp9+7UR9wkcBpIlDIYcaO/TDP+ltmkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TO5fK+ZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B21C4CEE7;
	Mon, 13 Oct 2025 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760355985;
	bh=qYCSzMfY0ZBPfALP2Ziyb7+jP0opDGgacyDq83Pd4/A=;
	h=Subject:To:Cc:From:Date:From;
	b=TO5fK+ZPR8+NJJNN066n2Kg8Oej80sZWGENr3f9fINqsflH8Hv/UeikpELgYl4KIt
	 SUNlEMRK03CshtLLcHOlMRAJL4THqppMmgzEgR9n4IOjIhcSxGtOSaJBDm3LD4Qk0I
	 Y4SiJ/SwWb1AnsQyKaYaG8zWZUWCdkHQuq3sSlG0=
Subject: FAILED: patch "[PATCH] misc: fastrpc: fix possible map leak in fastrpc_put_args" failed to apply to 5.4-stable tree
To: quic_lxu5@quicinc.com,dmitry.baryshkov@oss.qualcomm.com,ekansh.gupta@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:46:12 +0200
Message-ID: <2025101312-express-attractor-1757@gregkh>
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
git cherry-pick -x da1ba64176e0138f2bfa96f9e43e8c3640d01e1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101312-express-attractor-1757@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da1ba64176e0138f2bfa96f9e43e8c3640d01e1e Mon Sep 17 00:00:00 2001
From: Ling Xu <quic_lxu5@quicinc.com>
Date: Fri, 12 Sep 2025 14:12:35 +0100
Subject: [PATCH] misc: fastrpc: fix possible map leak in fastrpc_put_args

copy_to_user() failure would cause an early return without cleaning up
the fdlist, which has been updated by the DSP. This could lead to map
leak. Fix this by redirecting to a cleanup path on failure, ensuring
that all mapped buffers are properly released before returning.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://lore.kernel.org/r/20250912131236.303102-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1815b1e0c607..d950a179bff8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1085,6 +1085,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_phy_page *pages;
 	u64 *fdlist;
 	int i, inbufs, outbufs, handles;
+	int ret = 0;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
@@ -1100,14 +1101,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			u64 len = rpra[i].buf.len;
 
 			if (!kernel) {
-				if (copy_to_user((void __user *)dst, src, len))
-					return -EFAULT;
+				if (copy_to_user((void __user *)dst, src, len)) {
+					ret = -EFAULT;
+					goto cleanup_fdlist;
+				}
 			} else {
 				memcpy(dst, src, len);
 			}
 		}
 	}
 
+cleanup_fdlist:
 	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
@@ -1116,7 +1120,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			fastrpc_map_put(mmap);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,


