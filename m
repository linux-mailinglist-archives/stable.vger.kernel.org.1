Return-Path: <stable+bounces-143943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD98AB42D7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E260146600E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD229710B;
	Mon, 12 May 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQ7RJQBP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03892512F1;
	Mon, 12 May 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073369; cv=none; b=oy0pyeq6QipRJG93tbS5iz6M5CMmZBVbFTqSs4T7imQavx7x057dAj10nhNcsgjiDisY7QU0VFvwu4vYSOYsdChnPzQG3WjsOQWM1oCTzIR58Yr4mXXq0zzGeiEhF+4hQ4xdFSR1rR/ZbIylC12UYrMD5eIOaF2Wb23PZha7BSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073369; c=relaxed/simple;
	bh=QGYwIWt+lV7CStZyKmsokcf/Bi7yL0Us+MGPuYWn3l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt2Xy0G6IkN/tLGRtTOUDS8ohHRKHhovHlIIaT9XzjgJz0PFl38EpIUQ08hrfDWEBZERhfwKVM78khxkadgmWRQOm+RQgwGMBYsIQKgyenxS9jb6YIGsz/Vl7UvfNnSB2CngISk0yjmlKD3TFzKMSh//exmtHZPeDkRXt7th5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQ7RJQBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F5C4CEE7;
	Mon, 12 May 2025 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073368;
	bh=QGYwIWt+lV7CStZyKmsokcf/Bi7yL0Us+MGPuYWn3l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQ7RJQBPUbX8s5QZigt6owh1u69GM6hFGyYo5aos7lXLef4rQ8dUjePceG/o9RWrp
	 82lLW5Wp+IxQMNIVTR2RZzzEddlQFQm8VsQ9D0TXB45Ep6u3sLU/Eh1UGwaVPCxr6/
	 LhWNsbUU4LaUgR+BALaU8JEFS1Zkv+w4odXTgif4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/113] net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
Date: Mon, 12 May 2025 19:45:12 +0200
Message-ID: <20250512172028.625470509@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit a1c1901c5cc881425cc45992ab6c5418174e9e5a ]

The untagged default VLAN is added to the default vlan, which may be
one, but we modify the VLAN 0 entry on bridge leave.

Fix this to use the correct VLAN entry for the default pvid.

Fixes: fea83353177a ("net: dsa: b53: Fix default VLAN ID")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250429201710.330937-6-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 55893d4e405e8..b257757f0b9dc 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1967,7 +1967,7 @@ EXPORT_SYMBOL(b53_br_join);
 void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 {
 	struct b53_device *dev = ds->priv;
-	struct b53_vlan *vl = &dev->vlans[0];
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	unsigned int i;
 	u16 pvlan, reg, pvid;
@@ -1993,6 +1993,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
 	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
 
 	/* Make this port join all VLANs without VLAN entries */
 	if (is58xx(dev)) {
-- 
2.39.5




