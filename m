Return-Path: <stable+bounces-243085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPY+KFKo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 449774BE96D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF7F2300AC8D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548320DD51;
	Mon,  4 May 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6xTy6hr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FD3D6481;
	Mon,  4 May 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902979; cv=none; b=BaRVIwfY1yqyWtR2ahGW5p+xySEWzm41mdL4DTVMbE/lZ7YcMBRlCEalqf8cD6ECb0ixrM7F5o2EgepuYeJcesVcFrhSzzcGE/AFKW9TP10dQnaur0/ZNfJJv6e+NV45HInCqVKZ/JKX4/ZFzhpV+gYnySXtqsJl1vGP+7Bd+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902979; c=relaxed/simple;
	bh=psYC/UQLdiLg5hywByXPyU7RqJLMYJyn9bxUpVGBwTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB7ospnh9iPk4YJkhgr2G/mbjjj0Fv5lVqoXA1/fNjhTl//ldMJyYdmJ4dtcTnTQX32L9YOmtM3NjUiRFL2zrS+M0AVO6uvNCCEY7T+a9TnlFcjwDpjTdfU6oVDHFQfa7eUVk9QO2LqY6zhR50AjAdjJJGLUWDbMLnr94Exr7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6xTy6hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2279C2BCB8;
	Mon,  4 May 2026 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902979;
	bh=psYC/UQLdiLg5hywByXPyU7RqJLMYJyn9bxUpVGBwTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6xTy6hrT+QTmj26yhm8NzVPKF0G47+z8fZiRw/fca5zkFFxrSbTar2uPBGhgZ8Z0
	 ngPqFwJWyo7QTZKurkEnlgnRN/HradhqRqrPYix0bEd5sHaLQkkeBSm8FG3mxA17u6
	 P56PIzob3jJRUtail2E9U258q/oxg8hEQRXTDpnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 056/307] media: mtk-jpeg: fix use-after-free in release path due to uncancelled work
Date: Mon,  4 May 2026 15:49:01 +0200
Message-ID: <20260504135144.929996566@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 449774BE96D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[zju.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_SPAM(0.00)[0.806];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zju.edu.cn:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fan Wu <fanwu01@zju.edu.cn>

commit 34c519feef3e4fcff1078dc8bdb25fbbbd10303f upstream.

The mtk_jpeg_release() function frees the context structure (ctx) without
first cancelling any pending or running work in ctx->jpeg_work. This
creates a race window where the workqueue callback may still be accessing
the context memory after it has been freed.

Race condition:

    CPU 0 (release)                    CPU 1 (workqueue)
    ----------------                   ------------------
    close()
      mtk_jpeg_release()
                                       mtk_jpegenc_worker()
                                         ctx = work->data
                                         // accessing ctx

        kfree(ctx)  // freed!
                                         access ctx  // UAF!

The work is queued via queue_work() during JPEG encode/decode operations
(via mtk_jpeg_device_run). If the device is closed while work is pending
or running, the work handler will access freed memory.

Fix this by calling cancel_work_sync() BEFORE acquiring the mutex. This
ordering is critical: if cancel_work_sync() is called after mutex_lock(),
and the work handler also tries to acquire the same mutex, it would cause
a deadlock.

Note: The open error path does NOT need cancel_work_sync() because
INIT_WORK() only initializes the work structure - it does not schedule
it. Work is only scheduled later during ioctl operations.

Fixes: 5fb1c2361e56 ("mtk-jpegenc: add jpeg encode worker interface")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1202,6 +1202,7 @@ static int mtk_jpeg_release(struct file
 	struct mtk_jpeg_dev *jpeg = video_drvdata(file);
 	struct mtk_jpeg_ctx *ctx = mtk_jpeg_file_to_ctx(file);
 
+	cancel_work_sync(&ctx->jpeg_work);
 	mutex_lock(&jpeg->lock);
 	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);



