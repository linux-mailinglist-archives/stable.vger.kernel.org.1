Return-Path: <stable+bounces-189013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21615BFCFBC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E151B19A5D67
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B81257846;
	Wed, 22 Oct 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx0L1Zn/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F72571DD
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148664; cv=none; b=j/s/FjO5mgn3YSrnX4Bl7AfZRjrfSsvEUeFvBhHfEB0FjY3wRpSpnFVi9NZ5c3VKle54IbPavE05hjWImgQBbwUOQEwM5K2Y/AkFySgTXOFZDXGTLP3rtcca4SYf0A1g+zGiqB36YqcD+9mpkRNAb2waukuj3AWE0J93Fx2nZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148664; c=relaxed/simple;
	bh=dbCAjiJaJQiN/J2VVY9g9g6U74sYQAol3HyEtlrFnUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFc9iEiS39GrKMMP06L0tdH17zC/ce53HiHLxvG2b5EO3nbir9rvjT8F+cHuyaY8WV8etgjLMQt/CuF3GgFyLdQw0kd3tP4A83NMP5rL3IMlLl/NOW/owTz+SSGwUIV05w8Q+zn0tOXXykvckaxuAAg8rmjbs8TFpL4YncxKVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx0L1Zn/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26d0fbe238bso51204715ad.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148662; x=1761753462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naY20CMWDzYHs1ZYgUoMtzuy7r6fuKt6p40K/aayGos=;
        b=Sx0L1Zn/+YbNgKBEhcPK3WoKkgnjYXr4nOcunJGN5Ffgl84cJ88khAUfZlBsDiWWH0
         2DEch3dt4YsmRHODqLmjLmgsM4dIGKrSHC1dRHJF+ZJ/DwDMeNNV+Y3O7gmxnBS2PPs+
         XgUsM2J1FYxvFAjSck/cO8AVIcGK5LufwCtStvs6y8j8P9mRKis1sowE+MJHJ+Ld21yD
         lNsExRIrGFUw+2GuDiD7MeTa4wh2GK1QmfQ85WUdB4lq1hAuwSCKpO3FQdw997mTt7Ww
         O3mVEuaBR8c4+egdqbsxNeUSf+mMwGbNRwKGQmjrFSFxITXgXHZI+1dw+0NZ4UhZkvmc
         sMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148662; x=1761753462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naY20CMWDzYHs1ZYgUoMtzuy7r6fuKt6p40K/aayGos=;
        b=m4fKmKSyJ/Kf5HEfj7W1bc5Y+85dQbxx7QuSsd5mUI20+GFjdCVItprIKZBSQixMwn
         yOOnbJpMdm33HRMS3nbbWTChyAvvcxA063iEWHyMrhIWwh44v78roJMlUknVKDZV84fL
         U6ODyHlKjG1o//SnRzdBGNwfXGPpeh6x6CrvRzynp+Lzy97uXvFWkbn2WiSW6nRLOoIq
         a3YaRxhzvwsKzGXLJI99UdZYF0dMJHHk2WTTdpLl1/CE9TszTcVNt95ZV6OBUZnNAXr1
         TTf2LODg0K8pPXG2ZlxyuwxxlkCpAjdu0lI1eSTWxQX9j88EHc3YnjcBbjlCNVaQmU9f
         m7aA==
X-Forwarded-Encrypted: i=1; AJvYcCXqDCPG1mrd29mj2LnlPpBSXAQhCbUJaampICsMBy/mnGWjXLN2hUJGFYIn5O63LBLi/I02plk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsZ777biO9ax+Q+HCi1oCjlKMWUQSP5UmMZvq89GPJhQtZPMr
	jEtN5tNCCtHTM7N8AiLSq4JZ9DpM7va+8exM+Ez+H2Ia3s3rKEJ/DeJc
X-Gm-Gg: ASbGncvbMtRbBD4doJ0EXPAHjR03rayC+FaZ4tX+biil7AfB0uH+2pQUq+sHE/RqvVt
	jounoM0t9ZRzzF5rTJ8jtmCf8Z5Zp5XuCR9DmIdHGN3p4XBgZcuNqfu7MiCLuR7ZDFe/tXS8oIN
	sGyOYr1x/iYQF1TilCphgNwPGp8w6WA3AVR7mITZICLMCIH+/J60HDCj2LJtxmvzMwR9gBU3X9c
	PidsVCW0mUfaPqllTTXjm6QHiAVHIhHyM2pR2Gs+E8NyWtnLRyJlYJAfW3ixIHAy1n8l41Z164p
	CYjNKT5A2WUpU9a/52wURo7e1gX4rlavCkiRKpamgW2aCpEwgQwgsRCJoNLCFCCW5ZBHwd+lDK+
	O2OlYtQjcBpDUOPPf8RegorCVY8i+7nM8E47RYIAC1+vYZAAcRh39tPQ4IB57MdrN0h04j74Wzt
	ijYSmWB69cyg==
X-Google-Smtp-Source: AGHT+IGff1qulcywTryt+y1hQgxYYHQojnwIuJuCP1ttfYIhTSd/04VrdxcFUc0K86XacXDYxdgD8Q==
X-Received: by 2002:a17:902:e88e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-290c9ca72bcmr272142045ad.17.1761148661728;
        Wed, 22 Oct 2025 08:57:41 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:1e3:b1:dcbf:ab83])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2930975631dsm21990425ad.20.2025.10.22.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:57:41 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] virtio-net: drop the multi-buffer XDP packet in zerocopy
Date: Wed, 22 Oct 2025 22:56:30 +0700
Message-ID: <20251022155630.49272-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtio-net, we have not yet supported multi-buffer XDP packet in
zerocopy mode when there is a binding XDP program. However, in that
case, when receiving multi-buffer XDP packet, we skip the XDP program
and return XDP_PASS. As a result, the packet is passed to normal network
stack which is an incorrect behavior (e.g. a XDP program for packet
count is installed, multi-buffer XDP packet arrives and does go through
XDP program. As a result, the packet count does not increase but the
packet is still received from network stack).This commit instead returns
XDP_ABORTED in that case.

Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Return XDP_ABORTED instead of XDP_DROP, make clearer explanation in
commit message
---
 drivers/net/virtio_net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..8e8a179aaa49 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1379,9 +1379,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	ret = XDP_PASS;
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* TODO: support multi buffer. */
+		if (num_buf == 1)
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+		else
+			ret = XDP_ABORTED;
+	}
 	rcu_read_unlock();
 
 	switch (ret) {
-- 
2.43.0


