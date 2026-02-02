Return-Path: <stable+bounces-213060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIJDFnGLgGnO9wIAu9opvQ
	(envelope-from <stable+bounces-213060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:33:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD0CBB0A
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 12:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28A9B3002D01
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4BF3624BC;
	Mon,  2 Feb 2026 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtHGk1xa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A03570D1
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031961; cv=none; b=f1tCjTEZ2xZJskZJMRpwJ7q9OJTjG2Wf/g501pQ1mnM97Z3at94QSZkB2AxVayDF09LsKa3BVpU4FTcY4+Vj2/OQ69NGj7MTID/AjK8mwGQB8aJzNUska1WV5cm3TCgZfh4BJWDJXiQSQ/Gy7fIFT94xHiWKvmUhu98hiWBz1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031961; c=relaxed/simple;
	bh=w8UP13amm384XzZzCwddmrnWJmCBemyZWN4IAg9GFDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cP9Nd4hQsv8dm7lfE5/aGAoeoMiliJLmNncmdgj3liyS7JqAiLAeOOcGhBPdX6Tkh3XDriPMzweFpq7Zuwvj4+T4hSF9lSn9our5drY7k6O9l8OHt/xqmEcqJdugA+prDoyHvzpxq5NpGxKfa6R02oM8deEMg0Zi619O57kvOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtHGk1xa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8230d228372so2259434b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 03:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770031960; x=1770636760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGF3kXNpuFGfHRZ/a4i+Y3oSMznaAZtKKSwOANieht4=;
        b=YtHGk1xaYtbWpOLCi3jmu8A/foZn/jeUWbLZmqCkBlb34T7IaaPAjhCg44blYLBGXW
         cSfgeANYgYc0l76MGcBIlLXpZaGBpf3vvO/haoTCykjwzvSp2N6Gs4a1ZCWLCUdcaOFu
         pabXlZ2HY+LZ8r2dObXdXKF1O0mlqvXSRYyHiLUj+83uz2803BjClYczkb7AWFrx+63b
         btVs/97NwxEMXzyCpEJzeze9+QsybarfFBene1+NWoN4fLeFjVtpUJeqRGFJAIAghs50
         l3DzKE8qzQ7oBBbKaRwZla0oD2b53A+zldo/w4zRsUBbJQylLcvtUhAsDiNCkrYs8jCU
         AgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031960; x=1770636760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGF3kXNpuFGfHRZ/a4i+Y3oSMznaAZtKKSwOANieht4=;
        b=D5t+oBFspNulJS4+ZnczhlLBkLdhS4iLYXLqWkwprIBVP58+4LvgXpYfZOvJ4K0Tw2
         aFpugB++YuxC89+aKi9930vl9rgD+HVrKktuZ+JMJNoF+e6NGdOsAERJv5irnfYUWBE6
         9xIWmaQ359yS0foL5Km1gyGbbyz80WegRGxDCw1rNrwnl38kx3pEmiMLA6ys+eqdfQ2I
         DMWltfBNxIe5CtHJeWcafI1hZJK435qo7nYAN3em5lN9jMU1bU6/uIry44DMmMy5RcYl
         pHyEkZrgbZHG9b7pZe+VW/M78zD7CuIJlF8zM/uymSnHKn9G9cJxn2hqGwKMg1+Jj7Be
         zDsw==
X-Forwarded-Encrypted: i=1; AJvYcCUjMKw4gNLjQuv0Mxpk/vNSZO/PFp/VdErQz9EYJUoQa4TzcHeTcfMVKQ7MAL04xN2oHT5mbyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzleNZzLRAiCaENmJb73tm+TrIcKcwukesrki1wYCSmvOtLjZBK
	/OyHkNq9dsGDefa31b0cSZFarQDjY7hGAQgCCkv56lg2IPv8t921JRqO
X-Gm-Gg: AZuq6aJ63/abLQ9QAMzoKo5IM4/MSDUQm/r4C99rE8ZQEe1qVXMLXSgeVg+D2W5TsVV
	4XatA2pzpiSGNeXs45Tcbn4wUo6LcepqFgLprSi5rar0KJYkkZWPVI7f6d7hu8w8mD6Snwsr1AG
	Ot+/InI5VzRM9+2Xg96slOb3+VqylAbDVlL1AAKCNuKmSV+SWOMdiNUci0btxIyZMjf0eFPb9+U
	rOQUkzAURtjLBvEC4PaFVbGyErExOyz1CGedNvmgEahpc7fMGeMWsKdd4uFU8iW594G+NoDB8IM
	qyXx14ft/EIs6PTyKG75717t/0wfAkDaoUDnxKZD31+msN9KUbxIQ8lKXTNI4FVBM/LLvn4eHVY
	PNg/pDkKp/JiX3elusHE2vBvVDBjca+XGGunamRuDgejqPz9kuwKxnn2hmNw4ShfnqAGRJ8w628
	FlCxP8OG0K2AEELb0YVPzClHbpdDWJTzzBA33J8g==
X-Received: by 2002:a05:6a20:6a11:b0:38d:f405:709e with SMTP id adf61e73a8af0-392e01097aamr11107034637.48.1770031959822;
        Mon, 02 Feb 2026 03:32:39 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm13743190a12.26.2026.02.02.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:32:39 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 0/3 v2] drm/exynos: vidi: fix various memory corruption bugs
Date: Mon,  2 Feb 2026 20:32:31 +0900
Message-Id: <20260202113234.183393-1-aha310510@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,samsung.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-213060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DCD0CBB0A
X-Rspamd-Action: no action

This is a series of patches that address several memory bugs that occur
in the Exynos Virtual Display driver.

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 11 deletions(-)

