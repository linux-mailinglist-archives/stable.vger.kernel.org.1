Return-Path: <stable+bounces-247690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKjAKqIJB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2F54EDF9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C616B30C51DE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD347D94F;
	Fri, 15 May 2026 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hx1YB6Ii"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533246AF0B
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845574; cv=none; b=CkqtBPvo75LnDAvbUZuOjh8d/4V8ZcoU4v4jbKELTHoamrakuBbQVUV2+u/21/4o+Hg5By8M0j9pkRZRokMLRjz/ugYdr4KWIh3l6Imhis+jZ+rYLkaz2IBIjp9F+kcyirS80I6c3YpXJEgO1NMX907U2bIV/rNSnh5QMquSpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845574; c=relaxed/simple;
	bh=u3OXNV1ZsGJ7YV+75tbKsC2Qixqc1UjjuVP+PF3T+n8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=krG7cFZsKZd7wnrwSNAI1qMUFsxfH8XNTIHpF/ijSH6dq1G8Q0CQOtLm0ebguVRiShaE82LAyFe6k64ozDCdlrqbdTaQ3AQGH7IWBOw64oVs/x/KWsOUDMnU19a3bgPPB+FZYlmUHEwbgowjHElwwCHw/F2hwmtWo62QT3OJPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hx1YB6Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3FEC2BCB0;
	Fri, 15 May 2026 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845574;
	bh=u3OXNV1ZsGJ7YV+75tbKsC2Qixqc1UjjuVP+PF3T+n8=;
	h=Subject:To:From:Date:From;
	b=hx1YB6IiiVRhIp3W5wulLx/7V8N11LpcYJjLHzYKysJnEuU1Qcb7CM7sYlbL/aK60
	 Pz4OHIvWLEF2zNxAGfQPL91zWNujE8Jvraqfb55UOtb1ViZIfo9CATShyxtSuZ1THc
	 WHmcn/KkP40uP5DH4Zh9OQ2UCtTv7sxh/EHLrsq4=
Subject: patch "iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()" added to char-misc-linus
To: benoit.monin@bootlin.com,Stable@vger.kernel.org,jamesnuss@nanometrics.ca,jic23@kernel.org,paul@crapouillou.net
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:56 +0200
Message-ID: <2026051556-overrate-renegade-4eae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 49F2F54EDF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a093999355084bdbfe6e97f1dd232e58a1525f0b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>
Date: Wed, 1 Apr 2026 17:24:58 +0200
Subject: iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iio_buffer_enqueue_dmabuf() allocates a struct iio_dma_fence (104 bytes,
kmalloc-128) via kmalloc_obj()+dma_fence_init(), which sets the initial
kref to 1.  It then calls dma_resv_add_fence() which takes a second
reference (kref=2), and stores a raw pointer in block->fence.

On the success path the function returns without calling dma_fence_put()
to release the initial reference, so every buffer enqueue permanently
leaks one kmalloc-128 allocation.

The iio_buffer_cleanup() work item only releases the temporary reference
taken during completion signalling by iio_buffer_signal_dmabuf_done();
the initial reference from dma_fence_init() is never released.

With four iio_rwdev instances at 240kHz and 512 samples per buffer,
this produces ~1875 kmalloc-128 allocations per second matching the
observed slab growth exactly. A test with ftrace confirmed that the
dma_fence_destroy event was never triggered.

Fix by calling dma_fence_put() after dma_resv_add_fence(), transferring
ownership of the fence to the DMA reservation object. The DMA fence then
gets properly discarded after being signalled.

Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
Originally-by: James Nuss <jamesnuss@nanometrics.ca>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 46f36a6ed271..5c3df993bea2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1909,6 +1909,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base,
 			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	cookie = dma_fence_begin_signalling();
-- 
2.54.0



