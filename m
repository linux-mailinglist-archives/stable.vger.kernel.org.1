Return-Path: <stable+bounces-24178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E397A869304
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1985F1C21BBA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E513B2B3;
	Tue, 27 Feb 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSYK8VP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECD2F2D;
	Tue, 27 Feb 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041253; cv=none; b=YmNDJ0iP4zq13B64tYZG8ON3hUBcbFddzV/ZNmtKOhDXrdv53QoEfHEZdukUh9rMz+3GvIGWKJWmNxLOBITyGtCuF/G0eAYZxnDutULkjbifWw9WBoh8N+MwvEnUYdI5G47xURxtqG4uwMiWPxdXt7Z3G9o9j9SS7Wsk7vFuSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041253; c=relaxed/simple;
	bh=c50q506tZm78FdsTfIUte+TC/72gAth8T8sl8rzDYXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZQ/crFkZf9e4BTF9dGhPBLhYvesOYWJwqh8p/r4p4aQYTfqZ7/XuxVjIemJHMe+VKFn7nFQNwwyDRPxrZn+9myJPhEOzTI7YwXpYuo4uEf8bsljVVGYaiwC3MJ4O04ClFMP0ssvpR6mqCY8/abzbBgbArsqky9k0RFJUgXL6bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSYK8VP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99064C433F1;
	Tue, 27 Feb 2024 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041253;
	bh=c50q506tZm78FdsTfIUte+TC/72gAth8T8sl8rzDYXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSYK8VP0ojd/V/bC2oBeZ5G/w5ZHNhjCny1BreAF7iw6UmCTNJO75FWX8l2k6OOf2
	 Pvk3koTXl3GFHRlLhACXGQVihXGU0EuI+n9ydeEK6/PYvTQlbBTadvT1vJ8Vd6+wvL
	 B8laTCXq52QxW4cIoAD1UIlpnr+mJWBOAKcpjPKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 272/334] net: bcmasp: Sanity check is off by one
Date: Tue, 27 Feb 2024 14:22:10 +0100
Message-ID: <20240227131639.767658110@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit f120e62e37f0af4c4cbe08e5a88ea60a6a17c858 ]

A sanity check for OOB write is off by one leading to a false positive
when the array is full.

Fixes: 9b90aca97f6d ("net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 29b04a274d077..80245c65cc904 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -535,9 +535,6 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 	int j = 0, i;
 
 	for (i = 0; i < NUM_NET_FILTERS; i++) {
-		if (j == *rule_cnt)
-			return -EMSGSIZE;
-
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -547,6 +544,9 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 		    priv->net_filters[i - 1].wake_filter)
 			continue;
 
+		if (j == *rule_cnt)
+			return -EMSGSIZE;
+
 		rule_locs[j++] = priv->net_filters[i].fs.location;
 	}
 
-- 
2.43.0




