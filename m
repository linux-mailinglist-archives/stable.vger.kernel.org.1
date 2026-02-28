Return-Path: <stable+bounces-220464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECPcE+w3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A68361C639C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D573302A9C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C303BED0F;
	Sat, 28 Feb 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7xR3V3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF53BED06;
	Sat, 28 Feb 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300351; cv=none; b=RzTxsp00R7gXDpyVp4bMwDofku1eQEDa8c/EruaUXMOgaNCqSQkjRfl/9yBpY+EvdmXMwu6ke2bP1UM0ifuhR5DzSQlaKkZmU68tTYc7oUDUYqu/x1nOyknjFLmwpa5a3UGD9Dlj8SgF+MhPpzrBTKQyjvuooM/TP3UpHo7BYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300351; c=relaxed/simple;
	bh=TCTzgd/ixZeKmx5B74oVFbclG3zNxk6BZ936t2NpB1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZdid4SDyTufRk2arN7tFNyntX9NPxHCeUpR28WGHfTqmvocb6KcTtZHd9lGe2/u6oMi+PlRRZnnTUISd07hDQ5L4pswXfqpynjaPjBa5fD8PX8O/lNTCVPcJF1b2pd7gDJDG6sXB+IuAkh/dwrJDAXC042eZdnQHTS83wBQmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7xR3V3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED8C19425;
	Sat, 28 Feb 2026 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300351;
	bh=TCTzgd/ixZeKmx5B74oVFbclG3zNxk6BZ936t2NpB1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7xR3V3Z1NrhLD+1pN+pyEi7r1tS0nrmFnk2X9cZvZ/yZ8JKQvc+6kUlO7T4FTl8g
	 RtmiM/5VorMUbcgh33CakP+d+tC795QcLTG02kc8eHoO/juV+AWoDbUKj68bVKxYbD
	 TwodyxjL2ognjWFfJt8j3JB9TwFzfpF72mJjAfwobuHbwnc2PyfVcuASmNjTt4r3yQ
	 D0aJXhtdYqIN+rsN+lv5z3s5UGv/ScNFky1lUS5W7wLI5Jzhum2YwwMS6jaS9hwncZ
	 LJ8sGWwsEqKtuerrTvXCY/sQTBnKD50p4r2fFSxpjMdjZLj1j2LFvQ6f85QK1SEu0P
	 V2Cp9rANjX3Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Day <me@samcday.com>,
	David Heidelberg <david@ixit.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 385/844] usb: gadget: f_fs: fix DMA-BUF OUT queues
Date: Sat, 28 Feb 2026 12:24:58 -0500
Message-ID: <20260228173244.1509663-386-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220464-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A68361C639C
X-Rspamd-Action: no action

From: Sam Day <me@samcday.com>

[ Upstream commit 0145e7acd29855dfba4a2f387d455b5d9a520f0e ]

Currently, DMA_FROM_DEVICE is used when attaching DMABUFs to IN
endpoints and DMA_TO_DEVICE for OUT endpoints. This is inverted from
how it should be.

The result is IOMMU read-only mappings placed on OUT queues,
triggering arm-smmu write faults.

Put differently, OUT endpoints flow data from host -> gadget, meaning
the UDC peripheral needs to have write access to the buffer to fill it
with the incoming data.

This commit flips the directions and updates the implicit-sync helpers
so IN endpoints act as readers and OUT endpoints as writers.

Signed-off-by: Sam Day <me@samcday.com>
Tested-by: David Heidelberg <david@ixit.cz>  # OnePlus 6T on sdm845-next-20251119
Link: https://patch.msgid.link/20260108-ffs-dmabuf-ioctl-fix-v1-2-e51633891a81@samcday.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index fa467a40949d2..928f51fddc64e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1509,7 +1509,7 @@ static int ffs_dmabuf_attach(struct file *file, int fd)
 		goto err_dmabuf_detach;
 	}
 
-	dir = epfile->in ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	dir = epfile->in ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
 	err = ffs_dma_resv_lock(dmabuf, nonblock);
 	if (err)
@@ -1639,7 +1639,7 @@ static int ffs_dmabuf_transfer(struct file *file,
 	/* Make sure we don't have writers */
 	timeout = nonblock ? 0 : msecs_to_jiffies(DMABUF_ENQUEUE_TIMEOUT_MS);
 	retl = dma_resv_wait_timeout(dmabuf->resv,
-				     dma_resv_usage_rw(epfile->in),
+				     dma_resv_usage_rw(!epfile->in),
 				     true, timeout);
 	if (retl == 0)
 		retl = -EBUSY;
@@ -1684,7 +1684,7 @@ static int ffs_dmabuf_transfer(struct file *file,
 	dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
 		       &priv->lock, priv->context, seqno);
 
-	resv_dir = epfile->in ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ;
+	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base, resv_dir);
 	dma_resv_unlock(dmabuf->resv);
-- 
2.51.0


