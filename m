Return-Path: <stable+bounces-96198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356619E1445
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84386B240B1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC71DD0F9;
	Tue,  3 Dec 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FoDdpLNL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB71DB344
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211077; cv=none; b=jR7honAsGMKnBwrIMlbQlcuty50pgtE+U0mp19ENuQZhSYeCbIq/2WxoeAqkGWQWl97P3WcPtpMrQgb0+b3Yj/m2mAcWDu/mFlqQPOg6WiFKf1L5Hmf3oAsmOU/6rT2PcLL513QqjZS/+CG/g5MTRb45QJO81ZN1Pxl1AZ02sXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211077; c=relaxed/simple;
	bh=Hk5ke9nzypkJaxk8bCoKEHSofdwMIA0X2l10CVp/tS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8/ZyxvIppFPKDw65aqwrHRc1OdYa9Gkn2UD701aw3RoViJlEMvEdlpsRRuG6LzRgT01vfeucvm2O10doytKWL//ODBRTWY+F14+JFTEjRnDEbSaCWvwuBYDiC9SxIhS/SbuSDe1yVGQNdYkP81ARsXE8q+AY+Jo9qcCPxw8r7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FoDdpLNL; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4CBD3F297
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211071;
	bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FoDdpLNLtkLYr3DZqbDvW+OKM6LMvAJQYtoJQGibXzOoGzAYrMspOUx8F1oz2/W+D
	 iwr2Nlnk+BZRs4ex7LDIz4oiTeGj+wo8X6x7OiSxchjb38NNuk3LtkwH4061GOjuYj
	 dOmyA1iU0wnritTFake7vAr/h5wGAqUGXKif6PazcmCOJv+ATpTmHuhbif6Mq1ehF2
	 6nyJJTvvruCyF7Emb+gWtq33AUq6Fmc2VQ4rxEr7ZYmspG4TXf0vyd3ycBX3iy+FI+
	 7R2l1JKSsUAtOHjnjvD48Wh5OF+manLBLUXKvwzXzISsfcslygl/fH7yjb+a5t/N/W
	 EYjEqGREvEO8A==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-724f5009c7dso5129662b3a.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 23:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211070; x=1733815870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
        b=qNHASIw7tPuMgrukOnu+YsLRN3yBC850K2+55/RoDFGjfe/X5R7GoojFDCqwnw7fFu
         GK/IYE5fKt+TXA5r1rmOZKTa7GUy87PAuCuO7PLADugNLBK9oLvhwAugh3hjUEEvEer2
         xYbl/T8v/bPkTSnxW1sLL4CNQE1cG5Q1Vm0UQoO582sUk6WZctmO+9tG6DJ7vnc5bX66
         JINXU7ZhimXSfic9ENt5Lq7pJLfjAwpD/JD1Tp6mNo19uwdHrD9q7dHkB/jJCgEHrRY3
         fYR51DzwTH0ZBtOPJ1bX1f0pw2Y2R7aZo9wnZeNfOKwWjv1UtIMbi6ddHpg1exCLJA5g
         0J/w==
X-Forwarded-Encrypted: i=1; AJvYcCVNdaGzA+PWkcNrprAe+o1DErszBr5sbG4dMdJl9VZN3a+x1iP9MDjGbSck4e603payCYDiJUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dlDUEjAKHlN9ngElAtbX/sjV4Bpx+VRC8DT6jQVgSrGpCK4L
	T1V/6Gn0s/8W/f+Rv4ismJmsr75O+p/wyxVVofpjDQTwKCSDQfdwz7w7IqBn4QMH9vzC0NjK8WK
	6wNQQfwdtUTjnrKNKORiWPmwqCunZytWqeuaO0DooehO3znsEV8RVXLeR0pq+0Wv6qb6NiQ==
X-Gm-Gg: ASbGnctEbFeqRY7Qoswn7xH1Q6+5U6ttnZvorYpOtvVUJVCUCKkePCj8Ftzl44BkEQx
	FZaTm1VqdaRRgjsJ8a35tXVH0Sa9wPyXN6I3nGqfbT0XJjNMDRLQbWnvNuFLagSmA/IMSnnIJ2Z
	448qGVZ1LcmvYiGj57RSa651fW0EJLexyMFIwwUX86cwpQlAr9f9oyu5BJKk2A8TudXUsK1WIgi
	+hlmsnIVX2IXwvsQniQF4mYejiazZ92MqVp5WtWb1XlDSsHu6lkBDCdhrum6H/lbugj
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393805ad.15.1733211070585;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEND0UzhbAQRYul9CwlhlE8NsG8OZop+RaB8RyNyzhSiQjfU17kWK9qXqZeOdr2+snjte5ZcQ==
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393625ad.15.1733211070289;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] virtio_net: add missing netdev_tx_reset_queue to virtnet_sq_bind_xsk_pool()
Date: Tue,  3 Dec 2024 16:30:25 +0900
Message-ID: <20241203073025.67065-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d5240a03b7d6..27d58fb47b07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5749,6 +5749,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
 	}
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	sq->xsk_pool = pool;
 
-- 
2.43.0


