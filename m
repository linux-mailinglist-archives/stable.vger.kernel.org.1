Return-Path: <stable+bounces-239910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HfmDuFY5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:48:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5404300D5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4A5933040C2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8822853F3;
	Mon, 20 Apr 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UV+qPim/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D233858B;
	Mon, 20 Apr 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701526; cv=none; b=BifflYQ/5I8bEgI+M6qtbhuwuPWS1JYltTXV7owuIPp0zOg+QE7/g8NUNU8d5ltwpwaKXHdUs/bYRYYfe2+4qEMnfjeLuYwtIqo9xhRo2V892aBr1Gwt4u0HniAr6EaaI57Benh4SYVoag4E4yYK7KHPYt7HmvNNhCpgatPQGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701526; c=relaxed/simple;
	bh=qAf76U7Pu0NWmcL2anGhWkystgcCWDanXLU8zQsKdtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akYZdUmeO4hpgU8JxhPQ+x9EBBt8gree3yMzFExjMJlJcm3gVdlMvhi0EdMoopZs9R2gfhm/aeBWgElJG1adToX/5xY7MBxCzEYIdP4k1sJwuapGt+Q/vxVAeY0MqC3U7EP/6fX2AUbOAxEuIfFWHBKzy8QFww+2QqNwF7VFn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UV+qPim/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE22C19425;
	Mon, 20 Apr 2026 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701526;
	bh=qAf76U7Pu0NWmcL2anGhWkystgcCWDanXLU8zQsKdtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UV+qPim/qpwDsr+/+wKrI6icwrpwgZr+YamsMFF0yx9vvBxYw6eoeO/7BxnqFf2CA
	 E+10qlL2H2uiK8hjNZstg83O/GTm/rh3avJa6h2qbH/UpBmH8SZHnf2QZrhpFWkx+A
	 C5ZeGEpwMsxbFKteuBVAnMpWN7MMwa3hBuhqiwlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Wu <fanwu01@zju.edu.cn>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 147/162] media: mediatek: vcodec: fix use-after-free in encoder release path
Date: Mon, 20 Apr 2026 17:42:59 +0200
Message-ID: <20260420153932.374276174@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[zju.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_SPAM(0.00)[0.948];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,collabora.com:email,zju.edu.cn:email]
X-Rspamd-Queue-Id: AE5404300D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fan Wu <fanwu01@zju.edu.cn>

commit 76e35091ffc722ba39b303e48bc5d08abb59dd56 upstream.

The fops_vcodec_release() function frees the context structure (ctx)
without first cancelling any pending or running work in ctx->encode_work.
This creates a race window where the workqueue handler (mtk_venc_worker)
may still be accessing the context memory after it has been freed.

Race condition:

    CPU 0 (release path)               CPU 1 (workqueue)
    ---------------------               ------------------
    fops_vcodec_release()
      v4l2_m2m_ctx_release()
        v4l2_m2m_cancel_job()
        // waits for m2m job "done"
                                        mtk_venc_worker()
                                          v4l2_m2m_job_finish()
                                          // m2m job "done"
                                          // BUT worker still running!
                                          // post-job_finish access:
                                        other ctx dereferences
                                          // UAF if ctx already freed
        // returns (job "done")
      kfree(ctx)  // ctx freed

Root cause: The v4l2_m2m_ctx_release() only waits for the m2m job
lifecycle (via TRANS_RUNNING flag), not the workqueue lifecycle.
After v4l2_m2m_job_finish() is called, the m2m framework considers
the job complete and v4l2_m2m_ctx_release() returns, but the worker
function continues executing and may still access ctx.

The work is queued during encode operations via:
  queue_work(ctx->dev->encode_workqueue, &ctx->encode_work)
The worker function accesses ctx->m2m_ctx, ctx->dev, and other ctx
fields even after calling v4l2_m2m_job_finish().

This vulnerability was confirmed with KASAN by running an instrumented
test module that widens the post-job_finish race window. KASAN detected:

  BUG: KASAN: slab-use-after-free in mtk_venc_worker+0x159/0x180
  Read of size 4 at addr ffff88800326e000 by task kworker/u8:0/12

  Workqueue: mtk_vcodec_enc_wq mtk_venc_worker

  Allocated by task 47:
    __kasan_kmalloc+0x7f/0x90
    fops_vcodec_open+0x85/0x1a0

  Freed by task 47:
    __kasan_slab_free+0x43/0x70
    kfree+0xee/0x3a0
    fops_vcodec_release+0xb7/0x190

Fix this by calling cancel_work_sync(&ctx->encode_work) before kfree(ctx).
This ensures the workqueue handler is both cancelled (if pending) and
synchronized (waits for any running handler to complete) before the
context is freed.

Placement rationale: The fix is placed after v4l2_ctrl_handler_free()
and before list_del_init(&ctx->list). At this point, all m2m operations
are done (v4l2_m2m_ctx_release() has returned), and we need to ensure
the workqueue is synchronized before removing ctx from the list and
freeing it.

Note: The open error path does NOT need cancel_work_sync() because
INIT_WORK() only initializes the work structure - it does not schedule
it. Work is only scheduled later during device_run() operations.

Fixes: 0934d3759615 ("media: mediatek: vcodec: separate decoder and encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -216,6 +216,15 @@ static int fops_vcodec_release(struct fi
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	/*
+	 * Cancel any pending encode work before freeing the context.
+	 * Although v4l2_m2m_ctx_release() waits for m2m job completion,
+	 * the workqueue handler (mtk_venc_worker) may still be accessing
+	 * the context after v4l2_m2m_job_finish() returns. Without this,
+	 * a use-after-free occurs when the worker accesses ctx after kfree.
+	 */
+	cancel_work_sync(&ctx->encode_work);
+
 	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
 	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);



