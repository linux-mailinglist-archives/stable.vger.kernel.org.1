Return-Path: <stable+bounces-213941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJANANxpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-213941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46618E9557
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B6A3128E42
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293D423167;
	Wed,  4 Feb 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="id7s7m37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D32C21F2;
	Wed,  4 Feb 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218028; cv=none; b=rd42/A2rpHdh2LB0azPsyFs1ujzbuELAzKYXABP6a4E/A4r7I8YwG1uLx6vXwkB3EmztgPE3gm2TpjzlTIANXfOBnhJ15k8fGhfGX8p+IlBEBCGaRx/B8XSU5648HKt5eyBiIk4TXglCNFpK2lLnCl8PP632cBG601Rept+D54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218028; c=relaxed/simple;
	bh=ywm7jc8MPBC7OdTEA9nZ6MrYHUfAfFo1FiQYwOuYTEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSuA115Et/hMsNuaouTrmyAM9mTHnebFn1ovpvvSi9F6Qwh9jiKcEY6wqrFnA+LqzhHu6OQArnQwTWJW+WnqyUBizfeN25dovffZOhgLsNs33VuwGm4YtWX8Of0ExI6pgwVvSBD6ZTL+AvVnO2ODj2Zu9pjTNu+0Ks9WwkWWKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=id7s7m37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C076C4CEF7;
	Wed,  4 Feb 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218028;
	bh=ywm7jc8MPBC7OdTEA9nZ6MrYHUfAfFo1FiQYwOuYTEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=id7s7m37h9RtYAwOmIko+v6U4Fah/SsM09Z99rU+6gMj+J7t6ZZ1JxPts9ktNTLgs
	 lQwOegU3ZRpDTKiRaWpi72wwiKoLly+SkOqn1taz1wB4SFAa9lir6hre1ue+3LewOM
	 RMJaiZfTVtsXzXOv2vIVYs/GVjjUXMCMD6MCU4NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 189/280] net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
Date: Wed,  4 Feb 2026 15:39:23 +0100
Message-ID: <20260204143916.411624930@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213941-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,seu.edu.cn:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46618E9557
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 108948f723b13874b7ebf6b3f1cc598a7de38622 ]

In esw_acl_ingress_lgcy_setup(), if esw_acl_table_create() fails,
the function returns directly without releasing the previously
created counter, leading to a memory leak.

Fix this by jumping to the out label instead of returning directly,
which aligns with the error handling logic of other paths in this
function.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 07bab9502641 ("net/mlx5: E-Switch, Refactor eswitch ingress acl codes")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260120134640.2717808-1-zilin@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
index 093ed86a0acd8..db51c500ed359 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
@@ -188,7 +188,7 @@ int esw_acl_ingress_lgcy_setup(struct mlx5_eswitch *esw,
 		if (IS_ERR(vport->ingress.acl)) {
 			err = PTR_ERR(vport->ingress.acl);
 			vport->ingress.acl = NULL;
-			return err;
+			goto out;
 		}
 
 		err = esw_acl_ingress_lgcy_groups_create(esw, vport);
-- 
2.51.0




