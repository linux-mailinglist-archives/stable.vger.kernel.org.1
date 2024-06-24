Return-Path: <stable+bounces-55065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8191548E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D5B1C22A05
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3517FC08;
	Mon, 24 Jun 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKNJAwm8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F419E7F7;
	Mon, 24 Jun 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247446; cv=none; b=OuZxyApZ9PWhiKheqQVu1M3RnRa2CHYyfvTvaxB4gen1gN8jRWLU6wIgRNJ5Y+aJL2MAL7YVgV9W3UrxUjqzRY+i4GwY2VjITDF4GA3ZFLZbNp/xU13ffJU+WiAvTujuDjv4e+N/zwWUJwXi92wL8Z+Yy+fgBvfTrz4V9vxEu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247446; c=relaxed/simple;
	bh=ROPDCII861NLGqzE80k9+DtJm8iQ/4QlSPD6kcUJ+YY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HY6EG2eM48YhPv2ZUtdJCvVxCN9SwCoq7ce28HEHzx5lPigC9uDgLqugelofqRYEfGSkPci5ME1D6FlsmKn5PRTWyEtYH9Fg++eB9A0n+AXfY5d+lWGy57GnuicoX/y6NDcL1IJg/vxCqJnqL+2pDaZzfgmZOm89tLu8lrHfzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKNJAwm8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so34824785e9.2;
        Mon, 24 Jun 2024 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719247443; x=1719852243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPl1ZQhtp404/46Icx++0xUILGoKNCSD4Zi+KclrJiY=;
        b=bKNJAwm8g+ph2AAdhF13Eb/jIXNcsYe473XVhEsSYaBAdcq/S4q8fUXoAOEiOfzACG
         bJGE5tVwsBDD4LKEvXyNecXldrWk1jhUrvQD5GWgz7GowQlJPC9IDGUji0euoN8HCNzz
         4I7GNjCRpkgXuQ4o1C68T437NAo/sdeaQNDz94Vb8AF2qAFTWQzCGVxGEqKZ1DlV/qmc
         OwQBzRf03VBcCabwqk5wiB45hobTzhyYWyveZzbcwRuwiVKYE5FPHd3lxLDNd0j53HP0
         +QWbm0yxHbvoMxaQ6R+KfDxCbRuT8axKDXziQfkFrgl+wky5HBLdc7AKYNLvhIwRSYOY
         a9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247443; x=1719852243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPl1ZQhtp404/46Icx++0xUILGoKNCSD4Zi+KclrJiY=;
        b=IkJ5RPHpoxRTyyGqha7jXdD++Pt8CLckiyVckkT4pGZ+00KuO0DQsxUCjQJEkqoRn/
         q/AsjpC6Q5cGaJZvoyeIRNt+4GFke+GFD4fp5gjOMjbLuaNxnO+5np2DGdpPr+jxay1Y
         CVBry7F1RKuHWxD7mIiE9Mzu3/9blwfpJq+a1BnCQ6D/QNu6wFxL3aqF4iMiEQ0C3CDb
         HFYYIhSDRuM8uX8BrZv4RoWZ7aL/3z0CFjdtUCmL6JC9g6crkGuB0+2CKeT6f9z+BuiC
         qIFZfFGd6Bn0XrpUw5nIkXAQzpE7GwoUbmA84Rjl8RDfAsJKuLtFyt/3nYBrWxGYlLJD
         zoFg==
X-Forwarded-Encrypted: i=1; AJvYcCVGKuyNd+GYvU2CGVUTlyzJcvyG8unYOC2VeVYoWlyV7seEw0bf3yVlsJDSTW7zozkq0ncYy/T53gOdjQrZctLEEDHl6T6NqpkXfaxo9sxpYMgWsKnPpAdEp7GHEQ5zQYNv6hmQ
X-Gm-Message-State: AOJu0Yxif/elXW7PSXFoCwsmSILKoNuhO67wWk8FrlUqNthaYZ4rU4mQ
	ETmpFMh51WLFqKq13Mit+zSId31yjY/r8YSjoXkUJPUghx/yoX7K
X-Google-Smtp-Source: AGHT+IHZL64bTgMiLUEUoyTtjAuoK7dRxFHbZnfAkyi5qDaE8VVg4wQ9jBw8En6Ky+VVdvaKH93RwQ==
X-Received: by 2002:a05:600c:4fd0:b0:424:74ed:dbfc with SMTP id 5b1f17b1804b1-4248cc66abbmr38179755e9.35.1719247443096;
        Mon, 24 Jun 2024 09:44:03 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42484fc0aecsm126090365e9.12.2024.06.24.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 09:44:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/3] drm/mediatek: fixes for ovl_adaptor
Date: Mon, 24 Jun 2024 18:43:45 +0200
Message-Id: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGieWYC/x3MSwqDMBAA0KvIrA3EMVjwKiIhTUY7+EnIiBSCd
 2/o8m1eAaHMJDA2BTLdLBzPiq5twH/cuZLiUA2o0egBjTquzQaWZOO9WxdcumK24mOioPRLoxv
 e2BvTQx1SpoW//32an+cHv+QRl20AAAA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719247441; l=1065;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ROPDCII861NLGqzE80k9+DtJm8iQ/4QlSPD6kcUJ+YY=;
 b=pk334UJ3+WtdigFDy/IyUejM7j4FgWaYmPUO9ZXnCA9jfFn1yVyJk19bsKp+cRJMFnnrkWzpz
 lSZ8e01j9sfDdOUxhI2QnN//s+lP7nzC5B3oCoMDOacSUVG55AN/ACX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The main fix is a possible memory leak on an early exit in the
for_each_child_of_node() loop. That fix has been divided into a patch
that can be backported (a simple of_node_put()), and another one that
uses the scoped variant of the macro, removing the need for any
of_node_put(). That prevents mistakes if new break/return instructions
are added, but the macro might not be available in older kernels.

When at it, an unused header has been dropped.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      drm/mediatek: ovl_adaptor: drop unused mtk_crtc.h header
      drm/mediatek: ovl_adaptor: add missing of_node_put()
      drm/mediatek: ovl_adaptor: use scoped variant of for_each_child_of_node()

 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240624-mtk_disp_ovl_adaptor_scoped-0702a6b23443

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


