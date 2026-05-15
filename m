Return-Path: <stable+bounces-247698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFYhIWAPB2qerAIAu9opvQ
	(envelope-from <stable+bounces-247698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:19:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80954F570
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C9C31A0C8D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99F47ECFF;
	Fri, 15 May 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBIAfLLG"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CB47DF88
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845611; cv=none; b=mJKe1xMt6z7zVIERGj1gZc6+jTCyXpTdz0Cr61fZSRR28hNabPgWne/hv42P3bO7Nm7lZmJOlkCm4L7Kt6KQWg0jyhkuhO91AbpMsqtgaO+d8LtRBH4BLdsODoWl2gQFaf9uL+nCa31mu15BsmzeNgU/J7116P+0kGByMViitxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845611; c=relaxed/simple;
	bh=PacLVI1s08i98McUoXe8llPO1lEHJ+GFJ4ypg1ZJyWU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Lu5K3CqJ7rOmmuqGm54JVSvEfhUtWjlnX0f0624iGfW57pUDXvftnlRFXFeYtqWyS4wkfYnlxwCioxhd3lwOG9qvSvzIy7H1MYb0XJVO9HYBC95MvYMJoqb+Z9fYnm/qxxfg0SUAmwrfyfBiJDiKx5fCRnvH4qQBTpn9H7Wb+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBIAfLLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F804C2BCFB;
	Fri, 15 May 2026 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845610;
	bh=PacLVI1s08i98McUoXe8llPO1lEHJ+GFJ4ypg1ZJyWU=;
	h=Subject:To:From:Date:From;
	b=iBIAfLLG6HDI8qtB3ETnF6gMN5LRHxluN04s+UDirASi37NU2VhZG+gBR/F6Xrkc0
	 P4I5NdHjv/q7VmLtrne7ye4q73l1xKgOO+3EosJ5ygaM6yoopESkphwtegh4rVvX9w
	 IKPDwPIxLhjlOKtDmfok1l4MhK4yKAONGSuMh61o=
Subject: patch "iio: buffer: hw-consumer: fix use-after-free in error path" added to char-misc-linus
To: ustc.gu@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,m32285159@gmail.com,nuno.sa@analog.com,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:46:00 +0200
Message-ID: <2026051500-bulldog-mandate-7e44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF80954F570
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247698-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,analog.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sashiko.dev:url]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: buffer: hw-consumer: fix use-after-free in error path

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 6f5ed4f2c7c83f33344e0ba179f72a12e5dad4a4 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 30 Apr 2026 21:29:06 +0800
Subject: iio: buffer: hw-consumer: fix use-after-free in error path
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
was using list_for_each_entry() to iterate through buffers while calling
iio_buffer_put() which can free the current buffer if refcount drops to 0.
The list_for_each_entry() loop macro then evaluates buf->head.next to
continue iteration, accessing the freed buffer.

Fix this by using list_for_each_entry_safe().

Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647%40gmail.com
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 24d7df603760..700528c9a0a4 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -85,7 +85,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
  */
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 {
-	struct hw_consumer_buffer *buf;
+	struct hw_consumer_buffer *buf, *tmp;
 	struct iio_hw_consumer *hwc;
 	struct iio_channel *chan;
 	int ret;
@@ -116,7 +116,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 	return hwc;
 
 err_put_buffers:
-	list_for_each_entry(buf, &hwc->buffers, head)
+	list_for_each_entry_safe(buf, tmp, &hwc->buffers, head)
 		iio_buffer_put(&buf->buffer);
 	iio_channel_release_all(hwc->channels);
 err_free_hwc:
-- 
2.54.0



