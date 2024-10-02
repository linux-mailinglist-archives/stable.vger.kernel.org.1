Return-Path: <stable+bounces-78651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAD98D339
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514131C2042A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF311CF7CC;
	Wed,  2 Oct 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XnZf1xvj"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A329CE7;
	Wed,  2 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872016; cv=none; b=Ab9r85RleW3snqjUX2GpOWUMdY6dnNaPzMgCoFNDSsAL2Mb94VYVnbQnMbnb5Zql76WPSt3o5sggLjHQEiaddE1nuwnRWKHvnydxnnSTpmoIkr33ATcPpJDz/ub/ubxrTHxTGTNzfatIpB96+L0VArCVp8kWNdOXWG6FAI2sREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872016; c=relaxed/simple;
	bh=Z3iGhP84Y3QCg9GHA/1Ymr+4r2pvOQzH06K7BVvfNfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqa4vFTXpC3pf2q5ZW0ZwOrlRqp/D19M1oKg9VcD0cnfI1OzB9B0ko4BCSmHMNK1cMhRhJMZ0ljAvglRJ9OH7jpR8NjGnUY+o7kBAFGWcSd4TDbxFot6BouOgxzDsJXvd+npp4x1jg1VwslSvVr1XzeiXiD6B8XdTjN0yBuVegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=XnZf1xvj; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4a24:0:640:9413:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 742476003B;
	Wed,  2 Oct 2024 15:26:41 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:6413::1:3])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ZQa8h82Ig0U0-XCZIZoN5;
	Wed, 02 Oct 2024 15:26:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1727872000;
	bh=BS9mL8Bw7Lo0Kw6QmoUghvwWGovppnMzZ0k0iicLcEc=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=XnZf1xvj3wgg172N1x5xR4EUX2UkEDvDhCsvHEXiHPWAaXDYVRWaGkhZQOyT2JfEe
	 hh2VBbHRH2LppJlmf+nb4/ibytdqBjlZ2x58Dp4h9M6+sjMThBIRlR1gh9gYQ2dKga
	 kJD5uogUSdKAGdwaojwzP9roPu2zAXg3Arp36/yY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org,
	bcm-kernel-feedback-list@broadcom.com,
	Sinclair Yeh <syeh@vmware.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH] drm/vmwgfx: Handle surface check failure correctly
Date: Wed,  2 Oct 2024 15:24:29 +0300
Message-Id: <20241002122429.1981822-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Currently if condition (!bo and !vmw_kms_srf_ok()) was met
we go to err_out with ret == 0.
err_out dereferences vfb if ret == 0, but in our case vfb is still NULL.

Fix this by assigning sensible error to ret.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org
Fixes: 810b3e1683d0 ("drm/vmwgfx: Support topology greater than texture size")
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 288ed0bb75cb..752510a11e1b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1539,6 +1539,7 @@ static struct drm_framebuffer *vmw_kms_fb_create(struct drm_device *dev,
 		DRM_ERROR("Surface size cannot exceed %dx%d\n",
 			dev_priv->texture_max_width,
 			dev_priv->texture_max_height);
+		ret = -EINVAL;
 		goto err_out;
 	}
 
-- 
2.34.1


