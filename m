Return-Path: <stable+bounces-217531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDaoM7DWl2k99QIAu9opvQ
	(envelope-from <stable+bounces-217531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BDD164699
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4538F300B8F6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FC52E0412;
	Fri, 20 Feb 2026 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg0gSW/M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07B2DECC2
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558563; cv=none; b=SWYrufcKQEmDq6daeNGsZdZOm/J14rGMpHQQ3t95iZklL0NAqKM4B9muqWTlR/x63uQoZ5ZbgUx/BkvMHNOcvhKLKAbKGxmz2KjQ0pKXTZ9VEiqjxIFK35eV98O2ifKTzyq+lIxmxZVj5xBgrDhKFc+99UWRjP3Xevi3ptIc6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558563; c=relaxed/simple;
	bh=14tp/ZbiHhc9fo6I3d3q5B/zYDGp7+QSAvy5xrmzM58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMHEjC18z73Q7sG75Wmc/6xxjm8aRfin8P2fLTJA0Rn+3jQBSfQN0fIZ8LtHW0CThPdRJa1UWVA9mRxuaWbndA6EATtIWDy+Iy6lmgdO2E/F1BZfvyrHsr2yrpi1tMi8W1OvX78MrXeRVqxImyN9s8A4SPue7DWlJEBmaEMmDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg0gSW/M; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c61343f82d7so590274a12.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 19:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771558561; x=1772163361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SNYtFmJqSV95moRlaJ0QYmUhL+TICukmgmBhi3zA4c=;
        b=kg0gSW/MXrjrrzq9iQGnNOuOjnn29PekJPPoWL1aoMTMyzkREyf8YthxbKs6phcxHx
         DBNiXnmIaNuAhr1z+9Ui4sKwHQWeePTgPfU6RdEVp+nPL0K0AZ8+ll9lLOcjDDLFMGnf
         n9dcA0XqdICkJ/gH0XVKE9G779SwyJBcai8UiWa51z041IfXKhlAgFvTtK5lG6Bzoq8L
         y7lHU1kMWBg/joEkYn+vLOu8xPEyNvppe+p+WSDVvqmjkODxKTM69ybb8gO541vKYzqL
         PgB2JrS+UnVFCzs8K3oMT0+IUbKsLECJIZVN9AA3+sZfSaBl+DEA5rONAX9FfbULqoU0
         eg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558561; x=1772163361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3SNYtFmJqSV95moRlaJ0QYmUhL+TICukmgmBhi3zA4c=;
        b=POB/Gaf+osFgfHTF7thdk4SBinvg5Uc5Y1i+9iJqCv1RMJYo8KOIKUsHGcEP24Mybq
         tV42L+hu5fnOppUuxDNG1yxrYFkVL6DTulrfXM8IKpRUZ33c39eYod5Sn2vvlAfbskqx
         HNMyYVUoUuQKi+zn+vE9S6Nnt7tla190FRT43RN8ElkTBdf7HGti6miGucp+GUJG7g/6
         /K6OqoyjmakN2satRvNsQZowoej5gq9Mi3AkFtSvqUVkUbcpUk0efERrgV5OpsgzxpYW
         8cpobgI9SCsu7GsxrVJ9+C6DYvUjlpohD1FiZ/AsdcWl8FXGk16Jyi2y5TyAsi/U2Y65
         vm8Q==
X-Gm-Message-State: AOJu0YyIXEDsQcaX0fXLHk8O3K/DGaqqJRxYsuofVYScJu9X3mCmRmbr
	VQBkHIrKvc5gJL+REXNdomTxJ0bez3vUMocADVJ9YOdke7P3zOV+8lxyDrFue3sx
X-Gm-Gg: AZuq6aICojuetD1ms1qFxMVT4glb/AsQcfZwmZThTW4/FBqoO/s6dGBKRCZ+/zR3DZe
	Al/Zx5CuLeZ4gZCEF7YMXWAn93yVGTV+CRMNfQjvjJ8PWJHbTwspyzaqO2mcPjRs0I6EE7hcuhI
	yJ38VZerPNXN5Wyg1bOi3aMrdnxJt09r+IywwARYNB22R33k0+Wis/9L635gnSo+VltRO8xXREI
	x7EqOUni+OaIpyvd0YTjdyEne8e9WcpGjiAko8yQQHAjmPrENvsRoXtREclKAH6pI5jLkaAIIVZ
	nZhGpiE7NSufVuIM5xA15semksgDuaBzXs2k6GDI2LKLja5r7T7urb4Eku9WlJMr2ra3ykFdevc
	pPZtTw4Wp7i00NtUbuBW7uEP+PL42Gd8jatqPewAXdPozawk3tzSAaMoR+yT2/8fUOKY8yIvZo2
	bU6MemBtrdW+Wo9oCbp49dc0kBwmEVu2BDbF9q2ImwG2ULVeoq+P/L5ZPAvBdB
X-Received: by 2002:a17:902:da8d:b0:2a7:80ac:85b0 with SMTP id d9443c01a7336-2ad17431c2bmr182977825ad.2.1771558561498;
        Thu, 19 Feb 2026 19:36:01 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5cf8sm177143675ad.52.2026.02.19.19.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:36:01 -0800 (PST)
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
Subject: [PATCH 6.19.y 6.18.y 2/2] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Fri, 20 Feb 2026 12:35:50 +0900
Message-Id: <20260220033550.124346-3-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220033550.124346-1-aha310510@gmail.com>
References: <20260220033550.124346-1-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email]
X-Rspamd-Queue-Id: 05BDD164699
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
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 1fe297d512e7..601406b640c7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -251,13 +251,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
--

