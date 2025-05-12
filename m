Return-Path: <stable+bounces-143941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D497AB42D6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31404625E6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A169299943;
	Mon, 12 May 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uoJcL7Zj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55F2517B1;
	Mon, 12 May 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073362; cv=none; b=qC0sHMY5AYbudQxlz8YYJrSZGaE/2du07RAMK8R1BWFWeDbeFQBQMWIsDNyq1oKEoxRkI1VDtwgg68MAiwtqx54ahT8UxFLCIKqQX9O/X8rlHedrtvyaUb3mYZcD3vYVHJV1cX7lnIWDSVxHnqmyrtBvYEfSE62FMV+EXUuC4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073362; c=relaxed/simple;
	bh=xYmfzR01N82RY3+otBbteamu/r9V02seIA5Sdi/XQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekurtOIrj1BW2sYOrKRsbZlQO6KfdlzgUkmTAKBiTKF+NqfLWYEJPxpy42ctE+gJHG1Y8AHjJHdq9uZcJ02Taju23WcjZbISAvxhvsRt7WWeke/6FeinxJGMPulZnZmiUHA58aTCthuF89udEfBnPB60wCfPagUmQMeLluCOb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uoJcL7Zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE8C4CEE7;
	Mon, 12 May 2025 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073362;
	bh=xYmfzR01N82RY3+otBbteamu/r9V02seIA5Sdi/XQfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoJcL7ZjQEH3eKok8VQRKqzQSuk8cQ1xxIABt1myg7RG2cH5L0UcCeA51Q9PGlI1P
	 rWKvj6PNoe+nau1dBFsmXZZ6pxmWEeB7o46ufziDEb9RNUm8YCmPIh0tVjUwjUqN2g
	 tXdXfaetamgt8ceTgL5BgN7+T2yGMc5I1sc0y/Ms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/113] net: dsa: b53: fix clearing PVID of a port
Date: Mon, 12 May 2025 19:45:10 +0200
Message-ID: <20250512172028.546979802@linuxfoundation.org>
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

[ Upstream commit f480851981043d9bb6447ca9883ade9247b9a0ad ]

Currently the PVID of ports are only set when adding/updating VLANs with
PVID set or removing VLANs, but not when clearing the PVID flag of a
VLAN.

E.g. the following flow

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set sw1p1 master bridge
$ bridge vlan add dev sw1p1 vid 10 pvid untagged
$ bridge vlan add dev sw1p1 vid 10 untagged

Would keep the PVID set as 10, despite the flag being cleared. Fix this
by checking if we need to unset the PVID on vlan updates.

Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250429201710.330937-4-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c438a5d9f6d8c..584de37a61c76 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1521,12 +1521,21 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	struct b53_vlan *vl;
+	u16 old_pvid, new_pvid;
 	int err;
 
 	err = b53_vlan_prepare(ds, port, vlan);
 	if (err)
 		return err;
 
+	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &old_pvid);
+	if (pvid)
+		new_pvid = vlan->vid;
+	else if (!pvid && vlan->vid == old_pvid)
+		new_pvid = b53_default_pvid(dev);
+	else
+		new_pvid = old_pvid;
+
 	vl = &dev->vlans[vlan->vid];
 
 	b53_get_vlan_entry(dev, vlan->vid, vl);
@@ -1543,9 +1552,9 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-	if (pvid && !dsa_is_cpu_port(ds, port)) {
+	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
-			    vlan->vid);
+			    new_pvid);
 		b53_fast_age_vlan(dev, vlan->vid);
 	}
 
-- 
2.39.5




