Return-Path: <stable+bounces-157590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB86AE54AF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C8D4459A8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414A1E22E6;
	Mon, 23 Jun 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scmonU4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D413FB1B;
	Mon, 23 Jun 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716240; cv=none; b=Gn4VGsh40F4c6ag72qnEu1vXZg1/v/6nmtyvrmCTfG4Z1NSqF+xxI4XEYBP/8VgUVyIitbxZKCNWW9KmdxWOEg8SQ2z08h9xpJa/OOAawvAgl0l60jhrPEv7H2jcE34Ysmm+YAi4sZIAXkuLS73qlVgAPEwjfnn+ykMM2pUN1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716240; c=relaxed/simple;
	bh=8FvWWBa9mSjcvWFyzazy9+BnBOsqB9JtczBkCXTtrA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNyvFJOmEqJL7pp+FTyCTAXYLR9E44hODLirY3cBmgL1egx6yMWQUEUJZCwbKZmO4BqUOKFAZXCLzaQbr1EZ4v/zjgZTPCO0E0ajqPPSJZADBDFhbVW7L0apaBeyKQJytCoFci/DV9aAwuf8Zx9xyJ+CIlQ42CpxN3sjq6qI+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scmonU4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CE8C4CEEA;
	Mon, 23 Jun 2025 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716240;
	bh=8FvWWBa9mSjcvWFyzazy9+BnBOsqB9JtczBkCXTtrA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scmonU4Pk2rAQgdNWMXdMYNEXvWTqkcxwfYloRBllK5KsjUH9Z2lvLreK+v34JBXA
	 iE4dnoj8rs+srRugkz/hPzWsIpZ2NltewjwhsBB6IB/T7HXZfOOojnmkXbThwiOmvI
	 i4/XTfFhUTVZeDeYiOXV9EiQ+118Gsqj+u6/AcVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 259/414] bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
Date: Mon, 23 Jun 2025 15:06:36 +0200
Message-ID: <20250623130648.513519518@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 5bccacb4cc32cb835fe2fe100a210332c494e81d ]

The "ref_count" field in struct bnxt_ulp is unused after
commit a43c26fa2e6c ("RDMA/bnxt_re: Remove the sriov config callback").
So we can just remove it now.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20250417172448.1206107-4-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 5 -----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 546d9a3d7efea..b33c29fdf8fd3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -148,7 +148,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	struct net_device *dev = edev->net;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_ulp *ulp;
-	int i = 0;
 
 	ulp = edev->ulp_tbl;
 	rtnl_lock();
@@ -164,10 +163,6 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 	synchronize_rcu();
 	ulp->max_async_event_id = 0;
 	ulp->async_events_bmap = NULL;
-	while (atomic_read(&ulp->ref_count) != 0 && i < 10) {
-		msleep(100);
-		i++;
-	}
 	mutex_unlock(&edev->en_dev_lock);
 	rtnl_unlock();
 	return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 4f4914f5c84c9..b76a231ca7dac 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -48,7 +48,6 @@ struct bnxt_ulp {
 	unsigned long	*async_events_bmap;
 	u16		max_async_event_id;
 	u16		msix_requested;
-	atomic_t	ref_count;
 };
 
 struct bnxt_en_dev {
-- 
2.39.5




