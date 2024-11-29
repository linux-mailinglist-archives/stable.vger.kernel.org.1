Return-Path: <stable+bounces-94322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403D9D3BFC
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C0A286245
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F41AB6E6;
	Wed, 20 Nov 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfz/0xh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E61DFEF;
	Wed, 20 Nov 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107667; cv=none; b=BfPi22rbn01B2/KS/nmtlui0voPiDyvqM6Mr3AqlUiJ1EL8rA50VAXbJ/Liw2IwCBIJ1yb6lol/dnAyd9DpJM/+7zNLr/c7yp3vaCqWw/uHk3g1FAfxllaX24Sp/Cn90mlg1OETf5a3MCh5v7HZ2rLWHG3iTvZjnTVoP/FO2wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107667; c=relaxed/simple;
	bh=Q82vM47DKIGPKnKOP4YYVYRBkT6gYVcGZBZnafefuhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb9e7n0U+X1anGGkapjaO62QjpSIl8MbaSsolN2CWQDDFIMACZ8X8r4CVg9S2XnpkEaYThrLahy1smvcAOBhf8logR1wHZeTpubk14FpUv7D/8ZnN6AgY691LsSR7+6ygT79ylbGH0L0WjtEPCDi0xGUdueDKkKCXyGTi7+pmHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfz/0xh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8DBC4CECD;
	Wed, 20 Nov 2024 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107667;
	bh=Q82vM47DKIGPKnKOP4YYVYRBkT6gYVcGZBZnafefuhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfz/0xh9hQO9YLnosplby7Ew2ffYixm6i+dSTRb59LuHN8sEXbXH2XTAgZTy8kgv1
	 VO2pDoVwk5X83rVHCJfmHFeAERIQLIrqBfceE+o3aMjB0s2VU6OwfParHHsdvYQ9s+
	 Js6sYLvLSoD2Kb8K2J8voMO4BpfqcId5pBlyry/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moshe Shemesh <moshe@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 07/73] net/mlx5e: CT: Fix null-ptr-deref in add rule err flow
Date: Wed, 20 Nov 2024 13:57:53 +0100
Message-ID: <20241120125809.804395940@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit e99c6873229fe0482e7ceb7d5600e32d623ed9d9 ]

In error flow of mlx5_tc_ct_entry_add_rule(), in case ct_rule_add()
callback returns error, zone_rule->attr is used uninitiated. Fix it to
use attr which has the needed pointer value.

Kernel log:
 BUG: kernel NULL pointer dereference, address: 0000000000000110
 RIP: 0010:mlx5_tc_ct_entry_add_rule+0x2b1/0x2f0 [mlx5_core]
…
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x150/0x3e0
  ? exc_page_fault+0x74/0x140
  ? asm_exc_page_fault+0x22/0x30
  ? mlx5_tc_ct_entry_add_rule+0x2b1/0x2f0 [mlx5_core]
  ? mlx5_tc_ct_entry_add_rule+0x1d5/0x2f0 [mlx5_core]
  mlx5_tc_ct_block_flow_offload+0xc6a/0xf90 [mlx5_core]
  ? nf_flow_offload_tuple+0xd8/0x190 [nf_flow_table]
  nf_flow_offload_tuple+0xd8/0x190 [nf_flow_table]
  flow_offload_work_handler+0x142/0x320 [nf_flow_table]
  ? finish_task_switch.isra.0+0x15b/0x2b0
  process_one_work+0x16c/0x320
  worker_thread+0x28c/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xb8/0xf0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2d/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fixes: 7fac5c2eced3 ("net/mlx5: CT: Avoid reusing modify header context for natted entries")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20241107183527.676877-7-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index f01f7dfdbcf88..b011e0d2b620e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -862,7 +862,7 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 	return 0;
 
 err_rule:
-	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, zone_rule->attr, zone_rule->mh);
+	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, attr, zone_rule->mh);
 	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
 err_mod_hdr:
 	kfree(attr);
-- 
2.43.0




