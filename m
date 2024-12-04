Return-Path: <stable+bounces-98230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FB9E32E4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D7C284F2A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0A18A959;
	Wed,  4 Dec 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Qyu9S9mC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466718B47D
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288891; cv=none; b=niEFRJj9oP3MrTusOxnF/uvs3/KpJ6XvGVXKxsQ7joTv2gEMufpCKAtxiAwwsmzqcv1etgAvQrN9066rjEqaRQin/eXEORqR1F3cOPtyRPkqbrrIRSrUXmGzRiWpXJ+g+TPWhOQJk/4CrnTqo0USTlyUgxHOU0V/e+bTO17lPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288891; c=relaxed/simple;
	bh=hqMbrbaYzCq+7XyNHSdUPNm5e7GvSWtAGjiRKisOUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK9GVK6wGSKWgC80WYjLtwMYwECu52pHEYWgGWjmiNpxT+tqbSRR+6QvOhKnJRcTP8TY4eYDG7vNfj+MnNEgoiBVSAKD/mmJTJr31LmNr63nr6eBs6iaYy/PMwpeFxGCKi4slXaXIkhqn0GtlrQkNwobGA56HH+8Mg304CFIFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Qyu9S9mC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 37DAD40AFF
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288888;
	bh=FIgKTk0jFKfzwEEyDT2sgiCPxqET1PFOW7qhpD89ECQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Qyu9S9mCnx4pcYekkU190n1p39grb+EJu7YtPUBXvKPEUShglzziXTqE2DTDMYUA0
	 9KQssvONmiVWaFF/Txt8pUnMeMcTVZvmxNjtl8TDpKcf4c+sryIvfqE+VewwuoFGNg
	 I8s16N5y/sMzX4k0awSmBLtAtJuAQWIu4O5eZFsDDelJfubJtnvZIKa71pZy9KPZ4P
	 nce9h9hGCprVU+bh6nJhkYs+sEpyLpirAGKijXectYyUN6/ld8UDyspgMy+RbgMElT
	 DueY2B/N1dm5QYMYNhvxgXXy8HaTT0tkefBtOqCRoEdPOkdshnjs6Q9oqhzGFhmSgo
	 DpNBwmCvKEIqw==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fbbb61a67cso3790637a12.3
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288887; x=1733893687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIgKTk0jFKfzwEEyDT2sgiCPxqET1PFOW7qhpD89ECQ=;
        b=vCY8VcEi/sBSbEfOJtwM4r/Ol1UTKMtmlT+sGzlZWxOtk9cMrzuYJNyuKAYbAmcP7L
         moStGwFrhPsZhWlMYhHa23a1AK3uueS6bVnUeDrg5niS4jMyg7k8kdCdkF0vUAS7GIfH
         jNlZmG63hvL5hJydMMy4JWsLwvi1UAr7ZFZ+B1uE7V6IQkMECv2Frb/m1iG5vPcEzt34
         P7jYNpQnJNVEYr1lIAPkWAdN8uluNMH5dU7C9TX9ngRC2KYoRHCZ7FigSpHfQC5avvK9
         2fPqOuoYuZF94y4VobnVq8qWHSrTg3NqNlozvlxw/ozDRGPk5OJujXYil++URPUGWbwc
         0c9g==
X-Forwarded-Encrypted: i=1; AJvYcCXBUSsPTHA9mdZvOGubUaQmZBLAT0S6uJVYXry9jxUQDmGqVqTSgsv8CR4qxYS1nUPLeIIc0zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZj8X3O8KWndMl992u78p36ms2xjVkl13X3jFSyB9diqTxbnGt
	FVaCbbn7lHEA0mYm44V5cM6haAZCiGlCKSPMuOhm0EjN8lS/wTL97WiQIrpO3HWB2GUiuIpurXO
	c0rIUC2e+Av9AmTapxloJPyyJIpI1how9Topg/hYM3FDIV78rJko4gbWn0gNAyvmGlelmCA==
X-Gm-Gg: ASbGncvJ9mxdMvlMs02N4V0thXECjMGT6hYEJXnJClwMmdeyXmu6s8r+NP5oeJp7AIr
	EL5DDJS/ZqISmgFAFIbt2QeMN830c9pf7p4lB2olxfNUh5HCRarYdW5I2M3gcTVz7bxQM7wCLEX
	qriT0YxNTUBBR4IwlRldaSqSX02P+mfy1fpdP7Rxaz55AvomFfHUIeyP8QJPO+uutSZsOleM4Rh
	8k/6+CfuRt+3QJMXzpZidobsYm08UJAFBPnadgpmd50r9zruiPt7aJd/RrL9CGbDrGV
X-Received: by 2002:a05:6a20:9149:b0:1e0:d1c3:97d1 with SMTP id adf61e73a8af0-1e16bee16efmr4965547637.29.1733288886653;
        Tue, 03 Dec 2024 21:08:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPKUJ5bAB237DtTojPXFWcCu5gDgXnbdRSrhZV9hCNjaygoT5Of7Xd97gtubjWTrohnL5HSg==
X-Received: by 2002:a05:6a20:9149:b0:1e0:d1c3:97d1 with SMTP id adf61e73a8af0-1e16bee16efmr4965473637.29.1733288885901;
        Tue, 03 Dec 2024 21:08:05 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:05 -0800 (PST)
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
Subject: [PATCH net-next v3 3/7] virtio_net: introduce virtnet_sq_free_unused_buf_done()
Date: Wed,  4 Dec 2024 14:07:20 +0900
Message-ID: <20241204050724.307544-4-koichiro.den@canonical.com>
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

This will be used in the following commits, to ensure DQL reset occurs
iff. all unused buffers are actually recycled.

Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1b7a85e75e14..b3cbbd8052e4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	}
 }
 
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2txq(vq);
+
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
2.43.0


