Return-Path: <stable+bounces-98232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19899E32EF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECAD1671CF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA618DF64;
	Wed,  4 Dec 2024 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nDC+V+XV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9318D65E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288898; cv=none; b=RRB0HNtUI9F9BfY1vVT8W/612TxSbbEN0nv5pp/8+krbViONtnyYUlSY/F8zv7t2NUTNOGqyGDgz4CA1CdYNtCzty5xOQ123eoOiHhfp3SQduaSIufl3wCdTRXyOVVckr5OymrOoTnNy8b10VFIPdlNTZD2PVVA0lMYH+pVM2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288898; c=relaxed/simple;
	bh=gLYoI15BjmtBU7oAvSpTarPfyfyGSgvB72KHD0BKUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMdLviO3Sj1TZszrbKCe734GABOOLEWxF+P1zflDZQDNuZtZACgJMez6h88P5IE7o0HYSvVY8wUcQol3lYNiNSkLrZ3rVs2j6fGUHKnohJpoELpO9dIQ/dCe19ja4/xICgm8BDlmU6PDg1YxHZ2pzjpBUuA72vo4VGS3hAS5z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nDC+V+XV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF6A340C71
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288895;
	bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=nDC+V+XVcAD7b1H+1pBB2uwhAywejnQ/hMRFp+/jG23uEQ8xcyCd7DNJrJB5NRwup
	 pvzi+glCd2gAoKxP0vu813xGDVgcIFujukFGUtEpnFIZKnW7Cy0vQITQoxXgl6btHo
	 4Sx585rAL4o+J0zI9xb34fZHydysrUaDjQ8VywfhtJAmfOXOlLaKYo7Ynlaj6bb4el
	 mczlFqveJECYWvEtov3SuxjDvDtmgt9NdFgRrloBTcWfYA5ey1YGTC4w5+CpsxJ+og
	 LJps9Cvx3XxGE4mN5wyK3zv2rmUcvxGqy278oTtB0KT82YJiU8kmNmGTNBaxQdEgLA
	 bDX+oXzAcSLOg==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7fbd38074f4so2379296a12.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288894; x=1733893694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
        b=Pf25prBgB6ZdujVn3Jgz1P9izi8wVqPzgxR/O0lnf7toH+k6eaJX4Fspm3AKa1NdV6
         ONQ1rya6wblGk7CpqWyO1e0qDr9E2N+r566nq8h0uiQurNU5vf1Q2yGDpUi1SLsHAUnb
         qfnmYc1sd7HCrxCCIlS3EnjQFogk8Rsv8kENJ7zOy+4IXK+r7M+cyslIkK/x9BgbxAzS
         OIw9C5fqcAPju+rZ4lMmOpNQEBL+iofbXHivzF5s71c2BgcmOCyZWQ+x+Ye+bPVFVwmz
         fB6KILaaYCrckQsQrkbWu4rMncIL36ONFS3r5VfeLStdJtX6QavRDMaL8MQxwPS9FsL9
         9c9g==
X-Forwarded-Encrypted: i=1; AJvYcCX+i58CfipBiPo/8RwUnxc+SFPokVHNGABX5AuPMXIgvX5VW4Id13ibyT2SS1iiTDp3BardEkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7/EvB4kCAFzfWA+NF0i1j2wDGpKNXC4mga6zTZRYh8IDauO+
	DyfpO0/11oZtoKC1xgncHWHT2Q2O/nh5OHSqyyeK7BfivWIMI/GUe5zawLTcOroxzJ5X7iejham
	t5K+zVVbXfVn+pHGV/uo0E6B6hodGHO3FZkyHOSwmotqhLkDlrI8gpAGBHN+hsWxaCh+Uug==
X-Gm-Gg: ASbGnctrXTdFlok+zyN62x01TLIp6otUPf2ocpXelEmEgH8XFQLyDapOhq1yDiH/1Nh
	zeNQwbWQM8diEaScyUzRFtN1+soTd3bXjYIuHwL1P+H8uC78Em1oHXlcgsTXRks3Z348585XuF6
	U49wlqu22+Xr7sUb45cSYk9r+PaaECjsAlxFubUlJsqgcbprbnOR/8g06LMLJzW24lo981xXTtZ
	0OPp7wc5Wv2K3Ke37AGXaskd+sZHivBTEyGrQBOQgaK0me8ifLxWlTyAvo34NN4vieE
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699724637.3.1733288894387;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj+uUlyY1C0BsWmALoxtojbbY8sLNjryjJ+hUDmswkw3F7P+vqgijj+KJpqRsQ36IWx1WReA==
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699705637.3.1733288894118;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:13 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Wed,  4 Dec 2024 14:07:22 +0900
Message-ID: <20241204050724.307544-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a90655cfa4f..d0cf29fd8255 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3395,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
-- 
2.43.0


