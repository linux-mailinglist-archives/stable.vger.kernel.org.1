Return-Path: <stable+bounces-231057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHQOAtCymky7AUAu9opvQ
	(envelope-from <stable+bounces-231057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:27:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE73582CE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D87E430480CE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E733B38B4;
	Mon, 30 Mar 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSbHaYzF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195838946E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774862367; cv=none; b=syM3VxI/ZESNVfgSyBy/74WANjPd7QjbAg25s3nqMWNqVvySunAVeeGUr4N7nJEClZACsUB6N97EfgQ2WMLcwNdPmd+3x4s8G1MomEMOCO30UZGrL+MC+kW/c9v/HgkyPR0XIhDeEe+ooktWkdz/u+Ffee00kz6S7u51ISj+N2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774862367; c=relaxed/simple;
	bh=v2wJm5OxMhFirUpbsSseKePV0XDwNFTZ0HeYn749ALw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4ySDVqr23NJx9cgJTqoNRCf/y040Lfr4x4HOIBq7kMX3Fgv32Kpyd7fBTSjvHo4yx49Vcv2szrmIS7HO6eLn+5J4g8Ajn6Xof6Ql+f4z2kXELi/0h15uR2FOK+mM0M45YgzRmgccd8QX7BexryoTO/zQZDuz3QRdSyWGc0CKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSbHaYzF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so9157505e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862364; x=1775467164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jy4tutbo6n4MCIxyRYqtKSRHX+kUl57MnIxgCmBAFA=;
        b=dSbHaYzF+LR3DQUxQV7NjAh+UO7BEBjxiNKYgum10Q06KjKvnBebNap1yVBTWbGCq5
         c1CGp/6sGmVmtJgP3FiQlmGp1CtBGzaNUMq/a2fJn8ZeA3TDkbejeZJTQDc1TBpVe+3o
         zLFZ6t4XvHKfJF+63Pb+dyZu7xtM9NGHVsNEg2Al9gVWQvUXhSC9Eo5+AiqEbKTsRJgN
         dgKoGXyLD2qIk8X7d8hKUbTpn1fSXI5MWjmuFWwmxJpKc6XT8/Dvi2cf9KWvnowbVOfI
         QRe02ix2rQD6iWn7J/QSCYhdpvhN1bxNz0eV1a5Pdkh/dIYigeKDaz1S/Z7xhXYfaNDd
         VmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862364; x=1775467164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jy4tutbo6n4MCIxyRYqtKSRHX+kUl57MnIxgCmBAFA=;
        b=D3d4CAkVzfZa9Lhba5X8XTGoWuimqW/ZvR4DYaDnaIR9KIo1scGTZPRnIRmDRVSp+f
         f5+jqkBinF4pilZlzC0YMDZHHIAwTTDQKCcNHinflJ96YqBRY8C7Pfbsn0iVWgzADHUP
         ERcgVk8E5lG9ybKQm0XfJKRuLfyOxG4V/eV+ix9B0hMRZHGe9XR6fJBf/m1cDpPjZ3r+
         tmO8KcSdf1Qm/Fh5d2YBVNCD+CNAZlNEIDhapbDskjlQfNLQMpjn1p1r/d0hhHYLCHff
         KEly+PNnM4WXvIEt+4GKE0Go4AD0tbitR42ddhkzRy5gKeiQv84SVmoUY3dCMk3y20au
         xYkg==
X-Forwarded-Encrypted: i=1; AJvYcCVizfSDly35XJUK4ajOwyPAAkS144VsJNuuQJdLWNKEJIyjL397CFPN0jdMg1vbwtIr42riw4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6neJoXDmjWz7ISd5PBXLb2G0XP6ikxRyyZB/j8KMAKcIBzKp
	KxslPBLgHXf7P0/QDPjQAvhmBUJpnqMAUwRLs16nz4Sr5kLTcydbGR5w
X-Gm-Gg: ATEYQzxfIwrLedqg4mymKli6IhbLUXWXVF05xiZ5Afw6fytMPxLeG6JPSrhF8kTlDqO
	w6dVu+OGtzeyjh3gsw6h5qD3X5chMo6BXk96mBJ6NtEWyu6NktWfG10IAtUBXTG5Gnw2VyYzsYj
	dZgP6LeATf4km9ZXlx8Is1rk+aHQifC81j6l76bDF3hgea9UII9UiwU1nx3fWSK4Xmi0CGQyTqV
	aRUCq5QOclf2NGs3AQqC8yg1ZDk207cR86S9LN3fbUT01DAc7CxIE07oZW5t/6j3oaI4KpjHUn0
	U018ButKmSZX8vXN1CbY7SXKszOXMDhB8+su3UJsfOy/7DunIP1qsJNPhmTkM+YqcBxIRm9jz6H
	Ac+tnwPzv5NzulLxVTtpXgfu5HrCcPe22p7RYJb0C0jfk2iRbmPDZLgn2nl0EgqUG0zrapcHckV
	MNWw3VmKnjxCaz5p/x7QpF+sFc7EXmXwXMlLO9d9t378CwTqgNATchx0D0QJRQ388+vKXn76nlm
	tGs7WSyJfKht+jUOV26
X-Received: by 2002:a05:600c:5249:b0:485:f1d6:2b1d with SMTP id 5b1f17b1804b1-48727c8680fmr118714665e9.0.1774862363788;
        Mon, 30 Mar 2026 02:19:23 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-131.paris.inria.fr. [128.93.82.131])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-487270af027sm123355925e9.3.2026.03.30.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:19:23 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Richard van Schagen <vschagen@icloud.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: eip93 - Fix dma_unmap_single() direction in eip93_hash_handle_result()
Date: Mon, 30 Mar 2026 11:18:14 +0200
Message-ID: <20260330091817.25797-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231057-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,gondor.apana.org.au,davemloft.net,icloud.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DDE73582CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The buffer rctx->sa_record_base was mapped in eip93_hash_update();
rctx->sa_state_ctr_base and rctx->sa_state_base in eip93_send_req()
with direction DMA_TO_DEVICE but unmap with DMA_FROM_DEVICE in
eip93_hash_handle_result() and eip93_handle_result().

Change the unmap to match the mapping.

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/crypto/inside-secure/eip93/eip93-common.c | 4 ++--
 drivers/crypto/inside-secure/eip93/eip93-hash.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-common.c b/drivers/crypto/inside-secure/eip93/eip93-common.c
index f4ad6beff15e..75659a45ea5a 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-common.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-common.c
@@ -687,12 +687,12 @@ void eip93_handle_result(struct eip93_device *eip93, struct eip93_cipher_reqctx
 	if (rctx->sa_state_ctr)
 		dma_unmap_single(eip93->dev, rctx->sa_state_ctr_base,
 				 sizeof(*rctx->sa_state_ctr),
-				 DMA_FROM_DEVICE);
+				 DMA_TO_DEVICE);
 
 	if (rctx->sa_state)
 		dma_unmap_single(eip93->dev, rctx->sa_state_base,
 				 sizeof(*rctx->sa_state),
-				 DMA_FROM_DEVICE);
+				 DMA_TO_DEVICE);
 
 	if (!IS_ECB(rctx->flags))
 		memcpy(reqiv, rctx->sa_state->state_iv, rctx->ivsize);
diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.c b/drivers/crypto/inside-secure/eip93/eip93-hash.c
index 2705855475b2..19a41a0db667 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-hash.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-hash.c
@@ -67,7 +67,7 @@ void eip93_hash_handle_result(struct crypto_async_request *async, int err)
 	int i;
 
 	dma_unmap_single(eip93->dev, rctx->sa_state_base,
-			 sizeof(*sa_state), DMA_FROM_DEVICE);
+			 sizeof(*sa_state), DMA_TO_DEVICE);
 
 	/*
 	 * With partial_hash assume SHA256_DIGEST_SIZE buffer is passed.
-- 
2.43.0


