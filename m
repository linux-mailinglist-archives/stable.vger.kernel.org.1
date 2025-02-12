Return-Path: <stable+bounces-115063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B3A329DC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268B9188503D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB46211A34;
	Wed, 12 Feb 2025 15:23:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C51E2116E7;
	Wed, 12 Feb 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373830; cv=none; b=RjYPaMAu2LaJwzWGAkADkRy4AWvWai3b0bPKlaFo4wgHbrFjI2vI3iqU+IfLh5rYgSYYda2sglKfIpW5UmyB0EwEPSscXOTkAP/YLkB47gfPLKvv/34PQ3FP7JYxrAIJ+fmF9iZoxmDnhQ1h51dA7j04cPdrGFg7Ym5AZja6K38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373830; c=relaxed/simple;
	bh=SclZpbH40sY/KQxGKpCzfbmqP2AczydQQ7QBhMNWjnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDBGOWuhgK+Omb7sEEERuqLiRNP4ndTOq/oqpyMz+R1/nvx+R0jGdAZtAJ0bd3DQx18I2D2lqvXV4yDD8LoGWhNh5JYiuEbR4CJbnN/waANx3sAjUjsTA8Jt/qfdnD4uKCA/DcdKdhyYeRkGgv+zp4T3tcRXOJnRQT7OTC/NhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACHjaHxvKxnsCd6DA--.11657S2;
	Wed, 12 Feb 2025 23:23:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: idosch@nvidia.com,
	petrm@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()
Date: Wed, 12 Feb 2025 23:23:11 +0800
Message-ID: <20250212152311.1332-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjaHxvKxnsCd6DA--.11657S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18KFW3ZF1kJF1kXr4rAFb_yoW8Jw43pa
	18GFyDZFyqqFn5Xw4DXayrZFy5Ga42q3yjgr1xt343uw10yFWYyw17Kr9Ykr10krW8Zw1r
	tw47Zr95AFyDAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcLA2estaoQowAAsk

Add a check for the return value of mlxsw_sp_port_get_stats_raw()
in __mlxsw_sp_port_get_stats(). If mlxsw_sp_port_get_stats_raw()
returns an error, exit the function to prevent further processing
with potentially invalid data.

Fixes: 614d509aa1e7 ("mlxsw: Move ethtool_ops to spectrum_ethtool.c")
Cc: stable@vger.kernel.org # 5.9+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 2bed8c86b7cf..3f64cdbabfa3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -768,7 +768,9 @@ static void __mlxsw_sp_port_get_stats(struct net_device *dev,
 	err = mlxsw_sp_get_hw_stats_by_group(&hw_stats, &len, grp);
 	if (err)
 		return;
-	mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	err = mlxsw_sp_port_get_stats_raw(dev, grp, prio, ppcnt_pl);
+	if (err)
+		return;
 	for (i = 0; i < len; i++) {
 		data[data_index + i] = hw_stats[i].getter(ppcnt_pl);
 		if (!hw_stats[i].cells_bytes)
-- 
2.42.0.windows.2


