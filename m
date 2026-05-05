Return-Path: <stable+bounces-244282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAWYJgNv+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1A4D455A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E84F301D812
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9694968F8;
	Tue,  5 May 2026 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WLEKPow7"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63B4921B0
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020087; cv=none; b=I4B7D1XqkUVYCr+q8zK77NYX5d2waXA5rNLLrGV6gSSyaVop3Ojbnaq0ZZ+3uunWoUjKH9cfJd7Tc8ocLPk5addrmOaDcw8QwfthGINYMIARdP4bXg2YLup6whWKZssdFHkyQPgygIUrx8iP5fnbHX9HuXAnALItLdsZ9Y94t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020087; c=relaxed/simple;
	bh=k8qPDungiWSHYdT+GLvlCuOo7ukY+ifWI3TmB3h7Hvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kojPusGKNQUG5JMt0rq3lcGZMEqLqW5erD7+ElVVNr+9Ey4ujf8o2rHb1Uy/apT5OXPN1G0gcozUQH+9RwKu32s5M0htYSfanbprmoETuGB8YIfko5BtKb31+hoUf7PJe1K5wz8dsKJj32Z1E/IQJxx8Vsw96vR/wNGbZX+6r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WLEKPow7; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-62ddb07fbd2so1199688137.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020085; x=1778624885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvTF9O3uwFA3OWdHwZuGL0USnnrisuTr7nTufwNcCJA=;
        b=SQLXb8adTAFaEBJ/QIHLkQE+jqhce2OkRn3naZN8OpxWG8n0gzOdTfsim3XqvaLTDK
         agdFi/VuTEqVhX0/3ZcYp8sryWQrSIxJhV9Yg1lSIkl0HH19/3V/Uy/afIgbCKhWD0YC
         f5bE6+UMPvOIYaHFIoRSawE5U5mYagUbZIdk01vSEuX1YoXLt9kiggXvpZYZfieyqGZB
         Jt4ScWN/+8Nc4OYtSFKtUmaPRyW2s0aSgDi+q2Q29wC1yTslzug3d8gfI+62AqQts7pd
         8kFwQYZy0DT/yoqey7G1DTocSiGv9GMpDpXXt2SC/iVZO9epuEDHza3Ofq8upuFCA1Z8
         eh7w==
X-Forwarded-Encrypted: i=1; AFNElJ8cGt9NF5wrHmSill784rx32FZiJ2DLyAHdNPcsjLMXmkjM0fvUB1fsbypJ6JrRMAAKyhNZPkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWVQCqUv4iXlGhdox6vV1SjnvcNxKlvI5CFh2XLcYGCZYqBp/
	4mykmH8AU6i2ydo4e0bpY1NX2/AJnhsW6f4azoIAbCTjk0pfXk1SEWNBNh6e8TPsXEAt9UQd5sg
	OsAGDOc10iPAYOIIPIDbHAqjNpkrrM8vniiq8Uh6qz1To52pISOWGh4yNSG4rpWYvaI2zUvZpdI
	Fi0ssoAxAafQlNnfNGhoCRdhJRNRhwthKnoGFx96+Odef6BeCKCBqbC05mNppisQDzjlQyGcHAS
	wNVd9eo
X-Gm-Gg: AeBDietnNx3spn9ybqJ6y9VAwdl5rx7uqqoP0IAPODjNrcpt9MZJ1dXzGv57UsD9Ick
	eakaZkuSVUvxpQdzs4sdrzlWPuZagnNj3jGU1Z37XbFPz6mqiTuoetkuiJk6ERKdNima1yTzzql
	+I8XziVdSB6puQOfs+d7khko0ZTcfL7JggPkxIT16g9BRgq7PAAUXXsTIlDaXdXxDQchkSlR91e
	tLpyLQmP5u3oMJub/ae1vNS91qMftaUy8ekn16oikC8cVO2jz2yh1PIIA0+nS3OYEH1hcd8fju+
	63cUz+sNYx8gk3kzgAIZ+xtlPPddm4T5juEKEpAsFkVjjF9d4/JJBDGXAw/mB/bSxG2A+85VxUk
	EwxxaQ8sr/vULqZ20drMjxUzHnCr9dJekcHJN7QO5Vc+ndd5+rxyVIgsAcX01ekDDXK1Ysh2n7h
	tA7jxlonaP3k2qRxwPvuGsQOfy/nbOV8ShElgaliiWq/QspZzEGvUmdLbE5JRDvrpK
X-Received: by 2002:a05:6102:38d3:b0:62f:4387:fcb4 with SMTP id ada2fe7eead31-630f8c4b6d7mr332567137.0.1778020084939;
        Tue, 05 May 2026 15:28:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62bfc187dcesm1144534137.10.2026.05.05.15.28.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:28:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so145974291cf.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020083; x=1778624883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvTF9O3uwFA3OWdHwZuGL0USnnrisuTr7nTufwNcCJA=;
        b=WLEKPow7D5zm3Yvai4ye1BwKFli9ph+yR3YKkCZN7tK2gEW4uMs+sqwpnssWkc0HQ5
         UVWAoly9e2teUZv1Jxp930AvzL81cKu4j5s1P/xPRZcUzr+kACoioriotaiMCsDUia6W
         uY/OvWyUbYC+C6LIF3bQMWgbl9+rzdkyM3sGg=
X-Forwarded-Encrypted: i=1; AFNElJ/5kDFbr0fi32ARsu551NyEGGBLzJJAidXfwom+2wpzs92vT1w1CS5wDc/NRaCC9KyJSONaSr8=@vger.kernel.org
X-Received: by 2002:a05:622a:5e0f:b0:509:3cd:b22f with SMTP id d75a77b69052e-51461e2c37fmr14585561cf.23.1778020082841;
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5e0f:b0:509:3cd:b22f with SMTP id d75a77b69052e-51461e2c37fmr14585111cf.23.1778020082236;
        Tue, 05 May 2026 15:28:02 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:28:00 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 12/12] drm/vmwgfx: validate external BO copy bounds for both stride paths
Date: Tue,  5 May 2026 18:22:33 -0400
Message-ID: <20260505222728.519626-13-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: C1C1A4D455A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244282-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_external_bo_copy() trusts caller-supplied offsets, strides, and
heights and operates on imported dma-buf vmaps:

  - The equal-stride memcpy() bound was clamped after subtracting the
    offsets from dst_size and src_size; an offset larger than the BO
    size wraps the unsigned subtraction to a huge value and the
    resulting memcpy() runs off the end of the vmap.  dst_stride *
    height is also a u32 multiplication that can overflow.
  - The non-equal-stride row-by-row path had no bound at all.  The
    loop touches bytes through offset + (height - 1) * stride +
    width_in_bytes, with only a WARN_ON(dst_stride < width_in_bytes),
    and could likewise step past the end of either mapping.

The offsets and strides are derived from STDU/SOU plane state, so a
configured CRTC submitting a crafted atomic commit on an imported
framebuffer can reach this path.

Validate the exact row-copy endpoint against each BO's size up front
using check_mul_overflow() and check_add_overflow().  Use the bulk
memcpy() path only when width_in_bytes covers the whole stride;
otherwise copy one row at a time so partial-row updates near the bottom
of a framebuffer remain valid.  Also reject zero strides and stride <
width_in_bytes, both of which the row-by-row path cannot represent
safely.

Fixes: 50f119925091 ("drm/vmwgfx: Fix prime with external buffers")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 39 ++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 135b75a3e013..56f965ec99dc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -30,6 +30,7 @@
 
 #include "vmwgfx_bo.h"
 #include <linux/highmem.h>
+#include <linux/overflow.h>
 
 /*
  * Template that implements find_first_diff() for a generic
@@ -463,19 +464,42 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 		container_of(dst->tbo.bdev, struct vmw_private, bdev);
 	size_t dst_size = dst->tbo.resource->size;
 	size_t src_size = src->tbo.resource->size;
+	size_t dst_end, src_end;
 	struct iosys_map dst_map = {0};
 	struct iosys_map src_map = {0};
+	bool dst_mapped = false;
+	bool src_mapped = false;
 	int ret, i;
 	int x_in_bytes;
 	u8 *vsrc;
 	u8 *vdst;
 
+	if (!height || !width_in_bytes)
+		return 0;
+
+	if (!dst_stride || !src_stride)
+		return -EINVAL;
+	if (dst_stride < width_in_bytes || src_stride < width_in_bytes)
+		return -EINVAL;
+	if (check_mul_overflow((size_t)dst_stride, (size_t)height - 1, &dst_end) ||
+	    check_add_overflow(dst_end, (size_t)width_in_bytes, &dst_end) ||
+	    check_add_overflow((size_t)dst_offset, dst_end, &dst_end) ||
+	    dst_end > dst_size ||
+	    check_mul_overflow((size_t)src_stride, (size_t)height - 1, &src_end) ||
+	    check_add_overflow(src_end, (size_t)width_in_bytes, &src_end) ||
+	    check_add_overflow((size_t)src_offset, src_end, &src_end) ||
+	    src_end > src_size) {
+		drm_dbg_driver(&vmw->drm, "Out-of-bounds external BO copy\n");
+		return -EINVAL;
+	}
+
 	vsrc = map_external(src, &src_map);
 	if (!vsrc) {
 		drm_dbg_driver(&vmw->drm, "Wasn't able to map src\n");
 		ret = -ENOMEM;
 		goto out;
 	}
+	src_mapped = true;
 
 	vdst = map_external(dst, &dst_map);
 	if (!vdst) {
@@ -483,16 +507,13 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 		ret = -ENOMEM;
 		goto out;
 	}
+	dst_mapped = true;
 
 	vsrc += src_offset;
 	vdst += dst_offset;
-	if (src_stride == dst_stride) {
-		dst_size -= dst_offset;
-		src_size -= src_offset;
-		memcpy(vdst, vsrc,
-		       min(dst_stride * height, min(dst_size, src_size)));
+	if (src_stride == dst_stride && width_in_bytes == dst_stride) {
+		memcpy(vdst, vsrc, dst_stride * (size_t)height);
 	} else {
-		WARN_ON(dst_stride < width_in_bytes);
 		for (i = 0; i < height; ++i) {
 			memcpy(vdst, vsrc, width_in_bytes);
 			vsrc += src_stride;
@@ -508,8 +529,10 @@ static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
 
 	ret = 0;
 out:
-	unmap_external(src, &src_map);
-	unmap_external(dst, &dst_map);
+	if (src_mapped)
+		unmap_external(src, &src_map);
+	if (dst_mapped)
+		unmap_external(dst, &dst_map);
 
 	return ret;
 }
-- 
2.51.0


