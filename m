Return-Path: <stable+bounces-218724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF4BK9RUnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E718FDEE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 790EB3101820
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA0263C7F;
	Wed, 25 Feb 2026 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkwUXgHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7F26E6F4;
	Wed, 25 Feb 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983587; cv=none; b=HeupnIOYFjcCCyxLnSbsmsocjaEbCjYh0kv4JE8SxOKB9kIfC/vIK3lolZuhDpCRItF5L99KRLwJ3KDhZjsiuh7fIlzar0VC/wfB26NZ6jzqgmKkyBX8w+At3i3WfpDd2B/cvJpmW91pn6vKt3zehHHxwjZ42GMp1ABQaxpdpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983587; c=relaxed/simple;
	bh=CyltqcXjIMiIfskTzjmrf8IY8W8EddvQUUNE8QfW9rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJSnY3vHn/+60+9SOiDo3lrfiypvxh2uGHmv2pNLzrP7BlJZgOn+uvgrmIcU6t/uIdHoDrd4jjWZLoBQRxm1XCUEpMaL7AcwJDPsk3K5dkUWt8VKRTALk6cIv0rR22fqgQeMsWDNm8Iac4gfoOXILh8rOtn8Moe1jcoAKoV7VL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkwUXgHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97470C116D0;
	Wed, 25 Feb 2026 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983586;
	bh=CyltqcXjIMiIfskTzjmrf8IY8W8EddvQUUNE8QfW9rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkwUXgHhbIb5wff+yD3cwmz+Q5HzcF5ta99SJ8/8Xp25inyRQRr/bukFzVRmP0yq2
	 7jIfp465uSHolWdww/0YqIGTFusH4OXcp7B2NXiefk8EFPJNEcw7FT+7qT9846cz87
	 NfVcZFApPyNXr+AmzRxbrMdGLmZSKxhOeE39KNaE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jacob Keller <Jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 685/781] net/mlx5: Fix multiport device check over light SFs
Date: Tue, 24 Feb 2026 17:23:14 -0800
Message-ID: <20260225012416.574909661@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218724-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 323E718FDEE
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 47bf2e813817159f4d195be83a9b5a640ee6baec ]

Driver is using num_vhca_ports capability to distinguish between
multiport master device and multiport slave device. num_vhca_ports is a
capability the driver sets according to the MAX num_vhca_ports
capability reported by FW. On the other hand, light SFs doesn't set the
above capbility.

This leads to wrong results whenever light SFs is checking whether he is
a multiport master or slave.

Therefore, use the MAX capability to distinguish between master and
slave devices.

Fixes: e71383fb9cd1 ("net/mlx5: Light probe local SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <Jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260218072904.1764634-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mlx5/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c54aa6f74fbc..1967d1c79139b 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1281,12 +1281,12 @@ static inline bool mlx5_rl_is_supported(struct mlx5_core_dev *dev)
 static inline int mlx5_core_is_mp_slave(struct mlx5_core_dev *dev)
 {
 	return MLX5_CAP_GEN(dev, affiliate_nic_vport_criteria) &&
-	       MLX5_CAP_GEN(dev, num_vhca_ports) <= 1;
+	       MLX5_CAP_GEN_MAX(dev, num_vhca_ports) <= 1;
 }
 
 static inline int mlx5_core_is_mp_master(struct mlx5_core_dev *dev)
 {
-	return MLX5_CAP_GEN(dev, num_vhca_ports) > 1;
+	return MLX5_CAP_GEN_MAX(dev, num_vhca_ports) > 1;
 }
 
 static inline int mlx5_core_mp_enabled(struct mlx5_core_dev *dev)
-- 
2.51.0




