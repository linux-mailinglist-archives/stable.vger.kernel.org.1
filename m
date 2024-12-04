Return-Path: <stable+bounces-98234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24869E32F5
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A38165B13
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABB190049;
	Wed,  4 Dec 2024 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b6Pa6F09"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44718B47C
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288907; cv=none; b=NMJDu1ESOMf0z+apFZfD0wowl3t1l1Boa+KCmZdkrx6JdbvUX15S2wo7UV3b7Ap4oK8GfzHqL8wi/67HD21k7c3jTYcsXLdnPhuafndFXZkZ+aOa42cx1GHcOblcQ4O6sfiMFc6SmT6nxT8zpymNkzLXXOc5XxPb+EsmQEHDkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288907; c=relaxed/simple;
	bh=pJkC/sg81thrf+L+DBV2A5EohoZuMx0x87sK8yW3WmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ij3YkpQdeU8k6T2Klev5v7N547r+dmcByoQXGMOONCcyaVREU68jqfknN3Dp6P02+fFS2HW7y2uLOGNutnQ0nLqDRV93clpqmhsLbEUNhxVxUJzqKEaXcZTdsjT/YxBm9yiHnggxC7rgXKkkWezrsR/PgrNPAtoYgLQ1S9iABNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b6Pa6F09; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC17540C49
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288903;
	bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=b6Pa6F09cluQnkUQzZZx8ma8BaEhBbv1cHN9CcKbEGyopffc+i2SxVLgYqh4nDv22
	 clW7iuq46Nikl8Ce4EPLhaocWinp0p5rYB00pFjtdKWd75iF6TG3z4qVogEtinG5VM
	 NSQ1ozqVz6B5PYF6zBMG0VMjXStwklZR8N7HnEcRoWRKwVbCjE1UOzVGcOwmFBxnog
	 wQKS1rXwfLB5aoJB29At79iY2lZiwMyCeO9Oq3seqTRXaLAits1ks4RTQPHigf/s27
	 dW0jE0UOxkP0Nxx7DKbxVh1YW3JeWaLHtJpjT2vLEdBy2oBwB1XDxvSXu1/g1o0Ty9
	 2NBT4i1duioiw==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7251d37eac5so7164499b3a.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288902; x=1733893702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
        b=dQOkMT0y578/zYd56SZcwWIjLb1i75skkg7obS+nxacHcWDMPEKlH2VJaPMYH2yD1l
         tyxJSCt2BU+7CBy/mggQqY0lN3qgFEq5z8TNbU2iFkSOtoz45YHeKXx4K/5+7Q7daVig
         peKKWcRL98tcVL/Sva5OrNsCuSS3x8CzQHT/2Hf1LvXHj3R7T79KKCMVEMjsSgykmZuZ
         tHwXJfPPCAP7X2H2jqtZ9BDb7Iw2cFnPprRqw7SW0Nov9vv8rNDV91Yl3qDG2FpFZnWj
         WcLaWSbhLM8xuLIqwJMJ0bvvov7W1Pr6gNLUT/dbbxzDdXdmdGRluiv4GVllq314p3Rr
         hmvA==
X-Forwarded-Encrypted: i=1; AJvYcCU0U+QdjC+H7PXLXty5hM2EupURSqpal/9MswMKOZUD8N1KOImigHD6a9bdRl8YeSzbK3kKow0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JYfV/GA6QrraO+SOXjHLgvgts/s5pq79h1eChorZlUkSNoEZ
	SilaY7qT16iMG4UjkXfzL2qb55bbGq7IR1DUyWkx0fvw0C4ofexg7M/s15IlrfbWHWWARNf9UMZ
	/4WRMgpc62vLcYVqlUFMBRQHDOROqEu4ACBhlRi05Av1BFgpEDlu3reVKwNa2UcoU4QdyhQ==
X-Gm-Gg: ASbGnctO8/2SyKzMKgHQhc4Id+GIbrEiJIKLCjkU+9L7zyqldMLhsC3fVZsRz1/qNgE
	1oxAmd6cZ7F+o6qy8LkNHwwi79NeqQ0UB3NpfCvEfUN7X/hOY0fDXiDQHlA5JXpgSHSty3HEQp6
	YKWVgLbYZWB2UzY5+w4AB4vHmSG8eZtuLti76GQQ0JOZdyesaSFWFRS41amOPfMA1IT1ALaZHt6
	OQT+6Gakrk7GykpAuqrp6o1h2KQcQaUQNJE83t/EN8xPirNyPH/1UBLbKz/GCs+wxck
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288075637.17.1733288902458;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtD8y79hadaHZvvNeugnEdk8crgadqfqLkx2GLITOJPtd6W8UtDItN+uiyqRlDo7jPSUc/FA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288032637.17.1733288902122;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:21 -0800 (PST)
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
Subject: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Wed,  4 Dec 2024 14:07:24 +0900
Message-ID: <20241204050724.307544-8-koichiro.den@canonical.com>
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

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset when flushing has actually occurred, Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
to handle this.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5eaa7a2884d5..177705a56812 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
-- 
2.43.0


