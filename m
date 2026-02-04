Return-Path: <stable+bounces-214208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDMWKmlog2kymgMAu9opvQ
	(envelope-from <stable+bounces-214208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:40:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB67E9196
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E07FD3253523
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67648413254;
	Wed,  4 Feb 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yh9rEVhx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A027702D;
	Wed,  4 Feb 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218925; cv=none; b=ZdZASDKHdm/6cXGMpCHiT5A9Vxgjp5NKVi1NPw5B2Fm+5P5aQd2ibwVdDILsLdiurx8jfTMByj86n6x3dwRFPUMaBxrdWnG28AIugNgQWAqwqZuNZ1iMNHHlY+zMB48gFaO4aB3hWRMaALBtI8nPU1ZRAiV4er3iCgoAWpImYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218925; c=relaxed/simple;
	bh=3ZbChxvd7dbHWmutl5x3zZ7lXWdoImOyu/FpKxI2ElA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4zRS5UmjcuCIZTtzMiyfsA61I0dC+vFf3HTL+EfoNuL7u3u5amigmjZTA+oKhUXqNFwlIP3ZpvQW1Amgkw0oIh1/zZWoreWKfIkfMNkxzdDacFT2+EJJJuP9Y/JYl6BYXenZRZxEu6XU4YqzSq3Lsld0iO86/dH2somM1HchLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yh9rEVhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F7C4CEF7;
	Wed,  4 Feb 2026 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218925;
	bh=3ZbChxvd7dbHWmutl5x3zZ7lXWdoImOyu/FpKxI2ElA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yh9rEVhxeH6Dzyu7IDblgtu/44w2MSbJNTf49aP0jPuch1GH/AagFecISJ0QnL533
	 x+XdZ4vyUXI2lOUByesyqhpL3OB2my0VqSVWcu6JZCLlYWsUHoKc5vrzGbyjwsorZL
	 g7NAGbMheBco7FV2kgiSVefj5iyHIju5N/K/uX0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Parav Pandit <parav@nvidia.com>,
	Zeng Chi <zengchi@kylinos.cn>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 015/122] net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()
Date: Wed,  4 Feb 2026 15:39:57 +0100
Message-ID: <20260204143852.415615798@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214208-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 1CB67E9196
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zeng Chi <zengchi@kylinos.cn>

[ Upstream commit ca12c4a155ebf84e9ef29b05ce979bc89364290f ]

The function mlx5_esw_vport_vhca_id() is declared to return bool,
but returns -EOPNOTSUPP (-45), which is an int error code. This
causes a signedness bug as reported by smatch.

This patch fixes this smatch report:
drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
warn: signedness bug returning '(-45)'

Fixes: 1baf30426553 ("net/mlx5: E-Switch, Set/Query hca cap via vhca id")
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260123085749.1401969-1-zeng_chi911@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 16eb99aba2a7e..2d91f77b01601 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -1002,7 +1002,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
 static inline bool
 mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 {
-	return -EOPNOTSUPP;
+	return false;
 }
 
 #endif /* CONFIG_MLX5_ESWITCH */
-- 
2.51.0




