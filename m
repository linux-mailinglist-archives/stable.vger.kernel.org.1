Return-Path: <stable+bounces-36528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B070A89C03B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E341C20F4A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE4745C5;
	Mon,  8 Apr 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYfQ4St1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05192DF73;
	Mon,  8 Apr 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581588; cv=none; b=JCW0buP2Wkmk4OkeVw4cm0DJEv94QAMaMOMg2znl1TGp5Vv7K47rJhARquQrbCXBpCHazeqgnmYQebYW1uICiRacprf7Q3TDlFqagZs3l+zRO3AgAHrnFjh3VqDB+D9aKif6X7+PQQwYu3OPS8CauIq92XM8ogmUjrsjGzFJLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581588; c=relaxed/simple;
	bh=FyyKzLMVvZye/P5jRAvzl+FPEZM6WBIREHXb1UC4vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo9KTk5OCf5bnFehu68uCnvFWVmplTt+E1kDPFJKn+oa00xjG6beAz21O/FXfZLsvqwxuuhWajM93QONYcYbhwW9Ug3MZscQkH2e2RISLv+SgvVeyXQ356asfHzJ6JLZlq9yfGl3nTfyi2GKJ7laRMbxrtaw5GLTrUS+G7rCumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYfQ4St1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB6C433F1;
	Mon,  8 Apr 2024 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581588;
	bh=FyyKzLMVvZye/P5jRAvzl+FPEZM6WBIREHXb1UC4vp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYfQ4St1xQptJWVxgws2PwoLPtAaYn6Iiay5YSg/r4qPGcMuHWXdesarKtS73gYwd
	 JxUelxIR2Xqe0EjNKXi6H4w+ADPDOAZQJ6jvti9MZ8isTYZuDsRAjsIlAQBqToaMR6
	 oMj3Ro5RqoWjk4g/TqCvKsCcQIT+zVC8/nKfAn20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/252] net: hsr: hsr_slave: Fix the promiscuous mode in offload mode
Date: Mon,  8 Apr 2024 14:55:20 +0200
Message-ID: <20240408125307.310551327@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

[ Upstream commit b11c81731c810efe592e510bb0110e0db6877419 ]

commit e748d0fd66ab ("net: hsr: Disable promiscuous mode in
offload mode") disables promiscuous mode of slave devices
while creating an HSR interface. But while deleting the
HSR interface, it does not take care of it. It decreases the
promiscuous mode count, which eventually enables promiscuous
mode on the slave devices when creating HSR interface again.

Fix this by not decrementing the promiscuous mode count while
deleting the HSR interface when offload is enabled.

Fixes: e748d0fd66ab ("net: hsr: Disable promiscuous mode in offload mode")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240322100447.27615-1-r-gunasekaran@ti.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_slave.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index e5742f2a2d522..1b6457f357bdb 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -220,7 +220,8 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
-		dev_set_promiscuity(port->dev, -1);
+		if (!port->hsr->fwd_offloaded)
+			dev_set_promiscuity(port->dev, -1);
 		netdev_upper_dev_unlink(port->dev, master->dev);
 	}
 
-- 
2.43.0




