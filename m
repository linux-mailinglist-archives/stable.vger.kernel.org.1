Return-Path: <stable+bounces-96196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809AA9E1449
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B4164E59
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A321CEADD;
	Tue,  3 Dec 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="og5pTrpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8E1BD9EB
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211068; cv=none; b=oN2QLdQ0JuRZIbj4OEk8eVlwqhAm3ZXF/5A2UgwrMJVAXmrUvhEweSgJFN1fFl9szOoWVBlhgwtKtAXqPcrOinmZcO1nczpR8l+t8Bfp3EHDKgvDhTUqHeKFDXI3ZhhTUartAdwfhY0SJ/KQ4xgIHx2SiOboBenVBE7+/A6deUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211068; c=relaxed/simple;
	bh=ONGQeGV/Lo+dvZaz/MxmBnTpy+k0yha3gjPk1y+HOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwFfo9Hj8+PTWK/qskzIPO4vH2n+Je2GlQx+rwQW7IIetVEFVMcWuoyyVq8+/mWCEpwr6Hu+0Tdij42YkOdZrk47vjksJDpHu28yQAq+iIs4cEO0z2BozaUQ3kAbx0YkTZ/u6cs7jf0z7nlEy5Rjqz7lMRe9qNVZNLgE9ZtuU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=og5pTrpR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F71940C4B
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211065;
	bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=og5pTrpRvLJr0XSW2GAPqyptSvzFiPq9P25nRwiD6RklmYc4qDy4rvVU9T3KAfj/x
	 Kof18ZoRu2x9ict/CHI2zJFFgFlnisNZJDC5EBmFIvzAp3IyH/I6AnGj6wQFPR8q1w
	 zbXemcHYEdDkJS1yXV2fTgikPPjukJndYPlIPy866fkR8/bemteoziajT0nGS1brC+
	 Ih4il8+C72+0fyb+YPTyc5qnsfMHHI4OkkyFX3QeTY3HbQ1wShBkEjDA58NiYyloHw
	 ng8xxkWAkYp3nJ7RNl8RLA7S/ixHNBID+0F0F7RXLwqWJMomQZt58oZk2zSkT7n41Y
	 fhH5R9zpnNlbA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2159a817442so19373625ad.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 23:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211063; x=1733815863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
        b=nxGhYHv3TfPExbb/pwM3HnU94KQ5yXSDib8QkD04uqirizugJoHCp8u2+rC3ie7/SS
         ONAHhcNJSlsOdJ+AeAWm01h3lccXOuO7ZsMt0951d0FmyJitCsE+X2qz2ePmfY0XyBq9
         vQuIn6VU9i3rD6zqwFKhiIPYTAHbVGhm8wg99dL/TFzDUP5xw87QDhbR5jun3c3ZuG3a
         4ZDoMpD/JHoG4OU2T14Y6pdNeDKyl0L6cPjr9iREC6XWpTTgVqDXs5BF+HN0bC6aFFFv
         CAL9W1f1PkVgBSPLgBOL+q0rxI8F5M1UvDBpiXSpHev5nmCL5jXL1gI6NYZUnbfbTKMy
         fW0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCyulz8/9JzQM7vW5eSorF+VAvI+SQecZPTczVshThJC3crd9cwW6ujrkX7aT6ch8TCczgWf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfe+zCsIUYWjmIVYeBDuLgmI/yGxNfh/gVGScoWfS+ajt/Smy
	8Lko00yBe1JZNe/8zOmdZWuBNgfZEvqeVFMx3vvmDwy2AUOZ5yZP56vXxwYE5wP0Sol6Ju7VPIL
	yJniFFpaG7m/1F3rw2dk6/9GeBvWzvNmlR2z7zyvvP6aFt0l2NQD+j0jCi4nf1v1xxbr5VQ==
X-Gm-Gg: ASbGncssYuLIh4IJF94DfZL/CFec5LX7zi8MPSJecgD/WNv6XKMjN6RMcu1/2S69LGZ
	OEXHBRU60WhZkBr7Ad49xm86LiEL8IehJNhxYECPOBDqDTDh+BzapVSOlW0svIZM1HV2DoPRuPE
	CRCk99ORxnUBkRVvJ+yUtHrY5uOoOdb765LMrdb4VOHyk1/pMPNMu2TKsLcqGczDoAbhwt9tf1H
	Y1lhtwSozIxEsL4pNNsolWfnplqVU7Bb5WeWVYuF4dZEEMun/hG/WiHSWLXIhEaWA/T
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893745ad.53.1733211063426;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeKLM2ys5e0Q3udqn6af/fNUMQYdUmFkZT/mCzd4RS2FR0h2mYZFsi+zEkr90jaY94M2UwGw==
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893465ad.53.1733211063136;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:02 -0800 (PST)
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
Subject: [PATCH net-next v2 3/5] virtio_net: add missing netdev_tx_reset_queue() to virtnet_tx_resize()
Date: Tue,  3 Dec 2024 16:30:23 +0900
Message-ID: <20241203073025.67065-4-koichiro.den@canonical.com>
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

virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
be reset.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df9bfe31aa6d..0103d7990e44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3399,6 +3399,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	virtnet_tx_resume(vi, sq);
 
-- 
2.43.0


