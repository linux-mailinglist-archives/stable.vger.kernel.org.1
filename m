Return-Path: <stable+bounces-122964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9CA5A240
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8484A3A6D0A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488C233D9C;
	Mon, 10 Mar 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9X/YEiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359122FF40;
	Mon, 10 Mar 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630650; cv=none; b=EwbZd1uYCRPc6VfnwRVjBfyRculT5UEMChuUAQ53u+MOfY+JUJ1qpcU/xMXnfSZcb02NQv7CpxVEUqH0YcbRHZ4YKBBzqRqrx0ztc8a5yDg+xcyN3Woto71lbJLNxi1aH4M7U9mU+RIVuikThR3vvppKvif4iWaUnfoQIcmVbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630650; c=relaxed/simple;
	bh=Z0lWxYdjlDQ+MTV2Oi1HozISabwqcCx6cSS9pkw4yBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ4ujiLkHUm2kVmJWAprW6ClH+RMYWlFftnvHCuwWwkipGp5a9ojdOU4aVHdqIzBFeY/8FsMiHH+YaEYYPdVBVQb99TzPkUwbx9xLtzfdQs+KTz4T3JpEgqLmYvCDTZJoSsS8XeYGcFw/TjupXs7AD3jX4Vu5wET1T4NEn3hA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9X/YEiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B0C4CEE5;
	Mon, 10 Mar 2025 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630649;
	bh=Z0lWxYdjlDQ+MTV2Oi1HozISabwqcCx6cSS9pkw4yBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9X/YEiZudL3c1uiudinbD1naRuDnlSsECSvSlKT+ZptXXvuY2bkynqy2LcC/Asg8
	 BIBzWQpQQA2d7pDEHr7tBqT104iaWQROHJcL9/kllWoRVc/h+T8gMSmPYAkDLylvZr
	 aSIfguhsk7ni9vS66h0+YmTcQIpVg+6swerg1oPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 456/620] batman-adv: Drop initialization of flexible ethtool_link_ksettings
Date: Mon, 10 Mar 2025 18:05:02 +0100
Message-ID: <20250310170603.583973150@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 813e62a6fe7539fdf0d8e018d4f157b57bdaeedd ]

The commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
flexible-array members") changed various structures from using 0-length
arrays to flexible arrays

  net/batman-adv/bat_v_elp.c: note: in included file:
  ./include/linux/ethtool.h:148:38: warning: nested flexible array
  net/batman-adv/bat_v_elp.c:128:9: warning: using sizeof on a flexible structure

In theory, this could be worked around by using {} as initializer for the
variable on the stack. But this variable doesn't has to be initialized at
all by the caller of __ethtool_get_link_ksettings - everything will be
initialized by the callee when no error occurs.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Stable-dep-of: 8c8ecc98f5c6 ("batman-adv: Drop unmanaged ELP metric worker")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 956c4e799a69c..9af40bbf45da9 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -141,7 +141,6 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	memset(&link_settings, 0, sizeof(link_settings));
 	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
 	rtnl_unlock();
-- 
2.39.5




