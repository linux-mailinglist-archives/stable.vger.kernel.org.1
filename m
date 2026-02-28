Return-Path: <stable+bounces-220565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPU8M8Q+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D71C6BF0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A651B33DF61A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB63DB4C8;
	Sat, 28 Feb 2026 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvC2q0o5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2248A2A8;
	Sat, 28 Feb 2026 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300446; cv=none; b=qSdmSsBEsRI2eFwN0O4pydKgfV6nvtUMg4OlkjH1vtipFNvWL1exwDZTqGPaP4cSgZAxPLyIeGh8Ik7/VTD9InNr8RFonWT/TApiBqGBW7GoarSlF0b17FAfSB0IwfwuLorcM7h6NlisPgzEhycfxz8JVJIGhjqQe5DRn4ECPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300446; c=relaxed/simple;
	bh=yH2Z9AcWUq5d8W1YQjCN4M2P2vtr+m3C/YvoCnfwbgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyZqSKxJycJyRn2Tp+ovDruqz0JY3azi36/C+dJbp13bdd7Xosppuk+tQcL8rrnWHdf/X6ZN2mJatAwWdY/L+DEF9fQnDItDJd9fSrPIrY+q/LSfBe0pxqyrt7p6we1yYCl5I6Q2slFL1u97UPKVc7fTbB1w4hGANy/L0Rfaw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvC2q0o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FDAC19425;
	Sat, 28 Feb 2026 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300446;
	bh=yH2Z9AcWUq5d8W1YQjCN4M2P2vtr+m3C/YvoCnfwbgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvC2q0o5Yet7GDChn8tVvCMOwQZ628MdD2ATCdZoUesjDY9b6exUjBURBA4BBdeDW
	 fG6Aye0hifINY+YY4Su7JOgT0j6gwm/HvsJUxxyBuIMaq/J5mrGlmKNlnyLMNNibyX
	 3qYz8VAthkA/xPi+fNgd3G5rukx+/kt6r6tAMKzcu1vUhTwW2FNM1EuKjiShl6XbxR
	 7HBxo5+sjQ4OBBJ0qvge2iXlgZgqnbpdTAiaUysw4qTBW59+0ogVK+y7+J/2oE4zwT
	 MIeSzSj8pIfS4JjhNg0z8AIwcTpzyOUuDQHcp8/z6tDNMf1TA+Xa8quFLpz5BTDxA6
	 TcchNOxXnN5ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 486/844] RDMA/ionic: Fix potential NULL pointer dereference in ionic_query_port
Date: Sat, 28 Feb 2026 12:26:39 -0500
Message-ID: <20260228173244.1509663-487-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220565-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5F3D71C6BF0
X-Rspamd-Action: no action

From: Kamal Heib <kheib@redhat.com>

[ Upstream commit fd80bd7105f88189f47d465ca8cb7d115570de30 ]

The function ionic_query_port() calls ib_device_get_netdev() without
checking the return value which could lead to NULL pointer dereference,
Fix it by checking the return value and return -ENODEV if the 'ndev' is
NULL.

Fixes: 2075bbe8ef03 ("RDMA/ionic: Register device ops for miscellaneous functionality")
Signed-off-by: Kamal Heib <kheib@redhat.com>
Link: https://patch.msgid.link/20260220222125.16973-2-kheib@redhat.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 164046d00e5d4..bd4c73e530d08 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -81,6 +81,8 @@ static int ionic_query_port(struct ib_device *ibdev, u32 port,
 		return -EINVAL;
 
 	ndev = ib_device_get_netdev(ibdev, port);
+	if (!ndev)
+		return -ENODEV;
 
 	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
 		attr->state = IB_PORT_ACTIVE;
-- 
2.51.0


