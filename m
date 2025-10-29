Return-Path: <stable+bounces-191574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A870CC18AD5
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3ED4F1A0B
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F15273D77;
	Wed, 29 Oct 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1eLcC7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176B30C626
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722606; cv=none; b=LTvqIPTwZARyXL+Q9R1nFuBfYd5a41xO3DD153mKVw2V5WvEgncSGMaoyQEjRfALemXSmFYurrfsRMvQGeVWGvHmsThVDGfyW+qYqj3sWdvDfOHsPNU+dn5sGquFsM5fSUzGAUz1N5wd0H27l78xt1/jrOorkSVmhrQqwY7mDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722606; c=relaxed/simple;
	bh=dc28hu2rjOtj0l/fFM7XCV5UFXk5eJgGGGyZl91ori8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZhVBH30ORfJ6S1QCpKMI6RSrsT2Eu/iU1VNrupjgCB61C3QKEhBpRnvB5QyhLqQximPmrS+hAAheXthU6qpwhmlp4QMc3TFgvG2/GZjq0STFZVSVKo36/zIE+0XI4IArrfkaboWdilO5z9I4LJDQyF7xGiaICceDVhlp8KiA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1eLcC7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso5851813b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722604; x=1762327404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7WzjBbcIkMp9vE4EpjCxo/Q8IBE8WxTrpS4XkHUl5o=;
        b=hx1eLcC7V1ma5NG2HYEX07nT9LLUQ7Ah0944PimsrSNirC+9sbO2HpY3xlvBgq+VfT
         UyvMgHJ6mDlSvvGab7fbJh/r+jwHacqJIW3jOhG3de79xoIqP19JdPE7xB9Rr0pQBV3l
         er08ysjn+LBcttIxV6s+nGlOWzScxTGsUnuLlGOOUMfBEP0bvAwVRl/5A7/lUXSA6iS9
         c37b3NMBsC8iaXJ0dDQhKno2xx52giSUQVqAz8FxHfzvNlzhtP7uRRPvv+/IvOKa6HqX
         dCrlYuq1r76QuTMILgDSCD2Qm+dmund4seGHkqxY2zBZ1vdIRNP2gS7hzXw5QKKBsHM4
         EIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722604; x=1762327404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7WzjBbcIkMp9vE4EpjCxo/Q8IBE8WxTrpS4XkHUl5o=;
        b=hLUEohUVShGzOHgmFxEa10dnOugTodWZGMGbcw/67qfyb5gtr2H9PWJCwl5ncano43
         UgH98/IplqJBJrjSx/zNpdKhjdPWPM7A5GQLwhSt3iM9dAh0GYepvtkpUY1M7V2FwKqE
         en7LIWCwLoLHl2oDY/yhxV+zHviHsKvY8V2jCa5WRTPWHUsLbyTDe0j/efggV9TpXGGa
         uc1Ayuva42+tlUem7sWp1i7n/f9AGEhq9P9oIBST7S5TEB9AxBjZHckmJFPC7U7QNKtG
         +rvuX4IDNDhj/CEB8kLwrfRBY8LtjUH8RwhtMbkCG/Be7Y4jeQ79y+UxJM/deCTmpLd7
         W0dw==
X-Forwarded-Encrypted: i=1; AJvYcCUcm4F6WHh9FIRoyq1j3UUQdRUEq3JICmOxO6E+dWRlqZvOqiPSpMZ3ULSeXMP7DB9S8fOjZzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKuRcTwA8z6hkBNMeZDlL/qe+529I4pD60igcE4QUtQd5D0jk
	ajumI8qFKBQRrNYNR0BzZglBFjCyfwDmOAHsqyBByFuWLoo3OP1OvjC1
X-Gm-Gg: ASbGncvXTZ4tKK2f7916Jofa4YCD/nRkCbtoUh1r7xzggeqH02HUiurSGThtUOyf5Dm
	A84yVgzuTfU3Lpj/S0oUWTwwA01fwMIpGqI8+diF1ZmsmVYipsQ1mPg01gc8C77CXL1K7OBSLUA
	ZWod85A7PPcAGII2U43wr82hOL/FRSxtZNdpOeGVijhXVUDszB9a7YbZawfiHc8dCBI6PX2fIlT
	RD9HGI0U7LZ9CH05+poSgNmE4Hq53GZlDNRuTp5CTt1GBcmquzv3Oq6GkPdhXGNNaHx5/tLHxBS
	OvYaTJEZrdLghspoLAna7uWMpMp3tJ4/R9wGoU2EHnFAd1A/YDn/q6jjQK9yELCY+7iqCbagYo/
	oF30HWGgaxX0au4AO3YAHVmxdtDI6xi9jkF33oJvgX/rLCSB0djuRlKpnTa547oeg8t4F06Utvi
	e40Ubij1qpOtL8I8xxa6odCA==
X-Google-Smtp-Source: AGHT+IFyoTqxEaHdHcYwG2j5PoXFVoRtIyJkYmXJKSPfYslsy5ZMiSdta/UGyBhYN4fJfCWD+fCbVA==
X-Received: by 2002:a05:6300:218c:b0:341:6c8a:5218 with SMTP id adf61e73a8af0-34655401460mr2197446637.56.1761722603774;
        Wed, 29 Oct 2025 00:23:23 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm13021005a12.5.2025.10.29.00.23.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:23:23 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Fix device node reference leak in mtk_dp_dt_parse()
Date: Wed, 29 Oct 2025 15:23:06 +0800
Message-Id: <20251029072307.10955-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mtk_dp_dt_parse() calls of_graph_get_endpoint_by_regs()
to get the endpoint device node, but fails to call of_node_put() to release
the reference when the function returns. This results in a device node
reference leak.

Fix this by adding the missing of_node_put() call before returning from
the function.

Found via static analysis and code review.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index bef6eeb30d3e..b0b1e158600f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2087,6 +2087,7 @@ static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 	endpoint = of_graph_get_endpoint_by_regs(pdev->dev.of_node, 1, -1);
 	len = of_property_count_elems_of_size(endpoint,
 					      "data-lanes", sizeof(u32));
+	of_node_put(endpoint);
 	if (len < 0 || len > 4 || len == 3) {
 		dev_err(dev, "invalid data lane size: %d\n", len);
 		return -EINVAL;
-- 
2.39.5 (Apple Git-154)


