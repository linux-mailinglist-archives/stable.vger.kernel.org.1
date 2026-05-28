Return-Path: <stable+bounces-255856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOZmOeClGGrClggAu9opvQ
	(envelope-from <stable+bounces-255856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B75F8D65
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAE49303F0D4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FF2F39B4;
	Thu, 28 May 2026 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J02MhGe+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25863DDC5;
	Thu, 28 May 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000069; cv=none; b=Q1wThb0TWb+B9QmlaDzVi/1du8LKysksL1yP2PPiRq4dP9W8Uw27ft/hwnX9Zs25Vc1uWKIdXYmoA4MbXJeYGEpDGQcTpMXubrMLsFArkrF49RfVUFeWjYwTZXk/d4qZpvJHHeiNcioNi7OSUcW1wDtYU8IUssuVbxjJJiY+vvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000069; c=relaxed/simple;
	bh=l4+HmCFfxrssU1lEkizEIPpgSfq0TGaSR3+gTglBhj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyR8XKqPY21eda7GLIc+6BxAUi0EX8b/b7IPEnCHSA0MAJ2MLTto7hPzd3f6dCqiR+donMp/JXjfJTNbKW7At2avtv8xmJ9aIJCvn00Vu0bmjnmxahNr4dWoCjg5ZhEqfReAbx22rcCsjl9V8SE0ylzORnLGwpzdxy0769Lbzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J02MhGe+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8905D1F000E9;
	Thu, 28 May 2026 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000068;
	bh=d/fLsJquHuA5T4kV13t/VEayAQJRRQ1puD17UC82M3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J02MhGe+3I2/C4uWOLErfyt5AaiwlNwS6AyZawYbE5WIqmayQIEhVsWVIUDu+Oohp
	 UOpyjdkdytDkT+0ySaqwrLODY+2qJz8d+erarMXaJV9yjczY5I9fz44Yc1csb23H4x
	 azE+nyRtvnNO2aJ0Xlh7csRkTx4iYaCCLMXYSAhw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeroen Massar <jmassar@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 291/377] net/mlx5: Do not restore destination-less TC rules
Date: Thu, 28 May 2026 21:48:49 +0200
Message-ID: <20260528194646.774083261@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255856-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EE1B75F8D65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeroen Massar <jmassar@nvidia.com>

[ Upstream commit 8d0a5af8b1ba598e7340761729801624e7a9330e ]

After IPsec policy/state TX rules are added, any TC flow rule, which
forwards packets to uplink, is modified to forward to IPsec TX tables.
As these tables are destroyed dynamically, whenever there is no
reference to them, the destinations of this kind of rules must be
restored to uplink, unless there is no destination for that rule.

The flow rules FLOW_ACTION_ACCEPT, DROP, TRAP, GOTO and SAMPLE do not
have a destination port, and thus out_count = 0.

At cleanup time of the rules in mlx5_esw_ipsec_modify_flow_dests
we call mlx5_eswitch_restore_ipsec_rule but as the above types
do not have a destination we get an underflow of out_count, as
the port is passed, which is esw_attr->out_count - 1.

This change avoids calling mlx5_eswitch_restore_ipsec_rule when
there are no output destinations and thus avoids the underflow.

Fixes: d1569537a837 ("net/mlx5e: Modify and restore TC rules for IPSec TX rules")
Signed-off-by: Jeroen Massar <jmassar@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260513063302.333761-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 3cfe743610d3f..ab50d2c734ede 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -142,7 +142,8 @@ static int mlx5_esw_ipsec_modify_flow_dests(struct mlx5_eswitch *esw,
 
 	attr = flow->attr;
 	esw_attr = attr->esw_attr;
-	if (esw_attr->out_count - esw_attr->split_count > 1)
+	if (!esw_attr->out_count ||
+	    esw_attr->out_count - esw_attr->split_count > 1)
 		return 0;
 
 	err = mlx5_eswitch_restore_ipsec_rule(esw, flow->rule[0], esw_attr,
-- 
2.53.0




