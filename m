Return-Path: <stable+bounces-254005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG5GCiHWEmqz4QYAu9opvQ
	(envelope-from <stable+bounces-254005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:42:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEE5C2118
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F6F53020127
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD938F646;
	Sun, 24 May 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+QY/xP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A52248A5
	for <stable@vger.kernel.org>; Sun, 24 May 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619042; cv=none; b=sLPaZQNhcUyDj+ijkv6Q6dPe8k2Pe4sxOrTFST9NyabvEqKQe3EKpBValy9AT/LGMHEXi+bUEm4PD8Jljcvl/QOQJIbTGep3YNhvzODxnVo7WFRl3Fv4IGWeDr1HFDT2bhF+lGKkdz6AvcnCA4uksb0G9MlS/eIXTrlU6lg9IQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619042; c=relaxed/simple;
	bh=5BBjvwH1SFC1IbOlD3lNfjrYB8x4Ns4FSb7De3zt/1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieyZw+tcapLKfUjt1P8EFY5hKYYXfoySjJ5VSEL11mdVpNZW9NhZRmnnwLpBWZlRzHbEut12aAePrGjdM4eev/an53MJBLcDGGmK2am+jH4e05gtSehaa8IzSmbNhMLtKHnYDYquKStDzsejnvp8z2NbgrRbxBu9Qm6LYhogh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+QY/xP3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso3539168b3a.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779619040; x=1780223840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srn/gFRHpPCBsHxpWI/ceV1wqLaO51KjDzwp1tS24PQ=;
        b=n+QY/xP3wPEsr+lmySllIiUoz7fw+NyTBXlkOD2GMhxwwVeFNq/vzS46A6OD64nL12
         Hog9Rg6HVt22wXJvjUINDGVa844rdNg80ngnVg9yXrrcZMLl4ZMWjHXzubscIXy9av6y
         cpAgnKGJmlflrG0Lkvn51j+cNmWpJRo/92q4kOEzXvKyYnPrbZrHdO6MQAdjY6NUIjoo
         ds8L0PudzRQQAy6Y3TMdPQdHhfGk80i5BuGQSMEhqnb9bZIa1+D+2nthmels9RV8UrBp
         T6kZZfomFBjwG8KZo5dS4MyNvnfGwhDP+Qe1Fm0lllW0CJzBgSHcIn/0LEerA7VOA8Ws
         APXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779619040; x=1780223840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Srn/gFRHpPCBsHxpWI/ceV1wqLaO51KjDzwp1tS24PQ=;
        b=sUaZyg3KW/iWCoNB9fYXweU/crwO8/9779m+nxEEP0xBk8gNw832MkTcoaaRNezaZJ
         hDscpSwKwRpApj61GbzRE4TL34/wzuWh+fOSLLDuQsveVWJGOKUDAWfYsnLp1ox8aqou
         SCCNMRJezAUJ5p+M4lBeZ9HU+CmbsZZLrY2u2ya8nz7tRfMB9QUuS0SDG1Tx+r6ewpSw
         zHiI/5KRqtx9qJJ4pxzCdSmfzq2P18cbiQ4IbsYCpx5USQvWT6T2Oy/UJ1fcK7MO4l5V
         pbVO2+JaqybsYngXxvbdoDrph+m1eCB4TV9yhknQXq3bsazRP2ey1cjTg+1cyRkWtY6W
         9Jww==
X-Forwarded-Encrypted: i=1; AFNElJ/0Tm932ImYVy6T2OztU71LWr0Tb6AkUUkdCaw5bY40XOxOLWGCm9V++5VHwN4MQKogVNtWs2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdPC6NNefCdXnDzB2AI1NkQv2MiSicV2LaUT4ZMOjJe8jBGdZ
	PQHvuY91qxBoCWDey0hzGwq7Bs7MrOxTSqTUFx/4tGK6TeAq/gQlRkyN
X-Gm-Gg: Acq92OE8/YXKiHIZcQl1jFEe9dl0mPEs5uH4jtDFcffzLXo5k5/A/EglWjNjJ6AsjsA
	cEKbDj7+RlFQHagtqBdT8b0uPyoVQK/vbA9JyDdASiezU0uo9/kMW+e0+H21wcmflsXNf34vuIM
	4pjneRxoQCRRcOBy9LR13zEogYSHu4N/0tFfAXDwiBBSqJDCQt32YSerVzXOAFxHMLzmANoNSKI
	yL48aWVtyU2xfyTabgf+bXb0tI86/LF0rOE0Bqbdp4wTbmqAif2RdQ+r5R1sZOy52kPsw5aXwNb
	ft6Ri1xHhDqJ52u/BzMyi5+FkkUl/ZDPsLY0N2NoP9M4hELSjAYKTtBRQ76QhS8jIq6FqfEyvrz
	DE+D0J5GSZCIgcb6RLcL8g1dGx8mj6HRNDPFI0tgtaeh9pXe1v6pfbZL2tweRK1gVLf5YqwXpBN
	zXCkw3QJiCktRtITNb4pPVSJsb9KGY2Q+DVtzJem21rolaTAxq9A7DhX882ELejR/kRkhJrdg4g
	10yfg/WF0WeyCHJsTMoBN/n/0nSIC451lFESiZO59iCuRzNjIdl9IgHkKIpqwrcaykioZcrRymi
	ee6fQWJrli0=
X-Received: by 2002:a05:6a00:4f94:b0:83d:b11f:796c with SMTP id d2e1a72fcca58-8415f3d3adbmr10063728b3a.49.1779619040399;
        Sun, 24 May 2026 03:37:20 -0700 (PDT)
Received: from codespaces-78f0a7.dxrpqgqhlb3ehogrxrezr215ye.rx.internal.cloudapp.net ([20.192.21.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe338sm6763005b3a.18.2026.05.24.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:37:19 -0700 (PDT)
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
Subject: [PATCH v3] accel/ethosu: fix arithmetic issues in dma_length()
Date: Sun, 24 May 2026 10:37:10 +0000
Message-ID: <20260524103710.47397-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524060644.106635-1-meatuni001@gmail.com>
References: <20260524060644.106635-1-meatuni001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254005-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 98FEE5C2118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_length() derives DMA region usage from command stream values and
updates region_size[]:

    len = ((len + stride[0]) * size0 + stride[1]) * size1
    region_size[region] = max(..., len + dma->offset)

Several arithmetic issues can corrupt the derived region size:

- signed stride values may underflow when added to len
- intermediate multiplications may overflow
- len + dma->offset may overflow during region_size updates
- dma_length() error returns were not validated by the caller

region_size[] is later used by ethosu_job.c to validate command stream
accesses against GEM buffer sizes. Arithmetic wraparound can therefore
under-report region usage and bypass the bounds validation.

Fix by validating signed additions, using overflow helpers for
multiplications and offset updates, and propagating dma_length()
failures to the caller.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---

v3:
- add check_add_overflow() for len + dma->offset
- validate dma_length() return value in caller
- rework commit message to avoid unproven claims

v2:
- add negative stride underflow checks before each addition
- replace unchecked multiplications with check_mul_overflow()
 drivers/accel/ethosu/ethosu_gem.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..8e95539da98f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -164,16 +165,26 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
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
+	}
+	if (dma->region >= 0) {
+		u64 end;
+
+		if (check_add_overflow(len, dma->offset, &end))
+			return U64_MAX;
+		info->region_size[dma->region] = max(info->region_size[dma->region], end);
 	}
-	if (dma->region >= 0)
-		info->region_size[dma->region] = max(info->region_size[dma->region],
-						     len + dma->offset);
 
 	return len;
 }
@@ -397,6 +408,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			if (srclen == U64_MAX || dstlen == U64_MAX)
+				return -EINVAL;
 
 			if (st.dma.dst.region >= 0)
 				info->output_region[st.dma.dst.region] = true;
-- 
2.53.0


