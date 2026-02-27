Return-Path: <stable+bounces-219913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL9bGNwsoWk/qwQAu9opvQ
	(envelope-from <stable+bounces-219913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:34:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE61B2E61
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C03C230FF916
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DE3D9033;
	Fri, 27 Feb 2026 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1biDKb2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C033ACA7A
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170402; cv=none; b=ZksEWprtO+7lWIn3Ri6QG9Yv4dY3z61J1BVo8LcmEMV6u9vkJP+hJjqZK1HScgHyT+nD/5RnkIkfTLjmC0b1HMFF3Na57rvuTU5HsbcTpaPqiVGm2gAR+mhcN+vbH8sa9ftHeNsQahhKL3lEQIz3EbawCWczJgduPvPlIzqNg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170402; c=relaxed/simple;
	bh=E2KHb1OdTxay7BO0Pa0igqLoUMUgt4R2mfyK+qbBt50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjWrAmILtyeEoS0EGXbeO60xFEt76kM2io7nPwhFw7g41YEs5AUTQQwscclzCPKMEAvuP/UXJpSTo3zzqQ3V1Zlxdf4AK013KK8aeA0UxTX54hQgfGgS2Wiu07ijFsv5fGMHV2+7rBByTzSu0OuoeqCxgr2YZNkNVtQDmLVwo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1biDKb2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82735a41985so974237b3a.2
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 21:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170401; x=1772775201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWxM/NY1WZY/R2hcKtz9Vxhb3ZZqeiMM9SHyVrFFUDk=;
        b=K1biDKb25NftLE5deslSvBJjeGLRUUTQST+q1y2sbPIstYmAZOxid46ZheT3iJR+2B
         aG/ku/rU4OakKXEdHbui6yA+rAOBz6ORkutFvc4WvqZ77ekdLmYA9YWEFYPBZJNXKzyl
         TdaQuP0SNPcjI6E2ucTukIIFrMIW+OTpOJ0bx8FPSc3mZd034MvBf4Ad1likdOZISjzN
         yA0dshu2S2wNERX35l9oDZcP+bhGMgosIZajNyrXko/n736amLbhr5lAKuWCG7szcLh5
         2C+S5a6j4Gt7ToJ2xi2OCPSwwAO77QXb3Qyvm1MlY5Rl+FT/lBu7va085dwV0ym/R1TQ
         wCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170401; x=1772775201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWxM/NY1WZY/R2hcKtz9Vxhb3ZZqeiMM9SHyVrFFUDk=;
        b=EzULkULhyBNry9+d1hko0F0v3dUA3Krn8PFStRdXDHFpeXTAy1xsqFjYndy6+th/E4
         BJMZ5FYO1FuBj58OaJBg6W4aUx/8FySnJxtzgpZ9NPS6rw/M/PL8VinEjeEA34kjccad
         s5J30/XqTjfvWqI4iw1kYXZGb3LKhQ/06uhqfrxIHq8C8UohHMXd0XZEiyEjnkqRLm9L
         HSjGYprvWWq1NVWmkEVYVjrtPw+UOkxItuHOm61E/rQPn4z3FnuoRll/PoYukfn4Fsw7
         TvTnq+tUP4ESKpeN8jSzY387+0e2KVcT1LKP81sjr6mOrgxnDSfsYQ1rpstJ7dGtjyOB
         bfzg==
X-Gm-Message-State: AOJu0YxfEO8WLM9A+WjZ84x5p3j4Y+6Mhjz1abYNPBYD4C5V7USQCgHr
	j52sUsc2cVSPqmWszU0FunbA5bLjSo1dEVWOw1EaZkD3qwWsTlzxGGgwHszQmQ==
X-Gm-Gg: ATEYQzwg1IoyNbtbt5S82GgaP6aRusRktvFxzz5Um5vZ4/P/Pp/9ZVUYr71FuNt7eAP
	9hYGQsGymHQGXSfbaI023jnzwX87vAIuPrpfkb/Gugz7VxB+CpMGdJSr+QWE6Bmtc4zED31TZ3w
	2WV12oavY4+AvpylbdXSYUV8ZZNqPsZeMq7cOgjSVs60K6BcLZphgqHT2Ti3DAtZBKVmyN/R4Hy
	rGjmYsvLG1mU9XhKPLnV+WzIcliUsM1R73iC16du7InYRouPKwJyZcrJM788M2OGcdUIQw19k68
	JkoajfQLDS+knu4jbN0IBo9L9N3o2TpcptRaJaBUhGqQc46meK39FaKGQ64pZ42ZmL1CCYuvkul
	l2aKjLCVCe0tr23XIzKi6puAd6ZAYX2Om8VrbIvIKjcXcNOJbFz2ifBlv20WKm/mBqjFVm2Grbr
	5rtJH8Vj3w4M5cGqQjhr7/yW1k5Ygdo4bkbmQ6ZxATyGS7668Www==
X-Received: by 2002:a05:6a00:4143:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-8274d972743mr1365727b3a.7.1772170401133;
        Thu, 26 Feb 2026 21:33:21 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a048615sm3815828b3a.52.2026.02.26.21.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:33:20 -0800 (PST)
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
Subject: [PATCH 6.1.y 5.15.y 5.10.y 0/3] drm/exynos: vidi: fix various memory corruption bugs
Date: Fri, 27 Feb 2026 14:33:14 +0900
Message-Id: <20260227053317.426000-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05EE61B2E61
X-Rspamd-Action: no action

This backport patch applies to the rest of the longterm kernel and fixes
a bug in the Exynos VIDI driver.

https://lore.kernel.org/all/20260119082553.195181-1-aha310510@gmail.com/

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 13 deletions(-)

