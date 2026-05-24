Return-Path: <stable+bounces-253996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7fOMBIyVEmp31AYAu9opvQ
	(envelope-from <stable+bounces-253996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEE5C17F9
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1112D300CE5E
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1A2D8DBB;
	Sun, 24 May 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBGYHTHT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F72248B3
	for <stable@vger.kernel.org>; Sun, 24 May 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779602823; cv=none; b=c/PzEZi1oiEKOsHiWLaLrAzq5tdQ3z1he40BdJw34y/HfNrB6jHHu8vaAVi2sqkM06SDlBe8/uIGn+5SSz499UPkxigT3JCHRGrjYlUCScOBktLZ+WbnA7z65uwKaIf9xn+EhXDT7Fzsy15Du2m3SiOWgCL/pxI+guxeF28Laps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779602823; c=relaxed/simple;
	bh=v3I0u2k/rCVGOjSflorBQS4WOY5BswCuWl7YrCNKfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvYAP/m9q7HzpO9M25cc0qhD1X4oQtnZ0GtoAYFjJRCZPw7nr+4N+Nm0i0qb5ypY2jF2qpl+9M7JJfUMM7S6niTuF6EGxiB/Gq6Bnnfm77Tm6/uIXfUUP2agHb/6/lSABzBXv8B5uSLEaD2cbf14Spq3hpltNXh7jqB6viJJmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBGYHTHT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3950612b3a.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779602822; x=1780207622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/5rmJ0MMc9nuHByS4ezujVFP1BbYR7lj+NuMOXCZLY=;
        b=cBGYHTHTyuzLy/iNpM3kmMi6TjeQjt88qjwx8f+dtv+Vai/0O+m0t++J764SI8JRvM
         427QU5tq8vaABuzuMmeaGNiS3fCEuulVNHherw7rTGv5MtkyWS127X5vygyFn0ASP4Sx
         mhnq4UPCGvqg/CAsM66k4P5apOOEtIzumsi/RvJ3SRkulM30paJnuTl2NHBoMRtL+3m0
         wchLYZaz6Rcoy9cFXFMRvFQ9wwXjxXSwGtGRdLARbGEs/+HhwZIGWuzrd6f/kQ1xBY58
         XnNcnxBy/pWEYUnGV5Uyi9x/k/irv3Ly5jITJO9EvWfEtwQ+TDKq0YU5EXhG2o92kVvI
         ns8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779602822; x=1780207622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/5rmJ0MMc9nuHByS4ezujVFP1BbYR7lj+NuMOXCZLY=;
        b=bLQUbghQywxSWmeI5cLIScSqUf0OoU8azsKFPiLJJ1jTbrut198i95eAroBdi1FYOd
         Ei9U6GYTxCYE21U6bT67b2Zh4CwYmaEgAfIB8VfqhS8tZrQ4ltgwhLCF5AyM2Zl4qMj9
         Z/ZnsiDMppvkkvskFvz8qW4aTE+dzIzYDEn5Xg0Ak2oxPXAulazUDgyTZ4EE3hqDyrdb
         wvOMaiogPcHboGDFHQWB0yn8WVTJadbs4kS3s/SeGKumsZp7OrlAsMw7F/XDvl+OrOYi
         E/ByaZvWL1eF7y//dutovvzLtbOwjyo8O3MfwUAGl8K261A5BQHi8wYFrFzfrOAjcCWi
         jeOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ypyGWmOkLOxvAjGlIrxF0p3RZ9XzwkfCKjsxj84aN4F7g3hQ8x5zNCqAWDQq/r0EG27QAi/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVjKE0KWjUGUvU911ZjZ1rPJe44ZJYiAP7Qksuh+sNFJODORV
	3rqXYX56qwZ7VwAoRIAYhUQ+YGXmxQCqojxOiz2MSZgmzdK5JhQogYvG
X-Gm-Gg: Acq92OFh2DSd4QP7uAcpN8VzQz7ZiHR50NUmnaHXX0wdK0OP6KkDtosfMFP4a22Swto
	HwVqEtsQVSdHV0ZQIBQcZSVCNbr3z3BEvVcOsCJyRozz4ygF2a7ouVT0LOVWNJDQ11ESqfytfeW
	IZIzroQQQNskIB4RLs0Pni6uZDBE10eypFG1hBFTu9w6b59aKppt/MTMXyqBNGghuPDSXHMp2kV
	tRtNCY767VMBl48XClez4sxyTQpmAIR4E3UtpheANHyK4aWFy+952WnGPiNwI6HhZvKw6VGjSmb
	kZxM/jNBErUUtO4n66rCUWxLe3VsytD3ZUtmDzp1a3iA+0mjs//kH97+NVYtx9ueiAS3nhFyLd3
	MNFy4wOxqs4v6S3wh2nszK05f5PQTyMpkinTcrsFGPqQQty3VrEccvRTOq7YlJYDGzI1+MdIvse
	9CRqOdJYfLB7XH/yBQ0B8zV15vdPFCyGWRoGLkCriTFgtU3DryZGjw0ntPgPg5jpjgOs5o2wZWj
	KP0H0X8ZiqchTIwWWHAt0bK/F8Itt5/FxpABQIhV+o1bpLDB5Eb8Xp4895fa55nZs2t4ByWw1Dh
	1VX5amQjgLcPiBoCEHkvZQ==
X-Received: by 2002:aa7:9067:0:b0:834:efcb:12b4 with SMTP id d2e1a72fcca58-8415f406722mr9473675b3a.28.1779602821789;
        Sat, 23 May 2026 23:07:01 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb00b6sm7310818b3a.40.2026.05.23.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 23:07:01 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] accel/ethosu: fix integer overflow and underflow in dma_length()
Date: Sun, 24 May 2026 06:06:44 +0000
Message-ID: <20260524060644.106635-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524051659.70654-1-meatuni001@gmail.com>
References: <20260524051659.70654-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253996-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58BEE5C17F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_length() computes the total DMA transfer length as:

    len = ((len + stride[0]) * size0 + stride[1]) * size1

where len and stride[] are 64-bit values derived from user-supplied
40-bit command stream fields, and size0/size1 are user-supplied u16
values.

Two bugs exist:

1. Integer overflow: the final multiplication by size1 (up to 65535)
   on an intermediate result that can already be ~2^55 easily exceeds
   2^64, wrapping the u64 result to a small positive value. This
   wrapped value passes the region_size[i] <= gem->size check in
   ethosu_job.c while the hardware executes DMA with the original
   large strides, accessing memory outside the GEM buffer.

2. Negative stride underflow: stride[0] and stride[1] are signed
   64-bit values sign-extended from 40-bit user input, and can be
   negative. Adding a large negative stride to a small u64 len wraps
   to a huge value. With size0 or size1 == 1, check_mul_overflow()
   does not trigger, and len + offset can wrap back to a small value,
   bypassing the bounds check while the hardware accesses memory below
   the GEM buffer base.

3. Missing caller check: dma_length() returned U64_MAX on error but
   the caller only used the result for dev_dbg(), never checking for
   U64_MAX. This left info->region_size[] at 0, causing ethosu_job.c
   to skip the region entirely and allow hardware to run with stale
   physical addresses.

Fix by adding underflow checks before each stride addition, replacing
the unchecked multiplications with check_mul_overflow(), and adding
a U64_MAX check in the caller that returns -EINVAL.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..0383b7a6c3d3 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -164,12 +165,18 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	u64 len = dma->len;
 
 	if (mode >= 1) {
+		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
+			return U64_MAX;
 		len += dma->stride[0];
-		len *= dma_st->size0;
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+			return U64_MAX;
 	}
 	if (mode == 2) {
+		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
+			return U64_MAX;
 		len += dma->stride[1];
-		len *= dma_st->size1;
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+			return U64_MAX;
 	}
 	if (dma->region >= 0)
 		info->region_size[dma->region] = max(info->region_size[dma->region],
@@ -397,6 +404,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			if (srclen == U64_MAX || dstlen == U64_MAX)
+				return -EINVAL;
 
 			if (st.dma.dst.region >= 0)
 				info->output_region[st.dma.dst.region] = true;
-- 
2.53.0


