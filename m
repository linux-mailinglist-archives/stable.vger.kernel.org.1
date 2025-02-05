Return-Path: <stable+bounces-113413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D494A2920D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBE716B631
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345E18C039;
	Wed,  5 Feb 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MadPVGNV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311D1FCF6B;
	Wed,  5 Feb 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766876; cv=none; b=ZGIV4vpp2zOnirPXTzbFinrWEPcmZ4Oc1SQEB0h5BsoB4bOrt1WOGxcGBBsu8vHz/hH3p17/oKeTPXLAIbXO7GYqjDey98YmjBCzflTDD1sI3BeQrUZ2G5Y2AefsXkbBLc8sKzbMrhDrYD+JnVFoA1q+2xY/gy1uoTkw34etPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766876; c=relaxed/simple;
	bh=JAfbUtzsssDyYUbTA5QBEf4Dil4fsEa5zMM+l2G8aKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfTVYCk2F/BctAmUE8Bdsj73e1C/5g2HRSYVLZfTauRBfbC9EEzex7ZTtUDbwEAn+uv0ydO3uAdVmF20OGvWWBR3HBS71ot6W0Bl/4GiziTn6si5l/7ZOfXBJmf7wv3Rr1HbRhKJutLkyokTG7tTu2lA93WFsNnhPoTjn1qQSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MadPVGNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FBDC4CED1;
	Wed,  5 Feb 2025 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766875;
	bh=JAfbUtzsssDyYUbTA5QBEf4Dil4fsEa5zMM+l2G8aKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MadPVGNVnwkx47lKu6N12w1Pu2qAMcxelXPIMajKTbezElaVghSZ84Nliz5wKYMcI
	 VJ5Syx+qcF6gDxP2pmR+DjaM3pQ4VuDImQ7DwEG4Q9Wk7HPiPrmE8QCR2FBh1YJ7uo
	 ZzJnFzy5kZnwo7CJ8DpyY1QH0Zmn9x1ebT1W8Yqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Qu Zicheng <quzicheng@huawei.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 323/623] padata: fix UAF in padata_reorder
Date: Wed,  5 Feb 2025 14:41:05 +0100
Message-ID: <20250205134508.579956543@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit e01780ea4661172734118d2a5f41bc9720765668 ]

A bug was found when run ltp test:

BUG: KASAN: slab-use-after-free in padata_find_next+0x29/0x1a0
Read of size 4 at addr ffff88bbfe003524 by task kworker/u113:2/3039206

CPU: 0 PID: 3039206 Comm: kworker/u113:2 Kdump: loaded Not tainted 6.6.0+
Workqueue: pdecrypt_parallel padata_parallel_worker
Call Trace:
<TASK>
dump_stack_lvl+0x32/0x50
print_address_description.constprop.0+0x6b/0x3d0
print_report+0xdd/0x2c0
kasan_report+0xa5/0xd0
padata_find_next+0x29/0x1a0
padata_reorder+0x131/0x220
padata_parallel_worker+0x3d/0xc0
process_one_work+0x2ec/0x5a0

If 'mdelay(10)' is added before calling 'padata_find_next' in the
'padata_reorder' function, this issue could be reproduced easily with
ltp test (pcrypt_aead01).

This can be explained as bellow:

pcrypt_aead_encrypt
...
padata_do_parallel
refcount_inc(&pd->refcnt); // add refcnt
...
padata_do_serial
padata_reorder // pd
while (1) {
padata_find_next(pd, true); // using pd
queue_work_on
...
padata_serial_worker				crypto_del_alg
padata_put_pd_cnt // sub refcnt
						padata_free_shell
						padata_put_pd(ps->pd);
						// pd is freed
// loop again, but pd is freed
// call padata_find_next, UAF
}

In the padata_reorder function, when it loops in 'while', if the alg is
deleted, the refcnt may be decreased to 0 before entering
'padata_find_next', which leads to UAF.

As mentioned in [1], do_serial is supposed to be called with BHs disabled
and always happen under RCU protection, to address this issue, add
synchronize_rcu() in 'padata_free_shell' wait for all _do_serial calls
to finish.

[1] https://lore.kernel.org/all/20221028160401.cccypv4euxikusiq@parnassus.localdomain/
[2] https://lore.kernel.org/linux-kernel/jfjz5d7zwbytztackem7ibzalm5lnxldi2eofeiczqmqs2m7o6@fq426cwnjtkm/
Fixes: b128a3040935 ("padata: allocate workqueue internally")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Qu Zicheng <quzicheng@huawei.com>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/padata.c b/kernel/padata.c
index cf63d9bcf4822..98f9fbcf3b324 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1121,6 +1121,12 @@ void padata_free_shell(struct padata_shell *ps)
 	if (!ps)
 		return;
 
+	/*
+	 * Wait for all _do_serial calls to finish to avoid touching
+	 * freed pd's and ps's.
+	 */
+	synchronize_rcu();
+
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
 	pd = rcu_dereference_protected(ps->pd, 1);
-- 
2.39.5




