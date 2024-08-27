Return-Path: <stable+bounces-71118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8BC9611B9
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28361B26B83
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFB11C68AE;
	Tue, 27 Aug 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKhWdpqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790F1C578D;
	Tue, 27 Aug 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772160; cv=none; b=stkDGFhMRCUIQfiAscW/Ohox3REcAOEUz9kgF5K2RAlgkuYjEkUSS+umlJVH5cWZONYcLZ7KDG7pnEHYyo2KgQN2iqj+uTavdGdkVq6UKFi7EGp8Va5WjVs2ug4XfujJ3OogRoGgPOygh5kPnvtOZsNDw0F9zowtCCDAK4opNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772160; c=relaxed/simple;
	bh=kuYb+fyMwVaF82Eo38rjH8W+MnQ5W/XW586vHYK+s4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKuDaO9chCCkJOcVgZhPLI0hAhDVu0TKpz1VKETW65Sae02DZrcn7aLcNz1utZHXkmnORv+FU8tKeGtsLJagiIFpjWi4YKjXJviPaM/il2rakvMIM/Vhm1m3f8ok5okjnvfL3bMvn0+p4qSvExsWXj9Vd5KNyIN2zgA/ar2LQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKhWdpqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847FEC61041;
	Tue, 27 Aug 2024 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772160;
	bh=kuYb+fyMwVaF82Eo38rjH8W+MnQ5W/XW586vHYK+s4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKhWdpqhe8sRrFaeL7n27YqThzx5QA43/PCcXUZlIehUMGYN0WdpXdSU3+rZnsj4z
	 jdXNCMZZWv/0VJ77UhA5EC9UIskJjBKhf+s0xuTGBEtHfAi/3eoFalqeYPZjrh14EM
	 93uq5QdLj/ixqaIdV+1tI/UcrpzHlnvkRCJevCL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengfeng Ye <dg573847474@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/321] staging: ks7010: disable bh on tx_dev_lock
Date: Tue, 27 Aug 2024 16:37:18 +0200
Message-ID: <20240827143843.193292294@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 058cbee52ccd7be77e373d31a4f14670cfd32018 ]

As &priv->tx_dev.tx_dev_lock is also acquired by xmit callback which
could be call from timer under softirq context, use spin_lock_bh()
on it to prevent potential deadlock.

hostif_sme_work()
--> hostif_sme_set_pmksa()
--> hostif_mib_set_request()
--> ks_wlan_hw_tx()
--> spin_lock(&priv->tx_dev.tx_dev_lock)

ks_wlan_start_xmit()
--> hostif_data_request()
--> ks_wlan_hw_tx()
--> spin_lock(&priv->tx_dev.tx_dev_lock)

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Link: https://lore.kernel.org/r/20230926161323.41928-1-dg573847474@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/ks7010/ks7010_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 9fb118e77a1f0..f1d44e4955fc6 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -395,9 +395,9 @@ int ks_wlan_hw_tx(struct ks_wlan_private *priv, void *p, unsigned long size,
 	priv->hostt.buff[priv->hostt.qtail] = le16_to_cpu(hdr->event);
 	priv->hostt.qtail = (priv->hostt.qtail + 1) % SME_EVENT_BUFF_SIZE;
 
-	spin_lock(&priv->tx_dev.tx_dev_lock);
+	spin_lock_bh(&priv->tx_dev.tx_dev_lock);
 	result = enqueue_txdev(priv, p, size, complete_handler, skb);
-	spin_unlock(&priv->tx_dev.tx_dev_lock);
+	spin_unlock_bh(&priv->tx_dev.tx_dev_lock);
 
 	if (txq_has_space(priv))
 		queue_delayed_work(priv->wq, &priv->rw_dwork, 0);
-- 
2.43.0




