Return-Path: <stable+bounces-254683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCo8HJ1aF2oPBQgAu9opvQ
	(envelope-from <stable+bounces-254683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 22:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCD5EA47A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 22:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D953192E2D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D983C2788;
	Wed, 27 May 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNqSXfM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85523B38AF
	for <stable@vger.kernel.org>; Wed, 27 May 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915054; cv=none; b=rFJroxqSYSn57SK5hr0Xfx/McjFTCFYqnFQmhUhGtlkat2i4dx2330m9S3t558yWBKkP1xgXe9SipowTmHSE9G9UYK8pVT0jj8Xl4KkMH+Emn0unXK39jZG25Gvf5CFG1FsjI+drzcVJGZT1mRN4EEw1SjzlgG6iO9AT8Ts9bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915054; c=relaxed/simple;
	bh=eRR5kbIsSk8uR68Yt/RxW5wJjv4k6qQ3jUkESRdonS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KUlUqHnWU+DZBNn74ToS/ZdP9Nnv/QUejKpElVV8lqhptSwT7UEZwYaU2wFVPeKy7uRu5rfHOrdpn65Y306/lTWcS3LOEdZQCB+HA+2ggqGVxdFwqVSNcHGFyUJ1g5jkvlYI8vtJDNHzscIlcT20LwudjyKIM+IIWHf3RG5Ggng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNqSXfM3; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8aca4660827so237690056d6.3
        for <stable@vger.kernel.org>; Wed, 27 May 2026 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779915051; x=1780519851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
        b=iNqSXfM37Tmxky1BVl8faF9mFcxHtxZXQT3kYGd1cCpSVzT2qkeqIMHmr5py3Izxhq
         WL0s0xUJcTywlm7QR46hLKSRfZ4NTKxv7WA1HTMYa0Me67JPJ9v+TI7vJJ/LjOm3Z1CF
         fK9V6AAMq1eZ1/Q3F48MajYW7RiEg8ZcFDRmbyO4klZqmV34pVngvDkX+QqL2uWMfA9J
         DMY0ysA406GJtmp2Q7GmMrAp4cLckKXltx/hA1keAtIsqavJ4r3IbW3CErnh5fVVfwZF
         wDyiQICo+zGFu3rDumZpk8axgHOlK8wgPw5i28I3ujfQZb3kt+adq0WNkOmVW3UlGbpa
         Kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779915051; x=1780519851;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
        b=Mk4oaspzSeQ+kQDzEa2PI+v++PUgenCuVReTtnMmX4I+hwt6x4eUcjBvrJG9muPBI6
         BSoGUkOordSimSYMLFd+A030LhsLkHwlv2nbFJRv8bPJXqdl8fWtAB9mVrrmcJZTDZ4c
         OXxi5LTjU/xmR5zf9jAuvrGf5S/nr3e/8mZqOPwwqGqVehtT2Z4FD0ZSpaUrjie+Qi5R
         7QSgTw70C/eNkyoB6YYX4ghlz9OAj1rjQZwrQ8QBayPuDcu8fpoNmdfaqjWAsueCPJmw
         5XHUGNMOZnACYT6K5M3Qcx9XJ7OUxdxhVAzxWlKhMPq7O3VydrpUDyMT9A+Q8OK2wUng
         Blgg==
X-Forwarded-Encrypted: i=1; AFNElJ9feMQrT7mMQyF1rzsa9xuRuQvzXKL7S28gRYkAQlg0udgxXfburPheGAQQD/XEVHQYn/tG9l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZeGEHAuwvYOXap0KrA7Yv7sIxxwS0Vq8CkJWQHFwOE4+WFkRe
	VmwlWFP3HnIHAhNynUOCfxUwhHW8bWiFYxAyeMRcq5QK5Tz18UCtkgHBKRCflZmFFfz/RWs8mnx
	xzcWvcKlcAj9O
X-Received: from qviu6.prod.google.com ([2002:a0c:c486:0:b0:8cc:2486:6603])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:54ca:b0:8ac:b237:9fb5 with SMTP id 6a1803df08f44-8cc7b5fe0d8mr387104406d6.49.1779915050519;
 Wed, 27 May 2026 13:50:50 -0700 (PDT)
Date: Wed, 27 May 2026 20:50:47 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527205048.2168808-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	leonro@nvidia.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254683-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuehaohu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDCCD5EA47A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

Previously, `mapped_len` was declared as 32-bit `unsigned int`.
When accumulating `size_t` lengths, this leads to a silent wrap-around.
This truncation causes truncated lengths to be passed to functions
like `fill_sg_entry()`.

Fix this by changing `mapped_len` to `size_t` (64-bit). While
at it, fix similar potential overflow issues in `calc_sg_nents`
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

to mapped_len, and leading to a silent overflow

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v2:
 Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 Added Reverse Xmas tree formatting (Pranjal).
 Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 Folded in type consistency fix for fill_sg_entry() (Pranjal).
 Droped unnecessary `nents = 0` initialization (Claude Bot).

 drivers/dma-buf/dma-buf-mapping.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..5bc769fc42ea 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 				  struct phys_vec *phys_vec, size_t nr_ranges,
 				  size_t size)
 {
-	unsigned int nents = 0;
+	size_t nents = 0;
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		nents = DIV_ROUND_UP(size, UINT_MAX);
 	}
 
+	if (nents > UINT_MAX)
+		return 0;
+
 	return nents;
 }
 
@@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
+	size_t mapped_len = 0;
+	unsigned int nents;
 	dma_addr_t addr;
 	size_t i;
 	int ret;
-- 
2.54.0.794.g4f17f83d09-goog


