Return-Path: <stable+bounces-189912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D006C0BE7C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536E64ECF16
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD12D9EED;
	Mon, 27 Oct 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7WUuKZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F72D6E58
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545277; cv=none; b=FzkE8ayo8StIYEc+zFhFOhvkbXGYEjOYQv++qbD3hN3T/e3EqkZYmo4QjKtd9lgIeONEv6Na3YZWj11WK4yytJOJCYAhBsICfkeiIyH8BapI9AK5gN2hKcYvf9jFV20YB5eyeWAw6TnkiT0v9qQmc6UEvN+90JfPFEcLW7xI+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545277; c=relaxed/simple;
	bh=2r27UqdYRY/th9NT3KvLaQBAFAv+vHzCvNeRmfAsipQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dy6gcxlwWY6/ZfIslGatQ0dthj5LOvpWINCMa39OWR+BQqWwLmORDFo2yRL8jQzqH/Ia6OPXgRAoLdP14okpmx2eH/PPvXCWhSe1bf9MR9AHj+wIH0iwiKbR9mDMKJyMsSDzZ0BRbFJxt85cPoukgahgDEFr/AGhJqQY7jgPxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn7WUuKZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b553412a19bso2713027a12.1
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545276; x=1762150076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=cn7WUuKZWO4i24/kSYes8hqPCLJa8+p/UPwL/NZOa8JNhMznj01ildmn3X0oKXsWJE
         Sbznu5vGNI3h4Fn+x5ePY9VkhUpvun3kj4CBE4zs1yxY9hY2YI1sGAfYLGz+LHnEnjpa
         241gi5w/fHQDH44eveIm3deTZcLBmdkjTXLoQAolKq0X+8vPiNLQ7eubTY/79vq5CtTf
         WmC2YzdEyiHDGnqvQ1h2XfJo7Qhj0Bk5RGYX7KZZEvEHx8WHl4seONdPhi5Ys6Zfn3+L
         pFp9u6G43Au1HQHuP1p5hJ+Uis4+dqaed9p/aSlKMvlpIml5Ml9pfb421TpHSyX3Torf
         ixvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545276; x=1762150076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FyP7h5NR2Q1a8ZGF1Za3mDWy2+W/UZG/poMuoDyAsA=;
        b=JcJ+uI2+D4RMQAwTL41WzwwKhwnXc2izoIcTYn5THlWZTP3RHkpNR+vkoTlLohbTMZ
         w9eaeJYf5ulMmA6S/G8PaA0O5TM8HUI7l+HqdQ1tukZbIajAFRUe0yi74Zo2GybP4q92
         TWGUhgq9X1hhTBZZm96nY/pahgvXkXWEW6YHfzEmnJ5An9nZth9cQgZLIM+adhbVin8W
         ydCbkhEedhF6UV9Y3lO6yqFiGd07h7XWABnGuJ08qk68l7Ll+mxIL15Moqja2yWMlph8
         RwImVZHzA1ClJ02XnP6eA8945+WmcsxV4mFKGGA9tbX7MQc4RkRqsLBctvDA4VzPYb8Z
         fgTg==
X-Forwarded-Encrypted: i=1; AJvYcCW6vK9+tOyH5QK4MttIBCCN8s4nR44a8/amnKgv9daDdSbyVfCmxCwBLPKobKWP09Wn0HMnzEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZjiFH43phjkiJvk4rj4j+S1ok3jhNrYLFgtgIQ5RBnhYwiKz
	8HDdvngvhWq2ZPIs9PPaCez/tdHzPrIGH1EJNUSJucacQeb+aofiJR1D
X-Gm-Gg: ASbGncu8atRiu2kk0+e+jACl6Oy2pWTnwGnRnzCpZH459DKFI5EIWIz1cj+nA1A+5+5
	ZfLfKasBuZne2g1JQjcuDmlKGVIvqWQ1DH3sBVjjDyAC3tPdKJY/hglwaHCuSD9VsoM90qjW1IK
	/lEXPNdwASwGkK0IoEAFdIie94Z9tiQtsF8h+y3oMh+R8c8WMjxRaSwadG06lgVkda/XXcY5I5Q
	r3Msn7QBNG5+axBTw2u0uIlSzJbri1wTXPnKhsatWV9RWwNRRgpSqs9BNby51/2MaskheXIsm9M
	vAm9ZnEYpVQ+LaVrPfWqCeYesQIa7tMlymK3q4F30mnH7/pGWyelcOwne3EqqVplHIS5XNUoVyL
	jAOFg+0nYjpfO5CKKMKRCGnWA6YPrCWCkcDpQKCpqU4FnJtxxdsfo6QhSyfrNG/UW82sSKQbRA3
	0jL29Ee6R5twGnDKlVkmxNZg==
X-Google-Smtp-Source: AGHT+IHkRBw9AN+xBRZdDNVj+3VWLhXLMgjUZyYBAk3neP09j59Fxp6vlIptXFrwVCD5MHrWoavEVA==
X-Received: by 2002:a17:902:dad1:b0:26c:87f9:9ea7 with SMTP id d9443c01a7336-2948ba78fd1mr155483155ad.59.1761545275616;
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm69674695ad.74.2025.10.26.23.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 23:07:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shijith Thotton <sthotton@marvell.com>,
	Satha Rao <skoteshwar@marvell.com>,
	Philipp Stanner <phasta@kernel.org>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] virtio: vdpa: Fix reference count leak in octep_sriov_enable()
Date: Mon, 27 Oct 2025 14:07:35 +0800
Message-Id: <20251027060737.33815-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_device() will increase the reference count for the returned
pci_dev, and also decrease the reference count for the input parameter
from if it is not NULL.

If we break the loop in  with 'vf_pdev' not NULL. We
need to call pci_dev_put() to decrease the reference count.

Found via static anlaysis and this is similar to commit c508eb042d97
("perf/x86/intel/uncore: Fix reference count leak in sad_cfg_iio_topology()")

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 9e8d07078606..31a02e7fd7f2 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -736,6 +736,7 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 		octep_vdpa_assign_barspace(vf_pdev, pdev, index);
 		if (++index == num_vfs) {
 			done = true;
+			pci_dev_put(vf_pdev);
 			break;
 		}
 	}
-- 
2.39.5 (Apple Git-154)


