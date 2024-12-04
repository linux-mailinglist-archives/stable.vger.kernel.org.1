Return-Path: <stable+bounces-98229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9554E9E32E1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14987B2684E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C0188737;
	Wed,  4 Dec 2024 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AwhOnM8K"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1B187FFA
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288887; cv=none; b=YYy0VC2HeVcD98xFfl/wsln2vjsKiL1hy+vQ0Ed1KLIOkMUJItz5kFPBE00I8L/w/2lDO+m+m5JZTPEhUrPT23GbaeaCtX+4nt/Sx0WBW1ccu9/SZ4ctwu06iW4yDGGn4cqbithmGZ4SsVWviGLQ8HFj/29WKqXOdgim5SlGoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288887; c=relaxed/simple;
	bh=QyB99KR/E5dyuun3oXDM9y/WJ8QG5my98H0Do5AE/aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew8KJ3p348pl3B8e100XhMkfUUTRH2kC9BfFzppCbrsoKFRDZpEX8BJxt7+lY0q37vPdi+SWA3l70rMfnnnMIQUwtfJ3EzpXFURJ91gdVjYRA4OrKTU3gNrLGVb3Ty0Sy0iMMrpXTFWueD2h/4C3ThrYUFyl0tb35rq9E2BTuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AwhOnM8K; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE9AA40C49
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288883;
	bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=AwhOnM8Kkfe0D69Kjh5oJnX/zXegdfKc5fWXWGPU1SOZjs/of9VZhyYHtOOi8MWOD
	 Fpt7tO/O62qlHN73+OjwtLILC/tOQUGQ3BrE/ZCoId18nbNOnE+3np/Tv80FArDaFk
	 8Mgg9xcgLJ5pkDbpmX7D7nZuq11qpHGTa5zqYXGtPkbDgAeyw+wmUS4H0RajFr5Gz1
	 YpRXyZRpWe8yHZx3UXnPZzNwDloxgOxjDHVdbFjMRWdoPMVxjo8NGaimqPfMzxAoVB
	 1eyEiuLJSouqekeKJ0gcJlvrqD3UjIkht04p6kmtwKdwQz6eXhiS6t2zJSRt3Ll4OZ
	 qctgxt8YPbRrw==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5f1dd01f596so3622619eaf.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288882; x=1733893682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
        b=UIbPUig7mdDvRpoi8AlT+LS/vCsDDBWRmwJweJVIOc6A0A3pTBWOfzmhiDP927Md0Q
         lbA6kacIgrczBANJmzTUXWo5Y/YHTSJTql3m63nS8isMOxAmKKpcmttB/V4hJlVtlz+p
         78K0L7i4tgfL8T8XHG2uPy5z/IgIWtQp+lfsP8HG2N6IHqpLGza/tZLvnLIpFB41SzGA
         mRksFKt7tymA+ucvWdeGgbIuiqaQ0WA0PQqoZhmvuE2zA7mLYQjMWkcesEL1aSC2Dxg3
         rHeytBlamk+WMkNhqw7D2IcyqOUmdxNZWpUoMu4HUwK2kFVoZJ9RZFr1KfbPemRxeGrQ
         +eMg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Tup57QWSJJ6sjsJ/rABdFSwBs81W0/+B9Ko2rpzuWN284gwpcQSWN+64hxgOabbDDHuCeIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+xymJv5+E/9CkolWsCBGNrHOcBdk19mzDC874xsBZUeHAC9d
	D8hyp+OpLqX3QrH/zj/cFfJ63ZF/AThQsQDxpCJ4ZCHCUU8kocAK2CbOS9Bu9TVvvNFa7NAbmaz
	MwI6UeLXapxhy117hwiYNB4E3C9YbwfDV91v/Buqaox2iiWyvCNoQvALSSw5AwKfXAdZ3lA==
X-Gm-Gg: ASbGncsIuMo9ZwIcrsGvyP40TkXMAsFSM6qE22d5eTJEf3R8B9AkQVZS1KR4+LHKnnQ
	Q4o72TINZ5B2CFkgfyR+sPy44knzRFU7Z/8Q7A1k83s85uKHxIolBF+6h4sA+TghSxfiEJ1h+Xc
	+JA4VpDlQF9YbETOOQ7eRpi686ZMU/HfjuqnEQaB89w2UKoz3+RmKukMmTqbPTb2CPF9IGl/nH4
	/K5aXdQvCpF9fBE7MGEc5GJvm57Ec1FZx53LyzhK+9hu9o7Osk+K8MnfwCXJnHOvgMH
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503388655d.0.1733288882541;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs3DkY/VwOKGPPt8+iJ+sQPX2t2a1HIu9jL1g2fxiv2RrXsi55RCQsiq+IatRf8oAeRlGmPQ==
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503387455d.0.1733288882234;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:01 -0800 (PST)
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
Subject: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Wed,  4 Dec 2024 14:07:19 +0900
Message-ID: <20241204050724.307544-3-koichiro.den@canonical.com>
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

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 48ce8b3881b6..1b7a85e75e14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct send_queue *sq;
-	int i = vq2rxq(vq);
+	int i = vq2txq(vq);
 
 	sq = &vi->sq[i];
 
-- 
2.43.0


