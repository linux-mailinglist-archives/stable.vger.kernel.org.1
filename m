Return-Path: <stable+bounces-264424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LoxHA/VzMWrijgUAu9opvQ
	(envelope-from <stable+bounces-264424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CC691A80
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cwqS79eZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264424-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264424-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFB3430378AC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0144DB64;
	Tue, 16 Jun 2026 16:03:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC10451060;
	Tue, 16 Jun 2026 16:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625810; cv=none; b=LhQRkjjWLZT4wWVD6zUZjFQV0+X2gqhvB487AgedN4k1ez/RzoZBRQWecKAG141HDoTilea+8PWfel9yznKBw3O5u2CsFnja0gFfTpAIumfxSYHNyhjoDqe9Rh8t/ktSSTleKi1VNEvZ+4tCB3GUZ1ltDjn/5ADI8wWheRtKLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625810; c=relaxed/simple;
	bh=UcOKUbsIw5ars1rKJEx8Rz6W6fRf1iBZ7Fwm4gzTzJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNJmZ2g/kP5DQdkYAioKafSuMD4M/hQ3ofEQu0jaX8sUDCExhWZE63tGFNFjRHMwgvghY+Y3Vcl7LuZK4TQxHR4Xaq1OKxGx7dwSZoAjBt6i71v9USazd7Z8+HYcbV5yeT00fsaV9VBwhMHNgdGr2in+98LnazG8g0shgc1dmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwqS79eZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8F11F00A3A;
	Tue, 16 Jun 2026 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625809;
	bh=DT5jwDzoYBwGUGbrEe4ws0TOsz19ofyYlgw8rab61G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwqS79eZjnC1eA3tuYHhlSTnYrcLHmLLqOrxSSYpFqcpIaQlfK7lz55NJLiGiVGT5
	 65tvvDerX0Z54ZF4cjJoWMQ2FvLEQ7axe+vp1RS2Wm+uod+EffkSOlVWivJmSH5K9V
	 UkGLsjyJaNCJ71r17G3x4Jy+SaC7yF0KE6O2hHwc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 6.18 181/325] drm/virtio: fix dma_fence refcount leak on error in virtio_gpu_dma_fence_wait()
Date: Tue, 16 Jun 2026 20:29:37 +0530
Message-ID: <20260616145106.899713428@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:dmitry.osipenko@collabora.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 948CC691A80

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 3f26bb732cc136ab20176697c92f32c9c84cb125 upstream.

dma_fence_unwrap_for_each() internally calls dma_fence_unwrap_first()
which does cursor->chain = dma_fence_get(head), taking an extra
reference. On normal loop completion, dma_fence_unwrap_next()
releases this via dma_fence_chain_walk() -> dma_fence_put().

When virtio_gpu_do_fence_wait() fails and the function returns early
from inside the loop, the cursor->chain reference is never released.
This is the only caller in the entire kernel that does an early return
inside dma_fence_unwrap_for_each.

Add dma_fence_put(itr.chain) before the early return.

Cc: stable@vger.kernel.org
Fixes: eba57fb5498f ("drm/virtio: Wait for each dma-fence of in-fence array individually")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20260607090303.92423-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -65,8 +65,10 @@ static int virtio_gpu_dma_fence_wait(str
 
 	dma_fence_unwrap_for_each(f, &itr, fence) {
 		err = virtio_gpu_do_fence_wait(submit, f);
-		if (err)
+		if (err) {
+			dma_fence_put(itr.chain);
 			return err;
+		}
 	}
 
 	return 0;



