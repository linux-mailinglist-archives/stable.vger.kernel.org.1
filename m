Return-Path: <stable+bounces-182797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB5BADDBF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E071945D1D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FF1DF73C;
	Tue, 30 Sep 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vNq9zWjE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49A1F3FED;
	Tue, 30 Sep 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246119; cv=none; b=jwYwAyoubiYR5DrIJUNRQqL+i3qFFcNAetgtU54XH/fuqHdB0Hek8aBXSNHp5fu64wj8THnUJev96zybaDPu/dnZDLq27DPq4ooEyGFjm1n8QCuwIAEBswTcwiGXbkWwhIXVj41EZK3KJkE8pxUsE9W5lvFio/ZMvl8wFKERePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246119; c=relaxed/simple;
	bh=fwNtvg+ZdkdGag4PdBk8aQtzwoO1+igLqBiyqxtP8zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmGpfZ1xY+ApsYel7M0B1jC7lr8/h0d10LQj6LyWARB/x2mQs3LrMnUSm8C4QeVBzbavvi4+C7J9hqMVp3wlGLM1o0ErvQlsisZuBV5Tt/dcw2Ib3thhJm6FkFaAQ03KCt/co/A2hWw2sVhZUdOOmyglc/5GMK0hcFOGiehRIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vNq9zWjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBF5C4CEF0;
	Tue, 30 Sep 2025 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246119;
	bh=fwNtvg+ZdkdGag4PdBk8aQtzwoO1+igLqBiyqxtP8zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNq9zWjEIaba8tLbPH0NAjUcOQ2pLz0r0t4nAsR6dR0j7qF1JDVHFlakq4vG/ePRy
	 RRcHTW6FpeUENCsZWI59cdDN5nYl1JtaqB0IGFNXDklTsDzhyk4stfZPLXgQJ5fQlE
	 we3b/7+UmDjcOz7Ek6uoYnMJFNN3ZORIzEO3EZnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 57/89] octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()
Date: Tue, 30 Sep 2025 16:48:11 +0200
Message-ID: <20250930143824.280463339@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit d9c70e93ec5988ab07ad2a92d9f9d12867f02c56 ]

This code calls kfree_rcu(new_node, rcu) and then dereferences "new_node"
and then dereferences it on the next line.  Two lines later, we take
a mutex so I don't think this is an RCU safe region.  Re-order it to do
the dereferences before queuing up the free.

Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://patch.msgid.link/aNKCL1jKwK8GRJHh@stanley.mountain
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index e63cc1eb6d891..ed041c3f714f2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1319,7 +1319,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1339,6 +1338,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
-- 
2.51.0




