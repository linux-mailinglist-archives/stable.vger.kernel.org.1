Return-Path: <stable+bounces-173958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C12B3609B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F851BA7C4B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33D207DF3;
	Tue, 26 Aug 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhleI0du"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08B1C860B;
	Tue, 26 Aug 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213114; cv=none; b=pv9qY95dN1wBbNvNx5eczijHL8qv3TAS7Zq8hPJEJMXQO1CV+XfKjJONozI53RzV2LeYvK1KKJyb9dyGnCfeDa4xE+6jmm7Xpvs6cyYwJ3KKSdGJZFlpASvnMyXr+AfOx7+dp0DrvHOweWT50FPclDPgYWZlnnVkZdZSyM9k68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213114; c=relaxed/simple;
	bh=PPjkU87hZLjRwWeHVAilZ1R0A6qBK7ONcu9UgMxEDO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgAlhZMnpMvjWPgde7FZJqyiMvY807PS45UrIxpUgaOcSO0SD3poJgWfONeCRJ+cpAVddkt02wI8modCwwocTUratWSxTvLnBUN9XHBaGvukKPqL0TqpOMpn9EqUx7jPdUIgmNRFB7fwdLbVDBTfz9VKFprZYe9LfgQVhf3UQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhleI0du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EAC4CEF1;
	Tue, 26 Aug 2025 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213113;
	bh=PPjkU87hZLjRwWeHVAilZ1R0A6qBK7ONcu9UgMxEDO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhleI0durj+U2WR+3uyR5rUjzvRfSMuZxHz2D7C1mHz3c/moaLaYlytT1QS7jjUOk
	 xhO42ZHsDfhEY2I1ykJEXRU/GxN4U28vZ71MF8pgNRLDsKMHX77TEmP3fVRj6/ehrn
	 hNdfYgH864SO0hcKJMDXyi7iKvqsTAj4kl68xKHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Lazar <alazar@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 195/587] net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
Date: Tue, 26 Aug 2025 13:05:44 +0200
Message-ID: <20250826110957.901005909@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 60a8b1a5d0824afda869f18dc0ecfe72f8dfda42 ]

When CONFIG_VLAN_8021Q=n, a set of stub helpers are used, three of these
helpers use BUG() unconditionally.

This code should not be reached, as callers of these functions should
always check for is_vlan_dev() first, but the usage of BUG() is not
recommended, replace it with WARN_ON() instead.

Reviewed-by: Alex Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Link: https://patch.msgid.link/20250616132626.1749331-3-gal@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_vlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index a6b46f0eab16..272d9ad73960 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -258,19 +258,19 @@ vlan_for_each(struct net_device *dev,
 
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
 static inline u16 vlan_dev_vlan_id(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
 static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
-- 
2.39.5




