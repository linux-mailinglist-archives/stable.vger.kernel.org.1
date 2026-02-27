Return-Path: <stable+bounces-219915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIN8BCQtoWk/qwQAu9opvQ
	(envelope-from <stable+bounces-219915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:35:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF21B1B2E8F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D55D314B84A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497D83D7D95;
	Fri, 27 Feb 2026 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acg6Dy9r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BB3DA7DB
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170409; cv=none; b=M/9eq9+0QPnaA2AlEA6R2ZNMK3dVdoztgSaVKTkzTZhayThkbGqjOKNM6UUvxHADaI16w2M+gMsVWhMd9WXhf2A+/bqc3KKEnCFFVJlsgbrmjvf0KdsZVHBWhaCz94ZujMb+M4kPdLw7bu6rXLBVcHJuM5hBOYMrm7eta1BuMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170409; c=relaxed/simple;
	bh=0V9TfcF0jCfymmrv79UOCNsFP+ZBkFqnn+Tpw8wkDGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9i6d702O1VXqtEOzmOPdd3t0wPrMLzuiUb+kHxSkIi5HuqztPq/KItpAwwzaagGJa9fN92l52eQupNvUcz4kj4wpO1id7MwO/lXWSHuOSwMQ1g3p0XaU+3+nTevo3LfKji9SQCgrXm4psuPFxKKlv3zU6SxJmylz/qbsUa20nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acg6Dy9r; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so607318b3a.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 21:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170407; x=1772775207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqIhYcF+CYSjiR8zV9a6G8BIYgFMg1pnmFFZ2FA8I4I=;
        b=acg6Dy9rYJBVhQUCyjvRLXGmF4w5MOUCphXKoDzV4l9UwgfzfJgN0FWcoR/rVExRpI
         Rz12p+1rGH3cB32IKGKQ6gcdxhx0tM6IhiZgCWrRif3kEVvZXqxMUtAYt+cZ3x0lnaNO
         3OyfYExciJdkSCXfIktIpPa7w1v/iKrssyfoKcIM9lwOvTbqheqCSBOKKRd2hM6GLrKt
         Y5FteuMBTIcA4jp9blskAynrodmVdT9oejilEd+4ZwSvYLyHJKbBn2rP1eEng7ZddaPp
         ebkFOinMqPFxnw69bklrO0BNva4QSjo+kwwcZLMN14Ha+6EyAm8OuUp2vWb1d6Zq9quy
         LhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170407; x=1772775207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqIhYcF+CYSjiR8zV9a6G8BIYgFMg1pnmFFZ2FA8I4I=;
        b=tsDPhmmWDj+EK3G4tFXcsBkenrpyPgKqkwXw8FLHvKpQRCQ/JMR9xEIXR+N+lluQa5
         hJi0PyPQeyiRZgOBwK11Q1qVPd13hb9FcJhK4s18DrafPr12LuzOBNf+Tlwq4ysTvmg5
         08W17JSRKBaC2bznqeyRni57Z8ucwGbnbj1ebCGBTBrEE4qxtL3DLN8n4udiGfiK4PDW
         pULlxGL1SxgL4ZOv9E2IL+EayTPAXessCazpuP/0oW3aW64gnvJcKNmL9Bb+5SUg2QZ3
         KdbvdFrcbxe0n1R2RFyAkwk5hAEeFK8w1A15KL+6D8L0kFYXm5MeRzsmYjgHqHTfNZM8
         mfoQ==
X-Gm-Message-State: AOJu0YxHCxMuhAdR9pyanqHg3jNjNy++TKJYTAihVqbLYDwaAMaVYtj1
	LyaG5gfU6092CoaTa2PBXeE9NLZyxT5gwc4hKi1q+6FK4pIVlHX4EwOPA1yVQQ==
X-Gm-Gg: ATEYQzygfMzXgTwZKmirNsfIgA41H/yAA+N+c7D56VHJg8+Arnm/SPwcsb7g9zpFw5C
	HKlaT/IFNnhkFUxmpwtO6b23YU+Dpz/XbAFW032DQLHZOF5zuC37CqVde+q6ku0s1ocMxHVCl2M
	LZzXvkiDXyBKX7utPUIf7+Q6DIH4R/DdVCj9zQUGU0qoISWM4I0nErmgqJsn9CgpRQfiYcJGT70
	oqYeh2fPCpTjmjNQImGwAwPh+0dIyIcyEnERHknpzuN2AvdXGZH8arHWWBIOhM0lvzkmPcvKcAG
	wjIIF1tqsSKYFxIYeGxhWwazJeDe26c3BWuB1ayPbFeDWYYTjXAztblkxq0zzceFAK6fGLNsTDV
	JoOfqJN82wYs0paS4zuJ1wSJuXkM6j73VWU8NdTAuPg6u/j4FIj4+hapHVCH5emlweOcD1n7Gpr
	3rOXf4hqUb6Gm6/zT7h15VghvrGqtaAtY3wRtA5OEfksrOkn1oEQ==
X-Received: by 2002:a05:6a00:94c4:b0:823:c59:9cb0 with SMTP id d2e1a72fcca58-8274d93b0b2mr1369523b3a.1.1772170407236;
        Thu, 26 Feb 2026 21:33:27 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a048615sm3815828b3a.52.2026.02.26.21.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:33:26 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 5.15.y 5.10.y 2/3] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Fri, 27 Feb 2026 14:33:16 +0900
Message-Id: <20260227053317.426000-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227053317.426000-1-aha310510@gmail.com>
References: <20260227053317.426000-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219915-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: AF21B1B2E8F
X-Rspamd-Action: no action

[ Upstream commit d4c98c077c7fb2dfdece7d605e694b5ea2665085 ]

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index d0e394397eca..576d79ebe9a8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -252,19 +252,26 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		struct edid *raw_edid;
+		struct edid edid_buf;
+		void *edid_userptr = u64_to_user_ptr(vidi->edid);
 
-		raw_edid = (struct edid *)(unsigned long)vidi->edid;
-		if (!drm_edid_is_valid(raw_edid)) {
+		if (copy_from_user(&edid_buf, edid_userptr, sizeof(struct edid)))
+			return -EFAULT;
+
+		if (!drm_edid_is_valid(&edid_buf)) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "edid data is invalid.\n");
 			return -EINVAL;
 		}
-		ctx->raw_edid = drm_edid_duplicate(raw_edid);
-		if (!ctx->raw_edid) {
+
+		raw_edid = drm_edid_duplicate(&edid_buf);
+
+		if (!raw_edid) {
 			DRM_DEV_DEBUG_KMS(ctx->dev,
 					  "failed to allocate raw_edid.\n");
 			return -ENOMEM;
 		}
+		ctx->raw_edid = raw_edid;
 	} else {
 		/*
 		 * with connection = 0, free raw_edid
--

