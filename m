Return-Path: <stable+bounces-21053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52485C6F2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA401C21AC4
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294A1509BF;
	Tue, 20 Feb 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMAJlh4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B314C585;
	Tue, 20 Feb 2024 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463201; cv=none; b=nh5q3JOrl/bfxSgJqXI/q18svnY+58vA5Rsw4y/R6VBiA2d00Sd442zG3ptoOLRpH9ZEaJ5weBzIDmFYQsr36r9lZ14J6/4ec6fxNn/8TJ9xGPjysZzt4/9DPZp54A9zp1EnwO6QqWrqPPPdBc1M4yDHoGdDNF4AIzfTcM2YP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463201; c=relaxed/simple;
	bh=zc+vKyNrW7oiqPbxiPg6tQOrCy1rKXF8UzEWA8tUKzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmtbS7noRjp4ipokzct/JmRxCB1GlSYYKi9OewbglX1GBj1j/wu5I2NaBTOJ3UUBZ4IGsg9PES0yD2GglYozXkYoN+z0FlScS/siDPKjy8U2OsuODfqrl520Zo95S1NHzciLXhyFhYeFzf6ALXDHWbAjlk0gPjwBUMcidEfddEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMAJlh4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DB8C433C7;
	Tue, 20 Feb 2024 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463201;
	bh=zc+vKyNrW7oiqPbxiPg6tQOrCy1rKXF8UzEWA8tUKzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMAJlh4Pv97xRwQHTjR2XQcqqhqoY7hQKMTzj4v9hzP0LJNwDFsL6HAyNpqX1gJ6L
	 mfYPkTUPyFpBJSEPUH1RCnG44uk5AhwbVQjGKazkJGxsP9dvVL4cjF95z/4GbwvJZw
	 scxwZYhkf397TWHL+03fCBRgahZG0BxQb0SwQcKo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel de Villiers <daniel.devilliers@corigine.com>,
	Louis Peens <louis.peens@corigine.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 139/197] nfp: flower: prevent re-adding mac index for bonded port
Date: Tue, 20 Feb 2024 21:51:38 +0100
Message-ID: <20240220204845.230136416@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel de Villiers <daniel.devilliers@corigine.com>

commit 1a1c13303ff6d64e6f718dc8aa614e580ca8d9b4 upstream.

When physical ports are reset (either through link failure or manually
toggled down and up again) that are slaved to a Linux bond with a tunnel
endpoint IP address on the bond device, not all tunnel packets arriving
on the bond port are decapped as expected.

The bond dev assigns the same MAC address to itself and each of its
slaves. When toggling a slave device, the same MAC address is therefore
offloaded to the NFP multiple times with different indexes.

The issue only occurs when re-adding the shared mac. The
nfp_tunnel_add_shared_mac() function has a conditional check early on
that checks if a mac entry already exists and if that mac entry is
global: (entry && nfp_tunnel_is_mac_idx_global(entry->index)). In the
case of a bonded device (For example br-ex), the mac index is obtained,
and no new index is assigned.

We therefore modify the conditional in nfp_tunnel_add_shared_mac() to
check if the port belongs to the LAG along with the existing checks to
prevent a new global mac index from being re-assigned to the slave port.

Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
CC: stable@vger.kernel.org # 5.1+
Signed-off-by: Daniel de Villiers <daniel.devilliers@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -980,7 +980,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app
 	u16 nfp_mac_idx = 0;
 
 	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
-	if (entry && nfp_tunnel_is_mac_idx_global(entry->index)) {
+	if (entry && (nfp_tunnel_is_mac_idx_global(entry->index) || netif_is_lag_port(netdev))) {
 		if (entry->bridge_count ||
 		    !nfp_flower_is_supported_bridge(netdev)) {
 			nfp_tunnel_offloaded_macs_inc_ref_and_link(entry,



