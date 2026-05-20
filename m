Return-Path: <stable+bounces-250848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECHhLmj5DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-250848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AED59585C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51423222AC1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347103D3D1C;
	Wed, 20 May 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMRtGj7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C43A7850;
	Wed, 20 May 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296465; cv=none; b=BbFdHZRo4EUm7im7AvFVJqavUVv8np6Vmj2Ym+iTaIQscHfaQTyWUYIJtZ8g0dJ1rb3TNvjwSiDLycRBj9tY8kc3a1dJ0NT8IHag3crMmaMUuwJ52oGThqK6pdLp4RanV0aIutFMSGVyoR7Q5iPUjAUusCXrcw18Y0GR5wogr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296465; c=relaxed/simple;
	bh=pfIpexa8RoFO9inU/acA/s5qnDaKlktKZhKkPLQEy7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1+YsfqEn4Mb5MYWAguuVZ2fL/PvK00A/17PT7dwW+/pzLN2vo0tKNiFCvc+/86jCV3JHizfL2Se01CmcM5HVxlpFz40sbyy8FLDlHGWD3tS79tiwaiiDLgPwZbl6F2HWMpLOODTyXVpX1A3vKLO2I86jP2WdnMKDYZ/jIDl1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMRtGj7p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7EF1F000E9;
	Wed, 20 May 2026 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296463;
	bh=mexmh4jMGnGVHVz+kPu9AHgpNCIWpupx4dtWgw2wfCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMRtGj7pLJwYudA1JfzqJnaV++z5SY9U3UK+SIZlZgBUHbHyEwZmT4EuCA9v9Lg4b
	 EVi3YFpSGRuwzpYu92aOH8MivFYAmgYt+97cdVGPDnEdoWzIo5eDHUs2Qq91OcpJeW
	 Z4zgU/DGWJTpxhgphEdBbncSTPkIC/+0KuNwtuL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0808/1146] net/mlx5: Fix HCA caps leak on notifier init failure
Date: Wed, 20 May 2026 18:17:38 +0200
Message-ID: <20260520162206.510385722@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-250848-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: 38AED59585C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

[ Upstream commit d03fc81a57956248383efec99967d0ae627390a8 ]

mlx5_mdev_init() allocates HCA caps via mlx5_hca_caps_alloc() before
calling mlx5_notifiers_init(). If notifier initialization fails, the
error path jumps to err_hca_caps and skips mlx5_hca_caps_free(), leaking
allocated caps.

Add a dedicated unwind label for notifier-init failure that frees HCA
caps before continuing the existing cleanup sequence.

Fixes: b6b03097f982 ("net/mlx5: Initialize events outside devlink lock")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260415005022.34764-1-prathameshdeshpande7@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 3f73d9b1115dd..fab80c79ff071 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1907,7 +1907,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	err = mlx5_notifiers_init(dev);
 	if (err)
-		goto err_hca_caps;
+		goto err_notifiers_init;
 
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
@@ -1923,6 +1923,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	return 0;
 
+err_notifiers_init:
+	mlx5_hca_caps_free(dev);
 err_hca_caps:
 	mlx5_adev_cleanup(dev);
 err_adev_init:
-- 
2.53.0




