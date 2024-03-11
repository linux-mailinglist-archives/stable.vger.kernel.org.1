Return-Path: <stable+bounces-27412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849A878AC4
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685BBB21180
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE633FE28;
	Mon, 11 Mar 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EQRJ3ksG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779432C88
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196243; cv=none; b=nhGzzicxaaPmba0DKX/Z3WWBgWKlFgK5G5YanXyTzH0XtvU0fj8XQzhLrH4Xfx15Tt9lr1HGci7S5GVn1CwsVccxnlwG7+t259sEyI4OVYGp6CKNr8T+0BgX+xs5J0Pg5GGPheP4/loT+e1aItA8D4XfDjhkuYva6ACwjlo7xdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196243; c=relaxed/simple;
	bh=OdMd+J50CNM+50f8uOMI7+ZekRCkUMCn9VJu8tzX+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtoepI8ZvtdY04b2AeECgDc5MxwSnONK+zkisPu3+956s05WI993yD4obEir66ifCiKtpWqFuL/zUmPaDAJCGcOlpv5VJe49BmWReo/Vt9xA1yIA1bXtSoVSZq/HxKA0+otUlFe+b2HONWWIuQvZ2Quukt4X2aUToBhAhzcrqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EQRJ3ksG; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea59cf81so2382229b6e.1
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1710196239; x=1710801039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUgfNiSuiTtBVNEOakTU6DEDXoHV6YA4dJcvkvf2wRA=;
        b=EQRJ3ksGEJfiPWiyb1C5o4HUUIJKuzKy6HMRmEOyrSHTD0EyPpdDPccXtGjGKp1+km
         a7vVvzvOwwuK9pUccmOW+/3HmzcwVix/w7tALNxjPwOYhTLnhgTng5RyorPrDwFU5coy
         WsQo8sYfNl9uKUbNq/n4W4jAUZEy7zKxd5Tgzkb3gxyTvL9hS03IefzTCCILUyGTvl9b
         Gj23R1UoKMylhSTz047MyM1y5Ad4WlQo78pvc2l9o1iXxpfyBKabvLfcFTxfUx4PewGW
         HG9xTkoUiZuY0VaTCRxMQcPlmu6594a8VOOrSqQchN8xGp4TAYqp5DVAl5qnBthUdXYr
         BCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196239; x=1710801039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUgfNiSuiTtBVNEOakTU6DEDXoHV6YA4dJcvkvf2wRA=;
        b=Nhzd8UaagJFW3WCDelLKOuyv4Nuz2pJCtAv2HrfV6/l46dQksGXdwPtk1bmhYzvH81
         o4T7Z49U9dsCGKOVOcpdo4lV0OdYdNFMzK6vwWbpbC1AI5NC3O947+Kx+F7izVOSMLwu
         43VBiUCdaXD2x3GMb9GYhv5md0/WDBh6OtCXcBsiiU3Y2i8FOGkEzf+Ku3joHxfTvY3A
         2Pop5NBdQvTntqxggcvKBel/f4vgEEtokZzHznmvECLjhH9IMAHccXPQQxCFE04GCC3c
         uwvyn0HdD35RCt32G2cLGu8Xg0ifsc+G5AzffKsHnSYfC/9zwvBgkNvI7/9ZqL8ySjlx
         hwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1Vd1Pl6HaGfKvnG5HJZjRfjAOxaer6BBQ5r56Z5lmJxaFm07NgYanJYg4OMKXc++3/OMwHRYdRshVvEK6gljIBH0QQN1
X-Gm-Message-State: AOJu0YyXoatALTTwvi7dSF1q/aS/8ykZhN/pn/doYJfcmwK2BERWDULS
	yUv6b67knCnJ24pbc3ncQ+0AxzVMK+373nciBt2uzejV505H9jl9if62sQqSN0M=
X-Google-Smtp-Source: AGHT+IHzsBVmxmvEd9yydjX8lSJ0aEa8zA7lYZdmXFKIknpvvZOV4bw6iQkCUwQW11vi3oEDLGEQsg==
X-Received: by 2002:a05:6808:1403:b0:3c2:3a65:eaf9 with SMTP id w3-20020a056808140300b003c23a65eaf9mr2279381oiv.9.1710196238894;
        Mon, 11 Mar 2024 15:30:38 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id gu17-20020a056a004e5100b006e572d86152sm4964638pfb.91.2024.03.11.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:30:38 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH] net/mlx5: offset comp irq index in name by one
Date: Mon, 11 Mar 2024 16:30:18 -0600
Message-Id: <20240311223018.580975-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mlx5 comp irq name scheme is changed a little bit between
commit 3663ad34bc70 ("net/mlx5: Shift control IRQ to the last index")
and commit 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation").
The index in the comp irq name used to start from 0 but now it starts
from 1. There is nothing critical here, but it's harmless to change
back to the old behavior, a.k.a starting from 0.

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 4dcf995cb1a2..6bac8ad70ba6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -19,6 +19,7 @@
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
+#define MLX5_IRQ_VEC_COMP_BASE 1
 
 #define MLX5_EQ_SHARE_IRQ_MAX_COMP (8)
 #define MLX5_EQ_SHARE_IRQ_MAX_CTRL (UINT_MAX)
@@ -246,6 +247,7 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
 		return;
 	}
 
+	vecidx -= MLX5_IRQ_VEC_COMP_BASE;
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
 }
 
@@ -585,7 +587,7 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
 	struct irq_affinity_desc af_desc;
-	int offset = 1;
+	int offset = MLX5_IRQ_VEC_COMP_BASE;
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
-- 
2.34.1


