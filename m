Return-Path: <stable+bounces-135259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D85A987CC
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FE54449AB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7602F266B66;
	Wed, 23 Apr 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ibM4+fvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03C22F754
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405243; cv=none; b=lTzLmuLiUM3vKmw6zru214yEWinuduwZ3AmErcyiGW/t+aMVLI34d4LcVM4YvdgOqT04veWqx1uf6hLkS44S1dvFtjovN4RSeHtYJf8O6DUPnIX0ieGU43Yrt89USwyXJfsgYU8SZipZWgAvFr3D0hcP4DPhjRhoXqcnGt7fYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405243; c=relaxed/simple;
	bh=UU9YoAHKOkXYDXJAShmuDPdc1qbY8RZWY4PpxLmQsaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gG7nK40vFQIIdZ6EcP6pZoPYzW+KI7h0TariVm8IBcwD5ltBpv88tSgELGq4ZhUIxBzfAqb0u5JOQe4gUT8ClErYiYbhokr1nxhCuoK+9Wx3A5CejxcVIyqDOp/+4HKnBvAsGBy8rAnikUAKr1LsdUUAb0VD4I9hzqYaBhb15GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ibM4+fvo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5248434f8f.0
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1745405239; x=1746010039; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMrbMlTagXkTnenmyJmmNlOF+FvuaE9CmrOSpWPOLlw=;
        b=ibM4+fvoC/i1nZm6QjOLYEBcEtNY4VRglgE1h9FtCfApED6ztndjIFTTsaUJVbYMHP
         OiTGl9IvNvI08ZjkU+mbfgE/DaLyykjEqJEhSety9WnAM1/ZpvmWl7HhKVp4gwICAeYX
         CDleHED2ciEYCw6j3RsTTXemJULWU4cjZWWMEbKFmjFi48VXhZYWhaffvNgg8GSpKzGa
         +csGPJz5tqp0jJ9yWsA04Nee/aP52jd+btsdtZ6wRDzgUiBp5ZiE3elcSEbzT1/zqNkj
         wPMHqyyMmdRqQlxe+XopSsRkBaXoZek2ju9py5UI265vVOoRhjNgl6+pyAk0a71UQjX6
         /Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745405239; x=1746010039;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMrbMlTagXkTnenmyJmmNlOF+FvuaE9CmrOSpWPOLlw=;
        b=S8TRdAVOfFqOW2GfvS/+GgxzXXHswF35SguBHrVN9tyv1mdEpxp4bsAR6KS46USETJ
         SjpA53DfziIp1p3hgZfD9ZMZLF90sS19dde6A85Sl5yeRKED7GwpCk9hTf2Q2kUdV0kM
         jL4Y70wQ92kW04CSejpmDrhgrb0UUYJEIxmcfNFQYtdMp21Voj4r7JmxoyOnQXUTe4rD
         4bH9AsekuhmfP21C1cNS9O0tkhE86fkRusRJ31yOhWtMyL75FAmIJZOaXDQpJSiNlrum
         qHRgQAljJaYaiXESLRFVsklR5xBG26Wb9sGYqHMcAi7mOGopkycyglXNyzj+AB0R0W12
         BUVw==
X-Forwarded-Encrypted: i=1; AJvYcCVkXXwIz+WV/826pdn9Yvb+47rO+2Er6PXhieiEeVd0EBOfpdQM319cFl2SO3RzVD+AXxgv+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9wMBABwXBUXXr21u17iAvSSrgnpDhqP4LFKHk2iWCBotSxUS
	YhYcxOPTCkA3dY64D0eibvt2zmo2NImzDmuWRU1gSyaaFRXXOhEtapEZAMtm40U=
X-Gm-Gg: ASbGnctxg+Qscfdjhnl9aD0Atlj1TrSfmKFPt/G+KrhtRHj28FeIzZBtHNnBHHY28NG
	fmGRtN6YK0ltQJEKViNy9hSFUkELDS2ZUa6rCg2l1DgBtOtmxejiRBloIeY8YZpPK37UVI4uWUe
	GYJW1ouQctw5JXN+0vHZeqmRUc2VUYTtewmAToBfQfVpifNgkZA0F92HR7tIlW5MQ6fEyEd+rO9
	zjLpkz/fgAoDDSG6GxC9GZgr0ecYJga397F/v6JVBxNXrvGpFhrLbls2DtauCiDViZvVfdLgpOC
	r+beX+zfAAmMMUH/Hnrm3Utym1SrilSQB4qDgMw8wnM=
X-Google-Smtp-Source: AGHT+IHzSNJo3Tq0+q1KtrvricG5SZh6DtKPLrPA5t2OxS4b3WEMt4hP3LFMNMdr80qgkwfOW+ZF3g==
X-Received: by 2002:a05:6000:4308:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-39efba5e837mr14942355f8f.28.1745405239415;
        Wed, 23 Apr 2025 03:47:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-44092d2f514sm21242895e9.24.2025.04.23.03.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 03:47:18 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Apr 2025 11:47:15 +0100
Subject: [PATCH v2] staging: bcm2835-camera: Initialise dev in v4l2_dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-staging-bcm2835-v4l2-fix-v2-1-3227f0ba4700@raspberrypi.com>
X-B4-Tracking: v=1; b=H4sIADLFCGgC/3WNSwqDQBAFrxJ6nQ5Oj4JmlXsEF/NTG+KHHhki4
 t0zEbLMsgpevR1iEA4R7pcdJCSOPE8Z6HoBN5ipD8g+M1BBVVGqAuNqep56tG6kWleYyhdhx2+
 0tbe+0dqRtpDni4Ssz/SzzTxwXGfZzqekvvYXLf9Hk0KFZMnbxtQdNfohJi42iGwL39w8Qnscx
 wclnBYlxgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
vchiq_state") changed mmal_init to pass dev->v4l2_dev.dev to
vchiq_mmal_init, however nothing iniitialised dev->v4l2_dev, so we got
a NULL pointer dereference.

Set dev->v4l2_dev.dev during bcm2835_mmal_probe. The device pointer
could be passed into v4l2_device_register to set it, however that also
has other effects that would need additional changes.

Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
Noted as we switched to 6.12 that the driver would fail during probe
with an invalid dereference if a camera module was actually configured
for the legacy camera stack.
https://github.com/raspberrypi/linux/issues/6753
---
Changes in v2:
- cc stable
- Add Stefan's R-b
- Link to v1: https://lore.kernel.org/r/20250414-staging-bcm2835-v4l2-fix-v1-1-2b2db9a8f293@raspberrypi.com
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index b839b50ac26a..fa7ea4ca4c36 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1900,6 +1900,7 @@ static int bcm2835_mmal_probe(struct vchiq_device *device)
 				__func__, ret);
 			goto free_dev;
 		}
+		dev->v4l2_dev.dev = &device->dev;
 
 		/* setup v4l controls */
 		ret = bcm2835_mmal_init_controls(dev, &dev->ctrl_handler);

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-staging-bcm2835-v4l2-fix-b8dbd933c23b

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


