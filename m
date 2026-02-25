Return-Path: <stable+bounces-218727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EmaOttUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424B18FE12
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FCD31E20B9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7F26CE1A;
	Wed, 25 Feb 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fWtJTfT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D241E2834;
	Wed, 25 Feb 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983590; cv=none; b=OKpI5RAzrhneKTYyawxRKjxuLHYWePagZGCbT8H/oz2d87oGTQo5Zv+nKhaZpCTwZ/MhzUc2QY6ayQpHQW/YmvE9e+oBq/BJBqsMu07wcxNgG2b24a+K498BJc/cWe5TJ+e0srz7jrIpVfIYIIZwrfI29Ju9r+b+p1iUq+9vtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983590; c=relaxed/simple;
	bh=XD/1YlRpTuHqYx2AeLg/6ULRsKZRn9ll6uOuoaXRdUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnaK6IT1nknBsMYJrOBwHNj9PhiJme+N/RY+Ke9H1UBQojz25da6Oa2zCOaZ0rMmq4U0aV7n15z/x+nrAut1mNg+4djgcTKrfTjKAvc0kB0z2P/7tcVx1XQkobr9CSEGFNPjEYBg57vzBe7NHGZT6O89eDe7QQFs/0B8ZaVHni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWtJTfT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF4BC116D0;
	Wed, 25 Feb 2026 01:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983590;
	bh=XD/1YlRpTuHqYx2AeLg/6ULRsKZRn9ll6uOuoaXRdUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWtJTfT41sMNZjcGzIlap1xrPHT8pwQ1HfwjNa+zzG5MQqwrmQa4l9WWUSSLaCpe8
	 Vd7AX9JAWHV6PFYG/sL99vgtytsuRM6ox5Yr3R7kR2vJf3GZoXsZuyu18wLGspRPpr
	 PuYbaNuZ6X+64ojnvAzqD1d5KkYGeu6DN+IhGQAI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jacob Keller <Jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 688/781] net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event
Date: Tue, 24 Feb 2026 17:23:17 -0800
Message-ID: <20260225012416.642185789@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218727-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 7424B18FE12
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 9854b243ce4225328d0b32fdc998d35b6952d3f7 ]

The macsec_aso_set_arm_event function calls mlx5_aso_poll_cq once
without a retry loop. If the CQE is not immediately available after
posting the WQE, the function fails unnecessarily.

Use read_poll_timeout() to poll 3-10 usecs for CQE, consistent with
other ASO polling code paths in the driver.

Fixes: 739cfa34518e ("net/mlx5: Make ASO poll CQ usable in atomic context")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <Jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260218072904.1764634-5-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 641cd3a2cdfab..90b3bc5f9166f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1386,7 +1386,8 @@ static int macsec_aso_set_arm_event(struct mlx5_core_dev *mdev, struct mlx5e_mac
 			   MLX5_ACCESS_ASO_OPC_MOD_MACSEC);
 	macsec_aso_build_ctrl(aso, &aso_wqe->aso_ctrl, in);
 	mlx5_aso_post_wqe(maso, false, &aso_wqe->ctrl);
-	err = mlx5_aso_poll_cq(maso, false);
+	read_poll_timeout(mlx5_aso_poll_cq, err, !err, 10, 10 * USEC_PER_MSEC,
+			  false, maso, false);
 	mutex_unlock(&aso->aso_lock);
 
 	return err;
-- 
2.51.0




