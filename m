Return-Path: <stable+bounces-214046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MPzDAJpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F767E9324
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8685A30E6D70
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E112D593E;
	Wed,  4 Feb 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2diM6+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23529993F;
	Wed,  4 Feb 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218380; cv=none; b=tejChqO+IhqWQT+vigXAsxwNJzQMwrPEpLkWivnCy9YJqjndoTM75hUAhWF3cS/yQYwL++K8f9/WBR03dOqC+5kEr3rP5WxBFOVQKgretAGoJeHxceLTWtKTzOu7RqY6YNylV8+R/cYjMjQwW3SBeonCcFRAr7clkKqBfL6wlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218380; c=relaxed/simple;
	bh=BaTNUOnM1ukr2lfLTwya4RELFm6sqwucgez0azHTjcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zsh3y9W2qPlX085Jz7WBCB9mVa3D14/eJiBHhriRoxLasNVoAymQC8+NT/1l8a0ueNF4XxHkrJLROEsnvBf7/0MHX37j455oQiA7FqPUHq2KVo0YpuvdGKoS34+7zDit+D0Htsb4CWBt/jLoKx+h2I4cD6yYjGmXYpzWvmOyRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2diM6+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53749C116C6;
	Wed,  4 Feb 2026 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218380;
	bh=BaTNUOnM1ukr2lfLTwya4RELFm6sqwucgez0azHTjcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2diM6+Y2pHzhQi1uz2uymNTqhVujEQ64S4f1hZjnuAkBpiFtZXG5AZ9WAyktlXid
	 BsaMPQx8zYJeDzWOadoabcyWFGxhOlcf/8wC2lXw/oh9ll1GLROR611zy5ao1HJBLz
	 61suA/qQbvtBS2ylV3nK/vg4M9SZvzNQBo1/wllg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 14/72] net/mlx5e: Report rx_discards_phy via rx_dropped
Date: Wed,  4 Feb 2026 15:40:17 +0100
Message-ID: <20260204143846.134096846@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
User-Agent: quilt/0.69
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-214046-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4F767E9324
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit c9cfced17365b1df8c6ae6cd5db56aebd7ed9b57 ]

We noticed a high number of rx_discards_phy events on certain servers while
running `ethtool -S`. However, this critical counter is not currently
included in the standard /proc/net/dev statistics file, making it difficult
to monitor effectively—especially given the diversity of vendors across a
large fleet of servers.

Let's report it via the standard rx_dropped metric.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20241210022706.6665-1-laoar.shao@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 476681f10cc1 ("net/mlx5e: Account for netdev stats in ndo_get_stats64")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 03201bcda1a68..c72c085be603c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3760,6 +3760,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	}
 
 	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_dropped = PPORT_2863_GET(pstats, if_in_discards);
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
-- 
2.51.0




