Return-Path: <stable+bounces-220578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CfVGiQ/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7491C6C87
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CC5F3130BF5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80463DE152;
	Sat, 28 Feb 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHJyX7NT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3423DE14A;
	Sat, 28 Feb 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300460; cv=none; b=ASIxOtbE4qw2TwZNI8GVv2joeb2iJ9Z8MtB/ltiiwoagMawoU/NcPo8Rrd8mpsd+90gxAQkh3tYS3TmXainzLvGpuDmjuZsdZKX9Bc+Iq1dGSU3h9ejEPjIb2MuUzP/p6CX3SpZUD91tu+yK7pAPB4J1iXFd9/RLomZ4Xwp6hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300460; c=relaxed/simple;
	bh=dgFpN3XHNCBHH2zfZ7BwvQ0zx2JH/3/1eleSXZHaDG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJcOrp439JXfuNHPUIqi+vz08hPBwLrsfLMaKQcYiNggryWyVd/y6oSDA9n3vguMzQYYW4JCENkiz+6/T3VKt2F07hSIBOPEpc2IGIWrDK2tI1qIxvQvqyRHOOEqKmIKpJyASQViURluJUc0kYWcAy0gMTahlp/Vs6DmTwfbo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHJyX7NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7870EC19423;
	Sat, 28 Feb 2026 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300460;
	bh=dgFpN3XHNCBHH2zfZ7BwvQ0zx2JH/3/1eleSXZHaDG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHJyX7NT10sgMwUnA1ATZJNxx2SOyvMxCTK+85eb5VQJoTe4fgWNgyPLR7P4QMg2c
	 TvgHouxi0moDbThYnfAHtXo9Ytq42CTWRrEdyX1AfO5U2i18D4Cue9oeC/kbrjt8Hk
	 7kAqjlcAycP200xoYL4G+2np6uEyPWys4Gu4mTI0GwKAsde4nrVQVLl7ann3CvH/Hb
	 vv43kwgCmOY/7D9cDQrEjQwqeT60f+7XubgtG1R51x3cpRVmBIRV06/BfwkFP2om5Y
	 gL6SiqwCAcS4KOZ7K6tQjfnYDcWj+g6r/92AV2VE3NfeAtjW+gND//6Ov00Ermq7rI
	 NE5/ME5+Z7yHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 499/844] net/mlx5: Fix missing devlink lock in SRIOV enable error path
Date: Sat, 28 Feb 2026 12:26:52 -0500
Message-ID: <20260228173244.1509663-500-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220578-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: 8A7491C6C87
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 60253042c0b87b61596368489c44d12ba720d11c ]

The cited commit miss to add locking in the error path of
mlx5_sriov_enable(). When pci_enable_sriov() fails,
mlx5_device_disable_sriov() is called to clean up. This cleanup function
now expects to be called with the devlink instance lock held.

Add the missing devl_lock(devlink) and devl_unlock(devlink)

Fixes: 84a433a40d0e ("net/mlx5: Lock mlx5 devlink reload callbacks")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260224114652.1787431-5-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index a2fc937d54617..172862a70c70d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -193,7 +193,9 @@ static int mlx5_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	err = pci_enable_sriov(pdev, num_vfs);
 	if (err) {
 		mlx5_core_warn(dev, "pci_enable_sriov failed : %d\n", err);
+		devl_lock(devlink);
 		mlx5_device_disable_sriov(dev, num_vfs, true, true);
+		devl_unlock(devlink);
 	}
 	return err;
 }
-- 
2.51.0


