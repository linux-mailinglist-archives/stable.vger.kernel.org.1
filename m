Return-Path: <stable+bounces-252640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBDyBb38DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E28596217
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A99D230DA666
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65573F23C5;
	Wed, 20 May 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J6m9cDcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF533BE64B;
	Wed, 20 May 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301205; cv=none; b=rnHbyvIQthz5aBF5hUWgsv5jVPHY+FWncXlnQaxRJTICAmI70AaqyHAkt8KY0C3NfTcAj2QtDlgPM3hP5ewzj8s+QEeQ1w4rS8Hh+PXyNkNmht0cUWjOkNaNIwe7f6fdo75gtDjGLux+scV3Oz/Neaz9e0sJO2Uu3Y2maPTpWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301205; c=relaxed/simple;
	bh=xLlLhVIuq9/gqK3NDX2MxxYu4IUS6t6SHxA/zWD9X1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQXqomcOirmOOmimAMEzrisCt2HyzR4DG5keaC8m46OOFdqPED/sWqC4SIEJDaTTnMSR63c6qyUe+Mn49Gh4EtBiDXA1HUk7RS51LiVnkkTWM8GSFzvzz4tGrkxzvlLpU7JSExay9go3Ur2dGgjuiBMy/Sag6SmCAn//+5bCosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J6m9cDcL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52731F000E9;
	Wed, 20 May 2026 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301204;
	bh=eNJviFvtODDaIDmER1M2mazwKWG6v4JyZdmdyuL2T/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J6m9cDcLINhmGNT74Ft83FgKX6COGQAUWZW4XJAk7L1r6dUCMnV3+hRYjPDqxdvxr
	 /tfP3JPIXwfWD/nZ6HisEl4uohJCUbBxQ//XKp1gKYXko2GiprHGOUQrFyXT6Xb0DW
	 3BVWL26RGnZnUwRH6CK6X14rrmhNhYGZtr5AYMU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 465/666] net/mlx5: Fix HCA caps leak on notifier init failure
Date: Wed, 20 May 2026 18:21:16 +0200
Message-ID: <20260520162121.347627300@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-252640-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A7E28596217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 8856949fbe6a4..4d8295249c427 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1885,7 +1885,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	err = mlx5_notifiers_init(dev);
 	if (err)
-		goto err_hca_caps;
+		goto err_notifiers_init;
 
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
@@ -1901,6 +1901,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	return 0;
 
+err_notifiers_init:
+	mlx5_hca_caps_free(dev);
 err_hca_caps:
 	mlx5_adev_cleanup(dev);
 err_adev_init:
-- 
2.53.0




