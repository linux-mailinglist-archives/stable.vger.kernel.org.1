Return-Path: <stable+bounces-262312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +KiIHgM1KGqcAAMAu9opvQ
	(envelope-from <stable+bounces-262312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 17:45:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02574661ED7
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 17:45:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=crapouillou.net header.s=mail header.b=Gpdm53dH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262312-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262312-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=crapouillou.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD3A2323620B
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB18392838;
	Tue,  9 Jun 2026 15:29:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29047F2D4;
	Tue,  9 Jun 2026 15:29:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018966; cv=none; b=Rp+HSKhPWZD8HLZoxEUXLqSXtK0B70jSJhopgfcXHZExzjsElpFJPUzKxce6q//t0y7TXxiQsbY/OwhRhIZsOznDNqmK+eSPZ9Lv2awhPiKAaxFJFK9hJW/OR2tRYPFZMsj4SvgCgp5zMqpmyrIolSuxwNhJX6XUoKvAavtdBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018966; c=relaxed/simple;
	bh=Hf3NUFTPdlpBckTP5tVrDmcFEZZmCKf1Y+qeXrTx6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdK/W2NgbUa3ShAkTSbUM/wMx2LVIig4nWdS3O57nY4SFzruPDvLXrv6wlH3Adx/fG2PSWEpYZNPiTx59KukuunFrbdVggScg3OnFl6DYkhmSq1MTWvROvhgKXy9jmjrTFtcvMfkqwx6Annhc93k7a+77xudIP7g+VHScHMZDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=Gpdm53dH; arc=none smtp.client-ip=185.119.170.32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1781018962;
	bh=Hf3NUFTPdlpBckTP5tVrDmcFEZZmCKf1Y+qeXrTx6lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Gpdm53dHk42Xo4ZX2nd8sW92GOs5ztQb9unPiXuQ11pbqgoKraldRUxfeKq34WFEr
	 zKtW9yR7StSn8L0Bu46FgiDi8LcRFUI/M1Me/Y2XylhHZ2SsX/qZNLLECEOfjS/CvC
	 R4oCXxPP1HAtgkL5yYfbU/MdDAQ1T4m+WvJWc/Ds=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Paul Cercueil <paul@crapouillou.net>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: Fix DMA fence leak
Date: Tue,  9 Jun 2026 17:29:05 +0200
Message-ID: <20260609152905.729328-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crapouillou.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[crapouillou.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262312-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nuno.sa@analog.com,m:paul@crapouillou.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@crapouillou.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@crapouillou.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[crapouillou.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crapouillou.net:dkim,crapouillou.net:email,crapouillou.net:mid,crapouillou.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02574661ED7

In ffs_dmabuf_transfer(), a ffs_dma_fence object is kmalloc'd, with the
underlying dma_fence later initialized by dma_fence_init(), which sets
its kref counter to 1. Then, dma_resv_add_fence() gets a second
reference, and a pointer to the ffs_dma_fence is passed as the
usb_request's "context" field.

The dma-resv mechanism will manage the second reference, but the first
reference is never properly released; the ffs_dmabuf_cleanup() function
decreases the reference count, but only to balance with the reference
grab in ffs_dmabuf_signal_done().

The code will then slowly leak memory as more ffs_dma_fence objects are
created without being ever freed.

Address this issue by transferring ownership of the fence to the DMA
reservation object, by calling dma_fence_put() right after
dma_resv_add_fence(). The ffs_dma_fence then gets properly discarded
after being signalled.

Fixes: 7b07a2a7ca02 ("usb: gadget: functionfs: Add DMABUF import interface")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/gadget/function/f_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 75912ce6ab55..7cc446502980 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1704,6 +1704,7 @@ static int ffs_dmabuf_transfer(struct file *file,
 	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base, resv_dir);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	/* Now that the dma_fence is in place, queue the transfer. */
-- 
2.53.0


