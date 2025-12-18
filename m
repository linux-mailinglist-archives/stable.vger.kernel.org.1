Return-Path: <stable+bounces-203006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D34CCC8F7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367AC301A9AC
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D353D35295B;
	Thu, 18 Dec 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szOBLTTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852B352955
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072269; cv=none; b=cKNTCouRzkovIyIriu0PZ5XySFfXOKJ2MLWjnv9ldOZbIceMBDIrJ9czkz5pRkW3s2Fiii7VNfDBFm7u+FLqnheoml94l2ceoHhsOXNbrduZpPPMG5ot90DDQA2kD8eK6amXob7v7tb0YcMddgCeHGiVcRS2a7Hy2VT/PfesuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072269; c=relaxed/simple;
	bh=R3fXwdr0A1Zs+QfZJ36SAZALrBl+SyZmZZHeXt6CsVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe6CyElIFADZSSIdfuu/ym6iuJkIchl8dWDnO4hJpB3reNq3qB5nmZktiC9PFMJSxJi6rmGwil8Cd1YDS5lomUtYJ8ssXWPNSwcSF2x/vHX0ceAe6wIneS1QCebl+3sNrVFCEpgP+EemJz9eYml2d2lmrEGuoF7M/z8PzgKSLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szOBLTTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9868CC4CEFB;
	Thu, 18 Dec 2025 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072269;
	bh=R3fXwdr0A1Zs+QfZJ36SAZALrBl+SyZmZZHeXt6CsVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szOBLTTlSqPO/UqOyGyJXV1HmeCdcxI68uN6BEbQmwRsShQxLKleolGmXGCg12CST
	 MQ25cDCk1cwA5ZN+8vnozzbT9bmnqJEJwG0myn7eLcds2oIRZ7E1lH4sI4WhqGtcPY
	 GKFMd3gE8rHd3Cq4BjlFd5OHXKsw/bapzB5/qVPP6aplxFVjYxBsUWFq1+xcpUlInY
	 NOCeeMusUQvXhWbf090LIuKfGJu5DuQWdNp6Ffv3PO7IUUJcoeJ3nQ2XnbU4kmRmFR
	 F5nM/PHHB2MD8Asa1n6AvwHXgVTQ47VyeozOY5TdWYUQIc/2slT4XQjB9BT26yAOxM
	 iNwrZlMhDrDPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hsr: hold rcu and dev lock for hsr_get_port_ndev
Date: Thu, 18 Dec 2025 10:37:36 -0500
Message-ID: <20251218153736.3435271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121829-aloof-cresting-f057@gregkh>
References: <2025121829-aloof-cresting-f057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 847748fc66d08a89135a74e29362a66ba4e3ab15 ]

hsr_get_port_ndev calls hsr_for_each_port, which need to hold rcu lock.
On the other hand, before return the port device, we need to hold the
device reference to avoid UaF in the caller function.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 9c10dd8eed74 ("net: hsr: Create and export hsr_get_port_ndev()")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250905091533.377443-4-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Drop multicast filtering changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 386aba50930a3..acbd77ce6afce 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -682,9 +682,14 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 	struct hsr_priv *hsr = netdev_priv(ndev);
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			dev_hold(port->dev);
+			rcu_read_unlock();
 			return port->dev;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
-- 
2.51.0


