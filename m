Return-Path: <stable+bounces-98901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C79E6324
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ED81673CD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E1184540;
	Fri,  6 Dec 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rgB1jWUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788B17BB32
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447531; cv=none; b=CRbSTtGXQxAHnQxms0yXb4qJOGh+63r8X4xFRS/8eeWsjnagnxeSG8StMomS5Mo2xsnVxs+UA8sCoehoIHD/H+puX6pq/7O6Evwp3DU7E1wiPQfw6LRmzaUgyHhpdEh+oQwiWufQOCLo8A+azEwJx5MHx7ZVUtUt//GtSL84z5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447531; c=relaxed/simple;
	bh=6hQW/GNmPuXyiRMQuoJ6EZUo9ki9tFcrjiw8b7LwAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPZDgXjxPreF66ikK5ACVKos0tp//FTtvNvVa8GmKoB0Zf0MD5j9jKiXB4Jk1HBYu51SQopoCpMv3zpi7FmxJ0vvVlOiNYKy7idfym8gELvgAsYjufaNT1LvtRVnm6LQ4tg5RxogJLjBvsl4mPpSJGJ3UWc/pqfD1Cy6aUgSwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rgB1jWUd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 733CE40D9C
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447528;
	bh=gPawsTtuEBPD/KPKBNzHBHV5THR/q5cTrBGd8UniWNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rgB1jWUdz9oWqyzNLwjxgaL/yyEMQNUW0WXxGV77IDk6tyO8oJ985gGsHzjCETp1H
	 zWhguCVwJlc8V3RcIZ+FjGOuWLjbB3SUGsIpDEZENhepu1gON9cR/9EWuYyymJxIjU
	 nN55ZeRSo9Hcj318+dU5KuO/m9aFiZ+BPGUdhATKqe8rmk+aooShCY19+WEQ3R9I0a
	 FmpBxTIKkth/eEhj6gdc00uPctb8haQf4G3PePHMfAN1v6FQ/AjpRfu/YS7pi0Kjq+
	 SaUVAHqBz6uSLBL4/PrhzMBLwIy5FQ8HaclFfSYnymnhA+3akXq5IH9h+R0ZUouoHW
	 CjZ374EvabUgA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-215ce784342so15547155ad.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 17:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447527; x=1734052327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPawsTtuEBPD/KPKBNzHBHV5THR/q5cTrBGd8UniWNk=;
        b=GFsFyAsAbgE8M6JXRD5J0TjK7LMkqBun9nsKl1igptdoHGg1fQ1io0qIqgnjaEFQAC
         h6bByNyuwErU8F9f/6wkDIysh45a8LyYvD7JKqcOilUYbPLJX6CMvIpOo4I2RUoWNGFS
         Hb+YE20cPvuZavwCApaVK9RF4F8KNyNN+bSdLB/9+lkeZ7e4n9oZC38AU6xuOqWcA106
         Kp/ea5u0wyB7mEPeocHbo+TpSwJSU0Df2SiPzBWwx19+JfKx3mGd3MmsDAkWUU/7hiK6
         0aCd0o8x6WuL8pLl2r3j6nZj+fCrBVHRswcTZYMbLv+8Mac9v0EAkQ0bXHBJJs2uFOWF
         iqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQn+4z3AiEbwsH/qfSIHLlRHqEIY4ED9Oi4HUtzyjS23CHq//n/vMDVw38/fWK6DXYN5loZEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP63mB/xOiv41AI5+uPZw1zX4+CRAXXS1rM6Vzc5BxiHotG2NX
	Uzf2Y45IN88iSRDcoIe8kBP8GnelkT2mjGYQawu1D/jcNNYbnpW6dNvRh2wSTDZmGtjKMmGFgbY
	SeEN/EPfu6wWzm3DBKH8KDzTQCsE/H0jiZxvoCkS3K/GfyQJ6h5bBXMDW1Ia2gR9bShErsA==
X-Gm-Gg: ASbGncsramn9JZxhkybAnCK3gQGwOVr/4ZfpFe5kT4l/QLFv79LdRTn4MTTIqbvQcBm
	YTjmn52Pxgfgje+0EmDXwv72w9v3GyWxzIH1ei4doK2881uoN0KO2MJyYZ7O8LHlrxlTdmiKYoS
	SiUunH+EZpHIp54rgIX2JAVofNbsLSpitH2kgmDJC/zMvpnyX8M7Y+BzuDwRWuBSleEXliCPCRq
	iSSt8AiXGCFw8wke7qjC7BZsTu+UbiG7DhyavIX4uQIw1v814A=
X-Received: by 2002:a17:902:d4cb:b0:215:827e:649c with SMTP id d9443c01a7336-21614da98bemr12028135ad.37.1733447526977;
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3hKgEtavuk/lPGuhbmEd6DMI7J2o7R7dxsGfXdXbPYpoB50i9XnBvW0RBnmyBI3MXmGOMsQ==
X-Received: by 2002:a17:902:d4cb:b0:215:827e:649c with SMTP id d9443c01a7336-21614da98bemr12027965ad.37.1733447526722;
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
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
Subject: [PATCH net v4 6/6] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Fri,  6 Dec 2024 10:10:47 +0900
Message-ID: <20241206011047.923923-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
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
index 5cf4b2b20431..7646ddd9bef7 100644
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


