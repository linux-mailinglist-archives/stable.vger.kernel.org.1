Return-Path: <stable+bounces-243655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLE4A/ir+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B50524BF46A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1665B3015708
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0B3DE43B;
	Mon,  4 May 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFTwDrdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1962315785;
	Mon,  4 May 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904440; cv=none; b=mw8fMaMiCwDyy8dB5Kq7C/RNCb4C3L1hbLHyexgB/I68VnwPw0JEhCJK98rRTOMQXT8EZXnTwdZ558q6npIezTh3VQfJg6pWPIdvBEZJn2i+FsDiEZ9x/qTN+fQfCaWOUWH8ayKVGfNz4sayp8YDwrV5Q6T4Ak0RR/5FSnNdTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904440; c=relaxed/simple;
	bh=jk2kKMc0GpZJpdQejgURcxm5PWTCQp7z4wUBDz+NxJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7A/viqdPLPVvzn+ZGiWAU9stbqZKo95Wopy9pagKTO+McpVN77/RnWcY6aS53YgdGT8dqL7ktZbIH77/KofzD0hhD7pqoaVV2o3pBB/dh08KWKwuLrzx0PuOkUl32u2eApc7lC2rOOc6Vv1Fw8/Mj1/ZI+0UYK7JYvkODCCCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFTwDrdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8788FC2BCC4;
	Mon,  4 May 2026 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904439;
	bh=jk2kKMc0GpZJpdQejgURcxm5PWTCQp7z4wUBDz+NxJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFTwDrdWZ6Tn7FnEuz4cSnD5KuaYVI1LksS0b5gjdFfbeMtSDwD52qvgXWoHE36GJ
	 6ad49nPSCwCKvxYISs0LZ7ICEKbWRnrWui80/c+Kuve/unN+9dN6Xz05CtoHkE6K9B
	 a9aR33XVBlmeyvyXENYlmmMIlq6V3kAR34EgP4Nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 040/215] media: amphion: Fix race between m2m job_abort and device_run
Date: Mon,  4 May 2026 15:50:59 +0200
Message-ID: <20260504135131.646946433@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B50524BF46A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243655-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@oss.nxp.com>

commit 8cd35ceadcfc8c5da2eb7f7ce24525ce9d4ee62e upstream.

Fix kernel panic caused by race condition where v4l2_m2m_ctx_release()
frees m2m_ctx while v4l2_m2m_try_run() is about to call device_run
with the same context.

Race sequence:
  v4l2_m2m_try_run():           v4l2_m2m_ctx_release():
    lock/unlock                   v4l2_m2m_cancel_job()
                                    job_abort()
                                      v4l2_m2m_job_finish()
                                  kfree(m2m_ctx)  <- frees ctx
    device_run()  <- use-after-free crash at 0x538

Crash trace:
  Unable to handle kernel read from unreadable memory at virtual address
  0000000000000538
  v4l2_m2m_try_run+0x78/0x138
  v4l2_m2m_device_run_work+0x14/0x20

The amphion vpu driver does not rely on the m2m framework's device_run
callback to perform encode/decode operations.

Fix the race by preventing m2m framework job scheduling entirely:
- Add job_ready callback returning 0 (no jobs ready for m2m framework)
- Remove job_abort callback to avoid the race condition

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/amphion/vpu_v4l2.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -448,17 +448,14 @@ static void vpu_m2m_device_run(void *pri
 {
 }
 
-static void vpu_m2m_job_abort(void *priv)
+static int vpu_m2m_job_ready(void *priv)
 {
-	struct vpu_inst *inst = priv;
-	struct v4l2_m2m_ctx *m2m_ctx = inst->fh.m2m_ctx;
-
-	v4l2_m2m_job_finish(m2m_ctx->m2m_dev, m2m_ctx);
+	return 0;
 }
 
 static const struct v4l2_m2m_ops vpu_m2m_ops = {
 	.device_run = vpu_m2m_device_run,
-	.job_abort = vpu_m2m_job_abort
+	.job_ready = vpu_m2m_job_ready,
 };
 
 static int vpu_vb2_queue_setup(struct vb2_queue *vq,



