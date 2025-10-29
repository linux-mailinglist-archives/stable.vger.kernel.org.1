Return-Path: <stable+bounces-191578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE2C18CBE
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7C4636B4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440130B527;
	Wed, 29 Oct 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGIyhXmR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9C30499B
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724077; cv=none; b=mFZphrqIucrL9fh8ytLkl2Jdkx/nx5UF14ShoTJ3IV3bO5pPaeq9yuzwi0Js07j8Mt8QY2EIxNNJORgaonoLWfkEf8Jy6EmFkrX+P5HsQ4nbp2XqZITg9adULf4mFQGDeytmAdx9N8RAUPRIX1R+PgVe5VectWQLSTDrEjQgo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724077; c=relaxed/simple;
	bh=vgS5Mv2an7aW8L2hop7Xh6r0KWmtXcOo0+xl9hewdoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArrHjLWrOIMM5OjxPYTCfmOTXlh92Ve8ovCfbpAt6nqXlk4DqBQ9WtEQb+mD7ItgPksMU5VKdWeGOnDMXbKUyiEw2Vq3+Hl7jVnaFPPZi8az/ss4QtejpbBKAh7h2ZFb1ZeRb4/CaBZwYPRb2p6W0/iK5lEOLs+ql7h19wvEiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGIyhXmR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a27053843bso9564591b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724075; x=1762328875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q30GbqlTwe2nQMX4UB7blFcjur++GRluVV4AWK8Q6Ek=;
        b=EGIyhXmR6beY7fmK664Aa5uFl8nBOaEstHj+1FEqaWRiVxX3hipJxLOa8bRfNmnmHq
         scI3I34+CqMKezwK8LNBTefOm0+2Sg0z7r8HYRAFaSXpP7gQsMBg4+m9lb3AjSBawi1V
         SqFddqL9Z9IWhuzCSRddXmAhM/hDwstBZDnKqrI7b5ZZC+ZcPuMGMqnIvyW0fIf1O14B
         SUDcOzIyBEZGJX5kkEo/RE6ojiMuDHhCLCV7MjVKl4MN+biFc7E36COE3vurmaKg8O3k
         mKJipqz0CjFXVtpx/yTJd07nPjbyFIfBPIE6gGYTPmqF2HOK7Mf2Kje0GC8VW0mPS/67
         Gzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724075; x=1762328875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q30GbqlTwe2nQMX4UB7blFcjur++GRluVV4AWK8Q6Ek=;
        b=Lu62imGV+qW0TESN5nxX6gyGqDX/e4S2O5O7TGJinIHDLrudkFIVavhMLfkWmPMwSV
         9wDg07Opwo6KD8kwaOgJr0/N0WewdAc9Bj/Uu2Kg05/Il0LhN/zdlhjds6onuOUdKgxb
         tlpMc3wGIjWvQsB+2GOj69KRTjnKIxpXSa4y3awd+ws2eg0kwbKbg3RFyXGJIs8B8QZm
         lOReW+sGrl2MMyZpBOAgoYTuVFzR8m6mcrMU2QuAKbXXPYmiZG12bmrXJL0mnLFpUsjM
         +vUQ3dJ/cqhOPzizMImjqh++KQwthGO4VCSAcAbydjsrjctuAELk4uAYI16y+/ZnqRq3
         6CKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0pZXjZlL+DK6wzqOMN94NxQFCm1Y9OTJNVmBC+fVMvY12CgtIc0QA514H1nbYOPn+sDdj9KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXTqBw1wkgT9lGwkxx+nQwKvS8dSfyVb/Y8+MLPzDh8/j4au/
	nrAFAaZW+xWEpim5Al+/QKh3lza61dXfv3ltfSCSQdvV4BtTEuMyuO0d
X-Gm-Gg: ASbGnct3Xq6s1RdF+8cAylOu7cyKc/Ljfv+jZLh/JTPhdzmm63Go/RC6u509TdGu/Vh
	L6ZHkZb0Fx6F1EDVUweGEJwTVYT3mnd6Hy/9ayOA7MufaAwf3/7ar7wwxu1Mz6E3V0LjG5339/t
	k3IxohKDmpaxAq0SWVzBwIYcDRWsj8QXEJgCQHDDxtC/sJ0K8tEZn9KXOhNzNwTZYJnZVDfvQzo
	ls6vTXNg0+hd2zsMpNPHE+mJBr+NcVq092NblovA/g6zuqRL5+dlM2NRoKYPiCSQPAwfXGmrjuv
	9tG3Vbh1AgcjmyAXhdLXGEPRmlRetj4/EJ90vS9L3iQpSrvA6yte2vV2N3v6rO/oim2p3vtUbBD
	Z47vH7pfnUwuROSJGoZQPX39iQ0rg6gNdtxFkoCK0hb+JN6itTchNgNKeEqu9y4Fzwjn8SSBvLo
	byvKhDFpb4h9AWwEi5WV/yUg==
X-Google-Smtp-Source: AGHT+IFuC13ebf9tUyrUJPnxA/BVzsjUbwXpoTRR8n0eYfWFABlmJzwguFPrChLih2199JwTZmChYQ==
X-Received: by 2002:a62:e90c:0:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a4e4c1ce32mr2077224b3a.18.1761724075412;
        Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm14201813b3a.65.2025.10.29.00.47.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Wadim Egorov <w.egorov@phytec.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: sii902x: Fix device node reference leak sii902x_probe
Date: Wed, 29 Oct 2025 15:47:36 +0800
Message-Id: <20251029074737.18282-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_graph_get_endpoint_by_regs() gets a reference to the endpoint node
to read the "bus-width" property but fails to call of_node_put()
to release the reference, causing a reference count leak.

Add the missing of_node_put() call to fix this.

Found via static analysis and code review.

Fixes: d284ccd8588c ("drm/bridge: sii902x: Set input bus format based on bus-width")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..3a247ac3c7dd 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1189,8 +1189,10 @@ static int sii902x_probe(struct i2c_client *client)
 
 	sii902x->bus_width = 24;
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
-	if (endpoint)
+	if (endpoint) {
 		of_property_read_u32(endpoint, "bus-width", &sii902x->bus_width);
+		of_node_put(endpoint);
+	}
 
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
 	if (endpoint) {
-- 
2.39.5 (Apple Git-154)


