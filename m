Return-Path: <stable+bounces-247427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENijFJHKBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E159C54A892
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D87A4300CFF8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73839A06F;
	Fri, 15 May 2026 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6GrCnHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CF3E557C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829806; cv=none; b=NqScjx07Abzau6jio/v5KXV5naoTCgpRzy7NwNXiD6abLxAlkAqszXR51OKNeC7n9NTvo5oBca4tIBbxkrCCB9yqNEbpHjgyWihoMlKYRToBlkBEZ7/Lsdg/wFho8aLX+DFuBsCAyPkGFk0oZaRP8Lv7h6ytSvUee/m3djxC8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829806; c=relaxed/simple;
	bh=m4mJKuAl8FqrfkQiN9mrnpYwBRbg+GpQv1fPrrCOIbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T8HfajOHVMlvL0dIjGQ6UJY8a1mSr0Sz+vAuVFfkyqdvNk8xsAVLny1lDLBHVXYDlPDoWTaYGaL0t5dm2C+GUnMKeQq4hFB9ksnyEdZX6817Z7s1YmqKZ4YNqp+AjkM4NupcUM1hysdQT886v6W2upbCqnAfREQ80eIP2WQRfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6GrCnHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C20C2BCB8;
	Fri, 15 May 2026 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778829805;
	bh=m4mJKuAl8FqrfkQiN9mrnpYwBRbg+GpQv1fPrrCOIbM=;
	h=Subject:To:Cc:From:Date:From;
	b=M6GrCnHuRxtLWmwi1cLpcgjTOlSc2M/GcUShJ7gfk8ty39BE0Cld8TE9nTAjYCgNP
	 mTdm1Fjs+qrz7SnHS6bAo24ILzyCoL92BFixs0xGPS4SIBgB/d8tw3qh+TidooL1OR
	 MNSzpdoG593JRmRGHsnaBGFEKPDpch0ktlVpND4I=
Subject: FAILED: patch "[PATCH] media: iris: fix use-after-free of fmt_src during MBPF check" failed to apply to 6.18-stable tree
To: busanna.reddy@oss.qualcomm.com,bod@kernel.org,dikshita.agarwal@oss.qualcomm.com,hverkuil+cisco@kernel.org,vikash.garodia@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:23:22 +0200
Message-ID: <2026051522-wince-ensure-1d1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E159C54A892
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247427-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3d9593ad1a58c5acc3e5fa2a48222bb7632e6812
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051522-wince-ensure-1d1b@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d9593ad1a58c5acc3e5fa2a48222bb7632e6812 Mon Sep 17 00:00:00 2001
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 18:58:31 +0530
Subject: [PATCH] media: iris: fix use-after-free of fmt_src during MBPF check

During concurrency testing, multiple instances can run in parallel, and
each instance uses its own inst->lock while the core->lock protects the
list of active instances. The race happens because these locks cover
different scopes, inst->lock protects only the internals of a single
instance, while the Macro Blocks Per Frame (MBPF) checker walks the
core list under core->lock and reads fields like fmt_src->width and
fmt_src->height. At the same time, iris_close() may free fmt_src and
fmt_dst under inst->lock while the instance is still present in the core
list. This allows a situation where the MBPF checker, still iterating
through the core list, reaches an instance whose fmt_src was already
freed by another thread and ends up dereferencing a dangling pointer,
resulting in a use-after-free. This happens because the MBPF checker
assumes that any instance in the core list is fully valid, but the
freeing of fmt_src and fmt_dst without removing the instance from the
core list is not correct.

The correct ordering is to defer freeing fmt_src and fmt_dst until after
the instance has been removed from the core list and all teardown under
the core lock has completed, ensuring that no dangling pointers are ever
exposed during MBPF checks.

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Fixes: 5ad964ad5656 ("media: iris: Initialize and deinitialize encoder instance structure")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 719217399a30..99d544e2af4f 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -61,12 +61,6 @@ int iris_vdec_inst_init(struct iris_inst *inst)
 	return iris_ctrls_init(inst);
 }
 
-void iris_vdec_inst_deinit(struct iris_inst *inst)
-{
-	kfree(inst->fmt_dst);
-	kfree(inst->fmt_src);
-}
-
 static const struct iris_fmt iris_vdec_formats_cap[] = {
 	[IRIS_FMT_NV12] = {
 		.pixfmt = V4L2_PIX_FMT_NV12,
diff --git a/drivers/media/platform/qcom/iris/iris_vdec.h b/drivers/media/platform/qcom/iris/iris_vdec.h
index ec1ce55d1375..5123d2a340e1 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/iris/iris_vdec.h
@@ -9,7 +9,6 @@
 struct iris_inst;
 
 int iris_vdec_inst_init(struct iris_inst *inst);
-void iris_vdec_inst_deinit(struct iris_inst *inst);
 int iris_vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int iris_vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int iris_vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index aa27b22704eb..4d886769d958 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -79,12 +79,6 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	return iris_ctrls_init(inst);
 }
 
-void iris_venc_inst_deinit(struct iris_inst *inst)
-{
-	kfree(inst->fmt_dst);
-	kfree(inst->fmt_src);
-}
-
 static const struct iris_fmt iris_venc_formats_cap[] = {
 	[IRIS_FMT_H264] = {
 		.pixfmt = V4L2_PIX_FMT_H264,
diff --git a/drivers/media/platform/qcom/iris/iris_venc.h b/drivers/media/platform/qcom/iris/iris_venc.h
index c4db7433da53..00c1716b2747 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.h
+++ b/drivers/media/platform/qcom/iris/iris_venc.h
@@ -9,7 +9,6 @@
 struct iris_inst;
 
 int iris_venc_inst_init(struct iris_inst *inst);
-void iris_venc_inst_deinit(struct iris_inst *inst);
 int iris_venc_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int iris_venc_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index bd38d84c9cc7..5eb1786b0737 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -289,10 +289,6 @@ int iris_close(struct file *filp)
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	mutex_lock(&inst->lock);
-	if (inst->domain == DECODER)
-		iris_vdec_inst_deinit(inst);
-	else if (inst->domain == ENCODER)
-		iris_venc_inst_deinit(inst);
 	iris_session_close(inst);
 	iris_inst_change_state(inst, IRIS_INST_DEINIT);
 	iris_v4l2_fh_deinit(inst, filp);
@@ -304,6 +300,8 @@ int iris_close(struct file *filp)
 	mutex_unlock(&inst->lock);
 	mutex_destroy(&inst->ctx_q_lock);
 	mutex_destroy(&inst->lock);
+	kfree(inst->fmt_src);
+	kfree(inst->fmt_dst);
 	kfree(inst);
 
 	return 0;


